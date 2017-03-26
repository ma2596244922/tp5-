<?php
/**
 * 用户后台入口
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../../') . '/config_admin.php';

function enterprise_admin_route($smarty)
{
    list($siteId, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
    $action = enterprise_get_query_data('action');
    switch ($action) {
        case 'logout':
            return enterprise_admin_action_logout($smarty);
        case 'login':
            return enterprise_admin_action_login($smarty, $siteId);
        default:
            $userId = enterprise_admin_grant_permission($siteId);
            enterprise_admin_assign_user_info($smarty, 'user', $userId);
            switch ($action) {
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
                case 'group':
                    return enterprise_admin_action_group($smarty);
                case 'edit_group':
                    return enterprise_admin_action_edit_group($smarty);
                case 'delete_group':
                    return enterprise_admin_action_delete_group($smarty);
                case 'product':
                    return enterprise_admin_action_product($smarty);
                case 'edit_product':
                    return enterprise_admin_action_edit_product($smarty);
                case 'delete_product':
                    return enterprise_admin_action_delete_product($smarty);
                case 'contact':
                    return enterprise_admin_action_contact($smarty);
                case 'edit_contact':
                    return enterprise_admin_action_edit_contact($smarty);
                case 'delete_contact':
                    return enterprise_admin_action_delete_contact($smarty);
                case 'photo':
                    return enterprise_admin_action_photo($smarty);
                case 'edit_photo':
                    return enterprise_admin_action_edit_photo($smarty);
                case 'delete_photo':
                    return enterprise_admin_action_delete_photo($smarty);
                case 'certification':
                    return enterprise_admin_action_certification($smarty);
                case 'edit_certification':
                    return enterprise_admin_action_edit_certification($smarty);
                case 'delete_certification':
                    return enterprise_admin_action_delete_certification($smarty);
                case 'task':
                    return enterprise_admin_action_task($smarty);
                case 'edit_task':
                    return enterprise_admin_action_edit_task($smarty);
                case 'delete_task':
                    return enterprise_admin_action_delete_task($smarty);
                case 'banner':
                    return enterprise_admin_action_banner($smarty);
                case 'edit_banner':
                    return enterprise_admin_action_edit_banner($smarty);
                case 'delete_banner':
                    return enterprise_admin_action_delete_banner($smarty);
                default:
                    return enterprise_admin_action_dashboard($smarty);
            }
            
    }
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../') . '/templates_c/');
$smarty->addPluginsDir(realpath(__DIR__ . '/../../') . '/plugins/');

session_start();

try {
    enterprise_admin_route($smarty);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    $smarty->assign('message', $e->getMessage());
    $smarty->display('admin/message.tpl');
}
