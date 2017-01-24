<?php
/**
 * 项目入口
 *
 * @package timandes\enterprise
 */

// default timezone
date_default_timezone_set("Asia/Shanghai");

require_once realpath(__DIR__ . '/../') . '/vendor/autoload.php';
require_once realpath(__DIR__ . '/../') . '/config.php';
require_once realpath(__DIR__ . '/../') . '/enterprise.h.php';

function enterprise_generate_guid()
{
    return md5(uniqid(mt_rand(), true), true);
}

/**
 * 过滤参数值
 *
 * @param mixed $mValue 参数值
 * @param string $sFilters 过滤函数清单
 * @return mixed
 */
function enterprise_filter($mValue, $sFilters = 'trim, strip_tags')
{
    if (!is_string($mValue))
        return $mValue; // skip non-string

    // 使用过滤函数
    if(!empty($sFilters)) {
        $aFilters = explode(',', $sFilters);
        if(is_array($aFilters)) foreach($aFilters as $f) {
            $f = trim($f);
            eval("\$mValue = {$f}(\$mValue);");
        }
    }

    return $mValue;
}

function enterprise_get_post_data($key, $filters = 'trim, strip_tags')
{
    $v = (isset($_POST[$key])?$_POST[$key]:'');
    return enterprise_filter($v, $filters);
}

// TODO:
$siteId = 1;
$originalDomainSuffix = 'snackmakingmachine.com';
$currentDomainSuffix = 'snackmakingmachineoff.com';

// 根据当前请求的域名，找出对应的站点替换规则
$domainInfo = array(
        'snackmakingmachineoff.com' => 1,
        'snackmakingmachinetest.com' => 1,
        'snackmakingmachine.com' => 1,
        'beauty-equipments.com' => 2,
        'popost.com' => 2,
        'laser-liposuction-equipment.com' => 2,
        'best-laser.com' => 3,
    );
$siteInfo = array(
        1 => 'snackmakingmachine.com',
        2 => 'beauty-equipments.com',
        3 => 'best-laser.com',
    );
$a = explode('.', $_SERVER['HTTP_HOST']);
$n = count($a);
if ($n < 3) {
    http_response_code(403);
    exit(1);
}
$currentDomainSuffix = $a[$n-2] . '.' . $a[$n-1];
$locale = ($a[$n-3]=='www'?'english':$a[$n-3]);
if (!isset($domainInfo[$currentDomainSuffix])) {
    http_response_code(404);
    exit(1);
}
$siteId = $domainInfo[$currentDomainSuffix];
if (!isset($siteInfo[$siteId])) {
    http_response_code(404);
    exit(1);
}
$originalDomainSuffix = $siteInfo[$siteId];

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
if (preg_match('/^\/sitemap\/([a-z]+)\.xml$/', $requestPath, $matches)) {
    $sitemapLocale = $matches[1];
    if ($sitemapLocale == 'index')
        enterprise_action_sitemap_index_proc($siteId, $currentDomainSuffix);// Terminated
    else
        enterprise_action_sitemap_proc($siteId, $originalDomainSuffix, $currentDomainSuffix, $sitemapLocale);// Terminated
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
    echo $content;
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
    // Upload filess
    $attachmentDAO = new \enterprise\daos\Attachment();
    $attachments = array();
    foreach ($_FILES as $meta) {
        if ($meta['error'])
            continue;
        $body = file_get_contents($meta['tmp_name']);
        $contentType = $meta['type'];
        $guid = enterprise_generate_guid();
        $values = array(
                'guid' => $guid,
                'body' => $body,
                'content_type' => $contentType,
                'created' => date('Y-m-d H:i:s'),
            );
        $id = $attachmentDAO->insert($values);
        $attachments[] = bin2hex($guid);
    }
    // Create inquiry
    $inquiryDAO = new \enterprise\daos\Inquiry();
    $guid = enterprise_generate_guid();
    $values = array(
            'guid' => $guid,
            'subject' => enterprise_get_post_data('subject'),
            'message' => enterprise_get_post_data('message', 'trim'),
            'courtesy_title' => enterprise_get_post_data('gender'),
            'company' => enterprise_get_post_data('company'),
            'tel' => enterprise_get_post_data('tel'),
            'fax' => enterprise_get_post_data('fax'),
            'website' => enterprise_get_post_data('senderwebsite'),
            'country' => enterprise_get_post_data('country'),
            'contact' => enterprise_get_post_data('name'),
            'email' => enterprise_get_post_data('email'),
            'price_n_terms' => enterprise_get_post_data('incoterm'),
            'payment' => enterprise_get_post_data('payment'),
            'initial_order' => enterprise_get_post_data('order'),
            'sample_terms' => enterprise_get_post_data('sample'),
            'request_specifications' => enterprise_get_post_data('othersc'),
            'request_company_description' => enterprise_get_post_data('othercd'),
            'request_deliver_time' => enterprise_get_post_data('otherscdt'),
            'contact_within_24h' => enterprise_get_post_data('iscontact'),
            'email_me_updates' => enterprise_get_post_data('newsletter'),
            'site_id' => $siteId,
            'attachments' => $attachments,
            'created' => date('Y-m-d H:i:s'),
        );
    $inquiryDAO->insert($values);
    $smarty->display('inquiry_sent.tpl');
    exit(0);
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
