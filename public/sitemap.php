<?php
/**
 * Sitemap
 *
 * @package timandes\enterprise
 */

// default timezone
date_default_timezone_set("Asia/Shanghai");

require_once realpath(__DIR__ . '/../') . '/vendor/autoload.php';
require_once realpath(__DIR__ . '/../') . '/config.php';

// TODO:
$siteId = 1;
$originalDomainSuffix = 'snackmakingmachine.com';
$currentDomainSuffix = 'snackmakingmachineoff.com';
$locale = 'english';

$pageDAO = new \crawler\daos\Page();
$curId = 0;
$urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 
do {
    $pages = $pageDAO->getBySite($siteId, $locale, $curId);
    if (!$pages)
        break;

    foreach ($pages as $page) {
        $curId = max($curId, $page['id']);

        $loc = str_replace($originalDomainSuffix, $currentDomainSuffix, $page['url']);
        $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
        $urlSet->addUrl($url);
    }
} while(true);

header('Content-Type: text/xml; utf-8');
echo (new Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
