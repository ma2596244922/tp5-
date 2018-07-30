<?php
/**
 * 产品公用函数库
 *
 * @package timandes\enterprise
 */

/** @var string Fields of Product for URL-Generating */
define('ENTERPRISE_PRODUCT_FIELDS_FOR_URL_GENERATING', '`id`, `caption`, `path`, `group_id`');

/** @var string Max Characters of Field 'summary' */
define('ENTERPRISE_PRODUCT_SUMMARY_MAX_CHARS', 300);

require_once __DIR__ . '/vendor/smarty/smarty/libs/plugins/modifier.truncate.php';

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

        $idCondition = ' IN (' . implode(',', $productIdArray) . ')';
        $langProducts = $langProductDAO->getMultiInOrderBy2('`product_id`' . $idCondition, '`product_id`, `group_id`, `caption`');
        $productLangInfoMapping = [];
        if (is_array($langProducts)) foreach ($langProducts as $p) {
            $productLangInfoMapping[$p['product_id']] = $p;
        }

        $idCondition = ' IN (' . implode(',', $productIdArray) . ')';
        $products = $productDAO->getMultiInOrderBy('`id`' . $idCondition, '`id`, `path`');
        $retval = [];
        if (is_array($products)) foreach ($products as $p) {
            if (isset($productLangInfoMapping[$p['id']])) {
                $info = $productLangInfoMapping[$p['id']];
                $p['group_id'] = $info['group_id'];
                $p['caption'] = $info['caption'];
            }
            $retval[] = $p;
        }
        $products = $retval;
    } else {
        $products = $productDAO->getMultiInOrderBy($mainCondition, ENTERPRISE_PRODUCT_FIELDS_FOR_URL_GENERATING, null, $pageSize, $start, '`idx_iteration`');
    }

    return enterprise_product_append_group_info($langCode, $products);
}


function enterprise_product_transform_field_for_lang_site($field)
{
    switch ($field) {
        case 'description':
            return 'elp.`description`';
        case 'images':
            return 'ep.`images`';
        case 'specifications':
            return 'elp.`specifications`';
        case 'tags':
            return 'elp.`tags`';
        case 'created':
            return 'elp.`created`';
        case 'embedded_video':
            return 'elp.`embedded_video`';
    }

    throw new \DomainException("Unsupported field '{$field}'");
}

function enterprise_product_transform_field_list_for_lang_site($fieldList)
{
    if (!$fieldList)
        throw new \LogicException("Empty field list was found");

    $fieldArray = explode(',', $fieldList);
    $transformedFieldArray = [];
    foreach ($fieldArray as $f) {
        $f = trim($f, ' `');
        $transformedFieldArray[] = enterprise_product_transform_field_for_lang_site($f);
    }

    return implode(',', $transformedFieldArray);
}

function enterprise_product_save_pending_product($siteId, $productId)
{
    $site = enterprise_get_site_info($siteId);
    if (!isset($site['translation_targets'])
            || !$site['translation_targets'])
        return;
    $translationTargets = json_decode($site['translation_targets'], true);
    if (!$translationTargets)
        return;
    if (!is_array($translationTargets))
        return;

    $values = array(
            'pending' => 1,
            'updated' => date('Y-m-d H:i:s'),
        );
    foreach ($translationTargets as $target => $v) {
        $langPendingProductDAO = new \enterprise\daos\LangPendingProduct($target);
        $langPendingProductDAO->upsert($productId, $values);
    }
}

function enterprise_product_description_2_summary($description)
{
    if (!$description)
        return '';

    return smarty_modifier_truncate(strip_tags($description), ENTERPRISE_PRODUCT_SUMMARY_MAX_CHARS, '');
}