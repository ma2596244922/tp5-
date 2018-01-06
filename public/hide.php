<?php
/**
 * 屏蔽功能入口
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../') . '/config.php';

// 根据当前请求的域名，找出对应的站点替换规则
try {
    list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();
} catch(HttpException $he) {
    header('Step: ESI');
    http_response_code($he->getCode());
    exit(1);
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');
$smarty->addPluginsDir(realpath(__DIR__ . '/../') . '/plugins/');
$smarty->loadFilter("pre", 'whitespace_control');

$ipAreaMainlandProvinceList = array (
    '中国' => 0,
    '北京市' => 1,
    '天津市' => 2,
    '河北省' => 3,
    '山西省' => 4,
    '内蒙古' => 5,
    '辽宁省' => 6,
    '吉林省' => 7,
    '黑龙江省' => 8,
    '上海市' => 9,
    '江苏省' => 10,
    '浙江省' => 11,
    '安徽省' => 12,
    '福建省' => 13,
    '江西省' => 14,
    '山东省' => 15,
    '河南省' => 16,
    '湖北省' => 17,
    '湖南省' => 18,
    '广东省' => 19,
    '广西' => 20,
    '海南省' => 21,
    '重庆市' => 22,
    '四川省' => 23,
    '贵州省' => 24,
    '云南省' => 25,
    '西藏' => 26,
    '陕西省' => 27,
    '甘肃省' => 28,
    '青海省' => 29,
    '宁夏' => 30,
    '新疆' => 31,
);

function enterprise_hide_ipaddr_in_white_list($hideSite, $ipAddr)
{
    return enterprise_hide_ipaddr_in_list($hideSite, $ipAddr, 'ipaddr_white_list');
}


function enterprise_hide_ipaddr_in_black_list($hideSite, $ipAddr)
{
    return enterprise_hide_ipaddr_in_list($hideSite, $ipAddr, 'ipaddr_black_list');
}

function enterprise_hide_ipaddr_in_list($hideSite, $ipAddr, $field)
{
    if (!$hideSite)
        return false;

    $linesString = $hideSite[$field];
    $linesArray = explode("\n", $linesString);
    foreach ($linesArray as $line) {
        $ipPattern = trim($line);
        $r = enterprise_match_ipaddr_with_wildcard($ipAddr, $ipPattern);
        if ($r)
            return true;
    }

    return false;
}

function enterprise_hide_route($smarty, $siteId)
{
    $action = timandes_get_query_data('a');
    switch ($action) {
        case 't':
            enterprise_hide_action_track($smarty, $siteId);
            break;
        default:
            enterprise_hide_action_default($smarty, $siteId);
            break;
    }
}

function enterprise_hide_action_track($smarty, $siteId)
{
    $ipAddr = timandes_get_remote_addr();

    $hit = (int)timandes_get_query_data('h');
    enterprise_hide_append_track($siteId, $ipAddr, $hit);

    header("Content-Type: text/javascript");
}

function enterprise_hide_append_track($siteId, $ipAddr, $hit = \hide\daos\Track::HIT_IP)
{
    $hideTrackDAO = new \hide\daos\Track();
    $refererPath = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_PATH);
    $values = array(
            'site_id' => $siteId,
            'ipaddr' => ip2long($ipAddr),
            'ua' => $_SERVER['HTTP_USER_AGENT'],
            'path' => $refererPath,
            'hit' => $hit,
            'created' => date('Y-m-d H:i:s'),
        );
    $hideTrackDAO->insert($values);
}


function enterprise_hide_action_default($smarty, $siteId)
{
    global $ipAreaMainlandProvinceList;

    $ipAddr = timandes_get_remote_addr();
    $hideSite = enterprise_get_hide_site_info($siteId);
    if ($hideSite
            && $hideSite['enabled']
            && !enterprise_hide_ipaddr_in_white_list($hideSite, $ipAddr)) {
        // IP
        if ($hideSite['hide_by_ipaddr']) {
            // Hide now?
            $r = enterprise_iparea_get_info_from_addr($ipAddr);
            $hideNow = false;
            if ($r
                    && array_key_exists('province', $r)
                    && in_array($r['province'], $ipAreaMainlandProvinceList))
                $hideNow = true;
            elseif (enterprise_hide_ipaddr_in_black_list($hideSite, $ipAddr))
                $hideNow = true;
            // Track
            if ($hideNow) {
                enterprise_hide_append_track($siteId, $ipAddr);
            }

            $smarty->assign('hide_now', $hideNow);
        }
        // Browser & OS
        $smarty->assign('hide_by_browser', $hideSite['hide_by_browser']);
        $smarty->assign('hide_by_os', $hideSite['hide_by_os']);
        // Redirect URL
        if ($hideSite['target_page'] == \hide\daos\Track::TARGET_PAGE_REDIRECT)
            $smarty->assign('redirect_url', $hideSite['target_page_url']);
    }

    header("Content-Type: text/javascript");
    $smarty->display('hide.tpl');
}

do {
    try {
/* {{{ 重复代码段 */
retry:
        $site = enterprise_get_site_info($siteId, $langCode);
        if (!$site)
            break;// continue routing
        if ($site['offline'])
            break;// continue routing

        if ($site['default_lang_code'] != $GLOBALS['gsDefaultLangCode']) {
            enterprise_set_default_lang_code($site['default_lang_code']);
            // 重新获取语言代码信息
            list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();
            goto retry;
        }

        if ($site['product_default_image'])
            $GLOBALS['gsProductDefaultImageUrl'] = enterprise_url_image($site['product_default_image']);

        enterprise_define_url_pattern_constants($site);
/* }}} */
        // 核心业务逻辑
        enterprise_hide_route($smarty, $siteId);

    } catch(HttpException $he) {
        http_response_code($he->getCode());
    } catch(\Exception $e) {
        http_response_code(500);
        error_log($e->getMessage());
        break;
    }
} while(exit(1));
