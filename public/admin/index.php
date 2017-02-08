<?php
/**
 * 用户后台入口
 *
 * @package timandes\enterprise
 */

// default timezone
date_default_timezone_set("Asia/Shanghai");

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

require_once realpath(__DIR__ . '/../../') . '/vendor/autoload.php';
require_once realpath(__DIR__ . '/../../') . '/config_admin.php';
require_once realpath(__DIR__ . '/../../') . '/enterprise.h.php';
require_once realpath(__DIR__ . '/../../') . '/enterprise_admin.h.php';

function enterprise_admin_route($smarty)
{
    $action = enterprise_get_query_data('action');
    switch ($action) {
        case 'logout':
            return enterprise_admin_action_logout($smarty);
        case 'login':
            return enterprise_admin_action_login($smarty);
        default:
            $userId = enterprise_admin_grant_permission();
            enterprise_admin_assign_user_info($smarty, 'user', $userId);
            switch ($action) {
                case 'password':
                    return enterprise_admin_action_password($smarty);
                case 'inquiry':
                    return enterprise_admin_action_inquiry($smarty);
                case 'inquiry_detail':
                    return enterprise_admin_action_inquiry_detail($smarty);
                default:
                    return enterprise_admin_action_dashboard($smarty);
            }
            
    }
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../') . '/templates_c/');

session_start();

try {
    enterprise_admin_route($smarty);
} catch (\RuntimeException $e) {
    $smarty->assign('message', $e->getMessage());
    $smarty->display('admin/message.tpl');
}
