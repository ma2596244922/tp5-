<?php
/**
 * 对接采集器 - 接口数据源
 *
 * @package timandes\enterprise
 */

require_once __DIR__ . '/bootstrap.php';

list($siteId, $locale, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();

$taskDAO = new blowjob\daos\Task();
$statusRange = blowjob\daos\Task::STATUS_PENDING . ', ' . blowjob\daos\Task::STATUS_IN_PROGRESS;
$condition = '`site_id`=' . (int)$siteId . ' AND `deleted`=0 AND `status` in (' . $statusRange . ')';
$tasks = $taskDAO->getMultiInOrderBy($condition, '`id`, `group_id`, `target_url`, `status`', '`id` DESC');

$response = array(
        "host"=> "www.popost.com",
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
    );

header('Content-type: application/json');
echo json_encode($response);