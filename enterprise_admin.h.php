<?php
/**
 * 用户后台公用函数库
 *
 * @package timandes\enterprise
 */

/**
 * Grant permission
 */
function enterprise_admin_grant_permission()
{
    $userId = enterprise_get_session_data('user_id');
    if (!$userId) {
        header('Location: /admin/?action=login');
        exit;
    }
}

/**
 * Dashboard
 */
function enterprise_admin_action_dashboard($smarty)
{
    $smarty->display('admin/index.tpl');
}

/**
 * Log-in
 */
function enterprise_admin_action_login($smarty)
{
    $tplPath = 'admin/login.tpl';

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) // No form data
        return $smarty->display($tplPath);

    $userName = enterprise_get_post_data('user');
    $password = enterprise_get_post_data('password');
    $passwordSum = md5($password);

    $userDAO = new \enterprise\daos\User();
    $condition = "`name`='" . $userDAO->escape($userName) . "'";
    $user = $userDAO->getOneBy($condition);
    if (!$userName
            || !$user
            || $user['password'] != $passwordSum) {
        $smarty->assign('error_msg', "用户名或密码错误");
        return $smarty->display($tplPath);
    }

    // Add meta to session
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['user_site_id'] = $user['site_id'];

    // Update last-log-in
    $values = array(
            'last_log_in' => date('Y-m-d H:i:s'),
        );
    $userDAO->update($user['id'], $values);

    // Redirect
    header('Location: /admin/');
}

/**
 * Log-out
 */
function enterprise_admin_action_logout($smarty)
{
    unset($_SESSION['user_id']);
    unset($_SESSION['user_site_id']);
    header('Location: /admin/?action=login');
}

/**
 * Change password
 */
function enterprise_admin_action_password($smarty)
{
    $userId = (int)enterprise_get_session_data('user_id');

    $submitButton = enterprise_get_post_data('submit');
    if ($submitButton) {
        $oldPassword = enterprise_get_post_data('old_password');
        $newPassword = enterprise_get_post_data('new_password');
        $newPassword2 = enterprise_get_post_data('new_password_2');
        $oldPasswordSum = md5($oldPassword);
        $newPasswordSum = md5($newPassword);

        $userDAO = new \enterprise\daos\User();
        $condition = "`id`={$userId}";
        $user = $userDAO->getOneBy($condition);
        if (!$user) {
            header('Location: /admin/?action=login');
            return;
        }
        if ($user['password'] != $oldPasswordSum)
            throw new \RuntimeException("旧密码不正确");
        if (!$newPassword)
            throw new \RuntimeException("新密码不能为空");
        if ($newPassword != $newPassword2)
            throw new \RuntimeException("两次输入的密码不相同");

        $values = array(
                'password' => $newPasswordSum,
                'updated' => date('Y-m-d H:i:s'),
            );
        $userDAO->update($userId, $values);
        echo "密码修改成功";
    } else {
        $smarty->display('admin/password.tpl');
    }
}

/**
 * Inquiries
 */
function enterprise_admin_action_inquiry($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $pageNo = (int)enterprise_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;

    $max = 20;
    $start = ($pageNo - 1) * $max;
    $inquiryDAO = new \enterprise\daos\Inquiry();
    $condition = "`site_id`={$userSiteId}";
    $inquiries = $inquiryDAO->getMultiInOrderBy($condition, '`id`, `subject`, `country`, `created`', '`id` DESC', $max, $start);
    $smarty->assign('inquiries', $inquiries);

    $smarty->display('admin/inquiry.tpl');
}

/**
 * Inquiry Detail
 */
function enterprise_admin_action_inquiry_detail($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $inquiryId = (int)enterprise_get_query_data('inquiry_id');

    $inquiryDAO = new \enterprise\daos\Inquiry();
    $condition = "`id`={$inquiryId}";
    $inquiry = $inquiryDAO->getOneBy($condition);
    $smarty->assign('inquiry', $inquiry);

    $smarty->display('admin/inquiry_detail.tpl');
}