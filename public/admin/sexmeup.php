<?php
/**
 * 对接火车采集器
 *
 * @package timandes\enterprise
 */

// default timezone
date_default_timezone_set("Asia/Shanghai");

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

define('PASSWD', 'BCF9DC55CA6FFB89CA44DBC3BC2C04');

require_once realpath(__DIR__ . '/../../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../../') . '/config_admin.php';

function enterprise_sexmeup_save_image_from_url($siteId, $imageUrl)
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
    $id = enterprise_admin_save_image($imageDAO, $siteId, $imageManager, $response->getBody(), $body);
    // Thumbnail
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

function enterprise_sexmeup_save_product($siteId, $groupId, $images)
{
    $caption = enterprise_get_post_data('title');
    $description = enterprise_get_post_data('content', 'trim');
    $brandName = enterprise_get_post_data('brand');
    $minOrderQuantity = enterprise_get_post_data('minamount');
    $price = enterprise_get_post_data('price');
    $supplyAbility = enterprise_get_post_data('amount');
    $deliveryTime = enterprise_get_post_data('days');

    $specificationsArray = array();
    for ($i=1; $i<=3; ++$i) {
        $k = enterprise_get_post_data('n' . $i);
        $v = enterprise_get_post_data('v' . $i);
        if ($k)
            $specificationsArray[$k] = $v;
    }

    $headImageId = ($images?$images[0]:0);

    $productDAO = new \enterprise\daos\Product();
    $values = array(
            'site_id' => $siteId,
            'caption' => $caption,
            'description' => $description,
            'group_id' => $groupId,
            'locale' => 'english',
            'updated' => date('Y-m-d H:i:s'),
            'brand_name' => $brandName,
            'min_order_quantity' => $minOrderQuantity,
            'price' => $price,
            'supply_ability' => $supplyAbility,
            'delivery_time' => $deliveryTime,
            'specifications' => $specificationsArray,
            'head_image_id' => $headImageId,
            'images' => $images,
        );
    $values['created'] = $values['updated'];
    $productDAO->insert($values);

    // Cnt of products
    $groupDAO = new \enterprise\daos\Group();
    $groupDAO->incrCnt($groupId);
}

function enterprise_sexmeup_route()
{
    $passwd = enterprise_get_query_data('pw');
    if (PASSWD != $passwd)
        throw new \RuntimeException('Wrong password');

    $siteId = 2;
    $images = enterprise_sexmeup_save_images($siteId);
    enterprise_sexmeup_save_product($siteId, $groupId, $images);
}

try {
    enterprise_sexmeup_route();
    echo 'SUCCESS';
} catch (\RuntimeException $e) {
    echo $e->getMessage();
}
