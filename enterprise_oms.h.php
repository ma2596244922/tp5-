<?php
/**
 * OMS公用函数库
 *
 * @package timandes\enterprise
 */

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
    $smarty->display('oms/new_site.tpl');
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
 * Industries
 */
function enterprise_oms_action_industry($smarty)
{
    $smarty->display('oms/industry.tpl');
}

/**
 * Edit Industry
 */
function enterprise_oms_action_edit_industry($smarty)
{
    $smarty->display('oms/edit_industry.tpl');
}
/* }}} */


/* {{{ VPSs */
/**
 * VPSs
 */
function enterprise_oms_action_vps($smarty)
{
    $smarty->display('oms/vps.tpl');
}

/**
 * Edit VPS
 */
function enterprise_oms_action_edit_vps($smarty)
{
    $smarty->display('oms/edit_vps.tpl');
}
/* }}} */


/* {{{ Operators */
/**
 * Operators
 */
function enterprise_oms_action_operator($smarty)
{
    $smarty->display('oms/operator.tpl');
}

/**
 * Edit Operator
 */
function enterprise_oms_action_edit_operator($smarty)
{
    $smarty->display('oms/edit_operator.tpl');
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
