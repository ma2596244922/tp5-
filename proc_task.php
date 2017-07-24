#! /bin/env php
<?php
/**
 * 处理异步任务
 *
 * @package timandes\enterprise
 */

ini_set('display_errors', true);
error_reporting(E_ALL);
ini_set('memory_limit', '4096M');

define('EXIT_SUCCESS', 0);
define('EXIT_FAILURE', 1);

$GLOBALS['gaSettings'] = array(
        'verbose' => 3,
    );

require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/config_admin.php';
require_once __DIR__ . '/duplicate_product.h.php';

function usage()
{
    global $argv;

    $appName = basename($argv[0]);
    $usage = "Usage:" . PHP_EOL;
    $usage .= "\tphp {$appName} [OPTIONS]" . PHP_EOL;
    fprintf(STDOUT, $usage);

    $options = "OPTIONS:" . PHP_EOL;
    $options .= "\t-v                           output warning/errors" . PHP_EOL;
    fprintf(STDOUT, $options);
}

function software_info()
{
    fprintf(STDOUT, "Process Task" . PHP_EOL);
}


function proc_enterprise_task()
{
    $verbose = $GLOBALS['gaSettings']['verbose'];
    $taskTypes = array(
            \blowjob\daos\Task::TYPE_INSERT_KEYWORDS,
            \blowjob\daos\Task::TYPE_REPLACE_KEYWORDS,
            \blowjob\daos\Task::TYPE_INSERT_IMAGES,
            \blowjob\daos\Task::TYPE_INSERT_DESC,
        );

    $taskDAO = new \blowjob\daos\Task();
    $condition = "`deleted`=0 AND `status`=" . \blowjob\daos\Task::STATUS_PENDING . " AND `type` IN (" . implode(',', $taskTypes) . ")";
    $batchSize = 1;
    do {
        $tasks = $taskDAO->getMultiBy($condition, $batchSize);
        if (!$tasks)
            break;

        $task = $tasks[0];
        fprintf(STDOUT, "Processing enterprise task {$task['id']} ..." . PHP_EOL);

        // In-Progress
        $taskDAO = new \blowjob\daos\Task();
        $values = array(
                'status' => \blowjob\daos\Task::STATUS_IN_PROGRESS,
                'updated' => date('Y-m-d H:i:s'),
            );
        $taskDAO->update($task['id'], $values);

        $processed = false;
        switch ($task['type']) {
            case \blowjob\daos\Task::TYPE_INSERT_KEYWORDS:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_insert_keywords_proc($siteId, $details);

                $processed = true;
                break;
            case \blowjob\daos\Task::TYPE_REPLACE_KEYWORDS:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_replace_keywords_proc($siteId, $details);

                $processed = true;
                break;
            case \blowjob\daos\Task::TYPE_INSERT_IMAGES:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_insert_images_proc($siteId, $details);

                $processed = true;
                break;
            case \blowjob\daos\Task::TYPE_INSERT_DESC:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_insert_desc_proc($siteId, $details);

                $processed = true;
                break;
            default:
                fprintf(STDERR, "Unsupported task type {$task['type']}, skipping ..." . PHP_EOL);
                break;
        }

        if ($processed) {
            $taskDAO = new \blowjob\daos\Task();
            $values = array(
                    'status' => \blowjob\daos\Task::STATUS_FINISHED,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $taskDAO->update($task['id'], $values);
        }
    } while(true);

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish enterprise task processing" . PHP_EOL);
}

function proc_oms_task()
{
    $verbose = $GLOBALS['gaSettings']['verbose'];

    $baseDateTime = date('Y-m-d H:i:s');

    $taskDAO = new \oms\daos\Task();
    $condition = "`deleted`=0 AND `status`=" . \oms\daos\Task::STATUS_PENDING . " AND `delay_until`<='{$baseDateTime}'";
    $batchSize = 1;
    do {
        $tasks = $taskDAO->getMultiBy($condition, $batchSize);
        if (!$tasks)
            break;

        $task = $tasks[0];
        fprintf(STDOUT, "Processing oms task {$task['id']} ..." . PHP_EOL);

        // In-Progress
        $taskDAO = new \oms\daos\Task();
        $values = array(
                'status' => \oms\daos\Task::STATUS_IN_PROGRESS,
                'updated' => date('Y-m-d H:i:s'),
            );
        $taskDAO->update($task['id'], $values);

        $details = json_decode($task['details'], true);
        $sourceGroupIdArray = explode(',', $details['source_group_id']);
        if (is_array($sourceGroupIdArray)) foreach ($sourceGroupIdArray as $id) {
            $id = trim($id);
            if (!$id)
                continue;
            duplicate_product_source_group($id, $details['source_lang_code'], $details['target_site_id'], $details['target_group_id'], $details['target_lang_code'], 0);
        }


        $taskDAO = new \oms\daos\Task();
        $values = array(
                'status' => \blowjob\daos\Task::STATUS_FINISHED,
                'updated' => date('Y-m-d H:i:s'),
            );
        $taskDAO->update($task['id'], $values);
    } while(true);

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish oms task processing" . PHP_EOL);
}

function main($argc, $argv)
{
    $type = '';
    $siteId = 0;

    software_info();

    $params = getopt("v", array());
    if(is_array($params)
            && count($params) > 0) foreach($params as $k => &$v) {
        switch($k) {
            case 'v':
                $GLOBALS['gaSettings']['verbose'] = count($v);
                break;
        }
    } else {
        usage();
        return EXIT_FAILURE;
    }

    try {
        proc_enterprise_task();
        proc_oms_task();
    } catch (\Exception $e) {
        $rc = new \ReflectionClass($e);
        fprintf(STDERR, "%s#%d %s" . PHP_EOL, $rc->getName(), $e->getCode(), $e->getMessage());
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

exit(main($argc, $argv));