<?php
/**
 * 管理后台入口
 *
 * @package timandes\enterprise
 */

define('SESSION_FIELD_USER_ID', 'oms_user_id');

require_once realpath(__DIR__ . '/../../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../../') . '/config_admin.php';

/**
 * Grant permission
 */
function enterprise_oms_grant_permission()
{
    $userId = (int)timandes_get_session_data(SESSION_FIELD_USER_ID);
    if (!$userId) {
        header('Location: ?action=login');
        exit;
    }

    return $userId;
}

function enterprise_oms_action_login($smarty)
{
    $tplPath = 'oms/login.tpl';

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) // No form data
        return $smarty->display($tplPath);

    $userName = timandes_get_post_data('user');
    $password = timandes_get_post_data('password');
    $passwordSum = md5($password);

    $user = array(
            'id' => '1',
            'password' => 'bc556a92571088df817377579416f4f6',
        );
    if (!$userName
            || !$user
            || $user['password'] != $passwordSum) {
        $smarty->assign('error_msg', "用户名或密码错误");
        return $smarty->display($tplPath);
    }

    // Add meta to session
    $_SESSION[SESSION_FIELD_USER_ID] = $user['id'];

    // Redirect
    header('Location: ?');
}

function enterprise_oms_action_dashboard($smarty)
{
    $siteDAO = new \oms\daos\Site();
    $sites = $siteDAO->getMultiInOrderBy(null, '`id`, `desc`, `created`, `updated`', '`id` DESC');
    $smarty->assign('sites', $sites);

    $smarty->display('oms/dashboard.tpl');
}

function enterprise_oms_action_edit_site($smarty)
{
    $tplPath = 'oms/edit_site.tpl';

    $siteId = (int)timandes_get_query_data('site_id');
    $smarty->assign('site_id', $siteId);

    $siteDAO = new \oms\daos\Site();

    $submitted = timandes_get_post_data('submit');
    if (!$submitted) {// No form data
        if ($siteId) {
            $site = $siteDAO->get($siteId);
            $smarty->assign('site', $site);
        }
        return $smarty->display($tplPath);
    }

    $desc = timandes_get_post_data('desc');

    // Save
    $values = array(
            'desc' => $desc,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($siteId) {// Edit
        $siteDAO->update($siteId, $values);
    } else {// Create
        $values['created'] = $values['updated'];
        $siteDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display('oms/message.tpl');
}

function enterprise_oms_route($smarty)
{
    $action = timandes_get_query_data('action');
    switch ($action) {
        case 'login':
            return enterprise_oms_action_login($smarty);
        default:
            $userId = enterprise_oms_grant_permission();
            switch ($action) {
                case 'edit_site':
                    return enterprise_oms_action_edit_site($smarty);
                default:
                    return enterprise_oms_action_dashboard($smarty);
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
    enterprise_oms_route($smarty);
} catch(HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    echo $e->getMessage();
    echo '<a href="javascript:void(0);" onclick="javascript: history.back();">返回</a>';
}
