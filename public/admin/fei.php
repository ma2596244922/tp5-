<?php
/**
 * 用户后台 - 前端接口入口
 *
 * @package timandes\enterprise
 */

require_once __DIR__ . '/bootstrap.php';
require_once realpath(__DIR__ . '/../../') . '/config_admin.php';

function enterprise_admin_fei_get_error_response($code, $msg)
{
    return array(
            'code' => $code,
            'message' => $msg,
        );
}

function enterprise_admin_fei_respond($response)
{
    $responseMsg = json_encode($response);
    header("Content-Type: application/json");
    echo $responseMsg;
}

function enterprise_admin_fei_respond_error($code, $msg)
{
    $response = enterprise_admin_fei_get_error_response($code, $msg);
    enterprise_admin_fei_respond($response);
}

function enterprise_admin_fei_action_get_url_of_keyword($site, $langCode)
{
    $keywordLines = timandes_get_post_data('keyword_lines');
    $keywordLineArray = explode("\n", $keywordLines);
    $retval = [];
    foreach ($keywordLineArray as $k) {
        $k = trim($k);
        if (!$k)
            continue;

        $a = array(
                'keyword' => $k,
                'url' => enterprise_url_product_search($k),
            );
        $retval[] = $a;
    }
    return $retval;
}

function enterprise_admin_fei_route($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    // Current User
    $user = enterprise_admin_check_permission($siteId);
    if (!$user)
        throw new \RuntimeException('Permission Denied');

/* {{{ 重复代码段 */
retry:
            // Site Info
            $userSiteId = (int)timandes_get_session_data('user_site_id');
            $site = enterprise_get_site_info($userSiteId, $langCode);
            if (!$site) {// 复制的站点通常没有`enterprise_sites`表记录
                $site = array(
                        'site_id' => $userSiteId,
                    );
            }
            // ++ OMS Site Info
            $omsSiteDAO = new \oms\daos\Site();
            $omsSite = $omsSiteDAO->get($userSiteId);

            if ($site['default_lang_code'] != $GLOBALS['gsDefaultLangCode']) {
                enterprise_set_default_lang_code($site['default_lang_code']);
                // 重新获取语言代码信息
                list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();
                goto retry;
            }

            enterprise_define_url_pattern_constants($site);
/* }}} */

    $action = timandes_get_query_data('action');
    switch ($action) {
        default:
            return enterprise_admin_fei_action_get_url_of_keyword($site, $langCode);
    }
}

list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();

ini_set('session.cookie_domain', '.' . $currentDomainSuffix);
session_start();

try {
    $response = enterprise_admin_fei_route($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_admin_fei_respond($response);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    enterprise_admin_fei_respond_error(1, $e->getMessage());
}