<?php
/**
 * 对接采集器 - 发布产品
 *
 * @package timandes\enterprise
 */

/** @var int 产品最大图片数 */
define('ENTERPRISE_ADMIN_BLOWJOB_SEXMEUP_MAX_IMAGES', 20);

require_once __DIR__ . '/bootstrap.php';

function enterprise_sexmeup_save_image_from_url($siteId, $imageUrl, $thumbnail = true)
{
    // Fetch
    $httpClient = new chinacn\common\HttpClient();
    try {
        $response = $httpClient->request('GET', $imageUrl);
    } catch (GuzzleHttp\Exception\RequestException $re) {
        return false;
    }

    // To image object
    $imageManager = new \Intervention\Image\ImageManager();
    $imageDAO = new \enterprise\daos\Image();
    $thumbnailDAO = new \enterprise\daos\Thumbnail();
    $body = null;
    $id = enterprise_admin_save_image($imageDAO, $siteId, $imageManager, $response->getBody()->__toString(), $body, IMAGE_MAX_WIDTH_4_PRODUCT);
    // Thumbnail
    if ($thumbnail)
        enterprise_admin_save_thumbs($thumbnailDAO, $id, $imageManager, $body);

    return $id;
}

function enterprise_sexmeup_save_images($siteId)
{
    $remoteImageUrlsParam = timandes_get_post_data('remotePic');
    if (!$remoteImageUrlsParam)
        return array();

    $remoteImageUrls = explode('|||', $remoteImageUrlsParam);
    $retval = array();
    $totalImages = 0;
    foreach ($remoteImageUrls as $imageUrl) {
        $imageId = enterprise_sexmeup_save_image_from_url($siteId, $imageUrl);
        if ($imageId) {
            $retval[] = $imageId;
            ++$totalImages;
        }
        if ($totalImages >= ENTERPRISE_ADMIN_BLOWJOB_SEXMEUP_MAX_IMAGES)
            break;
    }

    return $retval;
}

/**
 * @return string
 */
function enterprise_sexmeup_save_images_in_description($siteId, $description)
{
    $document = new \DOMDocument();
    @$document->loadHTML($description);
    $imgElements = $document->getElementsByTagName('img');
    foreach ($imgElements as $e) {
        if (!$e->hasAttribute('data-src'))
            continue;
        $originalHtml = $document->saveHTML($e);
        // src
        $url = $e->getAttribute('data-src');
        $imageId = enterprise_sexmeup_save_image_from_url($siteId, $url, false);
        $newUrl = enterprise_url_image($imageId, '', '', '', true);
        $e->setAttribute('src', $newUrl);
        $e->removeAttribute('data-src');
        // Regular attrs
        $regularAttrs = array(
                'alt', 'width', 'height',
            );
        foreach ($regularAttrs as $attr) {
            $dataAttr = 'data-' . $attr;
            if ($e->hasAttribute($dataAttr)) {
                $value = $e->getAttribute($dataAttr);
                $e->setAttribute($attr, $value);
                $e->removeAttribute($dataAttr);
            }
        }
        // Replace
        $newHtml = $document->saveHTML($e);
        $description = str_replace($originalHtml, $newHtml, $description);
    }

    return $description;
}

function enterprise_sexmeup_save_product($siteId, $langCode, $groupId, $images)
{
    $identity = timandes_get_post_data('identity');
    $caption = timandes_get_post_data('title');
    $description = timandes_get_post_data('content', 'trim, xss_clean');
    $brandName = timandes_get_post_data('brand');
    $modelNumber = timandes_get_post_data('model_number');
    $certification = timandes_get_post_data('certification');
    $placeOfOrigin = timandes_get_post_data('place_of_origin');
    $minOrderQuantity = timandes_get_post_data('minamount');
    $paymentTerms = timandes_get_post_data('payment_terms');
    $price = timandes_get_post_data('price');
    $supplyAbility = timandes_get_post_data('amount');
    $deliveryTime = timandes_get_post_data('days');
    $packagingDetails = timandes_get_post_data('packaging_details');
    $tagsString = timandes_get_post_data('tags');
    $specificationsString = timandes_get_post_data('specifications');
    $sourceUrl = timandes_get_post_data('shopurl');
    $customPath = timandes_get_post_data('custom_path');

    // Force to decode URL
    if (preg_match('/^https?%3a%2f%2f/i', $sourceUrl))
        $sourceUrl = urldecode($sourceUrl);

    // Images in description
    $description = enterprise_sexmeup_save_images_in_description($siteId, $description);

    // Tags
    $a = explode('|||', $tagsString);
    $tags = array();
    foreach ($a as $t) {
        $tags[] = trim($t);
    }
    $tagsFieldValue = implode(',', $tags);

    // Specifications
    $a = explode('|||', $specificationsString);
    $specifications = array();
    foreach ($a as $pairString) {
        $pair = explode(':', $pairString);
        if (count($pair) < 2)
            continue;
        $k = trim($pair[0]);
        $v = str_replace('~~~', ':', trim($pair[1]));
        $specifications[$k] = $v;
    }

    $headImageId = ($images?$images[0]:0);

    // Exists?
    $productIdentityDAO = new \blowjob\daos\ProductIdentity();
    $condition = "`site_id`=" . (int)$siteId . " AND `identity`='" . $productIdentityDAO->escape($identity) . "'";
    $productIdentity = $productIdentityDAO->getOneBy($condition);
    if ($productIdentity)// Already exists
        return $productIdentity['product_id'];

    $retval = enterprise_admin_save_product($langCode, 0, $brandName, $modelNumber, $certification, $placeOfOrigin, $price, $paymentTerms, $supplyAbility, $headImageId, $images, $siteId, $caption, $description, $groupId, $minOrderQuantity, $deliveryTime, $packagingDetails, $specifications, $tagsFieldValue, $customPath, $sourceUrl);

    // Insert identity
    $values = array(
            'site_id' => $siteId,
            'identity' => $identity,
            'product_id' => $retval,
        );
    $productIdentityDAO->insert($values);

    return $retval;
}

function enterprise_sexmeup_route()
{
    $passwd = timandes_get_post_data('pw');
    if (PASSWD != $passwd)
        throw new \RuntimeException('Wrong password');

    $groupId = timandes_get_post_data('group_id');
    if (!$groupId)
        throw new \RuntimeException("Empty group");

    list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();
    $images = enterprise_sexmeup_save_images($siteId);
    $productId = enterprise_sexmeup_save_product($siteId, $langCode, $groupId, $images);
    enterprise_sexmeup_response(0, 'SUCCESS', $productId);
}

function enterprise_sexmeup_response($code, $message, $productId = 0)
{
    $response = array(
            'code' => $code,
            'message' => $message,
        );
    if (!$code)
        $response['product_id'] = $productId;
    header('Content-type: application/json');
    echo json_encode($response);
}


try {
    enterprise_sexmeup_route();
} catch (\RuntimeException $e) {
    enterprise_sexmeup_response(1, $e->getMessage());
} catch (\Exception $e) {
    enterprise_sexmeup_response(2, $e->getMessage());
}
