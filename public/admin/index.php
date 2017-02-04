<?php
/**
 * 用户后台入口
 *
 * @package timandes\enterprise
 */

// default timezone
date_default_timezone_set("Asia/Shanghai");

require_once realpath(__DIR__ . '/../../') . '/vendor/autoload.php';
require_once realpath(__DIR__ . '/../../') . '/config.php';
require_once realpath(__DIR__ . '/../../') . '/enterprise.h.php';
require_once realpath(__DIR__ . '/../../') . '/enterprise_admin.h.php';

function enterprise_admin_route($smarty)
{
    $action = enterprise_get_query_data('action');
    switch ($action) {
        case 'login':
            return enterprise_admin_action_login($smarty);
        default:
            return enterprise_admin_action_dashboard($smarty);
    }
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../') . '/templates_c/');

session_start();

try {
    enterprise_admin_route($smarty);
} catch (\RuntimeException $e) {
    echo $e->getMessage();
}
