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
    enterprise_assign_group_list($smarty, $var, $siteId);
}

/* }}} */

/* {{{ Image Resizing */

/**
 * 生成缩略图
 *
 * @return \Intervention\Image\Image 缩略图对象
 */
function enterprise_admin_generate_thumbnail($imageManager, $imageData, $width, $height)
{
    $retval = $imageManager->make($imageData);

    $baseRatio = $width / $height;
    $ratio = $retval->width() / $retval->height();
    if ($ratio > $baseRatio) {
        $newWidth = $retval->width();
        $newHeight = (int)($newWidth / $baseRatio);
    } else {
        $newHeight = $retval->height();
        $newWidth = (int)($newHeight * $baseRatio);
    }
    
    return $retval->resizeCanvas($newWidth, $newHeight, 'center', false, '#FFFFFF')->fit($width, $height);
}

/**
 * 将图片规范为标准可存储尺寸
 *
 * @return \Intervention\Image\Image 标准化图片对象
 */
function enterprise_admin_standardize_image($imageManager, $path, $maxWidth = 800)
{
    $image = $imageManager->make($path);
    if ($image->width() < $maxWidth)
        return $image;

    $image = $image->widen($maxWidth);
    return $image;
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
 * Change logo
 */
function enterprise_admin_action_logo($smarty)
{
    $tplPath = 'admin/logo.tpl';

    $userSiteId = (int)enterprise_get_session_data('user_site_id');

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
        return $smarty->display($tplPath);
    }

    // Upload logo
    $images = enterprise_admin_upload_post_images('');
    if ($images)
        $logo = $images[0];
    else
        $logo = 0;

    $corporationDAO = new \enterprise\daos\Corporation();
    $values = array(
            'logo' => $logo,
            'updated' => date('Y-m-d H:i:s'),
        );
    $corporationDAO->update($userSiteId, $values);
    enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
    
    $smarty->assign('message', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change info
 */
function enterprise_admin_action_info($smarty)
{
    $tplPath = 'admin/info.tpl';

    $userSiteId = (int)enterprise_get_session_data('user_site_id');

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_corporation_info($smarty, 'site', $userSiteId);
        return $smarty->display($tplPath);
    }

    $name = enterprise_get_post_data('name');
    $address = enterprise_get_post_data('address');
    $factoryAddress = enterprise_get_post_data('factory_address');
    $worktime = enterprise_get_post_data('worktime');
    $telWt = enterprise_get_post_data('tel_wt');
    $telNWt = enterprise_get_post_data('tel_nwt');
    $fax = enterprise_get_post_data('fax');
    $skype = enterprise_get_post_data('skype');
    $email = enterprise_get_post_data('email');
    $yahoo = enterprise_get_post_data('yahoo');
    $businessType = enterprise_get_post_data('business_type');
    $mainMarket = enterprise_get_post_data('main_market');
    $brands = enterprise_get_post_data('brands');
    $noOfEmployees = enterprise_get_post_data('no_of_employees');
    $annualSales = enterprise_get_post_data('annual_sales');
    $yearEstablished = enterprise_get_post_data('year_established');
    $exportPC = enterprise_get_post_data('export_p_c');
    $introduction = enterprise_get_post_data('introduction', 'trim');
    $history = enterprise_get_post_data('history', 'trim');
    $service = enterprise_get_post_data('service', 'trim');
    $ourTeam = enterprise_get_post_data('our_team', 'trim');
    $qcProfile = enterprise_get_post_data('qc_profile', 'trim');

    if (!$name)
        throw new \RuntimeException("公司名称不能为空");

    $corporationDAO = new \enterprise\daos\Corporation();
    $values = array(
            'name' => $name,
            'address' => $address,
            'factory_address' => $factoryAddress,
            'worktime' => $worktime,
            'tel_wt' => $telWt,
            'tel_nwt' => $telNWt,
            'fax' => $fax,
            'skype' => $skype,
            'email' => $email,
            'yahoo' => $yahoo,
            'business_type' => $businessType,
            'main_market' => $mainMarket,
            'brands' => $brands,
            'no_of_employees' => $noOfEmployees,
            'annual_sales' => $annualSales,
            'year_established' => $yearEstablished,
            'export_p_c' => $exportPC,
            'introduction' => $introduction,
            'history' => $history,
            'service' => $service,
            'our_team' => $ourTeam,
            'qc_profile' => $qcProfile,
            'updated' => date('Y-m-d H:i:s'),
        );
    $corporationDAO->update($userSiteId, $values);
    enterprise_assign_corporation_info($smarty, 'site', $userSiteId);
    
    $smarty->assign('message', '修改成功');
    $smarty->display($tplPath);
}

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

    $smarty->display('admin/inquiry_detail_2.tpl');
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
        // Specifications
        $specificationsJSON = $product['specifications'];
        $specifications = json_decode($specificationsJSON, true);
        $smarty->assign($var . '_specifications', $specifications);
        // Images
        $imagesJSON = $product['images'];
        $images = json_decode($imagesJSON, true);
        $smarty->assign($var . '_images', $images);
    }
}

function enterprise_admin_save_image($imageDAO, $userSiteId, $imageManager, $source, &$body = null)
{
    $image = enterprise_admin_standardize_image($imageManager, $source, IMAGE_MAX_WIDTH);
    $body = (string)$image->encode('jpg', 90);
    $values = array(
            'site_id' => $userSiteId,
            'body' => $body,
            'created' => date('Y-m-d H:i:s'),
        );
    return $imageDAO->insert($values);
}

function enterprise_admin_save_thumbs($thumbnailDAO, $id, $imageManager, $body, $for = 'product')
{
    global $thumbnailInfo;

    $values = array(
            'image_id' => $id,
            'created' => date('Y-m-d H:i:s'),
        );
    foreach ($thumbnailInfo[$for] as $c => $size) {
        list($w, $h) = $size;
        $field = $c;
        $thumbnail = enterprise_admin_generate_thumbnail($imageManager, $body, $w, $h);
        $values[$field] = (string)$thumbnail->encode('jpg', 75);
    }
    $thumbnailDAO->insert($values);
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

    // Upload images
    $images = enterprise_admin_upload_post_images();
    if (!$images) {
        $smarty->assign('error_msg', '请选择至少一张图片');
        return $smarty->display($tplPath);
    }
    $headImageId = $images[0];

    // Save products
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
            'head_image_id' => $headImageId,
            'images' => $images,
        );
    if ($productId) {// Edit
        $productDAO->update($productId, $values);
        enterprise_admin_assign_product_info($smarty, 'product', $productId);
    } else {// Create
        $values['created'] = $values['updated'];
        $productDAO->insert($values);

        // Cnt of products
        $groupDAO = new \enterprise\daos\Group();
        $groupDAO->incrCnt($groupId);
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

    // Cnt of products
    $groupDAO = new \enterprise\daos\Group();
    $groupDAO->incrCnt($groupId, -1);

    header('Location: ?action=product&success_msg=' . urlencode('删除成功'));
}

/* }}} */

/* {{{ Contact */

/**
 * Contacts
 */
function enterprise_admin_action_contact($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    enterprise_assign_contact_list($smarty, 'contacts', $userSiteId);

    $smarty->display('admin/contact.tpl');
}

/**
 * Edit Contact
 */
function enterprise_admin_action_edit_contact($smarty)
{
    $tplPath = 'admin/edit_contact.tpl';

    $contactId = (int)enterprise_get_query_data('contact_id');
    $smarty->assign('contact_id', $contactId);

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($contactId) 
            enterprise_assign_contact_info($smarty, 'contact', $contactId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $name = enterprise_get_post_data('name');
    $title = enterprise_get_post_data('title');
    $tel = enterprise_get_post_data('tel');
    $skype = enterprise_get_post_data('skype');
    $email = enterprise_get_post_data('email');
    $yahoo = enterprise_get_post_data('yahoo');
    $icq = enterprise_get_post_data('icq');
    $viber = enterprise_get_post_data('viber');
    $whatsapp = enterprise_get_post_data('whatsapp');

    if (!$name) {
        $smarty->assign('error_msg', '请输入姓名');
        return $smarty->display($tplPath);
    }

    $contactDAO = new \enterprise\daos\Contact();
    $values = array(
            'site_id' => $userSiteId,
            'name' => $name,
            'title' => $title,
            'tel' => $tel,
            'skype' => $skype,
            'email' => $email,
            'yahoo' => $yahoo,
            'icq' => $icq,
            'viber' => $viber,
            'whatsapp' => $whatsapp,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($contactId) {// Edit
        $contactDAO->update($contactId, $values);
        enterprise_assign_contact_info($smarty, 'contact', $contactId);
    } else {// Create
        $values['created'] = $values['updated'];
        $contactDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Contact
 */
function enterprise_admin_action_delete_contact($smarty)
{
    $contactId = (int)enterprise_get_query_data('contact_id');

    $contactDAO = new \enterprise\daos\Contact();
    $values = array(
            'deleted' => 1,
        );
    $contactDAO->update($contactId, $values);
    header('Location: ?action=contact&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/* {{{ Photo */

/**
 * Photos
 */
function enterprise_admin_action_photo($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $type = (int)enterprise_get_query_data('type');
    if (!$type)
        $type = null;
    $pageNo = (int)enterprise_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $condition = enterprise_assign_photo_list($smarty, 'photos', $userSiteId, $type);
    $smarty->assign('photo_type', $type);

    $photoDAO = new \enterprise\daos\Photo();
    $totalPhotos = $photoDAO->countBy($condition);
    $totalPages = (int)($totalPhotos / $max) + (($totalPhotos % $max)?1:0);
    $smarty->assign('total_photos', $totalPhotos);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    $smarty->assign('predefined_photo_types', \enterprise\daos\Photo::getPredefinedTypes());

    $smarty->display('admin/photo.tpl');
}

function enterprise_admin_upload_post_images($thumbnailFor = 'product')
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $imageDAO = new \enterprise\daos\Image();
    $thumbnailDAO = new \enterprise\daos\Thumbnail();
    $imageManager = new \Intervention\Image\ImageManager();
    $images = array();
    foreach ($_FILES as $name => $meta) {
        $id = enterprise_get_post_data($name);
        if (!$id) {// Upload now!
            if ($meta['error'])
                continue;

            $body = null;
            $id = enterprise_admin_save_image($imageDAO, $userSiteId, $imageManager, $meta['tmp_name'], $body);
            // Thumbnail
            if ($thumbnailFor)
                enterprise_admin_save_thumbs($thumbnailDAO, $id, $imageManager, $body, $thumbnailFor);
        }
        // Save to array
        $images[] = $id;
    }

    return $images;
}

/**
 * Edit Photo
 */
function enterprise_admin_action_edit_photo($smarty)
{
    $tplPath = 'admin/edit_photo.tpl';

    $photoId = (int)enterprise_get_query_data('photo_id');
    $smarty->assign('photo_id', $photoId);

    $smarty->assign('predefined_photo_types', \enterprise\daos\Photo::getPredefinedTypes());

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($photoId) 
            enterprise_assign_photo_info($smarty, 'photo', $photoId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $uri = enterprise_get_post_data('uri');
    $desc = enterprise_get_post_data('desc');
    $type = (int)enterprise_get_post_data('type');

    if (!$desc) {
        $smarty->assign('error_msg', '请输入描述');
        return $smarty->display($tplPath);
    }
    if (!$type) {
        $smarty->assign('error_msg', '请选择分类');
        return $smarty->display($tplPath);
    }

    // Upload Images
    $images = enterprise_admin_upload_post_images();
    if (!$images) {
        $smarty->assign('error_msg', '请选择照片');
        return $smarty->display($tplPath);
    }
    $uri = $images[0];

    $photoDAO = new \enterprise\daos\Photo();
    $values = array(
            'site_id' => $userSiteId,
            'uri' => $uri,
            'desc' => $desc,
            'type' => $type,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($photoId) {// Edit
        $photoDAO->update($photoId, $values);
        enterprise_assign_photo_info($smarty, 'photo', $photoId);
    } else {// Create
        $values['created'] = $values['updated'];
        $photoDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Photo
 */
function enterprise_admin_action_delete_photo($smarty)
{
    $photoId = (int)enterprise_get_query_data('photo_id');

    $photoDAO = new \enterprise\daos\Photo();
    $values = array(
            'deleted' => 1,
        );
    $photoDAO->update($photoId, $values);
    header('Location: ?action=photo&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/* {{{ Certification */

/**
 * Certifications
 */
function enterprise_admin_action_certification($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');

    $condition = enterprise_assign_certification_list($smarty, 'certifications', $userSiteId);

    $smarty->display('admin/certification.tpl');
}

/**
 * Edit Certification
 */
function enterprise_admin_action_edit_certification($smarty)
{
    $tplPath = 'admin/edit_certification.tpl';

    $certificationId = (int)enterprise_get_query_data('certification_id');
    $smarty->assign('certification_id', $certificationId);

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($certificationId) 
            enterprise_assign_certification_info($smarty, 'certification', $certificationId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $uri = enterprise_get_post_data('uri');
    $standard = enterprise_get_post_data('standard');
    $number = enterprise_get_post_data('number');
    $issueDate = enterprise_get_post_data('issue_date');
    $expiryDate = enterprise_get_post_data('expiry_date');
    $scopeNRange = enterprise_get_post_data('scope_n_range');
    $issuedBy = enterprise_get_post_data('issued_by');

    // Upload Images
    $images = enterprise_admin_upload_post_images('certification');
    if (!$images) {
        $smarty->assign('error_msg', '请选择照片');
        return $smarty->display($tplPath);
    }
    $uri = 'image://' . $images[0];

    $certificationDAO = new \enterprise\daos\Certification();
    $values = array(
            'site_id' => $userSiteId,
            'uri' => $uri,
            'standard' => $standard,
            'number' => $number,
            'issue_date' => $issueDate,
            'expiry_date' => $expiryDate,
            'scope_n_range' => $scopeNRange,
            'issued_by' => $issuedBy,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($certificationId) {// Edit
        $certificationDAO->update($certificationId, $values);
        enterprise_assign_certification_info($smarty, 'certification', $certificationId);
    } else {// Create
        $values['created'] = $values['updated'];
        $certificationDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Certification
 */
function enterprise_admin_action_delete_certification($smarty)
{
    $certificationId = (int)enterprise_get_query_data('certification_id');

    $certificationDAO = new \enterprise\daos\Certification();
    $values = array(
            'deleted' => 1,
        );
    $certificationDAO->update($certificationId, $values);
    header('Location: ?action=certification&success_msg=' . urlencode('删除成功'));
}

/* }}} */

/* {{{ Task */

/**
 * Assign Task List
 *
 * @return string Condition
 */
function enterprise_admin_assign_task_list($smarty, $var, $siteId, $pageNo = 1, $pageSize = 10)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    $taskDAO = new \blowjob\daos\Task();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $tasks = $taskDAO->getMultiInOrderBy($condition, '*', '`id` DESC', $pageSize, $start);
    $smarty->assign($var, $tasks);

    return $condition;
}

/**
 * Assign task info
 */
function enterprise_admin_assign_task_info($smarty, $var, $taskId)
{
    $taskDAO = new \blowjob\daos\Task();
    $task = $taskDAO->get($taskId);
    $smarty->assign($var, $task);
}

/**
 * Tasks
 */
function enterprise_admin_action_task($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $pageNo = (int)enterprise_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $taskDAO = new \blowjob\daos\Task();
    $start = ($pageNo - 1) * $max;
    $sql = "SELECT t.*, g.`name` AS `group_name`
    FROM `blowjob_tasks` AS t
    LEFT JOIN `enterprise_groups` AS g ON t.`group_id`=g.`id`
    WHERE t.`site_id`={$userSiteId} AND t.`deleted`=0 ORDER BY t.`id` DESC LIMIT {$start}, {$max}";
    $tasks = $taskDAO->getMultiBySql($sql);
    $smarty->assign('tasks', $tasks);

    $condition = "`site_id`={$userSiteId} AND `deleted`=0";
    $totalTasks = $taskDAO->countBy($condition);
    $totalPages = (int)($totalTasks / $max) + (($totalTasks % $max)?1:0);
    $smarty->assign('total_productss', $totalTasks);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    $smarty->display('admin/task.tpl');
}

/**
 * Edit Task
 */
function enterprise_admin_action_edit_task($smarty)
{
    $tplPath = 'admin/edit_task.tpl';

    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    enterprise_assign_group_list($smarty, 'groups', $userSiteId);

    $taskId = (int)enterprise_get_query_data('task_id');
    $smarty->assign('task_id', $taskId);

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($taskId) 
            enterprise_admin_assign_task_info($smarty, 'task', $taskId);
        return $smarty->display($tplPath);
    }

    // Save
    $groupId = enterprise_get_post_data('group_id');
    $targetUrl = enterprise_get_post_data('target_url');
    if (!$groupId) {
        $smarty->assign('error_msg', '请选择目标分组');
        return $smarty->display($tplPath);
    }
    if (!$targetUrl) {
        $smarty->assign('error_msg', '请输入目标URL');
        return $smarty->display($tplPath);
    }

    $taskDAO = new \blowjob\daos\Task();
    $values = array(
            'site_id' => $userSiteId,
            'group_id' => $groupId,
            'target_url' => $targetUrl,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($taskId) {// Edit
        $taskDAO->update($taskId, $values);
        enterprise_admin_assign_task_info($smarty, 'task', $taskId);
    } else {// Create
        $values['created'] = $values['updated'];
        $taskDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Task
 */
function enterprise_admin_action_delete_task($smarty)
{
    $taskId = (int)enterprise_get_query_data('task_id');

    $taskDAO = new \blowjob\daos\Task();
    $values = array(
            'deleted' => 1,
        );
    $taskDAO->update($taskId, $values);
    header('Location: ?action=task&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/* {{{ Banner */

/**
 * Banners
 */
function enterprise_admin_action_banner($smarty)
{
    $userSiteId = (int)enterprise_get_session_data('user_site_id');

    $condition = enterprise_assign_banner_list($smarty, 'banners', $userSiteId);

    $smarty->display('admin/banner.tpl');
}

/**
 * Edit Banner
 */
function enterprise_admin_action_edit_banner($smarty)
{
    $tplPath = 'admin/edit_banner.tpl';

    $bannerId = (int)enterprise_get_query_data('banner_id');
    $smarty->assign('banner_id', $bannerId);

    $submitButton = enterprise_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($bannerId) 
            enterprise_assign_banner_info($smarty, 'banner', $bannerId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)enterprise_get_session_data('user_site_id');
    $uri = enterprise_get_post_data('uri');
    $desc = enterprise_get_post_data('desc');
    $link = enterprise_get_post_data('link');

    // Upload Images
    $images = enterprise_admin_upload_post_images();
    if (!$images) {
        $smarty->assign('error_msg', '请选择图片');
        return $smarty->display($tplPath);
    }
    $uri = 'image://' . $images[0];

    $bannerDAO = new \enterprise\daos\Banner();
    $values = array(
            'site_id' => $userSiteId,
            'uri' => $uri,
            'desc' => $desc,
            'link' => $link,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($bannerId) {// Edit
        $bannerDAO->update($bannerId, $values);
        enterprise_assign_banner_info($smarty, 'banner', $bannerId);
    } else {// Create
        $values['created'] = $values['updated'];
        $bannerDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display($tplPath);
}

/**
 * Delete Banner
 */
function enterprise_admin_action_delete_banner($smarty)
{
    $bannerId = (int)enterprise_get_query_data('banner_id');

    $bannerDAO = new \enterprise\daos\Banner();
    $values = array(
            'deleted' => 1,
        );
    $bannerDAO->update($bannerId, $values);
    header('Location: ?action=banner&success_msg=' . urlencode('删除成功'));
}

/* }}} */
