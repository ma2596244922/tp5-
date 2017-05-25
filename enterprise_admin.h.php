<?php
/**
 * 用户后台公用函数库
 *
 * @package timandes\enterprise
 */

/** @var string Fields of Inquiry for List */
define('ENTERPRISE_INQUIRY_FIELDS_FOR_LIST', '`id`, `subject`, `email`, `country`, `created`, `target_product_id`');

/**
 * Grant permission
 */
function enterprise_admin_grant_permission($targetSiteId)
{
    $userId = (int)timandes_get_session_data(SESSION_FIELD_USER_ID);
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    if (!$userId
            || $userSiteId != $targetSiteId) {
        header('Location: /admin/?action=login');
        exit;
    }

    $userDAO = new \enterprise\daos\User();
    $user = $userDAO->get($userId);
    if (!$user
            || $user['site_id'] != $targetSiteId) {
        header('Location: /admin/?action=login');
        exit;
    }

    return $user;
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
    $condition = "`site_id`={$userSiteId} AND `deleted`=0";
    $inquiries = $inquiryDAO->getMultiInOrderBy($condition, ENTERPRISE_INQUIRY_FIELDS_FOR_LIST, '`id` DESC', $max, $start);
    $smarty->assign($var, $inquiries);
}

/**
 * Assign Group List
 */
function enterprise_admin_assign_group_list($smarty, $var, $siteId, $max = null)
{
    enterprise_assign_group_list($smarty, $var, $siteId, $max, false);
}

function enterprise_admin_display_success_msg($smarty, $msg, $url = null, $text = null)
{
    $smarty->assign('success_msg', $msg);
    if ($url) {
        $smarty->assign('forward', array(
                'url' => $url,
                'text' => $text,
            ));
    }
    $smarty->display('admin/message.tpl');
}

function enterprise_admin_display_error_msg($smarty, $msg)
{
    $smarty->assign('error_msg', $msg);
    $smarty->display('admin/message.tpl');
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
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    enterprise_admin_assign_inquiry_list($smarty, 'inquiries', $userSiteId);

    $trackDAO = new \enterprise\daos\Track();
    $dateString = date('Y-m-d', time() - 86400);
    // PV
    $condition = "`site_id`={$userSiteId} AND `created` BETWEEN '{$dateString} 00:00:00' AND '{$dateString} 23:59:59'";
    $total = $trackDAO->countBy($condition);
    $smarty->assign('pv', $total);

    // UV
    $condition = "`site_id`={$userSiteId} AND `created` BETWEEN '{$dateString} 00:00:00' AND '{$dateString} 23:59:59'";
    $total = $trackDAO->countBy($condition, '`ipv4`');
    $smarty->assign('uv', $total);

    $smarty->display('admin/index.tpl');
}

/**
 * Message page
 */
function enterprise_admin_action_message($smarty)
{
    $error = (int)timandes_get_query_data('error');
    if ($error)
        $smarty->assign('error_msg', '这是一条错误消息');
    else {
        $smarty->assign('forward', array(
                'url' => '?action=dashboard',
                'text' => 'Dashboard',
            ));
        $smarty->assign('success_msg', '这是一条成功消息');
    }
    $smarty->display('admin/message.tpl');
}

/* {{{ Log-in Log-out */

/**
 * Log-in
 */
function enterprise_admin_action_login($smarty, $targetSiteId)
{
    $tplPath = 'admin/login.tpl';

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) // No form data
        return $smarty->display($tplPath);

    $userName = timandes_get_post_data('user');
    $password = timandes_get_post_data('password');
    $passwordSum = md5($password);
    $captcha = timandes_get_post_data('captcha');

    $captchaBuilder = new Gregwar\Captcha\CaptchaBuilder($_SESSION[SESSION_FIELD_CAPTCHA_PHRASE]);
    $_SESSION[SESSION_FIELD_CAPTCHA_PHRASE] = null;
    if (!$captchaBuilder->testPhrase($captcha)) {
        $smarty->assign('error_msg', "请输入正确的验证码");
        return $smarty->display($tplPath);
    }

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
    $_SESSION[SESSION_FIELD_USER_ID] = $user['id'];
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
    unset($_SESSION[SESSION_FIELD_USER_ID]);
    unset($_SESSION['user_site_id']);
    header('Location: /admin/?action=login');
}

/**
 * CAPTCHA
 */
function enterprise_admin_action_captcha($smarty)
{
    $builder = new Gregwar\Captcha\CaptchaBuilder();
    $builder->build(120, 34);
    header('Content-type: image/jpeg');
    $builder->output();
    $_SESSION[SESSION_FIELD_CAPTCHA_PHRASE] = $builder->getPhrase();
}

/* }}} */

/* {{{ Profile */

/**
 * Change profile
 */
function enterprise_admin_action_profile($smarty)
{
    $tplPath = 'admin/profile.tpl';

    $userId = (int)timandes_get_session_data(SESSION_FIELD_USER_ID);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    $email = timandes_get_post_data('email');

    $userDAO = new \enterprise\daos\User();
    $values = array(
            'email' => $email,
            'updated' => date('Y-m-d H:i:s'),
        );
    $userDAO->update($userId, $values);

    enterprise_admin_assign_user_info($smarty, 'user', $userId);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change fragment
 */
function enterprise_admin_action_fragment($smarty)
{
    $tplPath = 'admin/fragment.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_site_info($smarty, 'site', $userSiteId);
        return $smarty->display($tplPath);
    }

    $commonFragment = timandes_get_post_data('common_fragment', 'trim');
    $contactnowFragment = timandes_get_post_data('contactnow_fragment', 'trim');
    $contactsaveFragment = timandes_get_post_data('contactsave_fragment', 'trim');
    $commonHeadFragment = timandes_get_post_data('common_head_fragment', 'trim');

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'common_fragment' => $commonFragment,
            'contactnow_fragment' => $contactnowFragment,
            'contactsave_fragment' => $contactsaveFragment,
            'common_head_fragment' => $commonHeadFragment,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);
    enterprise_assign_site_info($smarty, 'site', $userSiteId);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change logo
 */
function enterprise_admin_action_logo($smarty)
{
    $tplPath = 'admin/logo.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
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
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change info
 */
function enterprise_admin_action_info($smarty, $langCode)
{
    $tplPath = 'admin/info.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
        return $smarty->display($tplPath);
    }

    $name = timandes_get_post_data('name');
    $address = timandes_get_post_data('address');
    $factoryAddress = timandes_get_post_data('factory_address');
    $worktime = timandes_get_post_data('worktime');
    $telWt = timandes_get_post_data('tel_wt');
    $telNWt = timandes_get_post_data('tel_nwt');
    $fax = timandes_get_post_data('fax');
    $skype = timandes_get_post_data('skype');
    $email = timandes_get_post_data('email');
    $yahoo = timandes_get_post_data('yahoo');
    $businessType = timandes_get_post_data('business_type');
    $mainMarket = timandes_get_post_data('main_market');
    $brands = timandes_get_post_data('brands');
    $noOfEmployees = timandes_get_post_data('no_of_employees');
    $annualSales = timandes_get_post_data('annual_sales');
    $yearEstablished = timandes_get_post_data('year_established');
    $exportPC = timandes_get_post_data('export_p_c');
    $introduction = timandes_get_post_data('introduction', 'xss_clean, remove_n_r, trim');
    $history = timandes_get_post_data('history', 'xss_clean, remove_n_r, trim');
    $service = timandes_get_post_data('service', 'xss_clean, remove_n_r, trim');
    $ourTeam = timandes_get_post_data('our_team', 'xss_clean, remove_n_r, trim');
    $qcProfile = timandes_get_post_data('qc_profile', 'xss_clean, remove_n_r, trim');
    $slogan = timandes_get_post_data('slogan');
    $desc4InquirySender = timandes_get_post_data('desc_4_inquiry_sender', 'xss_clean, remove_n_r, trim');
    $contactContent = timandes_get_post_data('contact_content', 'xss_clean, remove_n_r, trim');

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
            'slogan' => $slogan,
            'updated' => date('Y-m-d H:i:s'),
        );
    $corporationDAO->update($userSiteId, $values);
    enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);

    if ($langCode == 'en')
        $siteDAO = new \enterprise\daos\Site();
    else
        $siteDAO = new \enterprise\daos\LangSite($langCode);
    $values = array(
            'desc_4_inquiry_sender' => $desc4InquirySender,
            'contact_content' => $contactContent,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);
    $site = $smarty->getTemplateVars('site');
    $site['desc_4_inquiry_sender'] = $desc4InquirySender;
    $site['contact_content'] = $contactContent;
    $smarty->assign('site', $site);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change password
 */
function enterprise_admin_action_password($smarty)
{
    $tplPath = 'admin/password.tpl';
    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) // No form data
        return $smarty->display($tplPath);

    $userId = (int)timandes_get_session_data(SESSION_FIELD_USER_ID);

    $oldPassword = timandes_get_post_data('old_password');
    $newPassword = timandes_get_post_data('new_password');
    $newPassword2 = timandes_get_post_data('new_password_2');
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
    $smarty->assign('success_msg', '密码修改成功');
    $smarty->display($tplPath);
}

/**
 * Change index products
 */
function enterprise_admin_action_index_products($smarty, $site)
{
    $tplPath = 'admin/index_products.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_index_products($smarty, $site);
        return $smarty->display($tplPath);
    }

    $urls = timandes_get_post_data('urls');

    if (!is_array($urls))
        throw new \InvalidArgumentException("数据类型错误");
    if (!$urls)
        throw new \RuntimeException("请给出至少一个产品");

    $indexProductIdArray = array();
    foreach ($urls as $url) {
        $path = parse_url($url, PHP_URL_PATH);
        if (!$path)
            continue;
        if (!preg_match(PATTERN_PRODUCT_PAGE, $path, $matches))
            continue;
        $productId = $matches[1];
        if (!$productId)
            continue;
        $indexProductIdArray[] = $productId;
    }

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'index_products' => $indexProductIdArray,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    enterprise_assign_index_products($smarty, $site, 'en', $indexProductIdArray);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change user voices
 */
function enterprise_admin_action_user_voices($smarty, $site)
{
    $tplPath = 'admin/user_voices.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_user_voices($smarty, 'user_voices', $site);
        return $smarty->display($tplPath);
    }

    $userVoices = timandes_get_post_data('user_voices');

    if (!is_array($userVoices))
        throw new \InvalidArgumentException("数据类型错误");
    if (!$userVoices)
        throw new \RuntimeException("请给出至少一个用户");

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'user_voices' => $userVoices,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    enterprise_assign_user_voices($smarty, 'user_voices', $site, $userVoices);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change index tdk
 */
function enterprise_admin_action_index_tdk($smarty, $site)
{
    $tplPath = 'admin/index_tdk.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Auto TDK
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
        $corporation = $smarty->getTemplateVars('corporation');
        enterprise_assign_group_list($smarty, 'groups', $userSiteId, null, true, true, 3);
        $groups = $smarty->getTemplateVars('groups');
        enterprise_assign_tdk_of_home($smarty, $groups, $corporation, $site);

        return $smarty->display($tplPath);
    }

    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description');
    $metaDescription = str_replace("\n", '', $metaDescription);
    $metaDescription = str_replace("\r", '', $metaDescription);

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'index_html_title' => $htmlTitle,
            'index_meta_keywords' => $metaKeywords,
            'index_meta_description' => $metaDescription,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    $smarty->assign('title', $htmlTitle);
    $smarty->assign('keywords', $metaKeywords);
    $smarty->assign('description', $metaDescription);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Change product tdk
 */
function enterprise_admin_action_product_tdk($smarty, $site)
{
    $tplPath = 'admin/product_tdk.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    enterprise_assign_group_list($smarty, 'groups', $userSiteId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description');
    $metaDescription = str_replace("\n", '', $metaDescription);
    $metaDescription = str_replace("\r", '', $metaDescription);
    $tdkScope = (int)timandes_get_post_data('tdk_scope');
    $groupId = (int)timandes_get_post_data('group_id');

    if ($tdkScope > 0) 
        throw new OutOfRangeException("数据错误");
    if ($tdkScope < 0) {
        if (!$groupId)
            throw new RuntimeException("请选择分组");
        $tdkScope = $groupId;
    }

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'product_tdk_scope' => $tdkScope,
            'product_html_title' => $htmlTitle,
            'product_meta_keywords' => $metaKeywords,
            'product_meta_description' => $metaDescription,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    $site = $smarty->getTemplateVars('site');
    $site['product_tdk_scope'] = $tdkScope;
    $site['product_html_title'] = $htmlTitle;
    $site['product_meta_keywords'] = $metaKeywords;
    $site['product_meta_description'] = $metaDescription;
    $smarty->assign('site', $site);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/* }}} */

/* {{{ Inquiries */

/**
 * Inquiries
 */
function enterprise_admin_action_inquiry($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    enterprise_admin_assign_inquiry_list($smarty, 'inquiries', $userSiteId, $pageNo, $max);

    $inquiryDAO = new \enterprise\daos\Inquiry();
    $condition = "`site_id`={$userSiteId} AND `deleted`=0";
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
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $inquiryId = (int)timandes_get_query_data('inquiry_id');

    // Inquiry
    $inquiryDAO = new \enterprise\daos\Inquiry();
    $condition = "`id`={$inquiryId}";
    $inquiry = $inquiryDAO->getOneBy($condition);
    $smarty->assign('inquiry', $inquiry);

    // Country of Inquiry
    $inquiryCountry = $inquiry['country'];
    $ipv4 = $inquiry['ip'];
    $ipv4Addrs = array($ipv4);
    $r = enterprise_admin_iplookup_get_info_from_addrs($ipv4Addrs);
    if (isset($r[$ipv4])
            && $r[$ipv4])
        $inquiryCountry = $r[$ipv4]['country'] . ' ' . $r[$ipv4]['province'] . ' ' . $r[$ipv4]['city'];
    $smarty->assign('inquiry_country', $inquiryCountry);

    // Target product
    if ($inquiry['target_product_id'])
        enterprise_assign_product_info($smarty, 'target_product', $inquiry['target_product_id']);

    $smarty->display('admin/inquiry_detail_2.tpl');
}

/**
 * Delete Inquiry
 */
function enterprise_admin_action_delete_inquiry($smarty, $site)
{
    $inquiryId = (int)timandes_get_query_data('inquiry_id');

    $inquiryDAO = new \enterprise\daos\Inquiry();

    // Authentication
    $inquiry = $inquiryDAO->get($inquiryId);
    if (!$inquiry
            || $inquiry['site_id'] != $site['site_id'])
        return header('Location: ?action=inquiry&error_msg=' . urlencode('权限不足'));

    // Delete
    $values = array(
            'deleted' => 1,
        );
    $inquiryDAO->update($inquiryId, $values);
    header('Location: ?action=inquiry&success_msg=' . urlencode('删除成功'));
}

/* }}} */

/* {{{ Group */

/**
 * Groups
 */
function enterprise_admin_action_group($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    $smarty->display('admin/group.tpl');
}

/**
 * Get group info
 */
function enterprise_get_group_info($groupId)
{
    $groupDAO = new \enterprise\daos\Group();
    return $groupDAO->get($groupId);
}

/**
 * Assign group info
 */
function enterprise_admin_assign_group_info($smarty, $var, $groupId)
{
    $smarty->assign($var, enterprise_get_group_info($groupId));
}

/**
 * Edit Group
 */
function enterprise_admin_action_edit_group($smarty, $site)
{
    $tplPath = 'admin/edit_group.tpl';

    $groupId = (int)timandes_get_query_data('group_id');
    $smarty->assign('group_id', $groupId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($groupId) 
            enterprise_admin_assign_group_info($smarty, 'group', $groupId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $groupName = timandes_get_post_data('name');

    if (!$groupName)
        return enterprise_admin_display_error_msg($smarty, '请输入分组名称');

    $groupDAO = new \enterprise\daos\Group();
    $values = array(
            'site_id' => $userSiteId,
            'name' => $groupName,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($groupId) {// Edit
        // Authentication
        $originalGroup = $groupDAO->get($groupId);
        if (!$originalGroup
                || $originalGroup['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $groupDAO->update($groupId, $values);
        enterprise_admin_assign_group_info($smarty, 'group', $groupId);
    } else {// Create
        $values['created'] = $values['updated'];
        $groupDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=group', '产品分组');
}

/**
 * Delete Group
 */
function enterprise_admin_action_delete_group($smarty, $site)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $groupId = (int)timandes_get_query_data('group_id');
    $forceDelete = (int)timandes_get_query_data('force');

    $productDAO = new \enterprise\daos\Product();
    $groupDAO = new \enterprise\daos\Group();
    // Authentication
    $group = $groupDAO->get($groupId);
    if (!$group
            || $group['site_id'] != $site['site_id'])
        return header('Location: ?action=group&error_msg=' . urlencode('权限不足'));

    if (!$forceDelete) {// Check products in current group
        $condition = "`group_id`={$groupId}";
        $product = $productDAO->getOneBy($condition);
        if ($product) {
            header('Location: ?action=group&error_msg=' . urlencode('该分组下存在产品，无法删除'));
            return;
        }
    }

    // Delete products in current group
    $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `group_id`={$groupId}";
    $values = array(
            'deleted' => 1,
        );
    $productDAO->updateBy($condition, $values);

    // Delete group
    $values = array(
            'deleted' => 1,
        );
    $groupDAO->update($groupId, $values);
    header('Location: ?action=group&success_msg=' . urlencode('删除成功'));
}

/**
 * Count Products
 */
function enterprise_admin_action_count_products($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $groupId = (int)timandes_get_query_data('group_id');

    $groupCondition = '';
    if ($groupId)
        $groupCondition = " AND `group_id`={$groupId}";

    // Count products
    $productDAO = new \enterprise\daos\Product();
    $condition = "`site_id`={$userSiteId} AND `deleted`=0{$groupCondition}";
    $cnt = (int)$productDAO->countBy($condition);

    // Save count to group
    if ($groupId) {
        $groupDAO = new enterprise\daos\Group();
        $values = array(
                'cnt' => $cnt,
            );
        $groupDAO->update($groupId, $values);

        header('Location: ?action=group&success_msg=' . urlencode('操作成功'));
    } else {
        $siteDAO = new enterprise\daos\Site();
        $values = array(
                'product_cnt' => $cnt,
            );
        $siteDAO->update($userSiteId, $values);

        header('Location: ?action=product&success_msg=' . urlencode('操作成功'));
    }
}

/**
 * Count Products
 */
function enterprise_admin_action_remove_empty_caption_products($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $productDAO = new \enterprise\daos\Product();
    $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `caption`=''";
    $values = array(
            'deleted' => 1,
        );
    $productDAO->updateBy($condition, $values);

    header('Location: ?action=product&success_msg=' . urlencode('操作成功'));
}

/* }}} */

/* {{{ Product */

/**
 * Products
 */
function enterprise_admin_action_product($smarty, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    if ($langCode == 'en') {
        $productDAO = new \enterprise\daos\Product();
        $leftJoin1 = '';
        $diffFields = 'p.`caption`, p.`created`, p.`updated`, p.`source_url`, p.`group_id`';
        $tableAlias = 'p';
        $orderByFields = 'p.`id`';
    } else {
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        $leftJoin1 = 'LEFT JOIN `enterprise_products` AS p ON p.`id`=elp.`product_id`';
        $diffFields = 'elp.`caption`, elp.`created`, elp.`updated`, elp.`source_url`, elp.`group_id`';
        $tableAlias = 'elp';
        $orderByFields = 'elp.`product_id`';
    }
    $tableName = $productDAO->getTableName();

    // Filter - Group
    $groupId = (int)timandes_get_query_data('group_id');
    $groupCondition = '';
    if ($groupId) {
        $groupCondition = ' AND ' . $tableAlias . '.`group_id`=' . $groupId;
        enterprise_admin_assign_group_info($smarty, 'group', $groupId);
    }
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    // Filter - Keywords
    $keywords = timandes_get_query_data('keywords');
    $keywordsCondition = '';
    if ($keywords)
        $keywordsCondition = ' AND ' . $tableAlias . '.`caption` like \'%' . $productDAO->escape($keywords) . '%\'';

    $start = ($pageNo - 1) * $max;
    $sql = "SELECT p.`id`, p.`path`, g.`name` AS `group_name`, {$diffFields}
    FROM `{$tableName}` AS {$tableAlias}
    {$leftJoin1}
    LEFT JOIN `enterprise_groups` AS g ON {$tableAlias}.`group_id`=g.`id`
    WHERE {$tableAlias}.`site_id`={$userSiteId} AND {$tableAlias}.`deleted`=0{$groupCondition}{$keywordsCondition}
    ORDER BY {$orderByFields} DESC LIMIT {$start}, {$max}";
    $products = $productDAO->getMultiBySql($sql);
    $smarty->assign('products', $products);

    $groupCondition = str_replace($tableAlias . '.', '', $groupCondition);
    $keywordsCondition = str_replace($tableAlias . '.', '', $keywordsCondition);
    $condition = "`site_id`={$userSiteId} AND `deleted`=0{$groupCondition}{$keywordsCondition}";
    $totalProducts = $productDAO->countBy($condition);
    $smarty->assign('total_products', $totalProducts);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalProducts, $max, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

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

function enterprise_admin_save_image($imageDAO, $userSiteId, $imageManager, $source, &$body = null, $maxWidth = 800)
{
    $image = enterprise_admin_standardize_image($imageManager, $source, $maxWidth);
    $body = (string)$image->encode('jpg', 90);
    $bodySum = md5($body, true);

    // Use existing
    $imageRecord = $imageDAO->getByBodySum($bodySum);
    if ($imageRecord)
        return $imageRecord['id'];

    // Create new
    $values = array(
            'site_id' => $userSiteId,
            'body' => $body,
            'created' => date('Y-m-d H:i:s'),
            'body_sum' => $bodySum,
        );
    return $imageDAO->insert($values);
}

function enterprise_admin_save_thumbs($thumbnailDAO, $id, $imageManager, $body, $for = 'product')
{
    global $thumbnailInfo;

    // Existing?
    $thumbnailRecord = $thumbnailDAO->getByImage($id);
    if ($thumbnailRecord)
        return;

    // Create new
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
function enterprise_admin_action_edit_product($smarty, $site)
{
    $tplPath = 'admin/edit_product.tpl';

    $productId = (int)timandes_get_query_data('product_id');
    $smarty->assign('product_id', $productId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($productId) 
            enterprise_admin_assign_product_info($smarty, 'product', $productId);

        // Copying?
        $sourceProductId = (int)timandes_get_query_data('source_product_id');
        if ($sourceProductId)
            enterprise_admin_assign_product_info($smarty, 'product', $sourceProductId);

        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $caption = timandes_get_post_data('caption');
    $description = timandes_get_post_data('description', 'xss_clean, remove_n_r, trim');
    $groupId = timandes_get_post_data('group_id');
    $tags = timandes_get_post_data('tags');
    $brandName = timandes_get_post_data('brand_name');
    $modelNumber = timandes_get_post_data('model_number');
    $certification = timandes_get_post_data('certification');
    $placeOfOrigin = timandes_get_post_data('place_of_origin');
    $minOrderQuantity = timandes_get_post_data('min_order_quantity');
    $price = timandes_get_post_data('price');
    $paymentTerms = timandes_get_post_data('payment_terms');
    $supplyAbility = timandes_get_post_data('supply_ability');
    $deliveryTime = timandes_get_post_data('delivery_time');
    $packagingDetails = timandes_get_post_data('packaging_details');
    $specificationsQueryString = timandes_get_post_data('specifications');

    parse_str($specificationsQueryString, $specificationsCellArray);

    $specificationsArray = array();
    if (isset($specificationsCellArray['s'])
            && is_array($specificationsCellArray['s'])) foreach ($specificationsCellArray['s'] as $row) {
        $specificationsArray[$row['key']] = $row['val'];
    }

    if (!$caption)
        return enterprise_admin_display_error_msg($smarty, '请输入产品名称');
    if (!$groupId)
        return enterprise_admin_display_error_msg($smarty, '请选择所属分组');

    // Upload images
    $images = enterprise_admin_upload_post_images();
    if (!$images)
        return enterprise_admin_display_error_msg($smarty, '请选择至少一张图片');
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
        // Authentication
        $originalProduct = $productDAO->get($productId);
        if (!$originalProduct
                || $originalProduct['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $productDAO->update($productId, $values);
        enterprise_admin_assign_product_info($smarty, 'product', $productId);
    } else {// Create
        $values['created'] = $values['updated'];
        $productDAO->insert($values);

        // Cnt of products
        $groupDAO = new \enterprise\daos\Group();
        $groupDAO->incrCnt($groupId);

        // Cnt of products
        $siteDAO = new \enterprise\daos\Site();
        $siteDAO->incrProductCnt($userSiteId);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=product', '产品管理');
}

/**
 * Delete Product
 */
function enterprise_admin_action_delete_product($smarty, $site)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $productId = (int)timandes_get_query_data('product_id');

    // Get group ID
    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);
    if (!$product) {
        $msg = '找不到指定的产品';
        return header('Location: ?action=product&error_msg=' . urlencode($msg));
    }
    if ($product['site_id'] != $site['site_id'])
        return header('Location: ?action=product&error_msg=' . urlencode('权限不足'));
    if ($product['deleted']) 
        return header('Location: ?action=product&success_msg=' . urlencode('删除成功'));
    $groupId = $product['group_id'];

    // Delete product
    $values = array(
            'deleted' => 1,
        );
    $productDAO->update($productId, $values);

    // Cnt of products
    $groupDAO = new \enterprise\daos\Group();
    $groupDAO->incrCnt($groupId, -1);

    // Cnt of products
    $siteDAO = new \enterprise\daos\Site();
    $siteDAO->incrProductCnt($userSiteId, -1);

    header('Location: ?action=product&success_msg=' . urlencode('删除成功'));
}

/**
 * Edit Product TDK
 */
function enterprise_admin_action_edit_product_tdk($smarty, $site)
{
    $tplPath = 'admin/edit_product_tdk.tpl';

    $productId = (int)timandes_get_query_data('product_id');
    if (!$productId)
        return header('Location: ?action=product');
    $smarty->assign('product_id', $productId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Product Info
        enterprise_admin_assign_product_info($smarty, 'product', $productId);
        $product = $smarty->getTemplateVars('product');

        // Auto TDK
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
        $corporation = $smarty->getTemplateVars('corporation');
        enterprise_admin_assign_group_info($smarty, 'product_group', $product['group_id']);
        $productGroup = $smarty->getTemplateVars('product_group');
        enterprise_assign_tdk_of_product_detail($smarty, $corporation, $product, $productGroup);

        return $smarty->display($tplPath);
    }

    // Save
    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description');
    $metaDescription = str_replace("\n", '', $metaDescription);
    $metaDescription = str_replace("\r", '', $metaDescription);

    $productDAO = new \enterprise\daos\Product();
    // Authentication
    $originalProduct = $productDAO->get($productId);
    if (!$originalProduct
            || $originalProduct['site_id'] != $site['site_id'])
        return enterprise_admin_display_error_msg($smarty, '权限不足');

    // Save products
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
            'html_title' => $htmlTitle,
            'meta_keywords' => $metaKeywords,
            'meta_description' => $metaDescription,
        );
    $productDAO->update($productId, $values);

    // Product Info
    enterprise_admin_assign_product_info($smarty, 'product', $productId);
    $product = $smarty->getTemplateVars('product');

    // Auto TDK
    enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
    $corporation = $smarty->getTemplateVars('corporation');
    enterprise_admin_assign_group_info($smarty, 'product_group', $product['group_id']);
    $productGroup = $smarty->getTemplateVars('product_group');
    enterprise_assign_tdk_of_product_detail($smarty, $corporation, $product, $productGroup);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=product', '产品管理');
}

/**
 * Edit Product URL
 */
function enterprise_admin_action_edit_product_url($smarty, $site)
{
    $tplPath = 'admin/edit_product_url.tpl';

    $productId = (int)timandes_get_query_data('product_id');
    if (!$productId)
        return header('Location: ?action=product');
    $smarty->assign('product_id', $productId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Product Info
        enterprise_admin_assign_product_info($smarty, 'product', $productId);
        $product = $smarty->getTemplateVars('product');

        return $smarty->display($tplPath);
    }

    // Save
    $path = timandes_get_post_data('path');
    $path = '/' . ltrim($path, '/');
    $pathSum = md5($path, true);

    $productDAO = new \enterprise\daos\Product();
    // Authentication
    $originalProduct = $productDAO->get($productId);
    if (!$originalProduct
            || $originalProduct['site_id'] != $site['site_id'])
        return enterprise_admin_display_error_msg($smarty, '权限不足');

    // Save products
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
            'path' => $path,
            'path_sum' => $pathSum,
        );
    $productDAO->update($productId, $values);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=product', '产品管理');
}

/* {{{ 批量插入关键词 - Utils */

/**
 * 标准化关键词数组
 *  trim、去空白单元
 * @param int &$cnt 返回最终结果数量
 * @return array 标准化后的关键词数组
 */
function enterprise_admin_insert_keywords_standardize($keywords, &$cnt = null)
{
    $retval = array();
    $cnt = 0;
    foreach ($keywords as $k) {
        $k = trim($k);
        if (!$k)
            continue;
        $retval[] = $k;
        ++$cnt;
    }
    return $retval;
}

/**
 * 随机获取部分关键词
 *
 * @return array 随机结果数组
 */
function enterprise_admin_insert_keywords_get_random($keywords, $keywordsCnt, $targetCnt)
{
    if ($keywordsCnt <= $targetCnt) {
        shuffle($keywords);
        return $keywords;
    }

    $indexes = array();
    $maxIndex = $keywordsCnt - 1;
    $i = 0;
    $retval = array();
    do {
        $index = mt_rand(0, $maxIndex);
        if (isset($indexes[$index]))
            continue;

        $indexes[$index] = true;
        $retval[] = $keywords[$index];
        ++$i;
    } while($i < $targetCnt);

    return $retval;
}

/**
 * 随机插入关键词至指定的值
 *
 * @param string $separator 分隔符（标题使用空格，关键词使用英文半角逗号）
 */
function enterprise_admin_insert_random_keywords_to_value($value, $separator, $keywords, $keywordsCnt, $targetCnt)
{
    $targetKeywords = enterprise_admin_insert_keywords_get_random($keywords, $keywordsCnt, $targetCnt);
    return enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt);
}

/**
 * 插入关键词至指定的值
 *
 * @param string $separator 分隔符（标题使用空格，关键词使用英文半角逗号）
 */
function enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt)
{
    $words = explode($separator, $value);
    $wordsCnt = count($words);
    $finalWords = array();
    $minCnt = min($wordsCnt, $targetCnt);
    for ($i=0; $i<$minCnt; ++$i) {
        $finalWords[] = trim($words[$i]);
        $finalWords[] = $targetKeywords[$i];
    }
    if ($wordsCnt > $targetCnt) {
        for (; $i<$wordsCnt; ++$i) {
            $finalWords[] = trim($words[$i]);
        }
    } else {
        for (; $i<$targetCnt; ++$i) {
            $finalWords[] = trim($targetKeywords[$i]);
        }
    }

    return implode($separator, $finalWords);
}

/* }}} */

/**
 * Insert Keywords
 */
function enterprise_admin_action_insert_keywords($smarty)
{
    $tplPath = 'admin/insert_keywords.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

        return $smarty->display($tplPath);
    }

    // Save
    $keywords = timandes_get_post_data('keywords');
    $location = (int)timandes_get_post_data('location');
    $groupId = (int)timandes_get_post_data('group_id');

    $locationRange = array(1, 2);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$groupId)
        throw new \UnexpectedValueException("请选择分组");
    if (!$keywords)
        throw new \UnderflowException("请给出至少一个关键词");

    $targetCnt = (int)timandes_get_post_data('location_' . $location . '_cnt');
    $keywordsArray = explode("\n", $keywords);

    $keywordsCnt = 0;
    $keywordsArray = enterprise_admin_insert_keywords_standardize($keywordsArray, $keywordsCnt);

    $productDAO = new \enterprise\daos\Product();
    $curProductId = 0;
    do {
        $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `group_id`={$groupId} AND `id`>{$curProductId}";
        $products = $productDAO->getMultiInOrderBy($condition, '`id`, `caption`, `tags`', '`id` ASC', 100);
        if (!$products)
            break;

        foreach ($products as $product) {
            $values = array();
            if ($location == 1)
                $values['caption'] = enterprise_admin_insert_random_keywords_to_value($product['caption'], ' ', $keywordsArray, $keywordsCnt, $targetCnt);
            elseif ($location == 2)
                $values['tags'] = enterprise_admin_insert_random_keywords_to_value($product['tags'], ',', $keywordsArray, $keywordsCnt, $targetCnt);

            if ($values) {
                $values['updated'] = date('Y-m-d H:i:s');
                $productDAO->update($product['id'], $values);
            }

            $curProductId = $product['id'];
        }
    } while(true);

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

/**
 * Replace Keywords
 */
function enterprise_admin_action_replace_keywords($smarty)
{
    $tplPath = 'admin/replace_keywords.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

        return $smarty->display($tplPath);
    }

    // Save
    $oldPhrase = timandes_get_post_data('old_phrase');
    $newPhrase = timandes_get_post_data('new_phrase');
    $groupId = (int)timandes_get_post_data('group_id');
    $location = (int)timandes_get_post_data('location');

    $locationRange = array(0, 1, 2);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$oldPhrase)
        throw new \UnderflowException("原关键词不能为空");
    if (!$newPhrase)
        throw new \UnderflowException("新关键词不能为空");
    if (!$groupId)
        throw new \UnexpectedValueException("请选择分组");

    $productDAO = new \enterprise\daos\Product();
    $curProductId = 0;
    do {
        $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `group_id`={$groupId} AND `id`>{$curProductId}";
        $products = $productDAO->getMultiInOrderBy($condition, '`id`, `caption`, `tags`, `description`', '`id` ASC', 100);
        if (!$products)
            break;

        foreach ($products as $product) {
            $values = array();
            // Caption
            if (in_array($location, [0, 1])) {
                $values['caption'] = str_ireplace($oldPhrase, $newPhrase, $product['caption']);
            }
            // Tags
            if (in_array($location, [0, 2])) {
                $oldTags = explode(',', $product['tags']);
                $newTags = array();
                foreach ($oldTags as $tag) {
                    $tag = trim($tag);
                    $tag = str_ireplace($oldPhrase, $newPhrase, $tag);
                    $newTags[] = $tag;
                }
                $values['tags'] = implode(',', $newTags);
            }
            // Description
            //$values['description'] = str_ireplace($oldPhrase, $newPhrase, $product['description']);

            // Update
            if ($values) {
                $values['updated'] = date('Y-m-d H:i:s');
                $productDAO->update($product['id'], $values);
            }

            $curProductId = $product['id'];
        }
    } while(true);

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

/**
 * Insert Desc
 */
function enterprise_admin_action_insert_desc($smarty)
{
    $tplPath = 'admin/insert_desc.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

        return $smarty->display($tplPath);
    }

    // Save
    $desc = timandes_get_post_data('desc');
    $location = (int)timandes_get_post_data('location');
    $groupId = (int)timandes_get_post_data('group_id');

    $locationRange = array(1, 2);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$groupId)
        throw new \UnexpectedValueException("请选择分组");
    if (!$desc)
        throw new \UnderflowException("请给出至少一个关键词");

    $corporation = enterprise_get_corporation_info($userSiteId);
    $desc = str_replace('[公司名称]', $corporation['name'], $desc);

    $group = enterprise_get_group_info($groupId);
    $desc = str_replace('[产品分组]', $group['name'], $desc);

    $productDAO = new \enterprise\daos\Product();
    $curProductId = 0;
    do {
        $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `group_id`={$groupId} AND `id`>{$curProductId}";
        $products = $productDAO->getMultiInOrderBy($condition, '`id`, `caption`, `description`', '`id` ASC', 100);
        if (!$products)
            break;

        foreach ($products as $product) {
            $fragment = str_replace('[产品标题]', $product['caption'], $desc);
            $fragmentHtml = '<p>' . $fragment . '</p>';
            $newDescription = ($location==1?($fragmentHtml . $product['description']):($product['description'] . $fragmentHtml));
            $values = array(
                    'description' => $newDescription,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $productDAO->update($product['id'], $values);

            $curProductId = $product['id'];
        }
    } while(true);

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}


/**
 * Insert Images
 */
function enterprise_admin_action_insert_images($smarty)
{
    $tplPath = 'admin/insert_images.tpl';
    $maxImages = 5;

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

        return $smarty->display($tplPath);
    }

    // Save
    $location = (int)timandes_get_post_data('location');
    $groupId = (int)timandes_get_post_data('group_id');

    $locationRange = array(1);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$groupId)
        throw new \UnexpectedValueException("请选择分组");

    // Upload images
    $uploadedImages = enterprise_admin_upload_post_images();
    if (!$uploadedImages)
        return enterprise_admin_display_error_msg($smarty, '请选择至少一张图片');

    $targetCnt = (int)timandes_get_post_data('location_' . $location . '_cnt');

    $productDAO = new \enterprise\daos\Product();
    $curProductId = 0;
    $pendingImages = $uploadedImages;
    do {
        $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `group_id`={$groupId} AND `id`>{$curProductId}";
        $products = $productDAO->getMultiInOrderBy($condition, '`id`, `images`', '`id` ASC', 100);
        if (!$products)
            break;

        foreach ($products as $product) {
            $images = json_decode($product['images'], true);
            if (!is_array($images))
                $images = array();

            $imageCnt = count($images);
            $imageSlots = $maxImages - $imageCnt;
            for ($i=0; $i<$imageSlots; ++$i) {
                $img = array_pop($pendingImages);
                array_unshift($images, $img);
                if (count($pendingImages) <= 0) {
                    $pendingImages = $uploadedImages;
                    shuffle($pendingImages);
                }
            }

            $values = array(
                    'images' => $images,
                    'head_image_id' => $images[0],
                    'updated' => date('Y-m-d H:i:s'),
                );
            $productDAO->update($product['id'], $values);

            $curProductId = $product['id'];
        }
    } while(true);

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

/* }}} */

/* {{{ Contact */

/**
 * Contacts
 */
function enterprise_admin_action_contact($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_assign_contact_list($smarty, 'contacts', $userSiteId);

    $smarty->display('admin/contact.tpl');
}

/**
 * Edit Contact
 */
function enterprise_admin_action_edit_contact($smarty, $site)
{
    $tplPath = 'admin/edit_contact.tpl';

    $contactId = (int)timandes_get_query_data('contact_id');
    $smarty->assign('contact_id', $contactId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($contactId) 
            enterprise_assign_contact_info($smarty, 'contact', $contactId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $name = timandes_get_post_data('name');
    $title = timandes_get_post_data('title');
    $tel = timandes_get_post_data('tel');
    $skype = timandes_get_post_data('skype');
    $email = timandes_get_post_data('email');
    $yahoo = timandes_get_post_data('yahoo');
    $icq = timandes_get_post_data('icq');
    $viber = timandes_get_post_data('viber');
    $whatsapp = timandes_get_post_data('whatsapp');

    if (!$name)
        return enterprise_admin_display_error_msg($smarty, '请输入姓名');

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
        // Authentication
        $originalContact = $contactDAO->get($contactId);
        if (!$originalContact
                || $originalContact['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $contactDAO->update($contactId, $values);
        enterprise_assign_contact_info($smarty, 'contact', $contactId);
    } else {// Create
        $values['created'] = $values['updated'];
        $contactDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=contact', '管理联系人');
}

/**
 * Delete Contact
 */
function enterprise_admin_action_delete_contact($smarty, $site)
{
    $contactId = (int)timandes_get_query_data('contact_id');

    $contactDAO = new \enterprise\daos\Contact();
    // Authentication
    $contact = $contactDAO->get($contactId);
    if (!$contact
            || $contact['site_id'] != $site['site_id'])
        return header('Location: ?action=contact&error_msg=' . urlencode('权限不足'));
    // Delete
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
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $type = (int)timandes_get_query_data('type');
    if (!$type)
        $type = null;
    $pageNo = (int)timandes_get_query_data('page');
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
    global $maxWidthInfo;

    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $imageDAO = new \enterprise\daos\Image();
    $thumbnailDAO = new \enterprise\daos\Thumbnail();
    $imageManager = new \Intervention\Image\ImageManager();
    $images = array();
    foreach ($_FILES as $name => $meta) {
        $id = timandes_get_post_data($name);
        if (!$id) {// Upload now!
            if ($meta['error'])
                continue;

            $body = null;
            $maxWidth = (isset($maxWidthInfo[$thumbnailFor])?$maxWidthInfo[$thumbnailFor]:IMAGE_MAX_WIDTH_4_PRODUCT);
            $id = enterprise_admin_save_image($imageDAO, $userSiteId, $imageManager, $meta['tmp_name'], $body, $maxWidth);
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
function enterprise_admin_action_edit_photo($smarty, $site)
{
    $tplPath = 'admin/edit_photo.tpl';

    $photoId = (int)timandes_get_query_data('photo_id');
    $smarty->assign('photo_id', $photoId);

    $smarty->assign('predefined_photo_types', \enterprise\daos\Photo::getPredefinedTypes());

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($photoId) 
            enterprise_assign_photo_info($smarty, 'photo', $photoId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $uri = timandes_get_post_data('uri');
    $desc = timandes_get_post_data('desc');
    $type = (int)timandes_get_post_data('type');

    if (!$desc)
        return enterprise_admin_display_error_msg($smarty, '请输入描述');
    if (!$type)
        return enterprise_admin_display_error_msg($smarty, '请选择分类');

    // Upload Images
    $images = enterprise_admin_upload_post_images();
    if (!$images)
        return enterprise_admin_display_error_msg($smarty, '请选择照片');

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
        // Authentication
        $originalPhoto = $photoDAO->get($photoId);
        if (!$originalPhoto
                || $originalPhoto['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $photoDAO->update($photoId, $values);
        enterprise_assign_photo_info($smarty, 'photo', $photoId);
    } else {// Create
        $values['created'] = $values['updated'];
        $photoDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=photo', '公司图片');
}

/**
 * Delete Photo
 */
function enterprise_admin_action_delete_photo($smarty, $site)
{
    $photoId = (int)timandes_get_query_data('photo_id');

    $photoDAO = new \enterprise\daos\Photo();
    // Authentication
    $photo = $photoDAO->get($photoId);
    if (!$photo
            || $photo['site_id'] != $site['site_id'])
        return header('Location: ?action=photo&error_msg=' . urlencode('权限不足'));
    // Delete
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
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $condition = enterprise_assign_certification_list($smarty, 'certifications', $userSiteId);

    $smarty->display('admin/certification.tpl');
}

/**
 * Edit Certification
 */
function enterprise_admin_action_edit_certification($smarty, $site)
{
    $tplPath = 'admin/edit_certification.tpl';

    $certificationId = (int)timandes_get_query_data('certification_id');
    $smarty->assign('certification_id', $certificationId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($certificationId) 
            enterprise_assign_certification_info($smarty, 'certification', $certificationId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $uri = timandes_get_post_data('uri');
    $standard = timandes_get_post_data('standard');
    $number = timandes_get_post_data('number');
    $issueDate = timandes_get_post_data('issue_date');
    $expiryDate = timandes_get_post_data('expiry_date');
    $scopeNRange = timandes_get_post_data('scope_n_range');
    $issuedBy = timandes_get_post_data('issued_by');

    // Upload Images
    $images = enterprise_admin_upload_post_images('certification');
    if (!$images)
        return enterprise_admin_display_error_msg($smarty, '请选择照片');

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
        // Authentication
        $originalCertification = $certificationDAO->get($certificationId);
        if (!$originalCertification
                || $originalCertification['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $certificationDAO->update($certificationId, $values);
        enterprise_assign_certification_info($smarty, 'certification', $certificationId);
    } else {// Create
        $values['created'] = $values['updated'];
        $certificationDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=certification', '我的证书');
}

/**
 * Delete Certification
 */
function enterprise_admin_action_delete_certification($smarty, $site)
{
    $certificationId = (int)timandes_get_query_data('certification_id');

    $certificationDAO = new \enterprise\daos\Certification();
    // Authentication
    $certification = $certificationDAO->get($certificationId);
    if (!$certification
            || $certification['site_id'] != $site['site_id'])
        return header('Location: ?action=certification&error_msg=' . urlencode('权限不足'));
    // Delete
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
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
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
function enterprise_admin_action_edit_task($smarty, $site)
{
    $tplPath = 'admin/edit_task.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    $taskId = (int)timandes_get_query_data('task_id');
    $smarty->assign('task_id', $taskId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($taskId) 
            enterprise_admin_assign_task_info($smarty, 'task', $taskId);
        return $smarty->display($tplPath);
    }

    // Save
    $groupId = timandes_get_post_data('group_id');
    $targetUrl = timandes_get_post_data('target_url');
    if (!$groupId)
        return enterprise_admin_display_error_msg($smarty, '请选择目标分组');
    if (!$targetUrl)
        return enterprise_admin_display_error_msg($smarty, '请输入目标URL');

    $taskDAO = new \blowjob\daos\Task();
    $values = array(
            'site_id' => $userSiteId,
            'group_id' => $groupId,
            'target_url' => $targetUrl,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($taskId) {// Edit
        // Authentication
        $originalTask = $taskDAO->get($taskId);
        if (!$originalTask
                || $originalTask['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $taskDAO->update($taskId, $values);
        enterprise_admin_assign_task_info($smarty, 'task', $taskId);
    } else {// Create
        $values['created'] = $values['updated'];
        $taskDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=task', '我的任务');
}

/**
 * Delete Task
 */
function enterprise_admin_action_delete_task($smarty, $site)
{
    $taskId = (int)timandes_get_query_data('task_id');

    $taskDAO = new \blowjob\daos\Task();
    // Authentication
    $task = $taskDAO->get($taskId);
    if (!$task
            || $task['site_id'] != $site['site_id'])
        return header('Location: ?action=task&error_msg=' . urlencode('权限不足'));

    // Delete
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
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $condition = enterprise_assign_banner_list($smarty, 'banners', $userSiteId);

    $smarty->display('admin/banner.tpl');
}

/**
 * Edit Banner
 */
function enterprise_admin_action_edit_banner($smarty, $site)
{
    $tplPath = 'admin/edit_banner.tpl';

    $bannerId = (int)timandes_get_query_data('banner_id');
    $smarty->assign('banner_id', $bannerId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($bannerId) 
            enterprise_assign_banner_info($smarty, 'banner', $bannerId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $uri = timandes_get_post_data('uri');
    $desc = timandes_get_post_data('desc');
    $link = timandes_get_post_data('link');

    // Upload Images
    $images = enterprise_admin_upload_post_images('banner');
    if (!$images)
        return enterprise_admin_display_error_msg($smarty, '请选择图片');

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
        // Authentication
        $originalBanner = $bannerDAO->get($bannerId);
        if (!$originalBanner
                || $originalBanner['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $bannerDAO->update($bannerId, $values);
        enterprise_assign_banner_info($smarty, 'banner', $bannerId);
    } else {// Create
        $values['created'] = $values['updated'];
        $bannerDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=banner', 'Banner 管理');
}

/**
 * Delete Banner
 */
function enterprise_admin_action_delete_banner($smarty, $site)
{
    $bannerId = (int)timandes_get_query_data('banner_id');

    $bannerDAO = new \enterprise\daos\Banner();
    // Authentication
    $banner = $bannerDAO->get($bannerId);
    if (!$banner
            || $banner['site_id'] != $site['site_id'])
        return header('Location: ?action=banner&error_msg=' . urlencode('权限不足'));
    // Delete
    $values = array(
            'deleted' => 1,
        );
    $bannerDAO->update($bannerId, $values);
    header('Location: ?action=banner&success_msg=' . urlencode('删除成功'));
}

/* }}} */

/* {{{ IP Lookup */
/**
 * 获取指定IP地址可能位于的网络列表
 *
 * @param string $addr IP地址字符串
 * @return string intip1,intip2,...
 */
function enterprise_admin_iplookup_get_possible_networks($addr)
{
    $ip = ip2long($addr);
    $aLongNetworkAddrs = array();
    for($i=1; $i<=16777216; $i*=2) {
        $mask = (4294967296 - $i);
        $aLongNetworkAddrs[$ip & $mask] = 1;
    }

    return implode(",", array_keys($aLongNetworkAddrs));
}

/**
 * 获取IP所在地信息
 *
 * @param array $aAddrs 多个IP地址字符串
 * @return array[]|false (addr => (info => value))
 */
function enterprise_admin_iplookup_get_info_from_addrs($aAddrs, $sFields = '`country`,`city`,`province`,`district`,`isp`')
{
    if(!is_array($aAddrs))
        return array();
    if(!isset($aAddrs[0]))
        return array();
    if(empty($sFields))
        return array();

    $aSqls = array();
    foreach($aAddrs as $addr) {
        $sLongNetworkAddrs = enterprise_admin_iplookup_get_possible_networks($addr);
        $aSqls[] = "select {$sFields},`updatetime` from `enterprise_iplookup` where `start` in ({$sLongNetworkAddrs})";
    }

    $oDb = \DbFactory::create('crawler');

    $sSqls = implode(";", $aSqls);

    $r = $oDb->multi_query($sSqls);

    $i = 0;
    $aRetval = array();
    do {
        $iUpdateTime = 0;
        $aInfo = array();
        if($r = $oDb->store_result()) {
            while($row = $r->fetch_assoc()) {
                $ut = date_format(date_create($row['updatetime']), 'U'); // FIXME: 这里应该可以通过修改数据表结构优化。可以尝试使用int类型。
                if($ut > $iUpdateTime) {
                    $iUpdateTime = $ut;
                    $aInfo = $row;
                }
            }
            $r->free();

            $aRetval[$aAddrs[$i]] = $aInfo;
        }

        if(!$oDb->more_results())
            break;
        ++$i;
    } while($oDb->next_result());

    return $aRetval;
}
/* }}} */


/* {{{ CustomPage */

/**
 * CustomPages
 */
function enterprise_admin_action_custom_page($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_assign_custom_page_list($smarty, 'custom_pages', $userSiteId);

    $smarty->display('admin/custom_page.tpl');
}

/**
 * Edit CustomPage
 */
function enterprise_admin_action_edit_custom_page($smarty, $site)
{
    $tplPath = 'admin/edit_custom_page.tpl';

    $customPageId = (int)timandes_get_query_data('custom_page_id');
    $smarty->assign('custom_page_id', $customPageId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($customPageId) 
            enterprise_assign_custom_page_info($smarty, 'custom_page', $customPageId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $path = timandes_get_post_data('path');
    $desc = timandes_get_post_data('desc');
    $body = timandes_get_post_data('body', 'trim');

    if (!$path)
        return enterprise_admin_display_error_msg($smarty, '请输入页面路径');

    $customPageDAO = new \enterprise\daos\CustomPage();
    $values = array(
            'site_id' => $userSiteId,
            'path' => $path,
            'desc' => $desc,
            'body' => $body,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($customPageId) {// Edit
        // Authentication
        $originalCustomPage = $customPageDAO->get($customPageId);
        if (!$originalCustomPage
                || $originalCustomPage['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $customPageDAO->update($customPageId, $values);
        enterprise_assign_custom_page_info($smarty, 'custom_page', $customPageId);
    } else {// Create
        $values['created'] = $values['updated'];
        $customPageDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=custom_page', 'Webmasters 验证');
}

/**
 * Delete CustomPage
 */
function enterprise_admin_action_delete_custom_page($smarty, $site)
{
    $customPageId = (int)timandes_get_query_data('custom_page_id');

    $customPageDAO = new \enterprise\daos\CustomPage();
    // Authentication
    $customPage = $customPageDAO->get($customPageId);
    if (!$customPage
            || $customPage['site_id'] != $site['site_id'])
        return header('Location: ?action=custom_page&error_msg=' . urlencode('权限不足'));
    // Delete
    $values = array(
            'deleted' => 1,
        );
    $customPageDAO->update($customPageId, $values);
    header('Location: ?action=custom_page&success_msg=' . urlencode('删除成功'));
}

/* }}} */

/* {{{ Image Manager */

/**
 * Upload Image
 */
function enterprise_admin_action_upload_image($smarty)
{
    $funcNum = (int)timandes_get_query_data('CKEditorFuncNum');

    // Upload Images
    $images = enterprise_admin_upload_post_images('');
    if (!$images) {
        $msg = '请选择要上传的图片';
        $responseJS = "window.parent.CKEDITOR.tools.callFunction( {$funcNum}, undefined , '{$msg}' );";
        echo '<script type="text/javascript">' . $responseJS . '</script>';
        return;
    }

    $uri = 'image://' . $images[0];
    $imageUrl = enterprise_url_photo($uri, '', '', '', true);
    $responseJS = "window.parent.CKEDITOR.tools.callFunction( {$funcNum}, '{$imageUrl}' );";
    echo '<script type="text/javascript">' . $responseJS . '</script>';
}
/* }}} */


/* {{{ Comment */

/**
 * Comments
 */
function enterprise_admin_action_comment($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $productId = (int)timandes_get_query_data('product_id');
    $smarty->assign('product_id', $productId);

    enterprise_assign_comment_list($smarty, 'comments', $userSiteId, $productId);

    $smarty->display('admin/comment.tpl');
}

function enterprise_admin_source_inquiry_2_comment($sourceInquiryId)
{
    if (!$sourceInquiryId)
        return null;

    $inquiryDAO = new \enterprise\daos\Inquiry();
    $inquiry = $inquiryDAO->get($sourceInquiryId);
    if (!$inquiry)
        return null;

    $retval = array(
            'product_id' => $inquiry['target_product_id'],
            'subject' => $inquiry['subject'],
            'message' => $inquiry['message'],
        );
    return $retval;
}

/**
 * Edit Comment
 */
function enterprise_admin_action_edit_comment($smarty, $site)
{
    $tplPath = 'admin/edit_comment.tpl';

    $commentId = (int)timandes_get_query_data('comment_id');
    $smarty->assign('comment_id', $commentId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($commentId) 
            enterprise_assign_comment_info($smarty, 'comment', $commentId);

        // Product ID when creating
        $productId = (int)timandes_get_query_data('product_id');
        $smarty->assign('product_id', $productId);

        // From inquiry?
        $sourceInquiryId = (int)timandes_get_query_data('source_inquiry_id');
        $comment = enterprise_admin_source_inquiry_2_comment($sourceInquiryId);
        if ($comment)
            $smarty->assign('comment', $comment);

        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $productId = (int)timandes_get_post_data('product_id');
    $subject = timandes_get_post_data('subject');
    $message = timandes_get_post_data('message', 'xss_clean, remove_n_r, trim');
    $contact = timandes_get_post_data('contact');
    $issuedOn = timandes_get_post_data('issued_on');

    // Upload Images
    $images = enterprise_admin_upload_post_images();
    if (!$images)
        return enterprise_admin_display_error_msg($smarty, '请选择图片');

    $avatar = 'image://' . $images[0];

    $commentDAO = new \enterprise\daos\Comment();
    $values = array(
            'site_id' => $userSiteId,
            'product_id' => $productId,
            'subject' => $subject,
            'message' => $message,
            'avatar' => $avatar,
            'contact' => $contact,
            'issued_on' => $issuedOn,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($commentId) {// Edit
        // Authentication
        $originalComment = $commentDAO->get($commentId);
        if (!$originalComment
                || $originalComment['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $commentDAO->update($commentId, $values);
        enterprise_assign_comment_info($smarty, 'comment', $commentId);
    } else {// Create
        $values['created'] = $values['updated'];
        $commentDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=comment', '产品留言');
}

/**
 * Delete Comment
 */
function enterprise_admin_action_delete_comment($smarty, $site)
{
    $commentId = (int)timandes_get_query_data('comment_id');

    $commentDAO = new \enterprise\daos\Comment();
    // Authentication
    $comment = $commentDAO->get($commentId);
    if (!$comment
            || $comment['site_id'] != $site['site_id'])
        return header('Location: ?action=comment&error_msg=' . urlencode('权限不足'));
    // Delete
    $values = array(
            'deleted' => 1,
        );
    $commentDAO->update($commentId, $values);
    header('Location: ?action=comment&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/**
 * Email Template
 */
function enterprise_admin_action_email_template($smarty, $currentDomainSuffix)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $step = (int)timandes_get_query_data('step');
    switch ($step) {
        case 3:
            $user = $smarty->getTemplateVars('user');
            $message = timandes_get_post_data('message', 'xss_clean, remove_n_r, trim');
            $subject = 'EDM Template (#' . date('Y-m-d H:i:s') . ')';

            if ($user
                    && $user['email']
                    && Nette\Utils\Validators::is($user['email'], 'email')) {
                $mailDomain = 'mail.50u50.com';
                $from = 'no-reply@' . $mailDomain;
                $mail = timandes_initialize_mail_message($user['email'], $from, $user['email'], $subject, $message);
                $mailer = new Nette\Mail\SmtpMailer(array(
                        'host' => $mailDomain,
                    ));
                $mailer->send($mail);
            }
            $smarty->assign('success_msg', '发送成功');

            $smarty->assign('content', $message);
            $tplPath = 'admin/email_template_step_2.tpl';
            break;
        case 2:
            $groupIdArray = timandes_get_post_data('group_id_array');
            $productUrlArray = timandes_get_post_data('product_url_array');

            // Get groups
            $groupDAO = new enterprise\daos\Group();
            $groupIds = array_unique(array_values($groupIdArray));
            $condition = "`id` IN (" . implode(',', $groupIds) . ")";
            $groups = $groupDAO->getMultiBy($condition);
            $smarty->assign('selected_groups', $groups);

            // Get products
            $productDAO = new enterprise\daos\Product();
            $productArray = array();
            foreach ($productUrlArray as $urls) {
                $products = array();
                foreach ($urls as $url) {
                    $path = parse_url($url, PHP_URL_PATH);
                    if (!preg_match(PATTERN_PRODUCT_PAGE, $path, $matches))
                        continue;
                    $productId = $matches[1];
                    $products[] = $productDAO->get($productId);
                }
                $productArray[] = $products;
            }
            $smarty->assign('product_array', $productArray);

            enterprise_action_sets_common_proc($smarty, $userSiteId, $currentDomainSuffix);

            $templateContent = $smarty->fetch('admin/emails/edm.tpl');
            $smarty->assign('content', $templateContent);

            $tplPath = 'admin/email_template_step_2.tpl';
            break;
        default:
            $tplPath = 'admin/email_template_step_1.tpl';
            enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);
            break;
    }
    $smarty->display($tplPath);
}


/* {{{ News */

/**
 * News
 */
function enterprise_admin_action_news($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $newsDAO = new \enterprise\daos\News();

    $condition = enterprise_assign_news_list($smarty, 'news', $userSiteId, $pageNo, $max);

    $totalNews = $newsDAO->countBy($condition);
    $smarty->assign('total_news', $totalNews);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalNews, $max, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    $smarty->display('admin/news.tpl');
}

/**
 * Edit News
 */
function enterprise_admin_action_edit_news($smarty, $site)
{
    $tplPath = 'admin/edit_news.tpl';

    $newsId = (int)timandes_get_query_data('news_id');
    $smarty->assign('news_id', $newsId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_admin_assign_group_list($smarty, 'groups', $userSiteId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($newsId) 
            enterprise_assign_news_info($smarty, 'news', $newsId);

        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $caption = timandes_get_post_data('caption');
    $content = timandes_get_post_data('content', 'xss_clean, remove_n_r, trim');

    if (!$caption)
        return enterprise_admin_display_error_msg($smarty, '请输入新闻标题');

    // Upload images
    $images = enterprise_admin_upload_post_images('');
    $headImageId = ($images?$images[0]:0);

    // Save news
    $newsDAO = new \enterprise\daos\News();
    $values = array(
            'site_id' => $userSiteId,
            'caption' => $caption,
            'content' => $content,
            'updated' => date('Y-m-d H:i:s'),
            'head_image_id' => $headImageId,
        );
    if ($newsId) {// Edit
        // Authentication
        $originalNews = $newsDAO->get($newsId);
        if (!$originalNews
                || $originalNews['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $newsDAO->update($newsId, $values);
        enterprise_assign_news_info($smarty, 'news', $newsId);
    } else {// Create
        $values['created'] = $values['updated'];
        $newsDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=news', '新闻管理');
}

/**
 * Delete News
 */
function enterprise_admin_action_delete_news($smarty, $site)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $newsId = (int)timandes_get_query_data('news_id');

    // Get group ID
    $newsDAO = new \enterprise\daos\News();
    $news = $newsDAO->get($newsId);
    if (!$news) {
        $msg = '找不到指定的新闻';
        return header('Location: ?action=news&error_msg=' . urlencode($msg));
    }
    if ($news['site_id'] != $site['site_id'])
        return header('Location: ?action=news&error_msg=' . urlencode('权限不足'));
    if ($news['deleted']) 
        return header('Location: ?action=news&success_msg=' . urlencode('删除成功'));

    // Delete news
    $values = array(
            'deleted' => 1,
            'updated' => date('Y-m-d H:i:s'),
        );
    $newsDAO->update($newsId, $values);

    header('Location: ?action=news&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/* {{{ UserVoice */

/**
 * 从站点中导入旧的用户赠言
 *
 * @return array 导入的用户赠言
 */
function enterprise_admin_import_user_voices($site)
{
    $userVoices = json_decode($site['user_voices'], true);
    if (!is_array($userVoices))
        return false;

    $userVoiceDAO = new \enterprise\daos\UserVoice();
    $dateString = date('Y-m-d H:i:s');
    $retval = array();
    foreach ($userVoices as $uv) {
        $values = array(
                'site_id' => $site['site_id'],
                'title' => $uv['title'],
                'voice' => $uv['voice'],
                'created' => $dateString,
                'updated' => $dateString,
                'avatar_image_id' => 0,
            );
        $values['id'] = $userVoiceDAO->insert($values);

        $retval[] = $values;
    }

    return $retval;
}

/**
 * UserVoice
 */
function enterprise_admin_action_user_voice($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $userVoiceDAO = new \enterprise\daos\UserVoice();

    $condition = enterprise_assign_user_voice_list($smarty, 'user_voices', $userSiteId, $pageNo, $max);
    // Need import?
    $userVoices = $smarty->getTemplateVars('user_voices');
    if (!$userVoices) {
        $site = $smarty->getTemplateVars('site');
        $userVoices = enterprise_admin_import_user_voices($site);
        if ($userVoices)
            $smarty->assign('user_voices', $userVoices);
    }

    $totalUserVoice = $userVoiceDAO->countBy($condition);
    $smarty->assign('total_user_voice', $totalUserVoice);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalUserVoice, $max, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    $smarty->display('admin/user_voice.tpl');
}

/**
 * Edit UserVoice
 */
function enterprise_admin_action_edit_user_voice($smarty, $site)
{
    $tplPath = 'admin/edit_user_voice.tpl';

    $userVoiceId = (int)timandes_get_query_data('user_voice_id');
    $smarty->assign('user_voice_id', $userVoiceId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($userVoiceId) 
            enterprise_assign_user_voice_info($smarty, 'user_voice', $userVoiceId);

        return $smarty->display($tplPath);
    }

    // Save
    $title = timandes_get_post_data('title');
    $voice = timandes_get_post_data('voice');

    if (!$title)
        return enterprise_admin_display_error_msg($smarty, '请输入称谓');

    // Upload images
    $images = enterprise_admin_upload_post_images();
    $avatarImageId = ($images?$images[0]:0);

    // Save user_voice
    $userVoiceDAO = new \enterprise\daos\UserVoice();
    $values = array(
            'site_id' => $userSiteId,
            'title' => $title,
            'voice' => $voice,
            'updated' => date('Y-m-d H:i:s'),
            'avatar_image_id' => $avatarImageId,
        );
    if ($userVoiceId) {// Edit
        // Authentication
        $originalUserVoice = $userVoiceDAO->get($userVoiceId);
        if (!$originalUserVoice
                || $originalUserVoice['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $userVoiceDAO->update($userVoiceId, $values);
        enterprise_assign_user_voice_info($smarty, 'user_voice', $userVoiceId);
    } else {// Create
        $values['created'] = $values['updated'];
        $userVoiceDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=user_voice', '用户赠言');
}

/**
 * Delete UserVoice
 */
function enterprise_admin_action_delete_user_voice($smarty, $site)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $userVoiceId = (int)timandes_get_query_data('user_voice_id');

    // Get group ID
    $userVoiceDAO = new \enterprise\daos\UserVoice();
    $user_voice = $userVoiceDAO->get($userVoiceId);
    if (!$user_voice) {
        $msg = '找不到指定的赠言';
        return header('Location: ?action=user_voice&error_msg=' . urlencode($msg));
    }
    if ($user_voice['site_id'] != $site['site_id'])
        return header('Location: ?action=user_voice&error_msg=' . urlencode('权限不足'));
    if ($user_voice['deleted']) 
        return header('Location: ?action=user_voice&success_msg=' . urlencode('删除成功'));

    // Delete user_voice
    $values = array(
            'deleted' => 1,
            'updated' => date('Y-m-d H:i:s'),
        );
    $userVoiceDAO->update($userVoiceId, $values);

    header('Location: ?action=user_voice&success_msg=' . urlencode('删除成功'));
}

/* }}} */