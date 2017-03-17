<?php
/**
 * 对接采集器 - 发布产品
 *
 * @package timandes\enterprise
 */

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
    $id = enterprise_admin_save_image($imageDAO, $siteId, $imageManager, $response->getBody()->__toString(), $body);
    // Thumbnail
    if ($thumbnail)
        enterprise_admin_save_thumbs($thumbnailDAO, $id, $imageManager, $body);

    return $id;
}

function enterprise_sexmeup_save_images($siteId)
{
    $remoteImageUrlsParam = enterprise_get_post_data('remotePic');
    if (!$remoteImageUrlsParam)
        return array();

    $remoteImageUrls = explode('|||', $remoteImageUrlsParam);
    $retval = array();
    foreach ($remoteImageUrls as $imageUrl) {
        $imageId = enterprise_sexmeup_save_image_from_url($siteId, $imageUrl);
        if ($imageId)
            $retval[] = $imageId;
    }

    return $retval;
}

/**
 * @return string
 */
function enterprise_sexmeup_save_images_in_description($description)
{
    $document = new \DOMDocument();
    @$document->loadHTML($description);
    $imgElements = $document->getElementsByTagName('img');
    foreach ($imgElements as $e) {
        if (!$e->hasAttribute('data-src'))
            continue;
        $originalHtml = $document->saveHTML($e);
        $url = $e->getAttribute('data-src');
        $imageId = enterprise_sexmeup_save_image_from_url($siteId, $url, false);
        $newUrl = enterprise_url_image($imageId);
        $e->setAttribute
    }

    return $description;
}

function enterprise_sexmeup_save_product($siteId, $groupId, $images)
{
    $identity = enterprise_get_post_data('identity');
    $caption = enterprise_get_post_data('title');
    $description = enterprise_get_post_data('content', 'trim');
    $brandName = enterprise_get_post_data('brand');
    $modelNumber = enterprise_get_post_data('model_number');
    $certification = enterprise_get_post_data('certification');
    $placeOfOrigin = enterprise_get_post_data('place_of_origin');
    $minOrderQuantity = enterprise_get_post_data('minamount');
    $paymentTerms = enterprise_get_post_data('payment_terms');
    $price = enterprise_get_post_data('price');
    $supplyAbility = enterprise_get_post_data('amount');
    $deliveryTime = enterprise_get_post_data('days');
    $packagingDetails = enterprise_get_post_data('packaging_details');
    $tagsString = enterprise_get_post_data('tags');
    $specificationsString = enterprise_get_post_data('specifications');

    // Images in description
    $description = enterprise_sexmeup_save_images_in_description($description);

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

    // Insert product
    $productDAO = new \enterprise\daos\Product();
    $values = array(
            'site_id' => $siteId,
            'caption' => $caption,
            'description' => $description,
            'group_id' => $groupId,
            'locale' => 'english',
            'updated' => date('Y-m-d H:i:s'),
            'brand_name' => $brandName,
            'model_number' => $modelNumber,
            'certification' => $certification,
            'place_of_origin' => $placeOfOrigin,
            'min_order_quantity' => $minOrderQuantity,
            'payment_terms' => $paymentTerms,
            'price' => $price,
            'supply_ability' => $supplyAbility,
            'delivery_time' => $deliveryTime,
            'packaging_details' => $packagingDetails,
            'specifications' => $specifications,
            'head_image_id' => $headImageId,
            'images' => $images,
            'tags' => $tagsFieldValue,
        );
    $values['created'] = $values['updated'];
    $retval = $productDAO->insert($values);

    // Insert identity
    $values = array(
            'site_id' => $siteId,
            'identity' => $identity,
            'product_id' => $retval,
        );
    $productIdentityDAO->insert($values);

    // Cnt of products
    $groupDAO = new \enterprise\daos\Group();
    $groupDAO->incrCnt($groupId);
    return $retval;
}

function enterprise_sexmeup_route()
{
    $passwd = enterprise_get_post_data('pw');
    if (PASSWD != $passwd)
        throw new \RuntimeException('Wrong password');

    $groupId = enterprise_get_post_data('group_id');
    if (!$groupId)
        throw new \RuntimeException("Empty group");

    list($siteId, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
    $images = enterprise_sexmeup_save_images($siteId);
    echo enterprise_sexmeup_save_product($siteId, $groupId, $images);
}

try {
    enterprise_sexmeup_route();
} catch (\RuntimeException $e) {
    $response = array(
            'code' => -1,
            'message' => $e->getMessage(),
        );
    header('Content-Type: application/json');
    echo json_encode($response);
}
