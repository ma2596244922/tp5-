<?php
/**
 * 用户后台公用函数库
 *
 * @package timandes\enterprise
 */

/** @var string Fields of Inquiry for List */
define('ENTERPRISE_INQUIRY_FIELDS_FOR_LIST', '`id`, `subject`, `email`, `country`, `created`, `target_product_id`, `domain`');
/** @var int Max Images per Product */
define('ENTERPRISE_MAX_IMAGES_PER_PRODUCT', 5);
/** @var string Default Language Code */
define('ENTERPRISE_DEFAULT_LANG_CODE', 'en');
/** @var array 商务条款涉及的产品字段 */
define('ENTERPRISE_PRODUCT_TERM_FIELDS', ['brand_name', 'model_number', 'certification', 'place_of_origin', 'min_order_quantity', 'price', 'payment_terms', 'supply_ability', 'delivery_time', 'packaging_details']);

/** @var array 暂存分组信息 */
$GLOBALS['gaGroupCache'] = array();

/**
 * XSS Clean For Site Owner
 *
 * @return string
 */
function xss_clean_4_site_owner($s)
{
    $antiXss = new voku\helper\AntiXSS();
    $antiXss->removeEvilAttributes(array('style'));
    $antiXss->removeEvilHtmlTags(array('iframe'));
    return $antiXss->xss_clean($s);
}

/**
 * Grant permission
 */
function enterprise_admin_grant_permission($targetSiteId)
{
    $retval = enterprise_admin_check_permission($targetSiteId);
    if ($retval)
        return $retval;

    header('Location: /admin/?action=login');
    exit;
}

/**
 * Check permission
 *
 * @return array User Info
 */
function enterprise_admin_check_permission($targetSiteId)
{
    $userId = (int)timandes_get_session_data(SESSION_FIELD_USER_ID);
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    if (!$userId
            || $userSiteId != $targetSiteId)
        return null;

    $userDAO = new \enterprise\daos\User();
    $user = $userDAO->get($userId);
    if (!$user
            || $user['site_id'] != $targetSiteId)
        return null;

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

/**
 * Assign Group List Ext
 */
function enterprise_admin_assign_group_list_ex($smarty, $var, $siteId, $langCode = 'en', $max = null)
{
    enterprise_assign_group_list_ex($smarty, $var, $siteId, $langCode, $max, '', false);
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
 * 注册用户登录Session
 */
function enterprise_admin_register_user_session($siteId, $userId)
{
    $_SESSION[SESSION_FIELD_USER_ID] = $userId;
    $_SESSION['user_site_id'] = $siteId;
}

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

    enterprise_admin_register_user_session($user['site_id'], $user['id']);

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

function enterprise_admin_parse_base64_data($s, &$meta = array())
{
    if (!$s)
        return null;

    if (strpos($s, 'data:') !== 0)
        return $s;

    $fp = fopen($s, 'r');
    $meta = stream_get_meta_data($fp);
    $data = fread($fp, 1024);
    fclose($fp);

    return $data;
}

/**
 * Change favicon
 */
function enterprise_admin_action_favicon($smarty)
{
    $tplPath = 'admin/favicon.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    // Upload favicon
    $favicon = '';
    foreach ($_FILES as $name => $meta) {
        $faviconBase64 = timandes_get_post_data($name);
        if (!$faviconBase64
                || !($favicon = enterprise_admin_parse_base64_data($faviconBase64))) {// Upload now!
            if ($meta['error'])
                continue;

            $favicon = file_get_contents($meta['tmp_name']);
        }
    }

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'favicon' => $favicon,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    $site = $smarty->getTemplateVars('site');
    $site['favicon'] = $favicon;
    $smarty->assign('site', $site);
    
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
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId, $langCode);
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
    $pUrlPrefix = timandes_get_post_data('purl_prefix');
    $gUrlPrefix = timandes_get_post_data('gurl_prefix');
    $defaultLangCode = timandes_get_post_data('default_lang_code');

    if (!$defaultLangCode)
        $defaultLangCode = ENTERPRISE_DEFAULT_LANG_CODE;

    $pUrlPrefix = preg_replace('/[^a-z]/', '', $pUrlPrefix);
    $gUrlPrefix = preg_replace('/[^a-z]/', '', $gUrlPrefix);

    if (!$name)
        throw new \RuntimeException("公司名称不能为空");

    $langCorporationDAO = (($langCode == 'en')?null:new \enterprise\daos\LangCorporation($langCode));

    $corporationDAO = new \enterprise\daos\Corporation();
    $values = array(
            'worktime' => $worktime,
            'tel_wt' => $telWt,
            'tel_nwt' => $telNWt,
            'fax' => $fax,
            'skype' => $skype,
            'email' => $email,
            'yahoo' => $yahoo,
            'updated' => date('Y-m-d H:i:s'),
        );
    if (!$langCorporationDAO) {// English
        $values['name'] = $name;
        $values['address'] = $address;
        $values['factory_address'] = $factoryAddress;
        $values['business_type'] = $businessType;
        $values['main_market'] = $mainMarket;
        $values['brands'] = $brands;
        $values['no_of_employees'] = $noOfEmployees;
        $values['annual_sales'] = $annualSales;
        $values['year_established'] = $yearEstablished;
        $values['export_p_c'] = $exportPC;
        $values['introduction'] = $introduction;
        $values['history'] = $history;
        $values['service'] = $service;
        $values['our_team'] = $ourTeam;
        $values['qc_profile'] = $qcProfile;
        $values['slogan'] = $slogan;
    }
    $corporationDAO->update($userSiteId, $values);
    // Language Corporation
    if ($langCorporationDAO) {
        $values = array(
                'name' => $name,
                'address' => $address,
                'factory_address' => $factoryAddress,
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
        $langCorporationDAO->update($userSiteId, $values);
    }
    enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId, $langCode);

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

    if ($langCode != 'en') {
        $siteDAO = new \enterprise\daos\Site();
    }
    $values = array(
            'purl_prefix' => $pUrlPrefix,
            'gurl_prefix' => $gUrlPrefix,
            'default_lang_code' => $defaultLangCode,
        );
    $siteDAO->update($userSiteId, $values);

    $site = $smarty->getTemplateVars('site');
    $site['desc_4_inquiry_sender'] = $desc4InquirySender;
    $site['contact_content'] = $contactContent;
    $site['purl_prefix'] = $pUrlPrefix;
    $site['gurl_prefix'] = $gUrlPrefix;
    $site['default_lang_code'] = $defaultLangCode;
    $smarty->assign('site', $site);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/* {{{ Hide */
/**
 * Hide
 */
function enterprise_admin_action_hide($smarty, $langCode)
{
    $tplPath = 'admin/hide.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        $hideSite = enterprise_get_hide_site_info($userSiteId);
        $smarty->assign('hide_site', $hideSite);
        return $smarty->display($tplPath);
    }

    $enabled = (int)timandes_get_post_data('enabled');
    $hide_by_ipaddr = (int)timandes_get_post_data('hide_by_ipaddr');
    $hide_by_browser = (int)timandes_get_post_data('hide_by_browser');
    $hide_by_os = (int)timandes_get_post_data('hide_by_os');
    $ipaddr_black_list = timandes_get_post_data('ipaddr_black_list');
    $ipaddr_white_list = timandes_get_post_data('ipaddr_white_list');
    $target_page = timandes_get_post_data('target_page');
    $target_page_url = timandes_get_post_data('target_page_url');

    $hideSiteDAO = new \hide\daos\Site();
    $values = array(
            'enabled' => $enabled,
            'hide_by_ipaddr' => $hide_by_ipaddr,
            'hide_by_browser' => $hide_by_browser,
            'hide_by_os' => $hide_by_os,
            'ipaddr_black_list' => $ipaddr_black_list,
            'ipaddr_white_list' => $ipaddr_white_list,
            'target_page' => $target_page,
            'target_page_url' => $target_page_url,
            'updated' => date('Y-m-d H:i:s'),
        );
    $hideSite = enterprise_get_hide_site_info($userSiteId);
    if ($hideSite) {// Update
        $condition = "`site_id`=" . (int)$userSiteId;
        $hideSiteDAO->updateBy($condition, $values);

        $values['site_id'] = $hideSite['site_id'];
        $values['created'] = $hideSite['created'];
    } else {// Insert
        $values['site_id'] = $userSiteId;
        $values['created'] = $values['updated'];
        $hideSiteDAO->insert($values);
    }
    $hideSite = $values;

    $smarty->assign('hide_site', $hideSite);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}

/**
 * Tracks
 */
function enterprise_admin_action_hide_track($smarty, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $keywords = timandes_get_query_data('keywords');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $hideTrackDAO = new \hide\daos\Track();
    $condition = "`site_id`={$userSiteId}";
    if ($keywords) {
        $escapedKeywords = $hideTrackDAO->escape($keywords);
        $ipAddr = ip2long($keywords);
        $ipAddrCondition = ($ipAddr?" OR `ipaddr`='{$ipAddr}'":'');
        $condition .= " AND (`ua` LIKE '%{$escapedKeywords}%' OR `path` LIKE '%{$escapedKeywords}%'{$ipAddrCondition})";
    }
    $start = ($pageNo - 1) * $max;
    $sql = "SELECT * FROM `hide_tracks` WHERE {$condition} ORDER BY `id` DESC LIMIT {$start}, {$max}";
    $hideTracks = $hideTrackDAO->getMultiBySql($sql);
    $smarty->assign('hide_tracks', $hideTracks);

    $totalTracks = 1000;
    $smarty->assign('total_hide_tracks', $totalTracks);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalTracks, $max, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    $smarty->display('admin/hide_track.tpl');
}

/* }}} */

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
function enterprise_admin_action_index_products($smarty, $site, $langCode = 'en')
{
    $tplPath = 'admin/index_products.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_assign_index_products($smarty, $site, $langCode);
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
        if (!enterprise_match_url_product($path, $productId, $pageNo, $langCode, $site))
            continue;
        if (!$productId)
            continue;
        $indexProductIdArray[] = $productId;
    }

    if ($langCode == 'en')
        $siteDAO = new \enterprise\daos\Site();
    else
        $siteDAO = new \enterprise\daos\LangSite($langCode);
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
function enterprise_admin_action_index_tdk($smarty, $site, $langCode)
{
    $tplPath = 'admin/index_tdk.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Auto TDK
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
        $corporation = $smarty->getTemplateVars('corporation');
        enterprise_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode, null, '', true, true, 3);
        $groups = $smarty->getTemplateVars('groups');
        enterprise_assign_tdk_of_home($smarty, $groups, $corporation, $site, $langCode);

        return $smarty->display($tplPath);
    }

    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description', 'strip_tags, strip_rn, trim');

    if ($langCode == 'en')
        $siteDAO = new \enterprise\daos\Site();
    else
        $siteDAO = new \enterprise\daos\LangSite($langCode);
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
 * 去掉\r和\n
 */
function strip_rn($s)
{
    $s = str_replace("\n", '', $s);
    $s = str_replace("\r", '', $s);
    return $s;
}

/**
 * Change product tdk
 */
function enterprise_admin_action_product_tdk($smarty, $site, $langCode)
{
    $tplPath = 'admin/product_tdk.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    enterprise_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description', 'strip_tags, strip_rn, trim');
    $tdkScope = 0;
    $groupId = (int)timandes_get_post_data('group_id');

    if ($tdkScope > 0) 
        throw new OutOfRangeException("数据错误");
    if ($tdkScope < 0) {
        if (!$groupId)
            throw new RuntimeException("请选择分组");
        $tdkScope = $groupId;
    }

    if ($langCode == 'en')
        $siteDAO = new \enterprise\daos\Site();
    else
        $siteDAO = new \enterprise\daos\LangSite($langCode);
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

/**
 * Change default image of products
 */
function enterprise_admin_action_product_default_image($smarty)
{
    $tplPath = 'admin/product_default_image.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    // Upload logo
    $images = enterprise_admin_upload_post_images('');
    if ($images)
        $productDefaultImage = $images[0];
    else
        $productDefaultImage = 0;

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'product_default_image' => $productDefaultImage,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    $site = $smarty->getTemplateVars('site');
    $site['product_default_image'] = $productDefaultImage;
    $smarty->assign('site', $site);
    
    $smarty->assign('success_msg', '修改成功');
    $smarty->display($tplPath);
}


/**
 * Change backgroud image
 */
function enterprise_admin_action_common_bg_image($smarty)
{
    $tplPath = 'admin/common_bg_image.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    // Upload logo
    $images = enterprise_admin_upload_post_images('bg_image');
    if ($images)
        $commonBGImage = $images[0];
    else
        $commonBGImage = 0;

    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'common_bg_image' => $commonBGImage,
            'updated' => date('Y-m-d H:i:s'),
        );
    $siteDAO->update($userSiteId, $values);

    $site = $smarty->getTemplateVars('site');
    $site['common_bg_image'] = $commonBGImage;
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

function enterprise_admin_assign_inquiry_detail($smarty, $inquiry)
{
    // Inquiry Attachments
    if (is_array($inquiry['attachments']))
        $inquiryAttachments = $inquiry['attachments'];
    else
        $inquiryAttachments = json_decode($inquiry['attachments'], true);
    $smarty->assign('inquiry_attachments', $inquiryAttachments);

    $ipv4 = $inquiry['ip'];
    // Country of Inquiry
    $inquiryCountry = $inquiry['country'];
    $ipv4Addrs = array($ipv4);
    $r = enterprise_admin_iplookup_get_info_from_addrs($ipv4Addrs);
    if (isset($r[$ipv4])
            && $r[$ipv4])
        $inquiryCountry = $r[$ipv4]['country'] . ' ' . $r[$ipv4]['province'] . ' ' . $r[$ipv4]['city'];
    $smarty->assign('inquiry_country', $inquiryCountry);
    // Country of Inquiry V2
    $r = enterprise_iparea_get_info_from_addr($ipv4);
    if ($r)
        $inquiryCountryV2 = $r['province'] . ' ' . $r['city'];
    $smarty->assign('inquiry_country_v2', $inquiryCountryV2);

    // Target product
    if ($inquiry['target_product_id'])
        enterprise_assign_product_info($smarty, 'target_product', $inquiry['target_product_id']);
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

    enterprise_admin_assign_inquiry_detail($smarty, $inquiry);

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
            'updated' => date('Y-m-d H:i:s'),
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
function enterprise_admin_action_group($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');

    
    if ($langCode == 'en') {
        $groupTablePrefix = '';
        $langGroupTablePrefix = '';
        $groupDAO = new \enterprise\daos\Group();
    } else {
        $groupTablePrefix = 'g.';
        $langGroupTablePrefix = 'lg.';
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
    }

    // Filter - Keywords
    $keywords = timandes_get_query_data('keywords');
    $keywordsCondition = '';
    if ($keywords) {
        $likeKeywordsPart = 'like \'%' . $groupDAO->escape($keywords) . '%\'';
        $keywordsCondition = '(' . $groupTablePrefix . '`purl_prefix` ' . $likeKeywordsPart . ' OR ' . $langGroupTablePrefix . '`name` ' . $likeKeywordsPart . ')';
    }

    enterprise_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode, null, $keywordsCondition, false);

    $smarty->display('admin/group.tpl');
}

/**
 * Get group info
 */
function enterprise_get_group_info($groupId, $langCode = 'en', $enableCache = false)
{
    if ($enableCache) {
        if (isset($GLOBALS['gaGroupCache'][$langCode][$groupId]))
            return $GLOBALS['gaGroupCache'][$langCode][$groupId];
    }

    $groupDAO = new \enterprise\daos\Group();
    $group = $groupDAO->get($groupId);

    // Language Group
    if ($langCode != 'en') {
        $langGroupDAO = new \enterprise\daos\LangGroup($langCode);
        $condition = '`group_id`=' . (int)$groupId;
        $langGroup = $langGroupDAO->getOneBy($condition);
        if ($langGroup)
            $group = array_merge($group, $langGroup);
    }

    if ($enableCache) {
        $GLOBALS['gaGroupCache'][$langCode][$groupId] = $group;
    }

    return $group;
}

/**
 * Assign group info
 */
function enterprise_admin_assign_group_info($smarty, $var, $groupId, $langCode = 'en')
{
    $smarty->assign($var, enterprise_get_group_info($groupId, $langCode));
}

function enterprise_admin_save_group($langCode, $groupId, $groupName, $userSiteId, $path = null, $pUrlPrefix = null
        , $htmlTitle = null, $metaKeywords = null, $metaDescription = null, $productGiveH1To = null)
{
    // Language Group
    $langGroupDAO = (($langCode == 'en')?null:new \enterprise\daos\LangGroup($langCode));

    // Save group
    $groupDAO = new \enterprise\daos\Group();
    $values = array(
            'purl_prefix' => $pUrlPrefix,
            'updated' => date('Y-m-d H:i:s'),
        );
    if (isset($path)) {
        $values['path'] = $path;
        if ($path)
            $values['path_sum'] = md5($path, true);
    }
    if (isset($productGiveH1To))
        $values['product_give_h1_to'] = $productGiveH1To;
    if (!$langGroupDAO) {// English only
        $values['site_id'] = $userSiteId;
        $values['name'] = $groupName;
        $values['product_html_title'] = $htmlTitle;
        $values['product_meta_keywords'] = $metaKeywords;
        $values['product_meta_description'] = $metaDescription;
    }
    if ($groupId) {// Edit
        // Authentication
        $originalGroup = enterprise_get_group_info($groupId, $langCode);
        if (!$originalGroup
                || $originalGroup['site_id'] != $userSiteId)
            throw new \RuntimeException('权限不足');
        // Update
        $groupDAO->update($groupId, $values);
    } else {// Create
        $values['created'] = $values['updated'];
        $newGroupId = $groupDAO->insert($values);
    }

    // Save lang group
    if ($langGroupDAO) {
        $values = array(
                'site_id' => $userSiteId,
                'name' => $groupName,
                'product_html_title' => $htmlTitle,
                'product_meta_keywords' => $metaKeywords,
                'product_meta_description' => $metaDescription,
                'updated' => date('Y-m-d H:i:s'),
            );
        if ($groupId) {// Edit
            $langGroupDAO->update($groupId, $values);
        } else {// Create
            $values['created'] = $values['updated'];
            $values['group_id'] = $newGroupId;
            $langGroupDAO->insert($values);
        }
    }

    if (isset($newGroupId))
        return $newGroupId;
}

/**
 * Edit Group
 */
function enterprise_admin_action_edit_group($smarty, $site, $langCode)
{
    $tplPath = 'admin/edit_group.tpl';

    $groupId = (int)timandes_get_query_data('group_id');
    $smarty->assign('group_id', $groupId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($groupId) 
            enterprise_admin_assign_group_info($smarty, 'group', $groupId, $langCode);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $groupName = timandes_get_post_data('name');
    $path = timandes_get_post_data('path');
    if ($path)
        $path = '/' . ltrim($path, '/');
    $pUrlPrefix = timandes_get_post_data('purl_prefix');
    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description', 'strip_tags, strip_rn, trim');
    $productGiveH1To = (int)timandes_get_post_data('product_give_h1_to');

    if (!$groupName)
        return enterprise_admin_display_error_msg($smarty, '请输入分组名称');

    enterprise_admin_save_group($langCode, $groupId, $groupName, $userSiteId, $path, $pUrlPrefix, $htmlTitle, $metaKeywords, $metaDescription, $productGiveH1To);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=group', '产品分组');
}

/**
 * Edit Group TDK
 */
function enterprise_admin_action_edit_group_tdk($smarty, $site)
{
    $tplPath = 'admin/edit_group_tdk.tpl';

    $groupId = (int)timandes_get_query_data('group_id');
    if (!$groupId)
        return header('Location: ?action=group');
    $smarty->assign('group_id', $groupId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Group Info
        enterprise_admin_assign_group_info($smarty, 'group', $groupId);
        $group = $smarty->getTemplateVars('group');

        // Auto TDK
        enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
        $corporation = $smarty->getTemplateVars('corporation');
        enterprise_assign_tdk_of_product_list($smarty, $corporation, 1, 'en', $groupId, $group);

        // Fill custom into blank
        if ($group['html_title'])
            $smarty->assign('title', $group['html_title']);
        if ($group['meta_keywords'])
            $smarty->assign('keywords', $group['meta_keywords']);
        if ($group['meta_description'])
            $smarty->assign('description', $group['meta_description']);

        return $smarty->display($tplPath);
    }

    // Save
    $htmlTitle = timandes_get_post_data('html_title');
    $metaKeywords = timandes_get_post_data('meta_keywords');
    $metaDescription = timandes_get_post_data('meta_description');
    $metaDescription = str_replace("\n", '', $metaDescription);
    $metaDescription = str_replace("\r", '', $metaDescription);

    $groupDAO = new \enterprise\daos\Group();
    // Authentication
    $originalGroup = $groupDAO->get($groupId);
    if (!$originalGroup
            || $originalGroup['site_id'] != $site['site_id'])
        return enterprise_admin_display_error_msg($smarty, '权限不足');

    // Save groups
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
            'html_title' => $htmlTitle,
            'meta_keywords' => $metaKeywords,
            'meta_description' => $metaDescription,
        );
    $groupDAO->update($groupId, $values);

    // Group Info
    enterprise_admin_assign_group_info($smarty, 'group', $groupId);
    $group = $smarty->getTemplateVars('group');

    // Auto TDK
    enterprise_assign_corporation_info($smarty, 'corporation', $userSiteId);
    $corporation = $smarty->getTemplateVars('corporation');
    enterprise_assign_tdk_of_product_list($smarty, $corporation, 1, 'en', $groupId, $group);

    // Fill custom into blank
    if ($group['html_title'])
        $smarty->assign('title', $group['html_title']);
    if ($group['meta_keywords'])
        $smarty->assign('keywords', $group['meta_keywords']);
    if ($group['meta_description'])
        $smarty->assign('description', $group['meta_description']);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=group', '分组管理');
}

/**
 * Edit Group Desc
 */
function enterprise_admin_action_edit_group_desc($smarty, $site)
{
    $tplPath = 'admin/edit_group_desc.tpl';

    $groupId = (int)timandes_get_query_data('group_id');
    if (!$groupId)
        return header('Location: ?action=group');
    $smarty->assign('group_id', $groupId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Group Info
        enterprise_admin_assign_group_info($smarty, 'group', $groupId);
        return $smarty->display($tplPath);
    }

    // Save
    $desc = timandes_get_post_data('desc', 'xss_clean_4_site_owner, remove_n_r, trim');

    $groupDAO = new \enterprise\daos\Group();
    // Authentication
    $originalGroup = $groupDAO->get($groupId);
    if (!$originalGroup
            || $originalGroup['site_id'] != $site['site_id'])
        return enterprise_admin_display_error_msg($smarty, '权限不足');

    // Save groups
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
            'desc' => $desc,
        );
    $groupDAO->update($groupId, $values);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=group', '分组管理');
}


/**
 * Export Products
 */
function enterprise_admin_action_export_group_products($smarty, $site, $langCode = 'en')
{
    $groupId = (int)timandes_get_query_data('group_id');
    if (!$groupId)
        $groupId = null;

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $fp = fopen("php://output", 'w');

    $fileName = 'Products.csv';
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename=' . $fileName);

    $colList = array(
            'ID', 'Caption', 'Group ID',
        );
    $fieldList = array(
            'id', 'caption', 'group_id',
        );
    fputcsv($fp, $colList);

    $size = 100;
    $page = 1;
    do {
        $products = enterprise_get_product_list($userSiteId, $langCode, $groupId, false, $page, $size);
        if (!is_array($products))
            break;
        if (count($products) <= 0)
            break;

        foreach ($products as $product) {
            $valueList = [];
            foreach ($fieldList as $f)
                $valueList[] = $product[$f];
            fputcsv($fp, $valueList);
        }

        ++$page;
    } while(true);

    fclose($fp);
}


/**
 * Import Products
 */
function enterprise_admin_action_import_group_products($smarty, $site, $langCode = 'en')
{
    $tplPath = 'admin/import_group_products.tpl';

    $groupId = (int)timandes_get_query_data('group_id');
    if (!$groupId)
        return header('Location: ?action=group');
    $smarty->assign('group_id', $groupId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    $type = (int)timandes_get_post_data('type');

    switch ($type) {
        case 10:
            $columnName = 'Caption';
            $fieldName = 'caption';
            if ($langCode == 'en')
                $productDAO = new \enterprise\daos\Product();
            else
                $productDAO = new \enterprise\daos\LangProduct($langCode);
            break;
        default:
            $columnName = 'Model Number';
            $fieldName = 'model_number';
            $productDAO = new \enterprise\daos\Product();
            break;
    }

    if ($_FILES['file']['error'])
        return enterprise_admin_display_error_msg($smarty, '请选择文件#' . $_FILES['file']['error']);

    $fp = fopen($_FILES['file']['tmp_name'], 'r');

    $headerLine = fgetcsv($fp);
    if ($headerLine[0] != 'ID'
            || $headerLine[1] != $columnName) {
        fclose($fp);
        return enterprise_admin_display_error_msg($smarty, '文件格式不正确');
    }

    while ($dataLine = fgetcsv($fp)) {
        $productId = (int)trim($dataLine[0]);
        $modelNumber = trim($dataLine[1]);
        $values = array(
                'updated' => date('Y-m-d H:i:s'),
                $fieldName => $modelNumber,
            );
        $productDAO->update($productId, $values);
    }

    fclose($fp);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=group', '分组管理');
}

/**
 * Delete Group
 */
function enterprise_admin_action_delete_group($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $groupId = (int)timandes_get_query_data('group_id');
    $forceDelete = (int)timandes_get_query_data('force');

    if ($langCode == 'en') {
        $productDAO = new \enterprise\daos\Product();
        $groupDAO = new \enterprise\daos\Group();
    } else {
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
    }
    // Authentication
    $group = $groupDAO->get($groupId);
    if (!$group
            || $group['site_id'] != $site['site_id'])
        return header('Location: ?action=group&error_msg=' . urlencode('权限不足'));

    if (!$forceDelete) {// Check products in current group
        $condition = "`site_id`={$userSiteId} AND `deleted`=0 AND `group_id`={$groupId}";
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
function enterprise_admin_action_count_products($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $groupId = (int)timandes_get_query_data('group_id');

    $groupCondition = '';
    if ($groupId)
        $groupCondition = " AND `group_id`={$groupId}";

    // Count products
    if ($langCode == 'en') {
        $productDAO = new \enterprise\daos\Product();
        if ($groupId)
            $groupCondition = " AND `group_id`={$groupId}";
        $condition = "`site_id`={$userSiteId} AND `deleted`=0{$groupCondition}";
    } else{
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        if ($groupId)
            $groupCondition = " AND elp.`group_id`={$groupId}";
        $condition = "elp.`site_id`={$userSiteId} AND elp.`deleted`=0{$groupCondition}";
    }
    $cnt = (int)$productDAO->countBy($condition);

    // Save count to group
    if ($groupId) {
        if ($langCode == 'en')
            $groupDAO = new enterprise\daos\Group();
        else
            $groupDAO = new enterprise\daos\LangGroup($langCode);
        $values = array(
                'cnt' => $cnt,
            );
        $groupDAO->update($groupId, $values);

        header('Location: ?action=group&success_msg=' . urlencode('操作成功'));
    } else {
        if ($langCode == 'en')
            $siteDAO = new enterprise\daos\Site();
        else
            $siteDAO = new enterprise\daos\LangSite($langCode);
        $values = array(
                'product_cnt' => $cnt,
            );
        $siteDAO->update($userSiteId, $values);

        header('Location: ?action=product&success_msg=' . urlencode('操作成功'));
    }
}

/**
 * Remove empty-caption products proc
 */
function enterprise_admin_remove_empty_caption_products_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];

    if ($langCode == 'en') {
        $productDAO = new \enterprise\daos\Product();
        $groupDAO = new \enterprise\daos\Group();
        $siteDAO = new \enterprise\daos\Site();
    } else {
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
        $siteDAO = new \enterprise\daos\LangSite($langCode);
    }

    do {
        if ($langCode == 'en')
            $products = enterprise_get_product_list($userSiteId, $langCode, null, false, 1, 100, "`caption`=''", '`id` ASC');
        else
            $products = enterprise_get_product_list($userSiteId, $langCode, null, false, 1, 100, "elp.`caption`=''", 'elp.`product_id` ASC');
        if (!$products)
            break;

        foreach ($products as $product) {
            $values = array(
                    'deleted' => 1,
                );
            $productDAO->update($product['id'], $values);

            // Cnt of products of group
            $groupDAO->incrCnt($product['group_id'], -1);

            // Cnt of products
            $siteDAO->incrProductCnt($userSiteId, -1);
        }
    } while(true);
}

/**
 * Count Products
 */
function enterprise_admin_action_remove_empty_caption_products($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $background = 1;

    $taskDetails = array(
            'lang_code' => $langCode,
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_REMOVE_EMPTY_CAPTION_PRODUCTS, $taskDetails);
    } else {
        enterprise_admin_remove_empty_caption_products_proc($userSiteId, $taskDetails);
    }

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
        $orderByFields = 'p.`updated`';
        $groupDAO = new \enterprise\daos\Group();
        $groupPrimaryKey = '`id`';
    } else {
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        $leftJoin1 = 'LEFT JOIN `enterprise_products` AS p ON p.`id`=elp.`product_id`';
        $diffFields = 'elp.`caption`, elp.`created`, elp.`updated`, elp.`source_url`, elp.`group_id`';
        $tableAlias = 'elp';
        $orderByFields = 'elp.`updated`';
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
        $groupPrimaryKey = '`group_id`';
    }
    $tableName = $productDAO->getTableName();
    $groupTableName = $groupDAO->getTableName();

    // Filter - Group
    $groupId = (int)timandes_get_query_data('group_id');
    $groupCondition = '';
    if ($groupId) {
        $groupCondition = ' AND ' . $tableAlias . '.`group_id`=' . $groupId;
        enterprise_admin_assign_group_info($smarty, 'group', $groupId, $langCode);
    }
    enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

    // Filter - Keywords
    $keywords = timandes_get_query_data('keywords');
    $keywordsCondition = '';
    if ($keywords)
        $keywordsCondition = ' AND ' . $tableAlias . '.`caption` like \'%' . $productDAO->escape($keywords) . '%\'';

    $start = ($pageNo - 1) * $max;
    $sql = "SELECT p.`id`, p.`path`, g.`name` AS `group_name`, {$diffFields}
    FROM `{$tableName}` AS {$tableAlias} FORCE INDEX (`idx_get_by_site`)
    {$leftJoin1}
    LEFT JOIN `{$groupTableName}` AS g ON {$tableAlias}.`group_id`=g.{$groupPrimaryKey}
    WHERE {$tableAlias}.`site_id`={$userSiteId} AND {$tableAlias}.`deleted`=0{$groupCondition}{$keywordsCondition}
    ORDER BY {$orderByFields} DESC LIMIT {$start}, {$max}";
    $products = $productDAO->getMultiBySql($sql);
    $productsWithGroup = array();
    if (is_array($products)) foreach ($products as $p) {
        $p['group'] = enterprise_get_group_info($p['group_id'], $langCode, true);
        $productsWithGroup[] = $p;
    }
    $smarty->assign('products', $productsWithGroup);

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
function enterprise_admin_assign_product_info($smarty, $var, $productId, $langCode = 'en')
{
    $product = enterprise_get_product_info($productId, $langCode);
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

    // No thumbnail info
    if (!isset($thumbnailInfo[$for]))
        return;

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
 * Save Products
 */
function enterprise_admin_save_product($langCode, $productId, $brandName, $modelNumber, $certification, $placeOfOrigin, $price, $paymentTerms, $supplyAbility, $headImageId, $images, $userSiteId, $caption, $description, $groupId, $minOrderQuantity, $deliveryTime, $packagingDetails, $specificationsArray, $tags, $customPath = null, $sourceUrl = null, $updated = null, $embeddedVideo = null)
{
    // LangProductDAO
    $langProductDAO = (($langCode!='en')?new \enterprise\daos\LangProduct($langCode):null);

    // Updated
    if (!$updated)
        $updated = date('Y-m-d H:i:s');

    // Save products
    $productDAO = new \enterprise\daos\Product();
    $values = array(
            'updated' => $updated,
            'brand_name' => $brandName,
            'model_number' => $modelNumber,
            'certification' => $certification,
            'place_of_origin' => $placeOfOrigin,
            'price' => $price,
            'payment_terms' => $paymentTerms,
            'supply_ability' => $supplyAbility,
            'head_image_id' => $headImageId,
            'images' => $images,
        );
    if ($customPath) {
        $values['path'] = '/' . ltrim($customPath, '/');
        $values['path_sum'] = md5($values['path'], true);
    }
    if (!$langProductDAO) {// English only
        $values['site_id'] = $userSiteId;
        $values['caption'] = $caption;
        $values['description'] = $description;
        $values['group_id'] = $groupId;
        $values['min_order_quantity'] = $minOrderQuantity;
        $values['delivery_time'] = $deliveryTime;
        $values['packaging_details'] = $packagingDetails;
        $values['specifications'] = $specificationsArray;
        $values['tags'] = $tags;
        $values['source_url'] = $sourceUrl;
        $values['embedded_video'] = $embeddedVideo;
    }
    if ($productId) {// Edit
        // Authentication
        $originalProduct = enterprise_get_product_info($productId, $langCode);
        if (!$originalProduct
                || $originalProduct['site_id'] != $userSiteId)
            throw new \RuntimeException('权限不足');
        // Update
        $productDAO->update($productId, $values);

        // Cnt of products of group
        if (!$langProductDAO// English only
                && $originalProduct['group_id'] != $values['group_id']) {
            $groupDAO = new \enterprise\daos\Group();
            $group = $groupDAO->get($originalProduct['group_id']);
            if ($group
                    && $group['cnt'] > 0)
                $groupDAO->incrCnt($originalProduct['group_id'], -1);
            $groupDAO->incrCnt($groupId);
        }
    } else {// Create
        $values['created'] = $values['updated'];
        $newProductId = $productDAO->insert($values);

        if (!$langProductDAO) {// English only
            // Cnt of products of group
            $groupDAO = new \enterprise\daos\Group();
            $groupDAO->incrCnt($groupId);

            // Cnt of products
            $siteDAO = new \enterprise\daos\Site();
            $siteDAO->incrProductCnt($userSiteId);
        }
    }

    // Save pending product
    if (!$langProductDAO) {
        if ($productId)
            enterprise_product_save_pending_product($userSiteId, $productId);
        else
            enterprise_product_save_pending_product($userSiteId, $newProductId);
    }

    // Save lang product
    if ($langProductDAO) {
        $values = array(
                'site_id' => $userSiteId,
                'caption' => $caption,
                'description' => $description,
                'group_id' => $groupId,
                'updated' => $updated,
                'min_order_quantity' => $minOrderQuantity,
                'delivery_time' => $deliveryTime,
                'packaging_details' => $packagingDetails,
                'specifications' => $specificationsArray,
                'tags' => $tags,
                'source_url' => $sourceUrl,
                'embedded_video' => $embeddedVideo,
            );
        if ($productId) {// Edit
            $values['product_id'] = $productId;
            $langProductDAO->update($productId, $values);

            // Cnt of products of group
            if ($originalProduct['group_id'] != $values['group_id']) {
                $groupDAO = new \enterprise\daos\LangGroup($langCode);
                $group = $groupDAO->get($originalProduct['group_id']);
                if ($group
                        && $group['cnt'] > 0)
                    $groupDAO->incrCnt($originalProduct['group_id'], -1);
                $groupDAO->incrCnt($groupId);
            }
        } else {// Create
            $values['product_id'] = $newProductId;
            $values['created'] = $values['updated'];
            $langProductDAO->insert($values);

            // Cnt of products of group
            $groupDAO = new \enterprise\daos\LangGroup($langCode);
            $groupDAO->incrCnt($groupId);

            // Cnt of products
            $siteDAO = new \enterprise\daos\LangSite($langCode);
            $siteDAO->incrProductCnt($userSiteId);
        }
    }

    if (isset($newProductId))
        return $newProductId;
}

/**
 * Edit Product
 */
function enterprise_admin_action_edit_product($smarty, $site, $langCode)
{
    $tplPath = 'admin/edit_product.tpl';

    $productId = (int)timandes_get_query_data('product_id');
    $smarty->assign('product_id', $productId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');
    enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($productId) 
            enterprise_admin_assign_product_info($smarty, 'product', $productId, $langCode);

        // Copying?
        $sourceProductId = (int)timandes_get_query_data('source_product_id');
        if ($sourceProductId)
            enterprise_admin_assign_product_info($smarty, 'product', $sourceProductId, $langCode);

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
    $embeddedVideo = timandes_get_post_data('embedded_video', 'remove_n_r, trim');

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

    enterprise_admin_save_product($langCode, $productId, $brandName, $modelNumber, $certification, $placeOfOrigin, $price, $paymentTerms, $supplyAbility, $headImageId, $images, $userSiteId, $caption, $description, $groupId, $minOrderQuantity, $deliveryTime, $packagingDetails, $specificationsArray, $tags, null, null, null, $embeddedVideo);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=product', '产品管理');
}

/**
 * Delete Product
 */
function enterprise_admin_action_delete_product($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $productId = (int)timandes_get_query_data('product_id');

    // Get group ID
    $product = enterprise_get_product_info($productId, $langCode);
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
    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);
    $values = array(
            'deleted' => 1,
        );
    $productDAO->update($productId, $values);

    // FIXME: Delete language product

    // Cnt of products
    if ($langCode == 'en')
        $groupDAO = new \enterprise\daos\Group();
    else
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
    $groupDAO->incrCnt($groupId, -1);

    // Cnt of products
    if ($langCode == 'en')
        $siteDAO = new \enterprise\daos\Site();
    else
        $siteDAO = new \enterprise\daos\LangSite($langCode);
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
        enterprise_assign_tdk_of_product_detail($smarty, ENTERPRISE_PRODUCT_PAGE_TYPE_DEFAULT, $site, $corporation, $product, $productGroup);

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
    enterprise_assign_tdk_of_product_detail($smarty, ENTERPRISE_PRODUCT_PAGE_TYPE_DEFAULT, $site, $corporation, $product, $productGroup);

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


/**
 * Duplicate Products
 */
function enterprise_admin_action_duplicate_products($smarty, $site, $langCode)
{
    $tplPath = 'admin/duplicate_products.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $productId = (int)timandes_get_query_data('product_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $cnt = (int)timandes_get_post_data('cnt');
    $groupId = (int)timandes_get_post_data('group_id');

    if (!$groupId)
        throw new \UnexpectedValueException("请选择分组");
    if (!$cnt)
        throw new \UnexpectedValueException("请输入数量");

    $product = enterprise_get_product_info($productId, $langCode);
    if (!$product)
        throw new \RuntimeException("找不到指定的产品");

    // Pre-Process
    $product['images'] = [];
    $product['head_image_id'] = 0;
    $product['specifications'] = ($product['specifications']?json_decode($product['specifications'], true):[]);

    for ($i=0; $i<$cnt; ++$i) {
        enterprise_admin_save_product($langCode, 0, $product['brand_name'], $product['model_number'], $product['certification'], $product['place_of_origin'], $product['price'], $product['payment_terms'], $product['supply_ability'], $product['head_image_id'], $product['images'], $product['site_id'], $product['caption'], $product['description'], $groupId, $product['min_order_quantity'], $product['delivery_time'], $product['packaging_details'], $product['specifications'], $product['tags']);
    }

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
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
function enterprise_admin_insert_random_keywords_to_value($value, $separator, $keywords, $keywordsCnt, $targetCnt, $reverse = false)
{
    $targetKeywords = enterprise_admin_insert_keywords_get_random($keywords, $keywordsCnt, $targetCnt);
    return enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt, $reverse);
}

/**
 * 插入关键词至指定的值
 *
 * @param string $separator 分隔符（标题使用空格，关键词使用英文半角逗号）
 */
function enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt, $reverse = false)
{
    $words = ($value?explode($separator, $value):[]);
    if ($reverse)
        $words = array_reverse($words);

    $wordsCnt = count($words);
    $finalWords = array();
    $minCnt = min($wordsCnt, $targetCnt);
    for ($i=0; $i<$minCnt; ++$i) {
        $w = trim($words[$i]);
        if ($reverse) {
            array_unshift($finalWords, $w);
            array_unshift($finalWords, $targetKeywords[$i]);
        } else {
            $finalWords[] = $w;
            $finalWords[] = $targetKeywords[$i];
        }
    }
    if ($wordsCnt > $targetCnt) {
        for (; $i<$wordsCnt; ++$i) {
            $w = trim($words[$i]);
            if ($reverse)
                array_unshift($finalWords, $w);
            else
                $finalWords[] = $w;
        }
    } else {
        for (; $i<$targetCnt; ++$i) {
            $w = trim($targetKeywords[$i]);
            if ($reverse)
                array_unshift($finalWords, $w);
            else
                $finalWords[] = $w;
        }
    }

    return implode($separator, $finalWords);
}

/* }}} */

/**
 * Replace vars in keywords' array with product meta
 */
function enterprise_admin_insert_keywords_replace_var($product, $keywordsArray)
{
    if (!is_array($keywordsArray))
        return array();

    $retval = array();
    $searches = ['[产品型号]'];
    $replacements = [$product['model_number']];
    foreach ($keywordsArray as $k) {
        $retval[] = str_replace($searches, $replacements, $k);
    }
    return $retval;
}

/**
 * Insert keywords proc
 */
function enterprise_admin_insert_keywords_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];
    $groupId = $taskDetails['group_id'];
    $keywords = $taskDetails['keywords'];
    $location = $taskDetails['location'];
    $targetCnt = $taskDetails['target_cnt'];
    $ids = $taskDetails['ids']??[];
    $type = $taskDetails['type']??1;

    $keywordsArray = explode("\n", $keywords);

    $keywordsCnt = 0;
    $keywordsArray = enterprise_admin_insert_keywords_standardize($keywordsArray, $keywordsCnt);

    if ($langCode == 'en'
            || $location == 3)
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);

    if ($type == 1)
        $generator = enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId, '`tags`');
    else {
        $idArray = explode("\n", $ids);
        $generator = enterprise_admin_get_products_generator($userSiteId, $langCode, $idArray, '`tags`');
    }

    $accProducts = 0;
    $accKeywordIndex = 0;
    foreach ($generator as $product) {
        $replacedKeywords = enterprise_admin_insert_keywords_replace_var($product, $keywordsArray);
        $values = array();
        if ($location == 1)
            $values['caption'] = enterprise_admin_insert_random_keywords_to_value($product['caption'], ' ', $replacedKeywords, $keywordsCnt, $targetCnt);
        elseif ($location == 4)
            $values['caption'] = enterprise_admin_insert_random_keywords_to_value($product['caption'], ' ', $replacedKeywords, $keywordsCnt, $targetCnt, true);
        elseif ($location == 5) {
            $targetKeywords = enterprise_admin_insert_keywords_get_random($replacedKeywords, $keywordsCnt, $targetCnt);
            $values['caption'] = $targetKeywords[0] . ' ' . $product['caption'];
        } elseif ($location == 6) {
            $targetKeywords = enterprise_admin_insert_keywords_get_random($replacedKeywords, $keywordsCnt, $targetCnt);
            $values['caption'] = $product['caption'] . ' ' . $targetKeywords[0];
        } elseif ($location == 2)
            $values['tags'] = enterprise_admin_insert_random_keywords_to_value($product['tags'], ',', $replacedKeywords, $keywordsCnt, $targetCnt);
        elseif ($location == 3) {
            if (false) { // Random
                $targetKeywords = enterprise_admin_insert_keywords_get_random($replacedKeywords, $keywordsCnt, $targetCnt);
                $values['model_number'] = $targetKeywords[0]; // Overwrite
            } else {// By order
                $values['model_number'] = $replacedKeywords[$accKeywordIndex]; // Overwrite
                ++$accKeywordIndex;
                if ($accKeywordIndex >= $keywordsCnt)
                    $accKeywordIndex = 0;
            }
        }

        if ($values) {
            $values['updated'] = date('Y-m-d H:i:s');
            $productDAO->update($product['id'], $values);
        }

        ++$accProducts;
    }
}

/**
 * Insert Keywords
 */
function enterprise_admin_action_insert_keywords($smarty, $site, $langCode)
{
    $tplPath = 'admin/insert_keywords.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $keywords = timandes_get_post_data('keywords');
    $location = (int)timandes_get_post_data('location');
    $groupId = (int)timandes_get_post_data('group_id');
    $background = (int)timandes_get_post_data('background');
    $type = (int)timandes_get_post_data('type');
    $ids = timandes_get_post_data('ids');

    $typeRange = array(1, 2);
    if (!in_array($type, $typeRange))
        throw new \RangeException("非法的类型");
    $locationRange = array(1, 2, 3, 4, 5, 6);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$keywords)
        throw new \UnderflowException("请给出至少一个关键词");
    if ($type == 1) {
        if (!$groupId)
            throw new \UnexpectedValueException("请选择分组");
    } elseif ($type == 2) {
        if (!$ids)
            throw new \UnderflowException("请给出至少一个产品ID");
    }
    $targetCnt = (int)timandes_get_post_data('location_' . $location . '_cnt');

    $taskDetails = array(
            'keywords' => $keywords,
            'group_id' => $groupId,
            'location' => $location,
            'lang_code' => $langCode,
            'target_cnt' => $targetCnt,
            'type' => $type,
            'ids' => $ids,
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_INSERT_KEYWORDS, $taskDetails);
    } else {
        enterprise_admin_insert_keywords_proc($userSiteId, $taskDetails);
    }

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

function enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId, $extraFieldList = '`description`')
{
    $curProductId = 0;
    do {
        if ($langCode == 'en')
            $products = enterprise_get_product_list($userSiteId, $langCode, $groupId, false, 1, 100, "`id`>{$curProductId}", '`id` ASC', $extraFieldList);
        else {
            $products = enterprise_get_product_list($userSiteId, $langCode, $groupId, false, 1, 100, "elp.`product_id`>{$curProductId}", 'elp.`product_id` ASC', enterprise_product_transform_field_list_for_lang_site($extraFieldList));
        }
        if (!$products)
            break;

        foreach ($products as $product) {
            yield $product;

            $curProductId = $product['id'];
        }
    } while(true);
}


function enterprise_admin_get_multi_group_products_generator($userSiteId, $langCode, $groupIdArray, $extraFieldList = '`description`')
{
    foreach ($groupIdArray as $groupId) {
        if (!$groupId)
            continue;

        $generator = enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId, $extraFieldList);
        foreach ($generator as $product)
            yield $product;
    }
}


function enterprise_admin_get_products_generator($userSiteId, $langCode, $idArray, $extraFieldList = '`description`')
{
    $idArrayProcessed = array();
    foreach ($idArray as $id) {
        $id = trim($id);
        if ($id)
            $idArrayProcessed[] = $id;
    }
    if (!$idArrayProcessed)
        return;

    $idList = implode(', ', $idArrayProcessed);

    $curProductId = 0;
    do {
        if ($langCode == 'en')
            $products = enterprise_get_product_list($userSiteId, $langCode, null, false, 1, 100, "`id` IN ({$idList}) AND `id`>{$curProductId}", '`id` ASC', $extraFieldList);
        else
            $products = enterprise_get_product_list($userSiteId, $langCode, null, false, 1, 100, "elp.`product_id` IN ({$idList}) AND elp.`product_id`>{$curProductId}", 'elp.`product_id` ASC', enterprise_product_transform_field_list_for_lang_site($extraFieldList));
        if (!$products)
            break;

        foreach ($products as $product) {
            yield $product;

            $curProductId = $product['id'];
        }
    } while(true);
}

function enterprise_admin_replace_desc_pic_with_urls($description, $urlArray, &$fromIdx = 0)
{
    $pathArrayProcessed = array();
    foreach ($urlArray as $url) {
        $url = trim($url);
        if ($url)
            $pathArrayProcessed[] = parse_url($url, PHP_URL_PATH);
    }
    if (!$pathArrayProcessed)
        return $description;

    $pathCnt = count($pathArrayProcessed);
    $document = new \DOMDocument();
    // See:
    //  - http://php.net/manual/en/class.domdocument.php#118509
    //  - https://stackoverflow.com/questions/8218230/php-domdocument-loadhtml-not-encoding-utf-8-correctly
    $convertedDescription = mb_convert_encoding($description, 'HTML-ENTITIES', 'UTF-8');
    @$document->loadHTML($convertedDescription);
    $imgElements = $document->getElementsByTagName('img');
    $pathIdx = $fromIdx;
    foreach ($imgElements as $e) {
        $e->setAttribute('src', $pathArrayProcessed[$pathIdx]);
        ++$pathIdx;
        if ($pathIdx >= $pathCnt)
            $pathIdx = 0;
    }
    $fromIdx = $pathIdx;

    $bodyElementList = $document->getElementsByTagName('body');
    $retval = '';
    $childNodes = $bodyElementList->item(0)->childNodes;
    foreach ($childNodes as $node) {
        $retval .= $document->saveHTML($node);
    }
    return $retval;
}

/**
 * Replace desc pic proc
 */
function enterprise_admin_replace_desc_pic_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];
    $groupId = $taskDetails['group_id']??0;
    $urls = $taskDetails['urls'];
    $ids = $taskDetails['ids'];
    $type = $taskDetails['type'];
    $recycleType = $taskDetails['recycle_type'];
    $groupIdArray = $taskDetails['group_id_array']??[];

    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);

    if ($type == 1)
        $generator = enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId);
    elseif ($type == 2) {
        $idArray = explode("\n", $ids);
        $generator = enterprise_admin_get_products_generator($userSiteId, $langCode, $idArray);
    } else {
        $groupIdArray = array_unique($groupIdArray);
        $generator = enterprise_admin_get_multi_group_products_generator($userSiteId, $langCode, $groupIdArray);
    }

    $urlArray = explode("\n", $urls);
    $urlArrayProcessed = array();
    foreach ($urlArray as $url) {
        $url = trim($url);
        if ($url)
            $urlArrayProcessed[] = $url;
    }
    if (!$urlArrayProcessed)
        return;

    $urlIdx = 0;
    foreach ($generator as $product) {
        $values = array();

        // URL Index
        if (!$recycleType)
            $urlIdx = 0;

        // 替换描述文本
        $values['description'] = enterprise_admin_replace_desc_pic_with_urls($product['description'], $urlArrayProcessed, $urlIdx);

        if ($values) {
            $values['updated'] = date('Y-m-d H:i:s');
            $productDAO->update($product['id'], $values);
        }
    }
}

/**
 * Replace Desc Pic
 */
function enterprise_admin_action_replace_desc_pic($smarty, $site, $langCode)
{
    $tplPath = 'admin/replace_desc_pic.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $urls = timandes_get_post_data('urls');
    $type = (int)timandes_get_post_data('type');
    $ids = timandes_get_post_data('ids');
    $recycleType = (int)timandes_get_post_data('recycle_type');
    $background = (int)timandes_get_post_data('background');
    $groupIdArray = timandes_get_post_data('group_id_array');

    $typeRange = array(3, 2);
    if (!in_array($type, $typeRange))
        throw new \RangeException("非法的类型");
    if ($type == 3) {
        if (!$groupIdArray)
            throw new \UnexpectedValueException("请选择分组");
    } elseif ($type == 2) {
        if (!$ids)
            throw new \UnderflowException("请给出至少一个产品ID");
    }
    if (!$urls)
        throw new \UnderflowException("请给出至少一个关键词");

    $taskDetails = array(
            'urls' => $urls,
            'group_id_array' => $groupIdArray,
            'type' => $type,
            'lang_code' => $langCode,
            'ids' => $ids,
            'recycle_type' => $recycleType,
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_REPLACE_DESC_PIC, $taskDetails);
    } else {
        enterprise_admin_replace_desc_pic_proc($userSiteId, $taskDetails);
    }

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

/**
 * Create Task
 */
function enterprise_admin_create_task($userSiteId, $type, $details)
{
    $taskDAO = new \blowjob\daos\Task();
    $values = array(
            'site_id' => $userSiteId,
            'type' => $type,
            'details' => $details,
            'created' => date('Y-m-d H:i:s'),
            'updated' => date('Y-m-d H:i:s'),
        );
    $taskDAO->insert($values);
}

/**
 * Replace keywords proc
 */
function enterprise_admin_replace_keywords_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];
    $groupId = $taskDetails['group_id']??null;
    $oldPhrase = $taskDetails['old_phrase'];
    $newPhrase = $taskDetails['new_phrase'];
    $location = $taskDetails['location'];
    $treat_as_multi_old_phrases = $taskDetails['treat_as_multi_old_phrases']??0;
    $type = $taskDetails['type'];
    $groupIdArray = $taskDetails['group_id_array']??[];

    if ($treat_as_multi_old_phrases) {
        $a = explode("\n", $oldPhrase);
        $a = array_unique($a);
        $oldPhrase = [];
        foreach ($a as $p) {
            $p = trim($p);
            $oldPhrase[] = $p;
        }
    }

    if ($groupId < 0)
        $groupId = null;

    $corporation = enterprise_get_corporation_info($userSiteId, $langCode);
    $newPhrase = str_replace('[公司名称]', $corporation['name'], $newPhrase);

    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);

    if ($type == 1)
        $generator = enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId, '`tags`, `description`, `specifications`');
    elseif ($type == 3) {
        $groupIdArray = array_unique($groupIdArray);
        $generator = enterprise_admin_get_multi_group_products_generator($userSiteId, $langCode, $groupIdArray, '`tags`, `description`, `specifications`');
    }

    foreach ($generator as $product) {
        $productNewPhrase = $newPhrase;
        $productNewPhrase = str_replace('[产品标题]', $product['caption'], $productNewPhrase);
        $productGroup = enterprise_get_group_info($product['group_id'], $langCode, true);
        $productNewPhrase = str_replace('[产品分组]', $productGroup['name'], $productNewPhrase);

        if ($treat_as_multi_old_phrases) {
            $productNewPhrase = array_fill(0, count($oldPhrase), $productNewPhrase);
        }

        $values = array();
        // Caption
        if (in_array($location, [0, 1, 5])) {
            $values['caption'] = str_ireplace($oldPhrase, $productNewPhrase, $product['caption']);
        }
        // Tags
        if (in_array($location, [0, 2, 5])) {
            $oldTags = explode(',', $product['tags']);
            $newTags = array();
            foreach ($oldTags as $tag) {
                $tag = trim($tag);
                $tag = str_ireplace($oldPhrase, $productNewPhrase, $tag);
                $newTags[] = $tag;
            }
            $values['tags'] = implode(',', $newTags);
        }
        // Description
        if (in_array($location, [3, 5]))
            $values['description'] = str_ireplace($oldPhrase, $productNewPhrase, $product['description']);
        // Terms & Specifications
        if (in_array($location, [4, 5])) {
            // Terms
            foreach (ENTERPRISE_PRODUCT_TERM_FIELDS as $f)
                $values[$f] = str_ireplace($oldPhrase, $productNewPhrase, $product[$f]);
            // Specifications
            $productSpecifications = array();
            if ($product['specifications']) {
                $productSpecifications = json_decode($product['specifications'], true);
                $newProductSpecifications = array();
                if (is_array($productSpecifications)) foreach ($productSpecifications as $k => $v) {
                    $newProductSpecifications[$k] = str_ireplace($oldPhrase, $productNewPhrase, $v);
                }
                $values['specifications'] = $newProductSpecifications;
            }
        }

        // Update
        if ($values) {
            $values['updated'] = date('Y-m-d H:i:s');
            $productDAO->update($product['id'], $values);
        }
    }
}

/**
 * Replace Keywords
 */
function enterprise_admin_action_replace_keywords($smarty, $site, $langCode)
{
    $tplPath = 'admin/replace_keywords.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $oldPhrase = timandes_get_post_data('old_phrase', 'xss_clean');
    $newPhrase = timandes_get_post_data('new_phrase', 'xss_clean, remove_n_r, trim');
    $location = (int)timandes_get_post_data('location');
    $background = (int)timandes_get_post_data('background');
    $removePhrase = (int)timandes_get_post_data('remove_phrase');
    if ($removePhrase)
        $newPhrase = '';
    $treat_as_multi_old_phrases = (int)timandes_get_post_data('treat_as_multi_old_phrases');
    if (!$treat_as_multi_old_phrases)
        $oldPhrase = remove_n_r($oldPhrase);
    $type = (int)timandes_get_post_data('type');
    $groupIdArray = timandes_get_post_data('group_id_array');

    $typeRange = array(3, 1);
    if (!in_array($type, $typeRange))
        throw new \RangeException("非法的类型");
    $locationRange = array(0, 1, 2, 3, 4, 5);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$oldPhrase)
        throw new \UnderflowException("原关键词不能为空");
    if (!$removePhrase
            && !$newPhrase)
        throw new \UnderflowException("新关键词不能为空");
    if ($type == 3) {
        if (!$groupIdArray)
            throw new \UnexpectedValueException("请选择分组");
    }

    $taskDetails = array(
            'old_phrase' => $oldPhrase,
            'new_phrase' => $newPhrase,
            'group_id_array' => $groupIdArray,
            'location' => $location,
            'lang_code' => $langCode,
            'treat_as_multi_old_phrases' => $treat_as_multi_old_phrases,
            'type' => $type,
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_REPLACE_KEYWORDS, $taskDetails);
    } else {
        enterprise_admin_replace_keywords_proc($userSiteId, $taskDetails);
    }

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

/**
 * Replace terms proc
 */
function enterprise_admin_replace_terms_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];
    $groupId = ($taskDetails['group_id']?$taskDetails['group_id']:null);
    $overwrite = $taskDetails['overwrite'];
    $fields = ENTERPRISE_PRODUCT_TERM_FIELDS;

    $corporation = enterprise_get_corporation_info($userSiteId, $langCode);

    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);
    $curProductId = 0;
    do {
        if ($langCode == 'en')
            $products = enterprise_get_product_list($userSiteId, $langCode, $groupId, false, 1, 100, "`id`>{$curProductId}", '`id` ASC');
        else
            $products = enterprise_get_product_list($userSiteId, $langCode, $groupId, false, 1, 100, "elp.`product_id`>{$curProductId}", 'elp.`product_id` ASC');
        if (!$products)
            break;

        foreach ($products as $product) {
            $group = enterprise_get_group_info($product['group_id'], $langCode, true);

            $searches = ['[公司名称]', '[产品分组]', '[产品标题]'];
            $replacements = [$corporation['name'], $group['name'], $product['caption']];

            $values = [];

            foreach ($fields as $f) {
                if (!$taskDetails[$f])
                    continue;// 没有填写的字段不参与批量设置操作

                if ($overwrite
                        || !$product[$f]) {
                    $values[$f] = str_replace($searches, $replacements, $taskDetails[$f]);
                }
            }

            // Update
            if ($values) {
                $values['updated'] = date('Y-m-d H:i:s');
                $productDAO->update($product['id'], $values);
            }

            $curProductId = $product['id'];
        }
    } while(true);
}

/**
 * Replace Terms
 */
function enterprise_admin_action_replace_terms($smarty, $site, $langCode)
{
    $tplPath = 'admin/replace_terms.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $groupId = (int)timandes_get_post_data('group_id');
    $overwrite = (int)timandes_get_post_data('overwrite');
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
    $background = (int)timandes_get_post_data('background');

    $overwriteRange = array(0, 1);
    if (!in_array($overwrite, $overwriteRange))
        throw new \RangeException("非法的策略值");

    $taskDetails = array(
            'group_id' => $groupId,
            'overwrite' => $overwrite,
            'lang_code' => $langCode,
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
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_REPLACE_TERMS, $taskDetails);
    } else {
        enterprise_admin_replace_terms_proc($userSiteId, $taskDetails);
    }

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}


function enterprise_admin_insert_desc_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];
    $groupId = $taskDetails['group_id'];
    $desc = $taskDetails['desc'];
    $location = $taskDetails['location'];
    $ids = $taskDetails['ids']??[];
    $type = $taskDetails['type']??1;

    $corporation = enterprise_get_corporation_info($userSiteId, $langCode);
    $desc = str_replace('[公司名称]', $corporation['name'], $desc);

    $group = enterprise_get_group_info($groupId, $langCode);
    $desc = str_replace('[产品分组]', $group['name'], $desc);

    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);

    if ($type == 1)
        $generator = enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId);
    else {
        $idArray = explode("\n", $ids);
        $generator = enterprise_admin_get_products_generator($userSiteId, $langCode, $idArray);
    }

    foreach ($generator as $product) {
        $fragment = str_replace('[产品标题]', $product['caption'], $desc);
        $fragmentHtml = $fragment;
        $newDescription = ($location==1?($fragmentHtml . $product['description']):($product['description'] . $fragmentHtml));
        $values = array(
                'description' => $newDescription,
                'updated' => date('Y-m-d H:i:s'),
            );
        $productDAO->update($product['id'], $values);
    }
}

/**
 * Insert Desc
 */
function enterprise_admin_action_insert_desc($smarty, $site, $langCode)
{
    $tplPath = 'admin/insert_desc.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $desc = timandes_get_post_data('desc', 'xss_clean, remove_n_r, trim');
    $location = (int)timandes_get_post_data('location');
    $groupId = (int)timandes_get_post_data('group_id');
    $background = (int)timandes_get_post_data('background');
    $type = (int)timandes_get_post_data('type');
    $ids = timandes_get_post_data('ids');

    $typeRange = array(1, 2);
    if (!in_array($type, $typeRange))
        throw new \RangeException("非法的类型");
    $locationRange = array(1, 2);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if (!$desc)
        throw new \UnderflowException("请给出至少一个关键词");
    if ($type == 1) {
        if (!$groupId)
            throw new \UnexpectedValueException("请选择分组");
    } elseif ($type == 2) {
        if (!$ids)
            throw new \UnderflowException("请给出至少一个产品ID");
    }

    $taskDetails = array(
            'desc' => $desc,
            'group_id' => $groupId,
            'location' => $location,
            'lang_code' => $langCode,
            'type' => $type,
            'ids' => $ids,
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_INSERT_DESC, $taskDetails);
    } else {
        enterprise_admin_insert_desc_proc($userSiteId, $taskDetails);
    }

    enterprise_admin_display_success_msg($smarty, '操作成功', '?action=product', '产品管理');
}

function enterprise_admin_insert_images_to_array(&$images, &$pendingImages, $uploadedImages, $targetCnt)
{
    $imageCnt = count($images);
    $imageSlots = $targetCnt - $imageCnt;
    $insertedImageCnt = 0;
    for ($i=0; $i<$imageSlots; ++$i) {
        $img = array_pop($pendingImages);
        array_unshift($images, $img);
        ++$insertedImageCnt;

        if (count($pendingImages) <= 0) {
            $pendingImages = $uploadedImages;
            shuffle($pendingImages);
        }
    }
}

function enterprise_admin_insert_images_to_product_images($product, &$pendingImages, $uploadedImages, $targetCnt, $overwrite)
{
    $imageBlackList = array(
            1428754, 1429277
        );

    $productDAO = new \enterprise\daos\Product();

    $curImages = json_decode($product['images'], true);
    if (!is_array($curImages))
        $curImages = array();
    if ($overwrite)
        $curImages = array();

    $images = array();
    foreach ($curImages as $id) {
        if (in_array($id, $imageBlackList))
            continue;
        $images[] = $id;
    }

    enterprise_admin_insert_images_to_array($images, $pendingImages, $uploadedImages, $targetCnt);

    $values = array(
            'images' => $images,
            'head_image_id' => $images[0],
            'updated' => date('Y-m-d H:i:s'),
        );
    $productDAO->update($product['id'], $values);
}

function enterprise_admin_insert_images_to_product_desc($product, &$pendingImages, $uploadedImages, $targetCnt, $location)
{
    $productDAO = new \enterprise\daos\Product();

    $images = array();
    enterprise_admin_insert_images_to_array($images, $pendingImages, $uploadedImages, $targetCnt);

    $fragmentHtml = '';
    foreach ($images as $id) {
        $fragmentHtml .= '<p><img src="' . enterprise_url_image($id, '', '', '', true) . '"/></p>';
    }
    $newDescription = ($location==2?($fragmentHtml . $product['description']):($product['description'] . $fragmentHtml));
    $values = array(
            'description' => $newDescription,
            'updated' => date('Y-m-d H:i:s'),
        );
    $productDAO->update($product['id'], $values);
}

function enterprise_admin_insert_images_proc($userSiteId, $taskDetails)
{
    $langCode = $taskDetails['lang_code'];
    $groupId = $taskDetails['group_id']??null;
    $uploadedImages = $taskDetails['uploaded_images'];
    $location = $taskDetails['location'];
    $targetCnt = $taskDetails['target_cnt'];
    $overwrite = $taskDetails['overwrite'];
    $type = $taskDetails['type'];
    $groupIdArray = $taskDetails['group_id_array']??[];
    $ids = $taskDetails['ids']??[];

    $targetCnt = min(ENTERPRISE_MAX_IMAGES_PER_PRODUCT, $targetCnt);

    if ($type == 1)
        $generator = enterprise_admin_get_group_products_generator($userSiteId, $langCode, $groupId, '`images`, `description`');
    elseif ($type == 3) {
        $groupIdArray = array_unique($groupIdArray);
        $generator = enterprise_admin_get_multi_group_products_generator($userSiteId, $langCode, $groupIdArray, '`images`, `description`');
    } else {
        $idArray = explode("\n", $ids);
        $generator = enterprise_admin_get_products_generator($userSiteId, $langCode, $idArray, '`images`, `description`');
    }

    $pendingImages = $uploadedImages;
    foreach ($generator as $product) {
        if ($location == 1)
            enterprise_admin_insert_images_to_product_images($product, $pendingImages, $uploadedImages, $targetCnt, $overwrite);

        if ($location == 2
                || $location == 3)
            enterprise_admin_insert_images_to_product_desc($product, $pendingImages, $uploadedImages, $targetCnt, $location);
    }
}


/**
 * Insert Images
 */
function enterprise_admin_action_insert_images($smarty, $site, $langCode)
{
    $tplPath = 'admin/insert_images.tpl';

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $location = (int)timandes_get_post_data('location');
    $background = (int)timandes_get_post_data('background');
    $type = (int)timandes_get_post_data('type');
    $groupIdArray = timandes_get_post_data('group_id_array');
    $ids = timandes_get_post_data('ids');

    $typeRange = array(3, 2, 1);
    if (!in_array($type, $typeRange))
        throw new \RangeException("非法的类型");
    $locationRange = array(1, 2, 3);
    if (!in_array($location, $locationRange))
        throw new \RangeException("非法的位置值");
    if ($type == 3) {
        if (!$groupIdArray)
            throw new \UnexpectedValueException("请选择分组");
    } elseif ($type == 2) {
        if (!$ids)
            throw new \UnderflowException("请给出至少一个产品ID");
    }

    // Upload images
    $uploadedImages = enterprise_admin_upload_post_images();
    if (!$uploadedImages)
        return enterprise_admin_display_error_msg($smarty, '请选择至少一张图片');

    $targetCnt = (int)timandes_get_post_data('location_' . $location . '_cnt');
    $overwrite = (int)timandes_get_post_data('location_' . $location . '_overwrite');

    $taskDetails = array(
            'uploaded_images' => $uploadedImages,
            'group_id_array' => $groupIdArray,
            'location' => $location,
            'lang_code' => $langCode,
            'target_cnt' => $targetCnt,
            'overwrite' => $overwrite,
            'type' => $type,
            'ids' => $ids,
        );
    if ($background) {
        enterprise_admin_create_task($userSiteId, \blowjob\daos\Task::TYPE_INSERT_IMAGES, $taskDetails);
    } else {
        enterprise_admin_insert_images_proc($userSiteId, $taskDetails);
    }

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
        $avatar = '';
    else
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

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=comment&product_id=' . $productId, '产品留言');
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
function enterprise_admin_action_email_template($smarty, $site, $langCode, $currentDomainSuffix)
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
            if ($langCode == 'en') {
                $groupDAO = new enterprise\daos\Group();
                $groupPrimaryKey = 'id';
            } else {
                $groupDAO = new enterprise\daos\LangGroup($langCode);
                $groupPrimaryKey = 'group_id';
            }
            $groupIds = array_unique(array_values($groupIdArray));
            $condition = "`{$groupPrimaryKey}` IN (" . implode(',', $groupIds) . ")";
            $groups = $groupDAO->getMultiBy($condition);
            $smarty->assign('selected_groups', $groups);

            // Get products
            $productArray = array();
            foreach ($productUrlArray as $urls) {
                $products = array();
                foreach ($urls as $url) {
                    $path = parse_url($url, PHP_URL_PATH);
                    if (!enterprise_match_url_product($path, $productId, $pageNo))
                        continue;
                    $products[] = enterprise_get_product_info($productId, $langCode);
                }
                $productArray[] = $products;
            }
            $smarty->assign('product_array', $productArray);

            enterprise_action_sets_common_proc($smarty, $site, $langCode, $currentDomainSuffix);

            $templateContent = $smarty->fetch('admin/emails/edm.tpl');
            $smarty->assign('content', $templateContent);

            $tplPath = 'admin/email_template_step_2.tpl';
            break;
        default:
            $tplPath = 'admin/email_template_step_1.tpl';
            enterprise_admin_assign_group_list_ex($smarty, 'groups', $userSiteId, $langCode);
            break;
    }
    $smarty->display($tplPath);
}


/* {{{ News */

/**
 * News
 */
function enterprise_admin_action_news($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $totalNews = enterprise_assign_news_list($smarty, 'news', $userSiteId, $langCode, $pageNo, $max, true);

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
function enterprise_admin_action_edit_news($smarty, $site, $langCode)
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
            enterprise_assign_news_info($smarty, 'news', $newsId, $langCode);

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

    // LangNewsDAO
    $langNewsDAO = (($langCode!='en')?new \enterprise\daos\LangNews($langCode):null);

    // Save news
    $newsDAO = new \enterprise\daos\News();
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
            'head_image_id' => $headImageId,
        );
    if (!$langNewsDAO) {// English
        $values['site_id'] = $userSiteId;
        $values['caption'] = $caption;
        $values['content'] = $content;
    }
    if ($newsId) {// Edit
        // Authentication
        $originalNews = enterprise_get_news_info($newsId, $langCode);
        if (!$originalNews
                || $originalNews['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $newsDAO->update($newsId, $values);
        enterprise_assign_news_info($smarty, 'news', $newsId);
    } else {// Create
        $values['created'] = $values['updated'];
        $newNewsId = $newsDAO->insert($values);
    }

    // Save Language News
    if ($langNewsDAO) {
        $values = array(
                'site_id' => $userSiteId,
                'caption' => $caption,
                'content' => $content,
                'updated' => date('Y-m-d H:i:s'),
                'head_image_id' => $headImageId,
            );
        if ($newsId) {// Edit
            $values['news_id'] = $newsId;
            $langNewsDAO->update($newsId, $values);
        } else {
            $values['news_id'] = $newNewsId;
            $values['created'] = $values['updated'];
            $langNewsDAO->insert($values);
        }
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=news', '新闻管理');
}

/**
 * Delete News
 */
function enterprise_admin_action_delete_news($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $newsId = (int)timandes_get_query_data('news_id');

    // Get news
    $news = enterprise_get_news_info($newsId, $langCode);
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
    if ($langCode == 'en')
        $newsDAO = new \enterprise\daos\News();
    else
        $newsDAO = new \enterprise\daos\LangNews($langCode);
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
function enterprise_admin_action_user_voice($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    enterprise_assign_user_voice_list($smarty, 'user_voices', $userSiteId, $langCode, $pageNo, $max);
    // Need import?
    $userVoices = $smarty->getTemplateVars('user_voices');
    if (!$userVoices
            && $langCode == 'en') {
        $site = $smarty->getTemplateVars('site');
        $userVoices = enterprise_admin_import_user_voices($site);
        if ($userVoices)
            $smarty->assign('user_voices', $userVoices);
    }

    $smarty->display('admin/user_voice.tpl');
}

/**
 * Edit UserVoice
 */
function enterprise_admin_action_edit_user_voice($smarty, $site, $langCode)
{
    $tplPath = 'admin/edit_user_voice.tpl';

    $userVoiceId = (int)timandes_get_query_data('user_voice_id');
    $smarty->assign('user_voice_id', $userVoiceId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($userVoiceId) 
            enterprise_assign_user_voice_info($smarty, 'user_voice', $userVoiceId, $langCode);

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

    // LangUserVoiceDAO
    $langUserVoiceDAO = (($langCode!='en')?new \enterprise\daos\LangUserVoice($langCode):null);

    // Save user_voice
    $userVoiceDAO = new \enterprise\daos\UserVoice();
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
            'avatar_image_id' => $avatarImageId,
        );
    if (!$langUserVoiceDAO) {// English
        $values['site_id'] = $userSiteId;
        $values['title'] = $title;
        $values['voice'] = $voice;
    }
    if ($userVoiceId) {// Edit
        // Authentication
        $originalUserVoice = enterprise_get_user_voice_info($userVoiceId, $langCode);
        if (!$originalUserVoice
                || $originalUserVoice['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $userVoiceDAO->update($userVoiceId, $values);
        enterprise_assign_user_voice_info($smarty, 'user_voice', $userVoiceId);
    } else {// Create
        $values['created'] = $values['updated'];
        $newUserVoiceId = $userVoiceDAO->insert($values);
    }

    // Save Language UserVoice
    if ($langUserVoiceDAO) {
        $values = array(
                'site_id' => $userSiteId,
                'title' => $title,
                'voice' => $voice,
                'updated' => date('Y-m-d H:i:s'),
            );
        if ($userVoiceId) {// Edit
            $condition = "`user_voice_id`=" . (int)$userVoiceId;
            $langUserVoiceDAO->updateBy($condition, $values);
        } else {
            $values['user_voice_id'] = $newUserVoiceId;
            $values['created'] = $values['updated'];
            $langUserVoiceDAO->insert($values);
        }
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=user_voice', '用户赠言');
}

/**
 * Delete UserVoice
 */
function enterprise_admin_action_delete_user_voice($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $userVoiceId = (int)timandes_get_query_data('user_voice_id');

    // Get group ID
    $user_voice = enterprise_get_user_voice_info($userVoiceId, $langCode);
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
    if ($langCode == 'en') {
        $userVoiceDAO = new \enterprise\daos\UserVoice();
        $userVoiceDAO->update($userVoiceId, $values);
    } else {
        $userVoiceDAO = new \enterprise\daos\LangUserVoice($langCode);
        $condition = "`user_voice_id`=" . (int)$userVoiceId;
        $userVoiceDAO->updateBy($condition, $values);
    }

    header('Location: ?action=user_voice&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/* {{{ MainProduct */

/**
 * 从站点中导入最新产品作为主推产品
 *
 * @return array 导入的主推产品
 */
function enterprise_admin_import_main_products($site, $langCode = 'en')
{
    $products = enterprise_get_product_list($site['site_id'], $langCode, null, true, 1, 3);

    $mainProductDAO = new \enterprise\daos\MainProduct();
    $dateString = date('Y-m-d H:i:s');
    $retval = array();
    if (is_array($products)) foreach ($products as $p) {
        $values = array(
                'site_id' => $site['site_id'],
                'label' => $p['caption'],
                'url' => enterprise_url_product($p),
                'created' => $dateString,
                'updated' => $dateString,
            );
        $values['id'] = $mainProductDAO->insert($values);

        $retval[] = $values;
    }

    return $retval;
}

/**
 * MainProduct
 */
function enterprise_admin_action_main_product($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $mainProductDAO = new \enterprise\daos\MainProduct();

    $condition = enterprise_assign_main_product_list($smarty, 'main_products', $userSiteId, $pageNo, $max);

    $totalMainProduct = $mainProductDAO->countBy($condition);
    $smarty->assign('total_main_product', $totalMainProduct);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalMainProduct, $max, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    $smarty->display('admin/main_product.tpl');
}

/**
 * Edit MainProduct
 */
function enterprise_admin_action_edit_main_product($smarty, $site)
{
    $tplPath = 'admin/edit_main_product.tpl';

    $mainProductId = (int)timandes_get_query_data('main_product_id');
    $smarty->assign('main_product_id', $mainProductId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($mainProductId) 
            enterprise_assign_main_product_info($smarty, 'main_product', $mainProductId);

        return $smarty->display($tplPath);
    }

    // Save
    $label = timandes_get_post_data('label');
    $url = timandes_get_post_data('url');

    if (!$label)
        return enterprise_admin_display_error_msg($smarty, '请输入关键词');
    if (!$url)
        return enterprise_admin_display_error_msg($smarty, '请输入URL');

    // Upload images
    $images = enterprise_admin_upload_post_images();
    $avatarImageId = ($images?$images[0]:0);

    // Save main_product
    $mainProductDAO = new \enterprise\daos\MainProduct();
    $values = array(
            'site_id' => $userSiteId,
            'label' => $label,
            'url' => $url,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($mainProductId) {// Edit
        // Authentication
        $originalMainProduct = $mainProductDAO->get($mainProductId);
        if (!$originalMainProduct
                || $originalMainProduct['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $mainProductDAO->update($mainProductId, $values);
        enterprise_assign_main_product_info($smarty, 'main_product', $mainProductId);
    } else {// Create
        $values['created'] = $values['updated'];
        $mainProductDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=main_product', '主推产品');
}

/**
 * Delete MainProduct
 */
function enterprise_admin_action_delete_main_product($smarty, $site)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $mainProductId = (int)timandes_get_query_data('main_product_id');

    // Get group ID
    $mainProductDAO = new \enterprise\daos\MainProduct();
    $main_product = $mainProductDAO->get($mainProductId);
    if (!$main_product) {
        $msg = '找不到指定的主推产品';
        return header('Location: ?action=main_product&error_msg=' . urlencode($msg));
    }
    if ($main_product['site_id'] != $site['site_id'])
        return header('Location: ?action=main_product&error_msg=' . urlencode('权限不足'));
    if ($main_product['deleted']) 
        return header('Location: ?action=main_product&success_msg=' . urlencode('删除成功'));

    // Delete main_product
    $values = array(
            'deleted' => 1,
            'updated' => date('Y-m-d H:i:s'),
        );
    $mainProductDAO->update($mainProductId, $values);

    header('Location: ?action=main_product&success_msg=' . urlencode('删除成功'));
}

/**
 * Import MainProduct
 */
function enterprise_admin_action_import_main_product($smarty, $site)
{
    enterprise_admin_import_main_products($site);

    header('Location: ?action=main_product&success_msg=' . urlencode('导入成功'));
}

/* }}} */

function enterprise_admin_calculate_parameter_sum($a, $phrase)
{
    ksort($a);
    return md5(http_build_query($a) . $phrase);
}

/**
 * 超级登录
 *
 * @todo 更为保险的方案是在持久存储中保存token，利用token保证请求的唯一性
 */
function enterprise_admin_action_super_login($smarty)
{
    $userId = (int)timandes_get_query_data('user_id');
    $timestamp = (int)timandes_get_query_data('timestamp');
    $redirectTo = timandes_get_query_data('redirect_to');
    $sum = timandes_get_query_data('sum');

    $a = array(
            'user_id' => $userId,
            'timestamp' => $timestamp,
            'redirect_to' => $redirectTo,
        );
    $localSum = enterprise_admin_calculate_parameter_sum($a, $GLOBALS['gsSuperLoginPhrase']);

    if ($sum != $localSum)
        throw new \RuntimeException("通讯失败");
    if ((time() - $timestamp) > 3)
        throw new \RuntimeException("通讯超时");

    $userDAO = new \enterprise\daos\User();
    $user = $userDAO->get($userId);
    if (!$user)
        throw new \RuntimeException("登录失败");

    enterprise_admin_register_user_session($user['site_id'], $user['id']);

    // Redirect
    if (!$redirectTo)
        $redirectTo = '/admin/';
    header('Location: ' . $redirectTo);
}



/* {{{ Picture */

/**
 * Pictures
 */
function enterprise_admin_action_picture($smarty)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    $condition = enterprise_assign_picture_list($smarty, 'pictures', $userSiteId);

    $pictureDAO = new \enterprise\daos\Picture();
    $totalPictures = $pictureDAO->countBy($condition);
    $totalPages = (int)($totalPictures / $max) + (($totalPictures % $max)?1:0);
    $smarty->assign('total_pictures', $totalPictures);
    $smarty->assign('page_size', $max);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    $smarty->display('admin/picture.tpl');
}

/**
 * Edit Picture
 */
function enterprise_admin_action_edit_picture($smarty, $site)
{
    $tplPath = 'admin/edit_picture.tpl';

    $pictureId = (int)timandes_get_query_data('picture_id');
    $smarty->assign('picture_id', $pictureId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($pictureId) 
            enterprise_assign_picture_info($smarty, 'picture', $pictureId);
        return $smarty->display($tplPath);
    }

    // Save
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $uri = timandes_get_post_data('uri');

    // Upload Images
    $images = enterprise_admin_upload_post_images('');
    if (!$images)
        return enterprise_admin_display_error_msg($smarty, '请选择照片');

    $uri = $images[0];

    $pictureDAO = new \enterprise\daos\Picture();
    $values = array(
            'site_id' => $userSiteId,
            'uri' => $uri,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($pictureId) {// Edit
        // Authentication
        $originalPicture = $pictureDAO->get($pictureId);
        if (!$originalPicture
                || $originalPicture['site_id'] != $site['site_id'])
            throw new \RuntimeException("权限不足");
        // Update
        $pictureDAO->update($pictureId, $values);
        enterprise_assign_picture_info($smarty, 'picture', $pictureId);
    } else {// Create
        $values['created'] = $values['updated'];
        $pictureDAO->insert($values);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=picture', '图片银行');
}

/**
 * Delete Picture
 */
function enterprise_admin_action_delete_picture($smarty, $site)
{
    $pictureId = (int)timandes_get_query_data('picture_id');

    $pictureDAO = new \enterprise\daos\Picture();
    // Authentication
    $picture = $pictureDAO->get($pictureId);
    if (!$picture
            || $picture['site_id'] != $site['site_id'])
        return header('Location: ?action=picture&error_msg=' . urlencode('权限不足'));
    // Delete
    $values = array(
            'deleted' => 1,
        );
    $pictureDAO->update($pictureId, $values);
    header('Location: ?action=picture&success_msg=' . urlencode('删除成功'));
}

/* }}} */



/* {{{ IndexKeyword */

/**
 * IndexKeyword
 */
function enterprise_admin_action_index_keyword($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    enterprise_assign_index_keyword_list($smarty, 'index_keywords', $userSiteId, $langCode, $pageNo, $max);

    $smarty->display('admin/index_keyword.tpl');
}

/**
 * Edit IndexKeyword
 */
function enterprise_admin_action_edit_index_keyword($smarty, $site, $langCode)
{
    $tplPath = 'admin/edit_index_keyword.tpl';

    $indexKeywordId = (int)timandes_get_query_data('index_keyword_id');
    $smarty->assign('index_keyword_id', $indexKeywordId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($indexKeywordId) 
            enterprise_assign_index_keyword_info($smarty, 'index_keyword', $indexKeywordId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $keyword = timandes_get_post_data('keyword');
    $url = timandes_get_post_data('url');

    if (!$keyword)
        return enterprise_admin_display_error_msg($smarty, '请输入关键词');

    // LangIndexKeywordDAO
    $langIndexKeywordDAO = (($langCode!='en')?new \enterprise\daos\LangIndexKeyword($langCode):null);

    // Save index_keyword
    $indexKeywordDAO = new \enterprise\daos\IndexKeyword();
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
        );
    if (!$langIndexKeywordDAO) {// English
        $values['site_id'] = $userSiteId;
        $values['keyword'] = $keyword;
        $values['url'] = $url;
    }
    if ($indexKeywordId) {// Edit
        // Authentication
        $originalIndexKeyword = enterprise_get_index_keyword_info($indexKeywordId, $langCode);
        if (!$originalIndexKeyword
                || $originalIndexKeyword['site_id'] != $site['site_id'])
            return enterprise_admin_display_error_msg($smarty, '权限不足');
        // Update
        $indexKeywordDAO->update($indexKeywordId, $values);
        enterprise_assign_index_keyword_info($smarty, 'index_keyword', $indexKeywordId);
    } else {// Create
        $values['created'] = $values['updated'];
        $newIndexKeywordId = $indexKeywordDAO->insert($values);
    }

    // Save Language IndexKeyword
    if ($langIndexKeywordDAO) {
        $values = array(
                'site_id' => $userSiteId,
                'keyword' => $keyword,
                'url' => $url,
                'updated' => date('Y-m-d H:i:s'),
            );
        if ($indexKeywordId) {// Edit
            $condition = "`index_keyword_id`=" . (int)$indexKeywordId;
            $langIndexKeywordDAO->updateBy($condition, $values);
        } else {
            $values['index_keyword_id'] = $newIndexKeywordId;
            $values['created'] = $values['updated'];
            $langIndexKeywordDAO->insert($values);
        }
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=index_keyword', '首页关键词');
}

/**
 * Delete IndexKeyword
 */
function enterprise_admin_action_delete_index_keyword($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $indexKeywordId = (int)timandes_get_query_data('index_keyword_id');

    // Get group ID
    $index_keyword = enterprise_get_index_keyword_info($indexKeywordId, $langCode);
    if (!$index_keyword) {
        $msg = '找不到指定的关键词';
        return header('Location: ?action=index_keyword&error_msg=' . urlencode($msg));
    }
    if ($index_keyword['site_id'] != $site['site_id'])
        return header('Location: ?action=index_keyword&error_msg=' . urlencode('权限不足'));
    if ($index_keyword['deleted']) 
        return header('Location: ?action=index_keyword&success_msg=' . urlencode('删除成功'));

    // Delete index_keyword
    $values = array(
            'deleted' => 1,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($langCode == 'en') {
        $indexKeywordDAO = new \enterprise\daos\IndexKeyword();
        $indexKeywordDAO->update($indexKeywordId, $values);
    } else {
        $indexKeywordDAO = new \enterprise\daos\LangIndexKeyword($langCode);
        $condition = "`index_keyword_id`=" . (int)$indexKeywordId;
        $indexKeywordDAO->updateBy($condition, $values);
    }

    header('Location: ?action=index_keyword&success_msg=' . urlencode('删除成功'));
}

/* }}} */


/* {{{ Keyword */

/**
 * Keyword
 */
function enterprise_admin_action_keyword($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    enterprise_assign_keyword_list($smarty, 'keywords', $userSiteId, $langCode, $pageNo, $max);

    $smarty->display('admin/keyword.tpl');
}

function enterprise_admin_save_keyword($userSiteId, $langCode, $keywordId, $keyword = null, $desc = null)
{
    $hasDesc = ((isset($desc) && $desc)?1:0);
    if (isset($keyword)) {
        $firstChar = substr($keyword, 0, 1);
        $alphabet = (array_key_exists($firstChar, KEYWORD_ALPHABET)?KEYWORD_ALPHABET[$firstChar]:0);
    } else
        $alphabet = null;

    // LangKeywordDAO
    $langKeywordDAO = (($langCode!='en')?new \enterprise\daos\LangKeyword($langCode):null);

    // Save keyword
    $keywordDAO = new \enterprise\daos\Keyword();
    $values = array(
            'updated' => date('Y-m-d H:i:s'),
        );
    if (!$langKeywordDAO) {// English
        $values['site_id'] = $userSiteId;
        if (isset($keyword)) {
            $values['keyword'] = $keyword;
            $values['alphabet'] = $alphabet;
        }
        if (isset($desc)) {
            $values['has_desc'] = $hasDesc;
            $values['desc'] = $desc;
        }
    }
    if ($keywordId) {// Edit
        // Authentication
        $originalKeyword = enterprise_get_keyword_info($keywordId, $langCode);
        if (!$originalKeyword
                || $originalKeyword['site_id'] != $userSiteId)
            throw new \RuntimeException('权限不足');
        // Update
        $keywordDAO->update($keywordId, $values);
    } else {// Create
        $values['created'] = $values['updated'];
        $newKeywordId = $keywordDAO->insert($values);
    }

    // Save Language Keyword
    if ($langKeywordDAO) {
        $values = array(
                'site_id' => $userSiteId,
                'updated' => date('Y-m-d H:i:s'),
            );
        if (isset($keyword)) {
            $values['keyword'] = $keyword;
            $values['alphabet'] = $alphabet;
        }
        if (isset($desc)) {
            $values['has_desc'] = $hasDesc;
            $values['desc'] = $desc;
        }
        if ($keywordId) {// Edit
            $condition = "`keyword_id`=" . (int)$keywordId;
            $langKeywordDAO->updateBy($condition, $values);
        } else {
            $values['keyword_id'] = $newKeywordId;
            $values['created'] = $values['updated'];
            $langKeywordDAO->insert($values);
        }
    }

    if (isset($newKeywordId))
        return $newKeywordId;
}

/**
 * Create Keywords
 */
function enterprise_admin_action_create_keywords($smarty, $site, $langCode)
{
    $tplPath = 'admin/create_keywords.tpl';

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        return $smarty->display($tplPath);
    }

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $keywordLines = timandes_get_post_data('keyword_lines');
    $descTemplate = timandes_get_post_data('desc_template', 'xss_clean_4_site_owner, remove_n_r, trim');

    $corporation = enterprise_get_corporation_info($userSiteId, $langCode);

    $keywordLineArray = explode("\n", $keywordLines);
    foreach ($keywordLineArray as $k) {
        $k = trim($k);
        if (!$k)
            continue;

        $desc = $descTemplate;
        $desc = str_replace('[公司名称]', $corporation['name'], $desc);
        $desc = str_replace('[关键词]', $k, $desc);

        enterprise_admin_save_keyword($userSiteId, $langCode, 0, $k, $desc);
    }

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=keyword', '关键词列表');
}

/**
 * Edit Keyword
 */
function enterprise_admin_action_edit_keyword($smarty, $site, $langCode)
{
    $tplPath = 'admin/edit_keyword.tpl';

    $keywordId = (int)timandes_get_query_data('keyword_id');
    $smarty->assign('keyword_id', $keywordId);

    $userSiteId = (int)timandes_get_session_data('user_site_id');

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        // Editing?
        if ($keywordId) 
            enterprise_assign_keyword_info($smarty, 'keyword', $keywordId, $langCode);

        return $smarty->display($tplPath);
    }

    // Save
    $desc = timandes_get_post_data('desc', 'xss_clean_4_site_owner, remove_n_r, trim');

    enterprise_admin_save_keyword($userSiteId, $langCode, $keywordId, null, $desc);

    enterprise_admin_display_success_msg($smarty, '保存成功', '?action=keyword', '关键词列表');
}

/**
 * Delete Keyword
 */
function enterprise_admin_action_delete_keyword($smarty, $site, $langCode)
{
    $userSiteId = (int)timandes_get_session_data('user_site_id');
    $keywordId = (int)timandes_get_query_data('keyword_id');

    // Get group ID
    $keyword = enterprise_get_keyword_info($keywordId, $langCode);
    if (!$keyword) {
        $msg = '找不到指定的关键词';
        return header('Location: ?action=keyword&error_msg=' . urlencode($msg));
    }
    if ($keyword['site_id'] != $site['site_id'])
        return header('Location: ?action=keyword&error_msg=' . urlencode('权限不足'));
    if ($keyword['deleted']) 
        return header('Location: ?action=keyword&success_msg=' . urlencode('删除成功'));

    // Delete keyword
    $values = array(
            'deleted' => 1,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($langCode == 'en') {
        $keywordDAO = new \enterprise\daos\Keyword();
        $keywordDAO->update($keywordId, $values);
    } else {
        $keywordDAO = new \enterprise\daos\LangKeyword($langCode);
        $condition = "`keyword_id`=" . (int)$keywordId;
        $keywordDAO->updateBy($condition, $values);
    }

    header('Location: ?action=keyword&success_msg=' . urlencode('删除成功'));
}

/* }}} */