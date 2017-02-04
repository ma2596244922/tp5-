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
    $submitButton = enterprise_get_post_data('submit');
    if ($submitButton) {
        $userName = enterprise_get_post_data('user');
        $password = enterprise_get_post_data('password');
        $passwordSum = md5($password);

        $userDAO = new \enterprise\daos\User();
        $condition = "`name`='" . $userDAO->escape($userName) . "'";
        $user = $userDAO->getOneBy($condition);
        if (!$user)
            throw new \RuntimeException("用户名或密码错误");
        if ($user['password'] != $passwordSum)
            throw new \RuntimeException("用户名或密码错误");

        // Add meta to session
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['user_site_id'] = $user['user_site_id'];

        // Update last-log-in
        $values = array(
                'last_log_in' => date('Y-m-d H:i:s'),
            );
        $userDAO->update($user['id'], $values);

        // Redirect
        header('Location: /admin/');
    } else {
        $smarty->display('admin/login.tpl');
    }
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