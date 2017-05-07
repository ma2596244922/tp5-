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

function enterprise_admin_route($smarty)
{
    list($siteId, $platform, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
    $action = timandes_get_query_data('action');
    switch ($action) {
        case 'captcha':
            return enterprise_admin_action_captcha($smarty);
        case 'logout':
            return enterprise_admin_action_logout($smarty);
        case 'login':
            return enterprise_admin_action_login($smarty, $siteId);
        default:
            $user = enterprise_admin_grant_permission($siteId);
            $smarty->assign('user', $user);

            $userSiteId = (int)timandes_get_session_data('user_site_id');
            enterprise_assign_site_info($smarty, 'site', $userSiteId);
            $site = $smarty->getTemplateVars('site');
            if (!$site) {// 复制的站点通常没有`enterprise_sites`表记录
                $site = array(
                        'site_id' => $userSiteId,
                    );
            }

            switch ($action) {
                case 'user_voices':
                    return enterprise_admin_action_user_voices($smarty, $site);
                case 'index_products':
                    return enterprise_admin_action_index_products($smarty, $site);
                case 'message':
                    return enterprise_admin_action_message($smarty);
                case 'email_template':
                    return enterprise_admin_action_email_template($smarty, $currentDomainSuffix);
                case 'upload_image':
                    return enterprise_admin_action_upload_image($smarty);
                case 'profile':
                    return enterprise_admin_action_profile($smarty);
                case 'fragment':
                    return enterprise_admin_action_fragment($smarty);
                case 'logo':
                    return enterprise_admin_action_logo($smarty);
                case 'info':
                    return enterprise_admin_action_info($smarty);
                case 'password':
                    return enterprise_admin_action_password($smarty);
                case 'inquiry':
                    return enterprise_admin_action_inquiry($smarty);
                case 'inquiry_detail':
                    return enterprise_admin_action_inquiry_detail($smarty);
                case 'delete_inquiry':
                    return enterprise_admin_action_delete_inquiry($smarty, $site);
                case 'group':
                    return enterprise_admin_action_group($smarty);
                case 'edit_group':
                    return enterprise_admin_action_edit_group($smarty, $site);
                case 'delete_group':
                    return enterprise_admin_action_delete_group($smarty, $site);
                case 'count_products':
                    return enterprise_admin_action_count_products($smarty);
                case 'product':
                    return enterprise_admin_action_product($smarty);
                case 'edit_product':
                    return enterprise_admin_action_edit_product($smarty, $site);
                case 'delete_product':
                    return enterprise_admin_action_delete_product($smarty, $site);
                case 'edit_product_tdk':
                    return enterprise_admin_action_edit_product_tdk($smarty, $site);
                case 'edit_product_url':
                    return enterprise_admin_action_edit_product_url($smarty, $site);
                case 'insert_keywords':
                    return enterprise_admin_action_insert_keywords($smarty);
                case 'replace_keywords':
                    return enterprise_admin_action_replace_keywords($smarty);
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

session_start();

try {
    enterprise_admin_route($smarty);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    enterprise_admin_display_error_msg($smarty, $e->getMessage());
}
