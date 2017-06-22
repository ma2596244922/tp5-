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

            enterprise_oms_assign_common($smarty);

            switch ($action) {
                case 'site_dashboard':
                    return enterprise_oms_action_site_dashboard($smarty);
                case 'input_inquiry':
                    return enterprise_oms_action_input_inquiry($smarty);
                case 'monthly_report':
                    return enterprise_oms_action_monthly_report($smarty);
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
                    return enterprise_oms_action_check_inquiry($smarty);
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
function enterprise_oms_action_check_inquiry($smarty)
{
    $smarty->display('oms/check_inquiry.tpl');
}

/**
 * Input Inquiry
 */
function enterprise_oms_action_input_inquiry($smarty)
{
    $smarty->display('oms/input_inquiry.tpl');
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
    $smarty->display('oms/client_info.tpl');
}

/**
 * Monthly Report
 */
function enterprise_oms_action_monthly_report($smarty)
{
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

function enterprise_oms_assign_common($smarty)
{
    $siteMappings = enterprise_oms_get_site_mapping_list();
    $smarty->assign('site_mappings', $siteMappings);
}