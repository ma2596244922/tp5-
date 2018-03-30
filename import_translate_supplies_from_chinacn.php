#! /bin/env php
<?php
/**
 * 导入并翻译中国供应商中文站产品
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
require_once __DIR__ . '/enterprise_translate.h.php';

function main($argc, $argv)
{
    $serializedString = '';

    if ($argc > 1) {
        $documentPath = $argv[1];
        if (!file_exists($documentPath)) {
            fprintf(STDERR, "Could not find file {$documentPath}" . PHP_EOL);
            return EXIT_FAILURE;
        }

        $serializedString = file_get_contents($documentPath);
    }

    $supplies = unserialize($serializedString);
    if (!$supplies
            || !is_array($supplies)) {
        fprintf(STDERR, "No supply was found" . PHP_EOL);
        return EXIT_FAILURE;
    }

    $translateClient = new Google\Cloud\Translate\TranslateClient(['key' => GOOGLE_CLOUD_API_KEY]);

    $langCode = 'en';
    $productId = null;
    $brandName = '';
    $modelNumber = '';
    $certification = '';
    $placeOfOrigin = '';
    $price = '';
    $paymentTerms = '';
    $supplyAbility = '';
    $headImageId = 0;
    $images = [];
    $userSiteId = 30;
    $groupId = 2330;//52;
    $minOrderQuantity = '';
    $deliveryTime = '';
    $packagingDetails = '';
    $specificationsArray = [];
    $tags = '';

    $totalChars = 0;
    foreach($supplies as $supply) {
        fprintf(STDOUT, "Processing supply {$supply['caption']} ..." . PHP_EOL);
        $htmlOptimizer = new \enterprise\translate\HtmlOptimizer($supply['intro']);

        $sentences = $htmlOptimizer->split();
        $optimizedIntro = implode('<p>', $sentences);
        $optimizedSrcText = enterprise_translate_implode_fields($supply['caption'], $optimizedIntro);

        $totalChars += mb_strlen($optimizedSrcText, 'UTF-8');

        $translation = $translateClient->translate($optimizedSrcText, ['source' => 'zh', 'target' => $langCode]);
        $targetText = $translation['text'];
        list($caption, $translatedIntro) = enterprise_translate_explode_fields($targetText);

        // Recover Intro
        $fragments = explode('<p>', $translatedIntro);
        $description = $htmlOptimizer->combine($sentences, $fragments);

        enterprise_admin_save_product($langCode, $productId, $brandName, $modelNumber, $certification, $placeOfOrigin, $price, $paymentTerms, $supplyAbility, $headImageId, $images, $userSiteId, $caption, $description, $groupId, $minOrderQuantity, $deliveryTime, $packagingDetails, $specificationsArray, $tags);
    }

    $costs = floor($totalChars / 1000) * 0.02;
    fprintf(STDOUT, "Total Chars=%d, Costs=$%.2f" . PHP_EOL, $totalChars, $costs);

    return EXIT_SUCCESS;
}

exit(main($argc, $argv));