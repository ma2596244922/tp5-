<?php
/**
 * 产品复制程序函数库
 *
 * @package timandes\enterprise
 */


/**
 * 复制源分组
 */
function duplicate_product_source_group($sourceGroupId, $sourceLangCode, $targetSiteId, $targetGroupId, $targetLangCode, $fromProductId, $updatePUrlPrefix = true, $tdkTemplate = null)
{
    $verbose = $GLOBALS['gaSettings']['verbose'];

    if ($verbose >= 2)
        fprintf(STDOUT, "Duplicating source group {$sourceGroupId} ..." . PHP_EOL);

    // Get source group
    $sourceGroup = enterprise_get_group_info($sourceGroupId, $sourceLangCode);
    if (!$sourceGroup)
        throw new \RuntimeException("Could not find source group {$sourceGroupId}");
    if ($verbose >= 2)
        fprintf(STDOUT, "Source Group: #{$sourceGroupId} {$sourceGroup['name']}" . PHP_EOL);
    $sourceSiteId = $sourceGroup['site_id'];

    if ($targetSiteId) {// Duplicate New Group
        // Get target language site
        if ($targetLangCode == 'en')
            $siteDAO = new \enterprise\daos\Site();
        else
            $siteDAO = new \enterprise\daos\LangSite($targetLangCode);
        $condition = "`site_id`=" . (int)$targetSiteId;
        $site = $siteDAO->getOneBy($condition);
        if (!$site)
            throw new \RuntimeException("Could not find target {$targetLangCode} site {$targetSiteId}");
        if ($verbose >= 2)
            fprintf(STDOUT, "Target Site: #{$targetSiteId} {$targetLangCode}" . PHP_EOL);

        // Product URL Prefix
        $pUrlPrefix = ($updatePUrlPrefix?'happy':$sourceGroup['purl_prefix']);

        // Product TDK
        $productHtmlTitle = (isset($tdkTemplate['html_title'])?$tdkTemplate['html_title']:$sourceGroup['product_html_title']);
        $productMetaKeywords = (isset($tdkTemplate['meta_keywords'])?$tdkTemplate['meta_keywords']:$sourceGroup['product_meta_keywords']);
        $productMetaDescription = (isset($tdkTemplate['meta_description'])?$tdkTemplate['meta_description']:$sourceGroup['product_meta_description']);

        // Duplicate Group
        $targetGroupId = enterprise_admin_save_group($targetLangCode, 0, $sourceGroup['name'], $targetSiteId, $sourceGroup['path'], $pUrlPrefix, $productHtmlTitle, $productMetaKeywords, $productMetaDescription);
        if ($verbose >= 2)
            fprintf(STDOUT, "Target group #{$targetGroupId} created" . PHP_EOL);
    } else {// Use Existing Group
        // Get target language group
        $group = enterprise_get_group_info($targetGroupId, $targetLangCode);
        if (!$group)
            throw new \RuntimeException("Could not find target {$targetLangCode} group {$targetGroupId}");
        if ($verbose >= 2)
            fprintf(STDOUT, "Target Group: #{$targetGroupId} {$targetLangCode}" . PHP_EOL);
        // Get Site ID
        $targetSiteId = $group['site_id'];
        if ($verbose >= 2)
            fprintf(STDOUT, "Target Site: #{$targetSiteId} {$targetLangCode}" . PHP_EOL);
    }

    // Duplicate Products
    if ($sourceLangCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($sourceLangCode);
    $curProductId = ($fromProductId>0?$fromProductId:0);
    do {
        if ($sourceLangCode == 'en')
            $products = enterprise_get_product_list($sourceSiteId, $sourceLangCode, $sourceGroupId, false, 1, 100, "`id`>{$curProductId}", '`id` ASC', '`tags`, `description`, `specifications`, `images`, `site_id`, `updated`');
        else
            $products = enterprise_get_product_list($sourceSiteId, $sourceLangCode, $sourceGroupId, false, 1, 100, "elp.`product_id`>{$curProductId}", 'elp.`product_id` ASC', 'elp.`tags`, elp.`description`, elp.`specifications`, ep.`images`, elp.`site_id`, elp.`updated`');
        if (!$products)
            break;

        if ($verbose >= 2)
            fprintf(STDOUT, "Found " . count($products) . " product(s)" . PHP_EOL);

        foreach ($products as $product) {
            if ($verbose >= 3)
                fprintf(STDOUT, "Duplicating product {$product['id']} ..." . PHP_EOL);

            $product['specifications'] = ($product['specifications']?json_decode($product['specifications'], true):[]);
            $product['images'] = ($product['images']?json_decode($product['images'], true):[]);

            $ts = strtotime($product['updated']);
            $updatedTS = $ts + mt_rand(-86400, 86400);

            enterprise_admin_save_product($targetLangCode, 0, $product['brand_name'], $product['model_number'], $product['certification'], $product['place_of_origin'], $product['price'], $product['payment_terms'], $product['supply_ability'], $product['head_image_id'], $product['images'], $targetSiteId, $product['caption'], $product['description'], $targetGroupId, $product['min_order_quantity'], $product['delivery_time'], $product['packaging_details'], $product['specifications'], $product['tags'], null, null, date('Y-m-d H:i:s', $updatedTS));

            $curProductId = $product['id'];
        }
    } while(true);

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish duplicate procedure for source group {$sourceGroupId}" . PHP_EOL);
}