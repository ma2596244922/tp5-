<?php
/**
 * 用户后台公用函数库
 *
 * @package timandes\enterprise
 */

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
        $condition = "`name`='" . $userDAO->escape_string($userName) . "'";
        $user = $userDAO->getOneBy($condition);
        if (!$user)
            throw new \RuntimeException("用户名或密码错误");
        if ($user['password'] != $passwordSum)
            throw new \RuntimeException("用户名或密码错误");

        $_SESSION['site_id'] = $user['site_id'];
        header('Location: /');
    } else {
        $smarty->display('admin/login.tpl');
    }
}