<?php
/**
 * 对接采集器 - 接口数据源
 *
 * @package timandes\enterprise
 */

require_once __DIR__ . '/bootstrap.php';

list($siteId, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();

// Get tasks
$taskDAO = new blowjob\daos\Task();
$groupDAO = new enterprise\daos\Group();
$statusRange = blowjob\daos\Task::STATUS_PENDING . ', ' . blowjob\daos\Task::STATUS_IN_PROGRESS;
$condition = 't.`site_id`=' . (int)$siteId . ' AND t.`deleted`=0 AND t.`status` in (' . $statusRange . ')';
$taskTableName = $taskDAO->getTableName();
$groupTableName = $groupDAO->getTableName();
$sql = "SELECT t.`id`, t.`group_id`, g.`name` AS `group_name`, t.`target_url`, t.`max_pages`, t.`status`
    FROM `{$taskTableName}` t
    LEFT JOIN `{$groupTableName}` g ON g.`id`=t.`group_id`
    WHERE {$condition} ORDER BY t.`id` DESC";
$tasks = $taskDAO->getMultiBySql($sql);

// Get groups
$condition = '`site_id`=' . (int)$siteId . ' AND `deleted`=0';
$groups = $groupDAO->getMultiInOrderBy($condition, '`id`, `name`', '`id` ASC');

$response = array(
        "host"=> "www." . $currentDomainSuffix,
        "site_id"=> $siteId,
        "update_task"=> array(
            "method"=> "PUT",
            "url"=> "/admin/blowjob/lick.php"
        ),
        "post_product"=> array(
            "method"=> "POST",
            "url"=> "/admin/blowjob/sexmeup.php"
        ),
        'tasks' => $tasks,
        'groups' => $groups,
    );

header('Content-type: application/json');
echo json_encode($response);