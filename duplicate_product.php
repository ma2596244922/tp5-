#! /bin/env php
<?php
/**
 * 将某站英文分组下的产品复制到另外一个站的葡萄牙语分站下
 *
 * @package timandes\enterprise
 */

ini_set('display_errors', true);
error_reporting(E_ALL);
ini_set('memory_limit', '4096M');

define('EXIT_SUCCESS', 0);
define('EXIT_FAILURE', 1);

$GLOBALS['gaSettings'] = array(
        'verbose' => 3,
        'source_group_id_list' => '',
        'source_lang_code' => 'en',
        'target_site_id' => 1,
        'target_lang_code' => 'pt',
        'from_product_id' => 0,
    );

require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/config_admin.php';

function usage()
{
    global $argv;

    $appName = basename($argv[0]);
    $usage = "Usage:" . PHP_EOL;
    $usage .= "\tphp {$appName} [OPTIONS]" . PHP_EOL;
    fprintf(STDOUT, $usage);

    $options = "OPTIONS:" . PHP_EOL;
    $options .= "\t-v                           output warning/errors" . PHP_EOL;
    $options .= "\t--source-group=<ID1,ID2,...> id list of source groups" . PHP_EOL;
    $options .= "\t--source-lang-code=<code>    language code of source group(default: en)" . PHP_EOL;
    $options .= "\t--target-site=<ID>           id of target site" . PHP_EOL;
    $options .= "\t--target-lang-code=<code>    language code of target group(default: pt)" . PHP_EOL;
    $options .= "\t--from-product-id=<ID>       process from which product id" . PHP_EOL;
    fprintf(STDOUT, $options);
}

function software_info()
{
    fprintf(STDOUT, "Duplicate Product" . PHP_EOL);
}


function duplicate_proc()
{
    $verbose = $GLOBALS['gaSettings']['verbose'];
    $sourceGroupIdList = $GLOBALS['gaSettings']['source_group_id_list'];

    $sourceGroupIdArray = explode(',', $sourceGroupIdList);
    if (is_array($sourceGroupIdArray)) foreach ($sourceGroupIdArray as $id) {
        duplicate_source_group($id);
    }

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish duplicate procedure" . PHP_EOL);
}

function duplicate_source_group($sourceGroupId)
{
    $verbose = $GLOBALS['gaSettings']['verbose'];
    $sourceLangCode = $GLOBALS['gaSettings']['source_lang_code'];
    $targetSiteId = $GLOBALS['gaSettings']['target_site_id'];
    $targetLangCode = $GLOBALS['gaSettings']['target_lang_code'];
    $fromProductId = $GLOBALS['gaSettings']['from_product_id'];

    if ($verbose >= 2)
        fprintf(STDOUT, "Duplicating source group {$sourceGroupId} ..." . PHP_EOL);

    // Get source group
    $sourceGroup = enterprise_get_group_info($sourceGroupId, $sourceLangCode);
    if (!$sourceGroup)
        throw new \RuntimeException("Could not find source group {$sourceGroupId}");
    if ($verbose >= 2)
        fprintf(STDOUT, "Source Group: #{$sourceGroupId} {$sourceGroup['name']}" . PHP_EOL);
    $sourceSiteId = $sourceGroup['site_id'];

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

    // Duplicate Group
    $targetGroupId = enterprise_admin_save_group($targetLangCode, 0, $sourceGroup['name'], $targetSiteId, $sourceGroup['path']);
    if ($verbose >= 2)
        fprintf(STDOUT, "Target group #{$targetGroupId} created" . PHP_EOL);

    // Duplicate Products
    if ($sourceLangCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($sourceLangCode);
    $curProductId = ($fromProductId>0?$fromProductId:0);
    do {
        if ($sourceLangCode == 'en')
            $products = enterprise_get_product_list($sourceSiteId, $sourceLangCode, $sourceGroupId, 1, 100, "`id`>{$curProductId}", '`id` ASC', '`tags`, `description`, `specifications`, `images`, `site_id`');
        else
            $products = enterprise_get_product_list($sourceSiteId, $sourceLangCode, $sourceGroupId, 1, 100, "elp.`product_id`>{$curProductId}", 'elp.`product_id` ASC', 'elp.`tags`, elp.`description`, elp.`specifications`, ep.`images`, elp.`site_id`');
        if (!$products)
            break;

        if ($verbose >= 2)
            fprintf(STDOUT, "Found " . count($products) . " product(s)" . PHP_EOL);

        foreach ($products as $product) {
            if ($verbose >= 3)
                fprintf(STDOUT, "Duplicating product {$product['id']} ..." . PHP_EOL);

            $product['specifications'] = ($product['specifications']?json_decode($product['specifications'], true):[]);
            $product['images'] = ($product['images']?json_decode($product['images'], true):[]);

            enterprise_admin_save_product($targetLangCode, 0, $product['brand_name'], $product['model_number'], $product['certification'], $product['place_of_origin'], $product['price'], $product['payment_terms'], $product['supply_ability'], $product['head_image_id'], $product['images'], $targetSiteId, $product['caption'], $product['description'], $targetGroupId, $product['min_order_quantity'], $product['delivery_time'], $product['packaging_details'], $product['specifications'], $product['tags']);

            $curProductId = $product['id'];
        }
    } while(true);

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish duplicate procedure for source group {$sourceGroupId}" . PHP_EOL);
}

function main($argc, $argv)
{
    $type = '';
    $siteId = 0;

    software_info();

    $params = getopt("v", array('source-group:', 'source-lang-code:', 'target-site:', 'target-lang-code:', 'from-product-id'));
    if(is_array($params)
            && count($params) > 0) foreach($params as $k => &$v) {
        switch($k) {
            case 'v':
                $GLOBALS['gaSettings']['verbose'] = count($v);
                break;
            case 'source-group':
                $GLOBALS['gaSettings']['source_group_id_list'] = $v;
                break;
            case 'source-lang-code':
                $GLOBALS['gaSettings']['source_lang_code'] = $v;
                break;
            case 'target-site':
                $GLOBALS['gaSettings']['target_site_id'] = (int)$v;
                break;
            case 'target-lang-code':
                $GLOBALS['gaSettings']['target_lang_code'] = $v;
                break;
            case 'from-product-id':
                $GLOBALS['gaSettings']['from_product_id'] = (int)$v;
                break;
        }
    } else {
        usage();
        return EXIT_FAILURE;
    }

    // --from-product-id
    if ($GLOBALS['gaSettings']['from_product_id'] > 0
            && strpos($GLOBALS['gaSettings']['source_group_id_list'], ',') !== false) {
        fprintf(STDERR, "Parameter --from-product-id can not be used when given multi groups");
        return EXIT_FAILURE;
    }

    try {
        duplicate_proc();
    } catch (\Exception $e) {
        $rc = new \ReflectionClass($e);
        fprintf(STDERR, "%s#%d %s" . PHP_EOL, $rc->getName(), $e->getCode(), $e->getMessage());
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

exit(main($argc, $argv));