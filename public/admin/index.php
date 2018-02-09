<?php
/**
 * 用户后台入口
 *
 * @package timandes\enterprise
 */

define('SESSION_FIELD_USER_ID', 'user_id');
define('SESSION_FIELD_CAPTCHA_PHRASE', 'captcha_phrase');

require_once realpath(__DIR__ . '/../../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../../') . '/config_admin.php';

function enterprise_admin_route($smarty, $siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    $action = timandes_get_query_data('action');
    switch ($action) {
        case 'captcha':
            return enterprise_admin_action_captcha($smarty);
        case 'logout':
            return enterprise_admin_action_logout($smarty);
        case 'login':
            return enterprise_admin_action_login($smarty, $siteId);
        case 'super_login':
            return enterprise_admin_action_super_login($smarty);
        default:
            // Current User
            $user = enterprise_admin_grant_permission($siteId);
            $smarty->assign('user', $user);
retry:
            // Site Info
            $userSiteId = (int)timandes_get_session_data('user_site_id');
            enterprise_assign_site_info($smarty, 'site', $userSiteId, $langCode);
            $site = $smarty->getTemplateVars('site');
            if (!$site) {// 复制的站点通常没有`enterprise_sites`表记录
                $site = array(
                        'site_id' => $userSiteId,
                    );
            }
            // ++ OMS Site Info
            $omsSiteDAO = new \oms\daos\Site();
            $omsSite = $omsSiteDAO->get($userSiteId);
            $smarty->assign('oms_site', $omsSite);

            if ($site['default_lang_code'] != $GLOBALS['gsDefaultLangCode']) {
                enterprise_set_default_lang_code($site['default_lang_code']);
                // 重新获取语言代码信息
                list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();
                goto retry;
            }

            $smarty->assign('default_lang_code', $GLOBALS['gsDefaultLangCode']);

            enterprise_define_url_pattern_constants($site);

            // Supported Language Codes
            $supportedLangCodes = \enterprise\daos\LangProduct::getSupportedLangCodes();
            $smarty->assign('supported_lang_codes', $supportedLangCodes);
            $smarty->assign('cur_lang_code', $langCode);

            // Domain suffix
            $smarty->assign('site_root_domain', $currentDomainSuffix);

            switch ($action) {
                case 'replace_terms':
                    return enterprise_admin_action_replace_terms($smarty, $site, $langCode);
                case 'duplicate_products':
                    return enterprise_admin_action_duplicate_products($smarty, $site, $langCode);
                case 'common_bg_image':
                    return enterprise_admin_action_common_bg_image($smarty);
                case 'product_default_image':
                    return enterprise_admin_action_product_default_image($smarty);
                case 'product_tdk':
                    return enterprise_admin_action_product_tdk($smarty, $site, $langCode);
                case 'index_tdk':
                    return enterprise_admin_action_index_tdk($smarty, $site, $langCode);
                case 'user_voices':
                    return enterprise_admin_action_user_voices($smarty, $site);
                case 'index_products':
                    return enterprise_admin_action_index_products($smarty, $site, $langCode);
                case 'message':
                    return enterprise_admin_action_message($smarty);
                case 'email_template':
                    return enterprise_admin_action_email_template($smarty, $site, $langCode, $currentDomainSuffix);
                case 'upload_image':
                    return enterprise_admin_action_upload_image($smarty);
                case 'profile':
                    return enterprise_admin_action_profile($smarty);
                case 'fragment':
                    return enterprise_admin_action_fragment($smarty);
                case 'favicon':
                    return enterprise_admin_action_favicon($smarty);
                case 'logo':
                    return enterprise_admin_action_logo($smarty);
                case 'hide':
                    return enterprise_admin_action_hide($smarty, $langCode);
                case 'hide_track':
                    return enterprise_admin_action_hide_track($smarty, $langCode);
                case 'info':
                    return enterprise_admin_action_info($smarty, $langCode);
                case 'password':
                    return enterprise_admin_action_password($smarty);
                case 'inquiry':
                    return enterprise_admin_action_inquiry($smarty);
                case 'inquiry_detail':
                    return enterprise_admin_action_inquiry_detail($smarty);
                case 'delete_inquiry':
                    return enterprise_admin_action_delete_inquiry($smarty, $site);
                case 'group':
                    return enterprise_admin_action_group($smarty, $site, $langCode);
                case 'edit_group':
                    return enterprise_admin_action_edit_group($smarty, $site, $langCode);
                case 'delete_group':
                    return enterprise_admin_action_delete_group($smarty, $site, $langCode);
                case 'edit_group_tdk':
                    return enterprise_admin_action_edit_group_tdk($smarty, $site);
                case 'edit_group_desc':
                    return enterprise_admin_action_edit_group_desc($smarty, $site);
                case 'export_group_products':
                    return enterprise_admin_action_export_group_products($smarty, $site, $langCode);
                case 'import_group_products':
                    return enterprise_admin_action_import_group_products($smarty, $site, $langCode);
                case 'remove_empty_caption_products':
                    return enterprise_admin_action_remove_empty_caption_products($smarty, $site, $langCode);
                case 'count_products':
                    return enterprise_admin_action_count_products($smarty, $site, $langCode);
                case 'product':
                    return enterprise_admin_action_product($smarty, $langCode);
                case 'edit_product':
                    return enterprise_admin_action_edit_product($smarty, $site, $langCode);
                case 'delete_product':
                    return enterprise_admin_action_delete_product($smarty, $site, $langCode);
                case 'edit_product_tdk':
                    return enterprise_admin_action_edit_product_tdk($smarty, $site);
                case 'edit_product_url':
                    return enterprise_admin_action_edit_product_url($smarty, $site);
                case 'insert_images':
                    return enterprise_admin_action_insert_images($smarty, $site, $langCode);
                case 'insert_desc':
                    return enterprise_admin_action_insert_desc($smarty, $site, $langCode);
                case 'insert_keywords':
                    return enterprise_admin_action_insert_keywords($smarty, $site, $langCode);
                case 'replace_desc_pic':
                    return enterprise_admin_action_replace_desc_pic($smarty, $site, $langCode);
                case 'replace_keywords':
                    return enterprise_admin_action_replace_keywords($smarty, $site, $langCode);
                case 'contact':
                    return enterprise_admin_action_contact($smarty);
                case 'edit_contact':
                    return enterprise_admin_action_edit_contact($smarty, $site);
                case 'delete_contact':
                    return enterprise_admin_action_delete_contact($smarty, $site);
                case 'photo':
                    return enterprise_admin_action_photo($smarty);
                case 'edit_photo':
                    return enterprise_admin_action_edit_photo($smarty, $site);
                case 'delete_photo':
                    return enterprise_admin_action_delete_photo($smarty, $site);
                case 'picture':
                    return enterprise_admin_action_picture($smarty);
                case 'edit_picture':
                    return enterprise_admin_action_edit_picture($smarty, $site);
                case 'delete_picture':
                    return enterprise_admin_action_delete_picture($smarty, $site);
                case 'certification':
                    return enterprise_admin_action_certification($smarty);
                case 'edit_certification':
                    return enterprise_admin_action_edit_certification($smarty, $site);
                case 'delete_certification':
                    return enterprise_admin_action_delete_certification($smarty, $site);
                case 'task':
                    return enterprise_admin_action_task($smarty);
                case 'edit_task':
                    return enterprise_admin_action_edit_task($smarty, $site);
                case 'delete_task':
                    return enterprise_admin_action_delete_task($smarty, $site);
                case 'banner':
                    return enterprise_admin_action_banner($smarty);
                case 'edit_banner':
                    return enterprise_admin_action_edit_banner($smarty, $site);
                case 'delete_banner':
                    return enterprise_admin_action_delete_banner($smarty, $site);
                case 'custom_page':
                    return enterprise_admin_action_custom_page($smarty);
                case 'edit_custom_page':
                    return enterprise_admin_action_edit_custom_page($smarty, $site);
                case 'delete_custom_page':
                    return enterprise_admin_action_delete_custom_page($smarty, $site);
                case 'comment':
                    return enterprise_admin_action_comment($smarty);
                case 'edit_comment':
                    return enterprise_admin_action_edit_comment($smarty, $site);
                case 'delete_comment':
                    return enterprise_admin_action_delete_comment($smarty, $site);
                case 'news':
                    return enterprise_admin_action_news($smarty, $site, $langCode);
                case 'edit_news':
                    return enterprise_admin_action_edit_news($smarty, $site, $langCode);
                case 'delete_news':
                    return enterprise_admin_action_delete_news($smarty, $site, $langCode);
                case 'user_voice':
                    return enterprise_admin_action_user_voice($smarty, $site, $langCode);
                case 'edit_user_voice':
                    return enterprise_admin_action_edit_user_voice($smarty, $site, $langCode);
                case 'delete_user_voice':
                    return enterprise_admin_action_delete_user_voice($smarty, $site, $langCode);
                case 'keyword':
                    return enterprise_admin_action_keyword($smarty, $site, $langCode);
                case 'create_keywords':
                    return enterprise_admin_action_create_keywords($smarty, $site, $langCode);
                case 'edit_keyword':
                    return enterprise_admin_action_edit_keyword($smarty, $site, $langCode);
                case 'delete_keyword':
                    return enterprise_admin_action_delete_keyword($smarty, $site, $langCode);
                case 'index_keyword':
                    return enterprise_admin_action_index_keyword($smarty, $site, $langCode);
                case 'edit_index_keyword':
                    return enterprise_admin_action_edit_index_keyword($smarty, $site, $langCode);
                case 'delete_index_keyword':
                    return enterprise_admin_action_delete_index_keyword($smarty, $site, $langCode);
                case 'main_product':
                    return enterprise_admin_action_main_product($smarty);
                case 'edit_main_product':
                    return enterprise_admin_action_edit_main_product($smarty, $site);
                case 'delete_main_product':
                    return enterprise_admin_action_delete_main_product($smarty, $site);
                case 'import_main_product':
                    return enterprise_admin_action_import_main_product($smarty, $site);
                default:
                    return enterprise_admin_action_dashboard($smarty);
            }
            
    }
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../') . '/templates_c/');
$smarty->addPluginsDir(realpath(__DIR__ . '/../../') . '/plugins/');
$smarty->loadFilter("pre", 'whitespace_control');

list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain) = enterprise_extract_site_infos();

ini_set('session.cookie_domain', '.' . $currentDomainSuffix);
session_start();

try {
    enterprise_admin_route($smarty, $siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    enterprise_admin_display_error_msg($smarty, $e->getMessage());
}
