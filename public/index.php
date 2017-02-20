<?php
/**
 * 项目入口
 *
 * @package timandes\enterprise
 */

// default timezone
date_default_timezone_set("Asia/Shanghai");

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

require_once realpath(__DIR__ . '/../') . '/vendor/autoload.php';
require_once realpath(__DIR__ . '/../') . '/config.php';
require_once realpath(__DIR__ . '/../') . '/enterprise.h.php';
require_once realpath(__DIR__ . '/../') . '/sites.php';
require_once realpath(__DIR__ . '/../') . '/images.php';

// 根据当前请求的域名，找出对应的站点替换规则
try {
    list($siteId, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
} catch(HttpException $he) {
    http_response_code($he->getCode());
    exit(1);
}

// abc.com ==(301)=> www.abc.com
if (!$locale) {
    header('Location: http://www.' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
    exit(1);
}

// 优先使用本地存储的页面、图片和资源等
$requestRelativeURI = $_SERVER['REQUEST_URI'];
$fakeRequestHost = str_replace($currentDomainSuffix, $originalDomainSuffix, $_SERVER['HTTP_HOST']);
$requestURL = 'http://' . $fakeRequestHost . $requestRelativeURI;
$requestPath = parse_url($requestURL, PHP_URL_PATH);
$urlSum = md5($requestURL, true);
$pathSum = md5($requestPath, true);
// + 无法收集且毫无用处的URL
$pageBlackList = array(
        '/stats.js' => 'application/x-javascript',
        '/images/loadingAnimation.gif' => 'image/gif',
    );
if (isset($pageBlackList[$requestPath])) {
    $contentType = $pageBlackList[$requestPath];
    header('Content-Type: ' . $contentType);
    exit(0);
}
// + Custom actions
// ++ Sitemap
if (preg_match('/^\/sitemap\/([a-z]+)\.xml$/', $requestPath, $matches)) {
    $sitemapLocale = $matches[1];
    if ($sitemapLocale == 'index')
        enterprise_action_sitemap_index_proc($siteId, $currentDomainSuffix);// Terminated
    else
        enterprise_action_sitemap_proc($siteId, $originalDomainSuffix, $currentDomainSuffix, $sitemapLocale);// Terminated
} elseif(preg_match('/^\/uploaded_images\/([a-z]?)([0-9]+)(-[0-9a-z]+)*\.jpg$/', $requestPath, $matches)) {
    $char = $matches[1];
    $imageId = $matches[2];
    enterprise_action_uploaded_image_proc($char, $imageId);// Terminated
}
// ++ Custom pages
if (isset($domainInfo[$currentDomainSuffix]['custom_pages'])
        && is_array($domainInfo[$currentDomainSuffix]['custom_pages'])
        && $domainInfo[$currentDomainSuffix]['custom_pages']) {
    foreach ($domainInfo[$currentDomainSuffix]['custom_pages'] as $p => $c) {
        if ($p == $requestPath) {
            echo $c;
            exit(0);
        }
    }
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');
$smarty->addPluginsDir(realpath(__DIR__ . '/../') . '/plugins/');

// + Page
$skippingPages = array(
        '/contactsave.html',
    );
if (!in_array($requestPath, $skippingPages)) {
    $pageDAO = new \crawler\daos\Page();
    $page = $pageDAO->getByUrlSum($urlSum);
    if ($page) {
        if ($page['status_code'] != 200) {
            http_response_code($page['status_code']);
            exit(1);
        }

        // Cache control
        header('Cache-Control: max-age=86400');

        $response = enterprise_filter_response($page['content'], $originalDomainSuffix, $currentDomainSuffix);
        // Replace group list
        $response = enterprise_response_replace_group_list($smarty, $siteId, $response);

        echo $response;

        // CNZZ
        enterprise_output_cnzz($currentDomainSuffix);

        // float2006.tq.cn
        if ($currentDomainSuffix == 'syrianeducation.org'
                && $requestPath != '/contactnow.html')
            echo '<SCRIPT LANGUAGE="JavaScript" src=http://float2006.tq.cn/floatcard?adminid=9772016&sort=0 ></SCRIPT>';
        exit(0);
    }
}
// + Image N Resource
$daos = array(
        new \crawler\daos\Image(),
        new \crawler\daos\Resource(),
    );
foreach ($daos as $dao) {
    $image = $dao->getByMutex($siteId, $pathSum);
    if ($image) {
        if ($image['status_code'] != 200) {
            http_response_code($image['status_code']);
            exit(1);
        }

        // Cache control
        header('Cache-Control: max-age=2592000');

        header('Content-Type: ' . $image['content_type']);
        echo $image['content'];
        exit(0);
    }
}

// 其次匹配特殊页面

try {
    enterprise_route($smarty, $requestPath, $siteId, $originalDomainSuffix, $currentDomainSuffix);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    $smarty->assign('message', $e->getMessage());
    $smarty->display('message.tpl');
}
