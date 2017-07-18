#! /bin/env php
<?php
/**
 * 将某站某分组下的产品复制到另外一个站的分站下
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
require_once __DIR__ . '/duplicate_product.h.php';

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
    $sourceLangCode = $GLOBALS['gaSettings']['source_lang_code'];
    $targetSiteId = $GLOBALS['gaSettings']['target_site_id'];
    $targetLangCode = $GLOBALS['gaSettings']['target_lang_code'];
    $fromProductId = $GLOBALS['gaSettings']['from_product_id'];

    $sourceGroupIdArray = explode(',', $sourceGroupIdList);
    if (is_array($sourceGroupIdArray)) foreach ($sourceGroupIdArray as $id) {
        duplicate_product_source_group($id, $sourceLangCode, $targetSiteId, 0, $targetLangCode, $fromProductId);
    }

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish duplicate procedure" . PHP_EOL);
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