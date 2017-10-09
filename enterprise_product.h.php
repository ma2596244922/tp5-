<?php
/**
 * 产品公用函数库
 *
 * @package timandes\enterprise
 */

/** @var string Fields of Product for URL-Generating */
define('ENTERPRISE_PRODUCT_FIELDS_FOR_URL_GENERATING', '`id`, `caption`, `path`');

/**
 * Append group info to product list
 *
 * @return array
 */
function enterprise_product_append_group_info($langCode, $products)
{
    $retval = array();
    foreach ($products as $p) {
        $p['group'] = enterprise_get_group_info($p['group_id'], $langCode, true);
        $retval[] = $p;
    }
    return $retval;
}

/**
 * Product Iteration
 *
 * @return array
 */
function enterprise_product_iteration($siteId, $langCode, $pageNo = 1, $pageSize = 10)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    $productDAO = new \enterprise\daos\Product();
    $mainCondition = "`site_id`={$siteId} AND `deleted`=0";

    if ($langCode != 'en') {
        $langProductDAO = new \enterprise\daos\LangProduct($langCode);
        $langProducts = $langProductDAO->getMultiInOrderBy2($mainCondition, '`product_id`', null, $pageSize, $start, '`idx_iteration`');

        $productIdArray = [];
        if (is_array($langProducts)) foreach ($langProducts as $p) {
            $productIdArray[] = $p['product_id'];
        }
        if (!$productIdArray)
            return array();

        $condition = '`id` IN (' . implode(',', $productIdArray) . ')';
        $products = $productDAO->getMultiInOrderBy($mainCondition, ENTERPRISE_PRODUCT_FIELDS_FOR_URL_GENERATING);
    } else {
        $products = $productDAO->getMultiInOrderBy($mainCondition, ENTERPRISE_PRODUCT_FIELDS_FOR_URL_GENERATING, null, $pageSize, $start, '`idx_iteration`');
    }

    return enterprise_product_append_group_info($langCode, $products);
}