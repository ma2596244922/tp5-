<?php
/**
 * 用户后台公用函数库
 *
 * @package timandes\enterprise
 */

/**
 * Grant permission
 */
function enterprise_admin_grant_permission($targetSiteId)
{
    $userId = (int)enterprise_get_session_data('user_id');
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    if (!$userId
            || $userSiteId != $targetSiteId) {
        header('Location: /admin/?action=login');
        exit;
    }

    return $userId;
}

/**
 * Assign user info to template
 */
function enterprise_admin_assign_user_info($smarty, $var, $userId)
{
    $userDAO = new \enterprise\daos\User();
    $user = $userDAO->get($userId);

    $smarty->assign($var, $user);
}

/* {{{ Common */

/**
 * Assign inquiry list to template
 */
function enterprise_admin_assign_inquiry_list($smarty, $var, $userSiteId, $pageNo = 1, $max = 10)
{
    $start = ($pageNo - 1) * $max;
    $inquiryDAO = new \enterprise\daos\Inquiry();
    $condition = "`site_id`={$userSiteId}";
    $inquiries = $inquiryDAO->getMultiInOrderBy($condition, '`id`, `subject`, `country`, `created`', '`id` DESC', $max, $start);
    $smarty->assign($var, $inquiries);
}

/**
 * Assign Group List
 */
function enterprise_admin_assign_group_list($smarty, $var, $siteId)
{
    $groupDAO = new \enterprise\daos\Group();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $groups = $groupDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $groups);
}

/* }}} */

/**
 * Dashboard
 */
function enterprise_admin_action_dashboard($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');

    enterprise_admin_assign_inquiry_list($smarty, 'inquiries', $userSiteId);

    $smarty->display('admin/index.tpl');
}

/* {{{ Log-in Log-out */

/**
 * Log-in
 */
function enterprise_admin_action_login($smarty, $targetSiteId)
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
            || $user['password'] != $passwordSum
            || $user['site_id'] != $targetSiteId) {
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

/* }}} */

/* {{{ Profile */

/**
 * Change password
 */
function enterprise_admin_action_password($smarty)
{
    $tplPath = 'admin/password.tpl';
    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) // No form data
        return $smarty->display($tplPath);

    $userId = (int)enterprise_get_session_data('user_id');

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
    $smarty->assign('message', '密码修改成功');
    $smarty->display($tplPath);
}

/* }}} */

/* {{{ Inquiries */

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

    enterprise_admin_assign_inquiry_list($smarty, 'inquiries', $userSiteId, $pageNo, $max);

    $inquiryDAO = new \enterprise\daos\Inquiry();
    $condition = "`site_id`={$userSiteId}";
    $totalInquiries = $inquiryDAO->countBy($condition);
    $totalPages = (int)($totalInquiries / $max) + (($totalInquiries % $max)?1:0);
    $smarty->assign('total_inquiries', $totalInquiries);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

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

/* }}} */

/* {{{ Group */

/**
 * Groups
 */
function enterprise_admin_action_group($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    $smarty->display('admin/group.tpl');
}

/**
 * Assign group info
 */
function enterprise_admin_assign_group_info($smarty, $var, $groupId)
{
    $groupDAO = new \enterprise\daos\Group();
    $group = $groupDAO->get($groupId);
    $smarty->assign($var, $group);
}

/**
 * Edit Group
 */
function enterprise_admin_action_edit_group($smarty)
{
    $tplPath = 'admin/edit_group.tpl';

    $groupId = (int)enterprise_get_query_data('group_id');
    $smarty->assign('group_id', $groupId);

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($groupId) 
            enterprise_admin_assign_group_info($smarty, 'group', $groupId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $groupName = enterprise_get_post_data('name');

    if (!$groupName) {
        $smarty->assign('error_msg', '请输入分组名称');
        return $smarty->display($tplPath);
    }

    $groupDAO = new \enterprise\daos\Group();
    $values = array(
            'site_id' => $userSiteId,
            'name' => $groupName,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($groupId) {// Edit
        $groupDAO->update($groupId, $values);
        enterprise_admin_assign_group_info($smarty, 'group', $groupId);
    } else {// Create
        $values['created'] = $values['updated'];
        $groupDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Group
 */
function enterprise_admin_action_delete_group($smarty)
{
    $groupId = (int)enterprise_get_query_data('group_id');

    $productDAO = new \enterprise\daos\Product();
    $condition = "`group_id`={$groupId}";
    $product = $productDAO->getOneBy($condition);
    if ($product) {
        header('Location: ?action=group&error_msg=' . urlencode('该分组下存在产品，无法删除'));
        return;
    }

    $groupDAO = new \enterprise\daos\Group();
    $values = array(
            'deleted' => 1,
        );
    $groupDAO->update($groupId, $values);
    header('Location: ?action=group&success_msg=' . urlencode('删除成功'));
}

/* }}} */

/* {{{ Product */

/**
 * Products
 */
function enterprise_admin_action_product($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $pageNo = (int)enterprise_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $productDAO = new \enterprise\daos\Product();
    $start = ($pageNo - 1) * $max;
    $sql = "SELECT p.`id`, p.`caption`, p.`created`, p.`updated`, g.`name` AS `group_name`
    FROM `enterprise_products` AS p
    LEFT JOIN `enterprise_groups` AS g ON p.`group_id`=g.`id`
    WHERE p.`site_id`={$userSiteId} AND p.`deleted`=0 LIMIT {$start}, {$max}";
    $products = $productDAO->getMultiBySql($sql);
    $smarty->assign('products', $products);

    $condition = "`site_id`={$userSiteId} AND `deleted`=0";
    $totalProducts = $productDAO->countBy($condition);
    $totalPages = (int)($totalProducts / $max) + (($totalProducts % $max)?1:0);
    $smarty->assign('total_productss', $totalProducts);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    $smarty->display('admin/product.tpl');
}

/**
 * Assign Product info
 */
function enterprise_admin_assign_product_info($smarty, $var, $productId)
{
    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);
    $smarty->assign($var, $product);

    if ($product) {
        $specificationsJSON = $product['specifications'];
        $specifications = json_decode($specificationsJSON, true);
        $smarty->assign($var . '_specifications', $specifications);
    }
}

/**
 * Edit Product
 */
function enterprise_admin_action_edit_product($smarty)
{
    $tplPath = 'admin/edit_product.tpl';

    $productId = (int)enterprise_get_query_data('product_id');
    $smarty->assign('product_id', $productId);

    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($productId) 
            enterprise_admin_assign_product_info($smarty, 'product', $productId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $caption = enterprise_get_post_data('caption');
    $description = enterprise_get_post_data('description', 'trim');
    $groupId = enterprise_get_post_data('group_id');
    $tags = enterprise_get_post_data('tags');
    $brandName = enterprise_get_post_data('brand_name');
    $modelNumber = enterprise_get_post_data('model_number');
    $certification = enterprise_get_post_data('certification');
    $placeOfOrigin = enterprise_get_post_data('place_of_origin');
    $minOrderQuantity = enterprise_get_post_data('min_order_quantity');
    $price = enterprise_get_post_data('price');
    $paymentTerms = enterprise_get_post_data('payment_terms');
    $supplyAbility = enterprise_get_post_data('supply_ability');
    $deliveryTime = enterprise_get_post_data('delivery_time');
    $packagingDetails = enterprise_get_post_data('packaging_details');
    $specificationsQueryString = enterprise_get_post_data('specifications');

    parse_str($specificationsQueryString, $specificationsArray);

    if (!$caption) {
        $smarty->assign('error_msg', '请输入产品名称');
        return $smarty->display($tplPath);
    }
    if (!$groupId) {
        $smarty->assign('error_msg', '请选择所属分组');
        return $smarty->display($tplPath);
    }

    $productDAO = new \enterprise\daos\Product();
    $values = array(
            'site_id' => $userSiteId,
            'caption' => $caption,
            'description' => $description,
            'group_id' => $groupId,
            'locale' => 'english',
            'updated' => date('Y-m-d H:i:s'),
            'tags' => $tags,
            'brand_name' => $brandName,
            'model_number' => $modelNumber,
            'certification' => $certification,
            'place_of_origin' => $placeOfOrigin,
            'min_order_quantity' => $minOrderQuantity,
            'price' => $price,
            'payment_terms' => $paymentTerms,
            'supply_ability' => $supplyAbility,
            'delivery_time' => $deliveryTime,
            'packaging_details' => $packagingDetails,
            'specifications' => $specificationsArray,
        );
    if ($productId) {// Edit
        $productDAO->update($productId, $values);
        enterprise_admin_assign_product_info($smarty, 'product', $productId);
    } else {// Create
        $values['created'] = $values['updated'];
        $productDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Product
 */
function enterprise_admin_action_delete_product($smarty)
{
    $productId = (int)enterprise_get_query_data('product_id');

    $productDAO = new \enterprise\daos\Product();
    $values = array(
            'deleted' => 1,
        );
    $productDAO->update($productId, $values);
    header('Location: ?action=product&success_msg=' . urlencode('删除成功'));
}

/* }}} */
