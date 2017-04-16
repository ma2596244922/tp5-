#! /bin/env php
<?php
/**
 * 计算图片摘要并调整重复图片数据
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
    fprintf(STDOUT, $options);
}

function software_info()
{
    fprintf(STDOUT, "Calculate Image Sum." . PHP_EOL);
}

function cal_proc()
{
    $verbose = $GLOBALS['gaSettings']['verbose'];

    $imageDAO = new \enterprise\daos\Image();
    $thumbnailDAO = new \enterprise\daos\Thumbnail();

    $imageSumMapping = array();
    $curImageId = 0;
    $batchSize = 100;
    do {
        $condition = "`id`>" . $curImageId;
        $images = $imageDAO->getMultiInOrderBy($condition, '*', '`id`', $batchSize);
        if (!$images)
            break;

        $imageCnt = count($images);
        if ($verbose >= 2)
            fprintf(STDOUT, "Got {$imageCnt} images" . PHP_EOL);

        foreach ($images as $image) {
            $curImageId = max($curImageId, $image['id']);

            if ($verbose >= 3)
                fprintf(STDOUT, "Processing image {$image['id']} ... ");

            $len = strlen($image['body']);
            if ($len <= ENTERPRISE_IMAGE_ID_IN_BLOB_LEN_THRESHOLD) {
                $dupImageId = (int)$image['body'];
                if ($verbose >= 3)
                    fprintf(STDOUT, "Redirect#{$dupImageId}" . PHP_EOL);
                continue;
            }

            $bodySum = md5($image['body'], true);
            if (isset($imageSumMapping[$bodySum])) {
                $dupImageId = $imageSumMapping[$bodySum];
                if ($verbose >= 3)
                    fprintf(STDOUT, "Dup#{$dupImageId}" . PHP_EOL);
                // Rewrite image body
                $values = array(
                        'body' => $dupImageId,
                    );
                $imageDAO->update($image['id'], $values);
                // Rewrite thumbnail body
                $values = array(
                        't' => $dupImageId,
                        'm' => $dupImageId,
                        'd' => $dupImageId,
                        'c' => $dupImageId,
                    );
                $thumbnailDAO->updateByImage($image['id'], $values);
            } else {
                $imageSumMapping[$bodySum] = $image['id'];
                if ($verbose >= 3)
                    fprintf(STDOUT, "Done" . PHP_EOL);
            }
        }
    } while(true);

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish sending procedure" . PHP_EOL);
}


function main($argc, $argv)
{
    $type = '';
    $siteId = 0;

    software_info();

    $params = getopt("v", array());
    if(is_array($params)
            && count($params) > 0) foreach($params as $k => &$v) {
        switch($k) {
            case 'v':
                $GLOBALS['gaSettings']['verbose'] = count($v);
                break;
        }
    } else {
        usage();
        return EXIT_FAILURE;
    }

    try {
        cal_proc();
    } catch (\Exception $e) {
        $rc = new \ReflectionClass($e);
        fprintf(STDERR, "%s#%d %s" . PHP_EOL, $rc->getName(), $e->getCode(), $e->getMessage());
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

exit(main($argc, $argv));
