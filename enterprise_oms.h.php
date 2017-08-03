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
        case 'logout':
            return enterprise_oms_action_logout($smarty);
        case 'login':
            return enterprise_oms_action_login($smarty);
        default:
            $operator = enterprise_oms_grant_permission();

            $site = enterprise_oms_assign_common($smarty);

            switch ($action) {
                // V1
                case 'site_mapping':
                    return enterprise_oms_action_site_mapping($smarty);
                case 'edit_site_mapping':
                    return enterprise_oms_action_edit_site_mapping($smarty);
                case 'delete_site_mapping':
                    return enterprise_oms_action_delete_site_mapping($smarty);
                case 'edit_site':
                    return enterprise_oms_action_edit_site($smarty);
                case 'dashboard1':
                    return enterprise_oms_action_dashboard($smarty);
                // V2
                case 'view_attachment':
                    $guidHex = timandes_get_query_data('guid');
                    echo enterprise_action_attachment_proc($guidHex);
                    return;
                case 'view_inquiry':
                    return enterprise_oms_action_view_inquiry($smarty);
                case 'edit_task':
                    return enterprise_oms_action_edit_task($smarty);
                case 'task':
                    return enterprise_oms_action_task($smarty);
                case 'vps_health':
                    return enterprise_oms_action_vps_health();
                case 'password':
                    return enterprise_oms_action_password($smarty, $operator);
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
                    return enterprise_oms_action_edit_operator($smarty, $operator);
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
                    return enterprise_oms_action_check_inquiry($smarty);
                case 'inquiry_stats':
                    return enterprise_oms_action_inquiry_stats($smarty);
                case 'site_stats':
                    return enterprise_oms_action_site_stats($smarty);
                case 'new_site':
                    return enterprise_oms_action_new_site($smarty);
                case 'dashboard':
                default:
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
    enterprise_oms_assign_vps_list($smarty, 'vpss');

    $smarty->assign('disk_free_space', disk_free_space('/'));
    $smarty->assign('disk_total_space', disk_total_space('/'));

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
 * Assign site list to template
 */
function enterprise_oms_assign_site_list($smarty, $var, $max = 10, $pageNo = 1,
        $type = null, $industryId = null, $vpsId = null, $from = null, $to = null, $stats = false, $orderBy = null)
{
    $siteMappingDAO = new \enterprise\daos\SiteMapping();

    // Build condition
    $condition = '';
    $conditionArray = [];
    if ($type) {
        $conditionArray[] = "s.`type`={$type}";
    }
    if ($industryId) {
        $conditionArray[] = "s.`industry_id`={$industryId}";
    }
    if ($vpsId) {
        $conditionArray[] = "s.`vps_id`={$vpsId}";
    }
    if ($conditionArray)
        $condition = " WHERE " . implode(' AND ', $conditionArray);

    // Build stats conditions
    $createdConditionArray = ['`deleted`=0'];
    $updatedConditionArray = ['`deleted`=1'];
    if ($from) {
        $escapedFrom = $siteMappingDAO->escape($from);
        $createdConditionArray[] = "`created`>='{$escapedFrom} 00:00:00'";
        $updatedConditionArray[] = "`updated`>='{$escapedFrom} 00:00:00'";
    }
    if ($to) {
        $escapedTo = $siteMappingDAO->escape($to);
        $createdConditionArray[] = "`created`<='{$escapedTo} 23:59:59'";
        $updatedConditionArray[] = "`updated`<='{$escapedTo} 23:59:59'";
    }

    $productDAO = new \enterprise\daos\Product();
    $inquiryDAO = new \enterprise\daos\Inquiry();

    $addFields = '';
    if (!$orderBy)
        $orderBy = 's.`id` DESC';
    elseif ($stats
            && $orderBy != 's.`id`') {
        $addFieldArray = [];
        $createdCondition = implode(' AND ', $createdConditionArray);
        $addFieldArray[] = "(SELECT count(0) FROM `{$productDAO->getTableName()}` WHERE {$createdCondition} AND `site_id`=s.`id`) AS `products`";
        $addFieldArray[] = "(SELECT count(0) FROM `{$inquiryDAO->getTableName()}` WHERE {$createdCondition} AND `site_id`=s.`id`) AS `inquiries`";
        $addFieldArray[] = "(SELECT count(0) FROM `{$inquiryDAO->getTableName()}` WHERE {$createdCondition} AND `site_id`=s.`id`) AS `inquiry_emails`";
        $updatedCondition = implode(' AND ', $updatedConditionArray);
        $addFieldArray[] = "(SELECT count(0) FROM `{$inquiryDAO->getTableName()}` WHERE {$updatedCondition} AND `site_id`=s.`id`) AS `deleted_inquiries`";
        $addFields = ', ' . implode(', ', $addFieldArray);
    }

    $start = ($pageNo - 1) * $max;
    $sql = "SELECT s.*, sm.`domain`{$addFields} FROM `enterprise_site_mappings` AS sm
    LEFT JOIN `oms_sites` AS s ON s.`id`=sm.`site_id`
    {$condition} ORDER BY {$orderBy} LIMIT {$start}, {$max}";
    $sites = $siteMappingDAO->getMultiBySql($sql);

    // Stats
    if ($stats
            && !$addFields
            && is_array($sites)) {
        foreach ($sites as &$s) {
            $createdConditionArray[] = "`site_id`=" . (int)$s['id'];
            $updatedConditionArray[] = "`site_id`=" . (int)$s['id'];

            $createdCondition = implode(' AND ', $createdConditionArray);
            $s['products'] = $productDAO->countBy($createdCondition);
            $s['inquiries'] = $inquiryDAO->countBy($createdCondition);
            $s['inquiry_emails'] = $inquiryDAO->countBy($createdCondition, 'email');
            $updatedCondition = implode(' AND ', $updatedConditionArray);
            $s['deleted_inquiries'] = $inquiryDAO->countBy($updatedCondition);
        }
    }

    $smarty->assign($var, $sites);
}

/**
 * Site Stats.
 */
function enterprise_oms_action_site_stats($smarty)
{
    $orderByTypes = [
        null, '`products`', '`inquiries`', '`inquiry_emails`', '`deleted_inquiries`',
    ];
    $orderByTypeLabels = [
        '开通时间', '产品数', '询盘量', '已删除询盘', '邮箱数',
    ];

    $type = (int)timandes_get_query_data('type');
    $industryId = (int)timandes_get_query_data('industry_id');
    $vpsId = (int)timandes_get_query_data('vps_id');
    $from = timandes_get_query_data('from');
    $to = timandes_get_query_data('to');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;
    $orderByType = (int)timandes_get_query_data('order_by_type');
    $orderByDirection = (int)timandes_get_query_data('order_by_dir');
    $orderBy = $orderByTypes[$orderByType]??null;
    if ($orderBy)
        $orderBy .= ' ' . ($orderByDirection?'ASC':'DESC');
    elseif (!$orderByDirection)
        $orderBy = 's.`id`';

    enterprise_oms_assign_site_list($smarty, 'sites', $max, $pageNo,
        $type, $industryId, $vpsId, $from, $to, true, $orderBy);

    $queries = array(
            'action' => 'site_stats',
            'type' => $type,
            'industry_id' => $industryId,
            'vps_id' => $vpsId,
            'from' => $from,
            'to' => $to,
            'order_by_type' => $orderByType,
            'order_by_dir' => $orderByDirection,
        );
    $queryString = http_build_query($queries);
    $smarty->assign('query_string', $queryString);

    // Types
    $types = \oms\daos\Site::getTypes();
    $smarty->assign('types', $types);

    enterprise_oms_assign_vps_list($smarty, 'vpss');

    enterprise_oms_assign_industry_list($smarty, 'industries');

    $smarty->assign('order_by_type', $orderByType);
    $smarty->assign('order_by_dir', $orderByDirection);
    $smarty->assign('order_by_type_labels', $orderByTypeLabels);

    $smarty->display('oms/site_stats.tpl');
}

/* }}} */

/* {{{ Inquiries */

/**
 * View Inquiry
 */
function enterprise_oms_action_view_inquiry($smarty)
{
    $inquiryId = (int)timandes_get_query_data('inquiry_id');

    $inquiryDAO = new \enterprise\daos\Inquiry();
    $inquiry = $inquiryDAO->get($inquiryId);

    $smarty->assign('inquiry', $inquiry);

    enterprise_admin_assign_inquiry_detail($smarty, $inquiry);

    $smarty->display('oms/view_inquiry.tpl');
}


/**
 * Assign inquiry list to template
 */
function enterprise_oms_assign_inquiry_list($smarty, $var, $siteId = null, $max = 10, $pageNo = 1,
        $email = null, $domain = null, $from = null, $to = null, $type = null)
{
    $inquiryDAO = new \enterprise\daos\Inquiry();

    // Build condition
    $condition = "`deleted`=0";
    if ($siteId) {
        $condition .= " AND `site_id`={$siteId}";
    }
    if ($email) {
        $escapedEmail = $inquiryDAO->escape($email);
        $condition .= " AND `email` like '%{$escapedEmail}%'";
    }
    if ($domain) {
        $escapedDomain = $inquiryDAO->escape($domain);
        $condition .= " AND `domain` like '%{$escapedDomain}%'";
    }
    if ($from) {
        $escapedFrom = $inquiryDAO->escape($from);
        $condition .= " AND `created`>='{$escapedFrom} 00:00:00'";
    }
    if ($to) {
        $escapedTo = $inquiryDAO->escape($to);
        $condition .= " AND `created`<='{$escapedTo} 23:59:59'";
    }
    if (isset($type)) {
        $condition .= " AND `type`={$type}";
    }

    $start = ($pageNo - 1) * $max;
    $inquiries = $inquiryDAO->getMultiInOrderBy($condition, ENTERPRISE_INQUIRY_FIELDS_FOR_LIST, '`id` DESC', $max, $start);
    $smarty->assign($var, $inquiries);
}

/**
 * Inquiry Stats.
 */
function enterprise_oms_action_inquiry_stats($smarty)
{
    $email = timandes_get_query_data('email');
    $domain = timandes_get_query_data('domain');
    $from = timandes_get_query_data('from');
    $to = timandes_get_query_data('to');
    $type = (int)timandes_get_query_data('type');
    $pageNo = (int)timandes_get_query_data('page');
    if ($pageNo <= 0)
        $pageNo = 1;
    $max = 20;

    enterprise_oms_assign_inquiry_list($smarty, 'inquiries', null, $max, $pageNo,
        $email, $domain, $from, $to, ($type<0?null:$type));

    $queries = array(
            'action' => 'inquiry_stats',
            'email' => $email,
            'domain' => $domain,
            'from' => $from,
            'to' => $to,
            'type' => $type,
        );
    $queryString = http_build_query($queries);
    $smarty->assign('query_string', $queryString);

    // Types
    $smarty->assign('TYPE_NATURAL', \enterprise\daos\Inquiry::TYPE_NATURAL);
    $smarty->assign('TYPE_INPUT', \enterprise\daos\Inquiry::TYPE_INPUT);

    $smarty->display('oms/inquiry_stats.tpl');
}


/**
 * Check Inquiry
 */
function enterprise_oms_action_check_inquiry($smarty)
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
                    // Save to inquiry table
                    $inquiryData = json_decode($pendingInquiry['data'], true);
                    $inquiryData['guid'] = enterprise_generate_guid();
                    $inquiryDAO = new \enterprise\daos\Inquiry();
                    $inquiryDAO->insert($inquiryData);
                }

                $values = array(
                        'deleted' => 1,
                    );
                $pendingInquiryDAO->update($pendingInquiryId, $values);

                if ($submitted == 1) {// 通过
                    // Send email
                    // 代码放在这里确保相关SQL已执行
                    enterprise_send_inquiry_email_to_user($inquiryData['site_id'], $inquiryData['subject'], $inquiryData['message'], $inquiryData['email']);
                }
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
function enterprise_oms_action_edit_operator($smarty, $operator)
{
    if (!$operator['advanced'])
        throw new \RuntimeException("权限不足");

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
    enterprise_oms_assign_industry_list($smarty, 'industries');
    // Types
    $types = \oms\daos\Site::getTypes();
    $smarty->assign('types', $types);
    // Supported lang codes
    $supportedLangCodes = \enterprise\LangCode::getSupportedLangCodes();
    $smarty->assign('supported_lang_codes', $supportedLangCodes);

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
    $vpsId = (int)timandes_get_post_data('vps_id');
    $industryId = (int)timandes_get_post_data('industry_id');
    $type = (int)timandes_get_post_data('type');
    $enable_mobile_sites = (int)timandes_get_post_data('enable_mobile_sites');
    $offline = (int)timandes_get_post_data('offline');
    $csr = timandes_get_post_data('csr');
    $key = timandes_get_post_data('key');
    $enable_https = (int)timandes_get_post_data('enable_https');
    $template = timandes_get_post_data('template');
    $langCodes = timandes_get_post_data('lang_codes');

    $values = array(
            'desc' => $desc,
            'qq' => $qq,
            'wechat' => $wechat,
            'name' => $name,
            'tel' => $tel,
            'sex' => $sex,
            'vps_id' => $vpsId,
            'industry_id' => $industryId,
            'type' => $type,
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
            'offline' => $offline,
            'template' => $template,
            'lang_codes' => $langCodes,
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

    // Ensure records
    foreach ($langCodes as $lc => $v) {
        // Lang Site
        $langSiteDAO = new \enterprise\daos\LangSite($lc);
        $condition = "`site_id`=" . (int)$siteId;
        $langSite = $langSiteDAO->getOneBy($condition);
        if (!$langSite) {
            $values = array (
                    'site_id' => $siteId,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $langSiteDAO->insert($values);
        }
        // Lang Corporation
        $langCorporationDAO = new \enterprise\daos\LangCorporation($lc);
        $condition = "`site_id`=" . (int)$siteId;
        $langCorporation = $langCorporationDAO->getOneBy($condition);
        if (!$langCorporation) {
            $values = array (
                    'site_id' => $siteId,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $langCorporationDAO->insert($values);
        }
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

        $siteLangCodes = ($site['lang_codes']?json_decode($site['lang_codes'], true):array());
        $smarty->assign('site_lang_codes', $siteLangCodes);
    }

    $types = \oms\daos\Site::getTypes();
    $smarty->assign('site_types', $types);

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


/**
 * Change password
 */
function enterprise_oms_action_password($smarty, $operator)
{
    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        return $smarty->display('oms/password.tpl');
    }

    $oldPassword = timandes_get_post_data('old_password');
    $newPassword = timandes_get_post_data('new_password');
    $newPassword2 = timandes_get_post_data('new_password_2');
    $oldPasswordSum = md5($oldPassword);
    $newPasswordSum = md5($newPassword);

    if ($operator['password'] != $oldPasswordSum)
        throw new \RuntimeException("旧密码不正确");
    if (!$newPassword)
        throw new \RuntimeException("新密码不能为空");
    if ($newPassword != $newPassword2)
        throw new \RuntimeException("两次输入的密码不相同");

    $values = array(
            'password' => $newPasswordSum,
            'updated' => date('Y-m-d H:i:s'),
        );
    $operatorDAO = new \oms\daos\Operator();
    $operatorDAO->update($operator['id'], $values);

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=dashboard', '运营管理');
}

/**
 * VPS Health
 */
function enterprise_oms_action_vps_health()
{
    $addr = timandes_get_query_data('addr');

    $uri = 'http://' . $addr . '/yanan2_status';

    $client = new \GuzzleHttp\Client();
    try {
        $response = $client->request('GET', $uri);
        echo 'OK';
    } catch (\GuzzleHttp\Exception\RequestException $e) {
        $response = $e->getResponse();
        echo 'STATUS=' . $response->getStatusCode();
    }
}


/* {{{ Tasks */
/**
 * Assign Task List
 */
function enterprise_oms_assign_task_list($smarty, $var)
{
    $taskDAO = new \oms\daos\Task();
    $condition = "`deleted`=0";
    $tasks = $taskDAO->getMultiInOrderBy($condition, '*', '`id` DESC');
    $smarty->assign($var, $tasks);
}

/**
 * Assign Task Info
 */
function enterprise_oms_assign_task_info($smarty, $var, $taskId)
{
    $taskDAO = new \oms\daos\Task();
    $task = $taskDAO->get($taskId);
    $smarty->assign($var, $task);

    $taskDetails = json_decode($task['details'], true);
    $smarty->assign($var . '_details', $taskDetails);
}

/**
 * Tasks
 */
function enterprise_oms_action_task($smarty)
{
    enterprise_oms_assign_task_list($smarty, 'tasks');

    $smarty->display('oms/task.tpl');
}

/**
 * Edit Task
 */
function enterprise_oms_action_edit_task($smarty)
{
    $types = array(
            10, 20
        );

    $taskId = (int)timandes_get_query_data('task_id');

    // Supported lang codes
    $supportedLangCodes = \enterprise\LangCode::getSupportedLangCodes();
    $smarty->assign('supported_lang_codes', $supportedLangCodes);

    $submitted = (int)timandes_get_post_data('submit');
    if (!$submitted) {
        if ($taskId)
            enterprise_oms_assign_task_info($smarty, 'task', $taskId);

        $smarty->assign('task_id', $taskId);

        return $smarty->display('oms/edit_task.tpl');
    }

    $source_group_id = timandes_get_post_data('source_group_id');
    $source_lang_code = timandes_get_post_data('source_lang_code');
    $target_type = (int)timandes_get_post_data('target_type');
    $target_group_id = (int)timandes_get_post_data('target_group_id');
    $target_site_id = (int)timandes_get_post_data('target_site_id');
    $target_lang_code = timandes_get_post_data('target_lang_code');
    $delay_until = timandes_get_post_data('delay_until');

    if (!in_array($target_type, $types))
        throw new \RuntimeException("暂不支持此目标类型{$target_type}");
    if (!$source_group_id)
        throw new \RuntimeException("源分组ID不能为空");
    if (!preg_match('/^[0-9, ]+$/', $source_group_id))
        throw new \RuntimeException("源分组ID格式不正确");
    if (!$source_lang_code)
        throw new \RuntimeException("源分组语种不能为空");
    switch ($target_type) {
        case 10:
            if (!$target_group_id)
                throw new \RuntimeException("目标分组ID不能为空");
            $target_site_id = 0;
            break;
        case 20:
            if (!$target_site_id)
                throw new \RuntimeException("目标站ID不能为空");
            $target_group_id = 0;
            break;
    }
    if (!$target_lang_code)
        throw new \RuntimeException("目标分组语种不能为空");

    $details = array (
            'source_group_id' => $source_group_id,
            'source_lang_code' => $source_lang_code,
            'target_type' => $target_type,
            'target_group_id' => $target_group_id,
            'target_site_id' => $target_site_id,
            'target_lang_code' => $target_lang_code,
        );

    $values = array(
            'details' => $details,
            'delay_until' => $delay_until,
            'updated' => date('Y-m-d H:i:s'),
        );
    $taskDAO = new \oms\daos\Task();
    if ($taskId) {
        $taskDAO->update($taskId, $values);
    } else {
        $values['created'] = $values['updated'];
        $taskId = $taskDAO->insert($values);
    }

    enterprise_oms_display_success_msg($smarty, '保存成功', '?action=task', '任务管理');
}
/* }}} */