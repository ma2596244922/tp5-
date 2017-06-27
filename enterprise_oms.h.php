<?php
/**
 * OMS公用函数库
 *
 * @package timandes\enterprise
 */


function enterprise_oms_route_2($smarty)
{
    $action = timandes_get_query_data('action');
    switch ($action) {
        case 'login':
            return enterprise_oms_action_login($smarty);
        default:
            $userId = enterprise_oms_grant_permission();

            $site = enterprise_oms_assign_common($smarty);

            switch ($action) {
                case 'super_login':
                    return enterprise_oms_action_super_login($smarty, $site);
                case 'edit_user':
                    return enterprise_oms_action_edit_user($smarty, $site);
                case 'user':
                    return enterprise_oms_action_user($smarty, $site);
                case 'site_dashboard':
                    return enterprise_oms_action_site_dashboard($smarty);
                case 'input_inquiry':
                    return enterprise_oms_action_input_inquiry($smarty, $site);
                case 'monthly_report':
                    return enterprise_oms_action_monthly_report($smarty, $site);
                case 'client_info':
                    return enterprise_oms_action_client_info($smarty);
                case 'edit_operator':
                    return enterprise_oms_action_edit_operator($smarty);
                case 'operator':
                    return enterprise_oms_action_operator($smarty);
                case 'edit_vps':
                    return enterprise_oms_action_edit_vps($smarty);
                case 'vps':
                    return enterprise_oms_action_vps($smarty);
                case 'edit_industry':
                    return enterprise_oms_action_edit_industry($smarty);
                case 'industry':
                    return enterprise_oms_action_industry($smarty);
                case 'check_inquiry':
                    return enterprise_oms_action_check_inquiry($smarty, $site);
                case 'inquiry_stats':
                    return enterprise_oms_action_inquiry_stats($smarty);
                case 'site_stats':
                    return enterprise_oms_action_site_stats($smarty);
                case 'new_site':
                    return enterprise_oms_action_new_site($smarty);
                case 'dashboard':
                    return enterprise_oms_action_dashboard_2($smarty);
            }
    }

    throw new \HttpException(404);
}

/**
 * Dashboard
 */
function enterprise_oms_action_dashboard_2($smarty)
{
    $smarty->display('oms/dashboard2.tpl');
}

/* {{{ Sites */
/**
 * New Site
 */
function enterprise_oms_action_new_site($smarty)
{
    $tplPath = 'oms/new_site.tpl';

    $siteDAO = new \oms\daos\Site();

    $submitted = timandes_get_post_data('submit');
    if (!$submitted) {// No form data
        return $smarty->display($tplPath);
    }

    $desc = timandes_get_post_data('desc');
    $domain = timandes_get_post_data('domain');

    if (!$domain) 
        throw new \RuntimeException("请输入根域地址");

    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    $condition = "`domain`='" . $siteMappingDAO->escape($domain) . "'";
    $siteMapping = $siteMappingDAO->getOneBy($condition);
    if ($siteMapping) 
        throw new \RuntimeException("根域地址已存在");

    // Save
    $values = array(
            'desc' => $desc,
            'updated' => date('Y-m-d H:i:s'),
        );
    $values['guid'] = enterprise_generate_guid();
    $values['created'] = $values['updated'];
    $siteId = $siteDAO->insert($values);

    enterprise_oms_add_records_for_related_tables($siteId, $domain);

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=dashboard', '运营管理');
}

/**
 * Site Stats.
 */
function enterprise_oms_action_site_stats($smarty)
{
    $smarty->display('oms/site_stats.tpl');
}

/* }}} */

/* {{{ Inquiries */

/**
 * Inquiry Stats.
 */
function enterprise_oms_action_inquiry_stats($smarty)
{
    $smarty->display('oms/inquiry_stats.tpl');
}


/**
 * Check Inquiry
 */
function enterprise_oms_action_check_inquiry($smarty, $site)
{
    $pendingInquiryDAO = new \enterprise\daos\PendingInquiry();

    $submitted = (int)timandes_get_post_data('submitted');
    if ($submitted == 1
            || $submitted == 2) {
        $pendingInquiryId = (int)timandes_get_post_data('pending_inquiry_id');
        if ($pendingInquiryId) {
            $pendingInquiry = $pendingInquiryDAO->get($pendingInquiryId);
            if ($pendingInquiry) {
                if ($submitted == 1) {// 通过
                    $values = json_decode($pendingInquiry['data'], true);
                    $values['guid'] = enterprise_generate_guid();
                    $inquiryDAO = new \enterprise\daos\Inquiry();
                    $inquiryDAO->insert($values);
                }

                $values = array(
                        'deleted' => 1,
                    );
                $pendingInquiryDAO->update($pendingInquiryId, $values);
            }
        }
    }

    $pendingInquiries = $pendingInquiryDAO->getMultiInOrderBy('`deleted`=0', '`id`, `data`', '`id` ASC', 1);
    if (!$pendingInquiries)
        return enterprise_oms_display_success_msg($smarty, '所有询盘已全部审核完成', '?action=dashboard', '运营管理');

    $inquiry = json_decode($pendingInquiries[0]['data'], true);
    $smarty->assign('inquiry', $inquiry);
    $smarty->assign('pending_inquiry_id', $pendingInquiries[0]['id']);

    enterprise_admin_assign_inquiry_detail($smarty, $inquiry);

    $smarty->display('oms/check_inquiry.tpl');
}

/**
 * Input Inquiry
 */
function enterprise_oms_action_input_inquiry($smarty, $site)
{
    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        return $smarty->display('oms/input_inquiry.tpl');
    }

    $siteMappings = enterprise_oms_get_site_mapping_list($site['id']);
    $domain = '';
    if ($siteMappings) {
        $domain = $siteMappings[0]['domain'];
    }

    $created = timandes_get_post_data('created');
    $ipAddr = timandes_get_post_data('ip_addr');
    $relatedUrl = timandes_get_post_data('related_url');

    // TODO: 校验时间、IP地址的格式
    // 获取目标产品ID
    $relatedPath = parse_url($relatedUrl, PHP_URL_PATH);
    $targetProductId = enterprise_parse_id_from_product_page($relatedPath);

    enterprise_save_inquiry_from_post_data($site, $domain, \enterprise\daos\Inquiry::TYPE_INPUT, $ipAddr, $created, $targetProductId);

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=site_dashboard&site_id=' . $site['id'], '网站管理');
}
/* }}} */

/* {{{ Industries */

/**
 * Assign Industry List
 */
function enterprise_oms_assign_industry_list($smarty, $var)
{
    $industryDAO = new \oms\daos\Industry();
    $condition = "`deleted`=0";
    $industries = $industryDAO->getMultiInOrderBy($condition, '*', '`id` DESC');
    $smarty->assign($var, $industries);
}

/**
 * Assign Industry Info
 */
function enterprise_oms_assign_industry_info($smarty, $var, $industryId)
{
    $industryDAO = new \oms\daos\Industry();
    $industry = $industryDAO->get($industryId);
    $smarty->assign($var, $industry);
}
/**
 * Industries
 */
function enterprise_oms_action_industry($smarty)
{
    enterprise_oms_assign_industry_list($smarty, 'industries');

    $smarty->display('oms/industry.tpl');
}


/**
 * Edit Industry
 */
function enterprise_oms_action_edit_industry($smarty)
{
    $industryId = (int)timandes_get_query_data('industry_id');

    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        if ($industryId)
            enterprise_oms_assign_industry_info($smarty, 'industry', $industryId);

        $smarty->assign('industry_id', $industryId);

        return $smarty->display('oms/edit_industry.tpl');
    }

    $name = timandes_get_post_data('name');

    if (!$name)
        throw new \RuntimeException("行业名称不能为空");

    $values = array(
            'name' => $name,
            'updated' => date('Y-m-d H:i:s'),
        );
    $industryDAO = new \oms\daos\Industry();
    if ($industryId) {
        $industryDAO->update($industryId, $values);
    } else {
        $values['created'] = $values['updated'];
        $industryId = $industryDAO->insert($values);
    }

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=industry', '行业管理');
}
/* }}} */


/* {{{ VPSs */
/**
 * Assign VPS List
 */
function enterprise_oms_assign_vps_list($smarty, $var)
{
    $vpsDAO = new \oms\daos\VPS();
    $condition = "`deleted`=0";
    $vpss = $vpsDAO->getMultiInOrderBy($condition, '*', '`id` DESC');
    $smarty->assign($var, $vpss);
}

/**
 * Assign VPS Info
 */
function enterprise_oms_assign_vps_info($smarty, $var, $vpsId)
{
    $vpsDAO = new \oms\daos\VPS();
    $vps = $vpsDAO->get($vpsId);
    $smarty->assign($var, $vps);
}

/**
 * VPSs
 */
function enterprise_oms_action_vps($smarty)
{
    enterprise_oms_assign_vps_list($smarty, 'vpss');

    $smarty->display('oms/vps.tpl');
}

/**
 * Edit VPS
 */
function enterprise_oms_action_edit_vps($smarty)
{
    $vpsId = (int)timandes_get_query_data('vps_id');

    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        if ($vpsId)
            enterprise_oms_assign_vps_info($smarty, 'vps', $vpsId);

        $smarty->assign('vps_id', $vpsId);

        return $smarty->display('oms/edit_vps.tpl');
    }

    $alias = timandes_get_post_data('alias');
    $ipAddr = timandes_get_post_data('ip_addr');

    if (!$alias)
        throw new \RuntimeException("VPS名称不能为空");
    if (!$ipAddr)
        throw new \RuntimeException("IP地址不能为空");

    $values = array(
            'alias' => $alias,
            'ip_addr' => $ipAddr,
            'updated' => date('Y-m-d H:i:s'),
        );
    $vpsDAO = new \oms\daos\VPS();
    if ($vpsId) {
        $vpsDAO->update($vpsId, $values);
    } else {
        $values['created'] = $values['updated'];
        $vpsId = $vpsDAO->insert($values);
    }

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=vps', 'VPS管理');
}
/* }}} */


/* {{{ Operators */

/**
 * Assign Operator List
 */
function enterprise_oms_assign_operator_list($smarty, $var)
{
    $operatorDAO = new \oms\daos\Operator();
    $condition = "`deleted`=0";
    $operators = $operatorDAO->getMultiInOrderBy($condition, '*', '`id` DESC');
    $smarty->assign($var, $operators);
}

/**
 * Assign Operator Info
 */
function enterprise_oms_assign_operator_info($smarty, $var, $operatorId)
{
    $operatorDAO = new \oms\daos\Operator();
    $operator = $operatorDAO->get($operatorId);
    $smarty->assign($var, $operator);
}

/**
 * Operators
 */
function enterprise_oms_action_operator($smarty)
{
    enterprise_oms_assign_operator_list($smarty, 'operators');

    $smarty->display('oms/operator.tpl');
}

/**
 * Edit Operator
 */
function enterprise_oms_action_edit_operator($smarty)
{
    $operatorId = (int)timandes_get_query_data('operator_id');

    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        if ($operatorId)
            enterprise_oms_assign_operator_info($smarty, 'operator', $operatorId);

        $smarty->assign('operator_id', $operatorId);

        return $smarty->display('oms/edit_operator.tpl');
    }

    $name = timandes_get_post_data('name');
    $password = timandes_get_post_data('password');

    $values = array(
            'updated' => date('Y-m-d H:i:s'),
        );
    if (!$operatorId) {// Create
        if (!$name)
            throw new \RuntimeException("用户名不能为空");
        if (!$password)
            throw new \RuntimeException("密码不能为空");
        $values['name'] = $name;
    }

    if ($password)
        $values['password'] = md5($password);
    $operatorDAO = new \oms\daos\Operator();
    if ($operatorId) {
        $operatorDAO->update($operatorId, $values);
    } else {
        $values['created'] = $values['updated'];
        $operatorId = $operatorDAO->insert($values);
    }

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=operator', '帐号管理');
}
/* }}} */

/**
 * Client Info.
 */
function enterprise_oms_action_client_info($smarty)
{
    $siteId = (int)timandes_get_query_data('site_id');

    enterprise_oms_assign_vps_list($smarty, 'vpss');

    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        return $smarty->display('oms/client_info.tpl');
    }

    $desc = timandes_get_post_data('desc');
    $qq = timandes_get_post_data('qq');
    $wechat = timandes_get_post_data('wechat');
    $name = timandes_get_post_data('name');
    $tel = timandes_get_post_data('tel');
    $sex = timandes_get_post_data('sex');
    $enable_inquiry_checking = (int)timandes_get_post_data('enable_inquiry_checking');
    $vps_id = (int)timandes_get_post_data('vps_id');
    $enable_mobile_sites = (int)timandes_get_post_data('enable_mobile_sites');
    $online = (int)timandes_get_post_data('online');
    $csr = timandes_get_post_data('csr');
    $key = timandes_get_post_data('key');
    $enable_https = (int)timandes_get_post_data('enable_https');

    $values = array(
            'desc' => $desc,
            'qq' => $qq,
            'wechat' => $wechat,
            'name' => $name,
            'tel' => $tel,
            'sex' => $sex,
            'vps_id' => $vps_id,
            'csr' => $csr,
            'key' => $key,
            'updated' => date('Y-m-d H:i:s'),
        );
    $omsSiteDAO = new \oms\daos\Site();
    $omsSiteDAO->update($siteId, $values);

    $values = array(
            'enable_inquiry_checking' => $enable_inquiry_checking,
            'enable_mobile_sites' => $enable_mobile_sites,
            'enable_https' => $enable_https,
            'online' => $online,
            'updated' => date('Y-m-d H:i:s'),
        );
    $entSiteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    if ($entSiteDAO->getOneBy($condition))
        $entSiteDAO->update($siteId, $values);
    else {
        $values['site_id'] = $siteId;
        $entSiteDAO->insert($values);
    }

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=site_dashboard&site_id=' . $siteId, '网站管理');
}

/**
 * Monthly Report
 */
function enterprise_oms_action_monthly_report($smarty, $site)
{
    $inquiryDAO = new \enterprise\daos\Inquiry();
    $inquiryTableName = $inquiryDAO->getTableName();

    $totalMonths = 6;
    $report = array();
    for ($i=0; $i<$totalMonths; ++$i) {
        $fmt = "first day of -{$i} month";
        $ts = strtotime($fmt);
        $from = date('Y-m-d', $ts);

        $fmt = "last day of -{$i} month";
        $ts = strtotime($fmt);
        $to = date('Y-m-d', $ts);

        $label = date('Y年m月月报', $ts);

        $sql = "SELECT COUNT(`id`) AS `cnt`, COUNT(DISTINCT `email`) AS `email_cnt` FROM `{$inquiryTableName}`
        WHERE `site_id`={$site['id']} AND `created` BETWEEN '{$from}' AND '{$to}' AND `deleted`=0";
        $result = $inquiryDAO->getOneBySql($sql);
        $result['label'] = $label;
        $report[] = $result;
    }
    $smarty->assign('report', $report);

    $smarty->display('oms/monthly_report.tpl');
}

/**
 * Site Dashboard
 */
function enterprise_oms_action_site_dashboard($smarty)
{
    $smarty->display('oms/site_dashboard.tpl');
}

function enterprise_oms_display_success_msg($smarty, $msg, $url = null, $text = null)
{
    $smarty->assign('success_msg', $msg);
    if ($url) {
        $smarty->assign('forwarding', array(
                'url' => $url,
                'text' => $text,
            ));
    }
    $smarty->display('oms/message2.tpl');
}

function enterprise_oms_display_error_msg($smarty, $msg)
{
    $smarty->assign('error_msg', $msg);
    $smarty->display('oms/message2.tpl');
}

function enterprise_oms_get_site_info($siteId)
{
    if (!$siteId)
        return null;

    $site = enterprise_get_site_info($siteId);

    $siteDAO = new \oms\daos\Site();
    $omsSite = $siteDAO->get($siteId);
    if ($site
            && $omsSite)
        return array_merge($site, $omsSite);
    elseif ($site)
        return $site;
    elseif ($omsSite)
        return $omsSite;

    return null;
}

/**
 * @return array Site Info
 */
function enterprise_oms_assign_common($smarty)
{
    $allSiteMappings = enterprise_oms_get_site_mapping_list();
    $smarty->assign('all_site_mappings', $allSiteMappings);

    $siteId = (int)timandes_get_query_data('site_id');
    $site = null;
    if ($siteId) {
        $site = enterprise_oms_get_site_info($siteId);
        $smarty->assign('site', $site);

        $siteMappings = enterprise_oms_get_site_mapping_list($siteId);
        $smarty->assign('site_mappings', $siteMappings);
    }

    return $site;
}


/**
 * 超后台
 */
function enterprise_oms_action_super_login($smarty, $site)
{
    $redirectTo = timandes_get_query_data('redirect_to');

    $users = enterprise_oms_get_user_list($site['id']);
    if (!$users)
        throw new \RuntimeException("站点内没有符合的用户");
    $firstUser = $users[0];

    $siteMappings = enterprise_oms_get_site_mapping_list($site['id']);
    if (!$siteMappings)
        throw new \RuntimeException("站点没有设置匹配的域名");
    $firstSiteMapping = $siteMappings[0];

    $parameters = array(
            'user_id' => $firstUser['id'],
            'timestamp' => time(),
            'redirect_to' => $redirectTo,
        );
    $parameters['sum'] = enterprise_admin_calculate_parameter_sum($parameters, $GLOBALS['gsSuperLoginPhrase']);

    // Redirect
    header('Location: http://www.' . $firstSiteMapping['domain'] . '/admin/?action=super_login&' . http_build_query($parameters));
}

/* {{{ Users */

/**
 * Get User List
 */
function enterprise_oms_get_user_list($siteId = null)
{
    $userDAO = new \enterprise\daos\User();
    $condition = "`deleted`=0";
    if ($siteId)
        $condition .= ' AND `site_id`=' . (int)$siteId;
    return $userDAO->getMultiInOrderBy($condition, '*', '`id` DESC');
}

/**
 * Assign User List
 */
function enterprise_oms_assign_user_list($smarty, $var, $siteId = null)
{
    $users = enterprise_oms_get_user_list($siteId);
    $smarty->assign($var, $users);
}

/**
 * Users
 */
function enterprise_oms_action_user($smarty, $site)
{
    enterprise_oms_assign_user_list($smarty, 'users', $site['id']);

    $smarty->display('oms/user.tpl');
}

/**
 * Edit User
 */
function enterprise_oms_action_edit_user($smarty, $site)
{
    $userId = (int)timandes_get_query_data('user_id');

    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        if ($userId)
            enterprise_admin_assign_user_info($smarty, 'user', $userId);

        $smarty->assign('user_id', $userId);

        return $smarty->display('oms/edit_user.tpl');
    }

    $name = timandes_get_post_data('name');
    $password = timandes_get_post_data('password');
    $email = timandes_get_post_data('email');
    $advanced = (int)timandes_get_post_data('advanced');

    $values = array(
            'email' => $email,
            'advanced' => $advanced,
            'site_id' => $site['id'],
            'updated' => date('Y-m-d H:i:s'),
        );
    if (!$userId) {// Create
        if (!$name)
            throw new \RuntimeException("用户名不能为空");
        if (!$password)
            throw new \RuntimeException("密码不能为空");
        $values['name'] = $name;
    }

    if ($password)
        $values['password'] = md5($password);
    $userDAO = new \enterprise\daos\User();
    if ($userId) {
        $userDAO->update($userId, $values);
    } else {
        $values['created'] = $values['updated'];
        $userId = $userDAO->insert($values);
    }

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=user&site_id=' . $site['id'], '帐号管理');
}
/* }}} */
