<?php
/**
 * 管理后台入口
 *
 * @package timandes\enterprise
 */

define('SESSION_FIELD_USER_ID', 'oms_user_id');

require_once realpath(__DIR__ . '/../../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../../') . '/enterprise_oms.h.php';
require_once realpath(__DIR__ . '/../../') . '/config_oms.php';

/**
 * Grant permission
 */
function enterprise_oms_grant_permission()
{
    $userId = (int)timandes_get_session_data(SESSION_FIELD_USER_ID);
    if (!$userId) {
        header('Location: ?action=login');
        exit;
    }

    return $userId;
}

function enterprise_oms_action_login($smarty)
{
    $tplPath = 'oms/login.tpl';

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) // No form data
        return $smarty->display($tplPath);

    $userName = timandes_get_post_data('user');
    $password = timandes_get_post_data('password');
    $passwordSum = md5($password);

    $user = array(
            'id' => '1',
            'password' => 'bc556a92571088df817377579416f4f6',
        );
    if (!$userName
            || !$user
            || $user['password'] != $passwordSum) {
        $smarty->assign('error_msg', "用户名或密码错误");
        return $smarty->display($tplPath);
    }

    // Add meta to session
    $_SESSION[SESSION_FIELD_USER_ID] = $user['id'];

    // Redirect
    header('Location: ?');
}

function enterprise_oms_action_dashboard($smarty)
{
    $siteDAO = new \oms\daos\Site();
    $sql = "SELECT s.`id`, s.`desc`, s.`created`, s.`updated`, c.`name` AS `corporation_name`
    FROM `oms_sites` AS s
    LEFT JOIN `enterprise_corporations` AS c on c.`site_id`=s.`id`
    ORDER BY s.`id` DESC
    ";
    $sites = $siteDAO->getMultiBySql($sql);
    $smarty->assign('sites', $sites);

    $smarty->display('oms/dashboard.tpl');
}

function enterprise_oms_add_records_for_related_tables($siteId, $domain)
{
    $nowString = date('Y-m-d H:i:s');

    // Create corporation
    $corporationDAO = new \enterprise\daos\Corporation();
    $values = array(
            'site_id' => $siteId,
            'updated' => $nowString,
        );
    $corporationDAO->insert($values);

    // Create site
    $siteDAO = new \enterprise\daos\Site();
    $values = array(
            'site_id' => $siteId,
            'template' => 'trade',
            'updated' => $nowString,
            'start_year' => 2017,
        );
    $siteDAO->insert($values);

    // Create site mapping
    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    $values = array(
            'site_id' => $siteId,
            'domain' => $domain,
            'created' => $nowString,
            'updated' => $nowString,
        );
    $siteMappingDAO->insert($values);

    // Decide user name
    $a = explode('.', $domain);
    $name = $a[0];

    // Create user
    $userDAO = new \enterprise\daos\User();
    $values = array(
            'site_id' => $siteId,
            'name' => $name,
            'password' => '9cbf8a4dcb8e30682b927f352d6559a0',
            'created' => $nowString,
            'updated' => $nowString,
        );
    for ($i=2; ; $i++) {
        try {
            $userDAO->insert($values);
            break;
        } catch (\mysqli_sql_exception $mse) {
            if (!$mse->getCode() == 1062)
                throw $mse;

            $values['name'] = $name . $i;
        }
    }
}

function enterprise_oms_action_edit_site($smarty)
{
    $tplPath = 'oms/edit_site.tpl';

    $siteId = (int)timandes_get_query_data('site_id');
    $smarty->assign('site_id', $siteId);

    $siteDAO = new \oms\daos\Site();

    $submitted = timandes_get_post_data('submit');
    if (!$submitted) {// No form data
        if ($siteId) {
            $site = $siteDAO->get($siteId);
            $smarty->assign('site', $site);
        }
        return $smarty->display($tplPath);
    }

    $desc = timandes_get_post_data('desc');
    $domain = timandes_get_post_data('domain');

    if (!$siteId) {
        if (!$domain) 
            throw new \RuntimeException("请输入根域地址");

        $siteMappingDAO = new \enterprise\daos\SiteMapping();
        $condition = "`domain`='" . $siteMappingDAO->escape($domain) . "'";
        $siteMapping = $siteMappingDAO->getOneBy($condition);
        if ($siteMapping) 
            throw new \RuntimeException("根域地址已存在");
    }

    // Save
    $values = array(
            'desc' => $desc,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($siteId) {// Edit
        $siteDAO->update($siteId, $values);
    } else {// Create
        $values['guid'] = enterprise_generate_guid();
        $values['created'] = $values['updated'];
        $siteId = $siteDAO->insert($values);

        enterprise_oms_add_records_for_related_tables($siteId, $domain);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->display('oms/message.tpl');
}


/**
 * SiteMappings
 */
function enterprise_oms_action_site_mapping($smarty)
{
    $siteId = (int)timandes_get_query_data('site_id');
    $smarty->assign('site_id', $siteId);

    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    if ($siteId)
        $condition = "`site_id`={$siteId}";
    else
        $condition = null;
    $siteMappings = $siteMappingDAO->getMultiBy($condition);
    $smarty->assign('site_mappings', $siteMappings);

    $smarty->display('oms/site_mapping.tpl');
}


/**
 * Assign site_mapping info
 */
function enterprise_oms_assign_site_mapping_info($smarty, $var, $siteMappingId)
{
    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    $siteMapping = $siteMappingDAO->get($siteMappingId);
    $smarty->assign($var, $siteMapping);
}

/**
 * Edit SiteMapping
 */
function enterprise_oms_action_edit_site_mapping($smarty)
{
    $tplPath = 'oms/edit_site_mapping.tpl';

    $siteId = (int)timandes_get_query_data('site_id');
    $smarty->assign('site_id', $siteId);

    $siteMappingId = (int)timandes_get_query_data('site_mapping_id');
    $smarty->assign('site_mapping_id', $siteMappingId);

    $submitButton = timandes_get_post_data('submit');
    if (!$submitButton) {// No form data
        if ($siteMappingId) 
            enterprise_oms_assign_site_mapping_info($smarty, 'site_mapping', $siteMappingId);
        return $smarty->display($tplPath);
    }

    // Save
    $domain = timandes_get_post_data('domain');
    $siteId = (int)timandes_get_post_data('site_id');

    if (!$domain) 
        throw new \RuntimeException('请输入根域地址');

    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    $values = array(
            'site_id' => $siteId,
            'domain' => $domain,
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($siteMappingId) {// Edit
        $siteMappingDAO->update($siteMappingId, $values);
    } else {// Create
        $values['created'] = $values['updated'];
        $siteMappingDAO->insert($values);
    }

    $smarty->assign('success_msg', '保存成功');
    $smarty->assign('forward', '?action=site_mapping&site_id=' . $siteId);
    $smarty->display('oms/message.tpl');
}

/**
 * Delete SiteMapping
 */
function enterprise_oms_action_delete_site_mapping($smarty)
{
    $siteMappingId = (int)timandes_get_query_data('site_mapping_id');

    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    $siteMapping = $siteMappingDAO->get($siteMappingId);
    if (!$siteMapping)
        throw new \RuntimeException("找不到指定的记录");

    $siteId = $siteMapping['site_id'];
    $siteMappingDAO->delete($siteMappingId);
    
    $smarty->assign('success_msg', '删除成功');
    $smarty->assign('forward', '?action=site_mapping&site_id=' . $siteId);
    $smarty->display('oms/message.tpl');
}

function enterprise_oms_route($smarty)
{
    $action = timandes_get_query_data('action');
    switch ($action) {
        case 'login':
            return enterprise_oms_action_login($smarty);
        default:
            $userId = enterprise_oms_grant_permission();
            switch ($action) {
                // V2
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
                // V1
                case 'site_mapping':
                    return enterprise_oms_action_site_mapping($smarty);
                case 'edit_site_mapping':
                    return enterprise_oms_action_edit_site_mapping($smarty);
                case 'delete_site_mapping':
                    return enterprise_oms_action_delete_site_mapping($smarty);
                case 'edit_site':
                    return enterprise_oms_action_edit_site($smarty);
                default:
                    return enterprise_oms_action_dashboard($smarty);
            }
            
    }
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../') . '/templates_c/');
$smarty->addPluginsDir(realpath(__DIR__ . '/../../') . '/plugins/');
$smarty->loadFilter("pre", 'whitespace_control');

session_start();

try {
    enterprise_oms_route_2($smarty);
    exit(0);
} catch(\HttpException $he) {
    $code = $he->getCode();
    if ($code != 404) {
        http_response_code($code);
        exit(1);
    }
} catch (\RuntimeException $e) {
    enterprise_oms_display_error_msg($smarty, $e->getMessage());
    exit(1);
}

try {
    enterprise_oms_route($smarty);
} catch(\HttpException $he) {
    http_response_code($he->getCode());
} catch (\RuntimeException $e) {
    echo $e->getMessage();
    echo '<a href="javascript:void(0);" onclick="javascript: history.back();">返回</a>';
}
