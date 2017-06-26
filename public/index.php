<?php
/**
 * 项目入口
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../') . '/config.php';
require_once realpath(__DIR__ . '/../') . '/settings.php';

// User Agent Parser
$userAgent = new Jenssegers\Agent\Agent();

// 根据当前请求的域名，找出对应的站点替换规则
try {
    list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
} catch(HttpException $he) {
    header('Step: ESI');
    http_response_code($he->getCode());
    exit(1);
}

// abc.com ==(301)=> www.abc.com
if (!$locale) {
    $subdomain = ($userAgent->isMobile()?'m':'www');
    header('Location: http://' . $subdomain . '.' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
    http_response_code(301);
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
        enterprise_action_sitemap_index_proc($siteId, $platform, $langCode, $currentDomainSuffix);// Terminated
    elseif ($sitemapLocale == 'product')
        enterprise_action_sitemap_proc_2($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, 1);// Terminated
    elseif ($sitemapLocale == 'group')
        enterprise_action_sitemap_group_proc($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, 1);// Terminated
    elseif ($sitemapLocale == 'core')
        enterprise_action_sitemap_core_proc($siteId, $originalDomainSuffix, $currentDomainSuffix, 1);// Terminated
    else
        enterprise_action_sitemap_proc($siteId, $originalDomainSuffix, $currentDomainSuffix, $sitemapLocale);// Terminated
} elseif (preg_match('/^\/sitemap\/product(-([0-9]+))?\.xml$/', $requestPath, $matches)) {
    if (isset($matches[2]))
        $no = (int)$matches[2];
    else
        $no = 1;
    enterprise_action_sitemap_proc_2($siteId, $originalDomainSuffix, $currentDomainSuffix, $no);// Terminated
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
$smarty->loadFilter("pre", 'whitespace_control');

// + 警告：这个新的Router是来截胡的
do {
    try {
        enterprise_load_preset_translations($smarty, $langCode);

        $site = enterprise_get_site_info($siteId, $langCode);
        if (!$site)
            break;// continue routing
        if ($site['product_default_image'])
            $GLOBALS['gsProductDefaultImageUrl'] = enterprise_url_image($site['product_default_image']);

        $response = enterprise_route_2($smarty, $site, $userAgent, $siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $requestURL, $requestPath, $pathSum);
        if (null === $response)
            break;// continue routing

        // Track
        $trackDAO = new \enterprise\daos\Track();
        $values = array(
                'site_id' => $siteId,
                'ipv4' => ip2long(timandes_get_remote_addr()),
                'path' => $_SERVER['REQUEST_URI'],
                'created' => date('Y-m-d H:i:s'),
            );
        $trackDAO->insert($values);

        // Cache-Control
        header('Cache-Control: no-cache');

        echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
        enterprise_output_cnzz($currentDomainSuffix);
    } catch(HttpException $he) {
        http_response_code($he->getCode());
    } catch (\RuntimeException $e) {
        $smarty->assign('message', $e->getMessage());
        $smarty->display('message.tpl');
    } catch(\DomainException $e) {
        header('DomainException: ' . $e->getMessage());
        http_response_code(404);
    }
} while(exit(1));

/**
 * 响应抓取到的页面
 *
 * @return bool 成功返回true，否则返回false
 */
function enterprise_response_crawled_page($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $urlSum)
{
    $pageDAO = new \crawler\daos\Page();
    $page = $pageDAO->getByUrlSum($urlSum);
    if (!$page)
        return;

    if ($page['status_code'] != 200) {
        http_response_code($page['status_code']);
        exit(1);
    }

    // Cache control
    header('Cache-Control: max-age=86400');

    $response = enterprise_filter_response($page['content'], $originalDomainSuffix, $currentDomainSuffix);
    // Replace group list
    $response = enterprise_response_replace_group_list($smarty, $siteId, $response);
    // Replace Corporation name
    if ($currentDomainSuffix == 'syrianeducation.org') {
        $response = str_ireplace('BEIJING MEDICAL BEAUTY COMMERCE CO.,LTD', 'Jinan Color Laser Beauty Co.,Ltd', $response);
        $response = str_ireplace('annie@ipl-rf.com.cn', 'robertjean68@yahoo.com', $response);//Email
        $response = str_ireplace('ipllaser@yahoo.cn', '', $response);//Yahoo
        $response = str_ireplace('annie-beautyequipment', '694118602@qq.com', $response);//Skype
        $response = str_ireplace('Yard 6,East Rd.,Nanchang 1st Village, Jiugong Town, Daxing District, Beijing, China', 'No.28, Nanquanfu Street, Licheng District, Jinan, Shandong, China', $response);//Address
        $response = str_ireplace('86-10-67506021', '', $response);//Business Phone :  (Working time)
        $response = str_ireplace('86--18801419856', '', $response);//Business Phone :  (Nonworking time)
        $response = str_ireplace('86--67506021-888', '', $response);//Fax
        $response = str_ireplace('Mrs. Annie Yu', '', $response);//Contact1
        $response = str_ireplace('Sales manager', '', $response);//Contact1-Title
        $response = str_ireplace('18801419856', '', $response);//Contact1-Business Phone
        $response = str_ireplace('8613161280838', '', $response);//Contact1-WHATSAPP
        $response = str_ireplace('Miss. Annie', '', $response);//Contact2
        $response = str_ireplace('86-18801419856', '', $response);//Contact2-VIBER 
        $response = str_ireplace('Beijingmedicalbeauty', '', $response);//Contact2-Skype
    } elseif ($currentDomainSuffix == 'ltbtv.com.cn') {
        $response = str_ireplace('Hangzhou FAMOUS Steel Engineering Co.,Ltd.', 'Hangzhou top Steel Engineering Co.,Ltd.', $response);
        $response = str_ireplace('Shangsan village 288#, Xindeng town, Fuyan City, Hangzhou, China.', '', $response);
        $response = str_ireplace('86-571-87688170', '', $response);//Business Phone :  (Working time)
        $response = str_ireplace('86-571-56389287', '', $response);//Fax
        $response = str_ireplace('86--18072735884', '', $response);//Business Phone :  (Nonworking time)
        $response = str_ireplace('sales@hfsteelstructure.com', 'robertjean68@yahoo.com', $response);//Email
        $response = str_ireplace('honesty.tomi@yahoo.com', '', $response);//Yahoo
        $response = str_ireplace('bluesky4912', '694118602@qq.com', $response);//Skype
        $response = str_ireplace('https://www.youtube.com/watch?v=g1SvKYhZibo&feature=youtu.be', '', $response);//ICQ
    } elseif ($currentDomainSuffix == 'mocfa.org') {
        $response = str_ireplace('NINGBO DEEPBLUE SMARTHOUSE CO.,LTD', 'G home Co.,Ltd.', $response);
        $response = str_ireplace('david@mocfa.org', 'robertjean68@yahoo.com', $response);//Email
        $response = str_ireplace('chinhy', '694118602@qq.com', $response);//Skype
        $response = str_ireplace('/logo.gif', '/logo.gif?t=123', $response);
    }

    echo $response;

    // CNZZ
    enterprise_output_cnzz($currentDomainSuffix);

    if ($currentDomainSuffix == 'peanut-buttermachines.com')
        echo '<SCRIPT LANGUAGE="JavaScript" src=http://float2006.tq.cn/floatcard?adminid=9772016&sort=0 ></SCRIPT>';

    exit(0);
}

// + Page
$skippingPages = array(
        '/contactsave.html',
    );
if (!in_array($requestPath, $skippingPages)) {
    enterprise_response_crawled_page($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $urlSum);
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
    enterprise_route($smarty, $siteId, $platform, $originalDomainSuffix, $currentDomainSuffix, $requestURL);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    $smarty->assign('message', $e->getMessage());
    $smarty->display('message.tpl');
}
