<?php
/**
 * 对接采集器 - 接口数据源
 *
 * @package timandes\enterprise
 */

require_once __DIR__ . '/bootstrap.php';

list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();

// Get tasks
$taskDAO = new blowjob\daos\Task();
if ($langCode == 'en') {
    $groupDAO = new enterprise\daos\Group();
    $groupPrimaryKey = '`id`';
    $groupListCondition = '`site_id`=' . (int)$siteId . ' AND `deleted`=0';
    $groupListFields = $groupPrimaryKey . ' AS `id`, `name`';
    $groupListOrderBy = $groupPrimaryKey . ' ASC';
} else {
    $groupDAO = new enterprise\daos\LangGroup($langCode);
    $groupPrimaryKey = '`group_id`';
    $groupListCondition = 'lg.`site_id`=' . (int)$siteId . ' AND lg.`deleted`=0';
    $groupListFields = 'lg.' . $groupPrimaryKey . ' AS `id`, lg.`name`';
    $groupListOrderBy = 'lg.' . $groupPrimaryKey . ' ASC';
}
$statusRange = blowjob\daos\Task::STATUS_PENDING . ', ' . blowjob\daos\Task::STATUS_IN_PROGRESS;
$condition = 't.`site_id`=' . (int)$siteId . ' AND t.`deleted`=0 AND t.`status` in (' . $statusRange . ')';
$taskTableName = $taskDAO->getTableName();
$groupTableName = $groupDAO->getTableName();
$sql = "SELECT t.`id`, t.`group_id`, g.`name` AS `group_name`, t.`target_url`, t.`max_pages`, t.`status`
    FROM `{$taskTableName}` t
    LEFT JOIN `{$groupTableName}` g ON g.{$groupPrimaryKey}=t.`group_id`
    WHERE {$condition} ORDER BY t.`id` DESC";
$tasks = $taskDAO->getMultiBySql($sql);

// Get groups
$groups = $groupDAO->getMultiInOrderBy($groupListCondition, $groupListFields, $groupListOrderBy);

$response = array(
        "host"=> $_SERVER['HTTP_HOST'],
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