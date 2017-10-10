<?php
/**
 * 前端接口入口
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
        $responseArray = array();

        $groups = enterprise_get_group_list($siteId, $langCode);
        $responseGroupArray = [];
        if (is_array($groups)) foreach ($groups as $g) {
            $responseGroupArray[] = array(
                    'id' => $g['id'],
                    'groupname' => $g['name'],
                    'num' => $g['cnt'],
                    'url' => enterprise_url_product_list($g),
                );
        }
        $responseArray['category'] = $responseGroupArray;

        header("Content-Type: application/json");
        echo json_encode($responseArray);

    } catch(HttpException $he) {
        http_response_code($he->getCode());
    } catch (\RuntimeException $e) {
        $smarty->assign('message', $e->getMessage());
        $smarty->display('message.tpl');
    } catch(\DomainException $e) {
        header('DomainException: ' . $e->getMessage());
        break;
    }
} while(exit(1));
