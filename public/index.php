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


function enterprise_print_cnzz($meta)
{
    if (!isset($meta['id'])
            || !$meta['id'])
        return;

    $paramShow = '';
    if (isset($meta['pic'])
            && $meta['pic'])
        $paramShow = '%26show%3Dpic' . $meta['pic'];

    echo <<<EOT
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_{$meta['id']}'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/z_stat.php%3Fid%3D{$meta['id']}{$paramShow}' type='text/javascript'%3E%3C/script%3E"));</script>
EOT;
}

// 根据当前请求的域名，找出对应的站点替换规则
try {
    list($siteId, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
} catch(HttpException $he) {
    http_response_code($he->getCode());
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
// + Page
$pageDAO = new \crawler\daos\Page();
$page = $pageDAO->getByUrlSum($urlSum);
if ($page) {
    if ($page['status_code'] != 200) {
        http_response_code($page['status_code']);
        exit(1);
    }

    $content = $page['content'];
    $content = str_replace('<script type=text/javascript src="/webim/webim.js"></script>', '', $content);
    $content = str_replace($originalDomainSuffix, $currentDomainSuffix, $content);
    $content = str_replace('//www.google-analytics.com/analytics.js', '', $content);
    echo $content;

    // CNZZ
    if (isset($domainInfo[$currentDomainSuffix]['cnzz'])
            && is_array($domainInfo[$currentDomainSuffix]['cnzz']))
        enterprise_print_cnzz($domainInfo[$currentDomainSuffix]['cnzz']);
    exit(0);
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

        header('Content-Type: ' . $image['content_type']);
        echo $image['content'];
        exit(0);
    }
}

// 其次匹配特殊页面
$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');

if ($requestPath == '/contactsave.html') {
    enterprise_action_save_inquiry_proc($smarty, $siteId);
}

http_response_code(404);
exit(1);

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');

$siteId = 1;
$domain = 'snackmakingmachineoff.com';
$translationDAO = new \crawler\daos\Translation();
$rows = $translationDAO->getBySite($siteId);
$translations = array();
foreach ($rows as $row) {
    $row['abbr'] = \crawler\daos\Translation::locale2Abbr($row['locale']);
    $row['text'] = \crawler\daos\Translation::locale2Text($row['locale']);
    $row['url'] = 'http://' . $row['locale'] . '.' . $domain . '/';
    $translations[] = $row;
}
$smarty->assign('translations', $translations);

$smarty->display('index.tpl');
