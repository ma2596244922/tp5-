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
    $options .= "\t-t <type>                    task type (enterprise, oms, translation, default: enterprise+oms)" . PHP_EOL;
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
            \blowjob\daos\Task::TYPE_REPLACE_TERMS,
            \blowjob\daos\Task::TYPE_REPLACE_DESC_PIC,
            \blowjob\daos\Task::TYPE_REMOVE_EMPTY_CAPTION_PRODUCTS,
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
            case \blowjob\daos\Task::TYPE_REPLACE_TERMS:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_replace_terms_proc($siteId, $details);

                $processed = true;
                break;
            case \blowjob\daos\Task::TYPE_REPLACE_DESC_PIC:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_replace_desc_pic_proc($siteId, $details);

                $processed = true;
                break;
            case \blowjob\daos\Task::TYPE_REMOVE_EMPTY_CAPTION_PRODUCTS:
                $siteId = $task['site_id'];
                $details = json_decode($task['details'], true);
                enterprise_admin_remove_empty_caption_products_proc($siteId, $details);

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
        shuffle($sourceGroupIdArray);
        if (is_array($sourceGroupIdArray)) foreach ($sourceGroupIdArray as $id) {
            $id = trim($id);
            if (!$id)
                continue;
            duplicate_product_source_group($id, $details['source_lang_code'], $details['target_site_id'], $details['target_group_id'], $details['target_lang_code'], 0, (bool)$details['update_purl_prefix']);
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

function proc_translation_get_translation_progress_generator($maxBatches = null)
{
    if (!isset($maxBatches))
        $maxBatches = 3;

    $translationProgressDAO = new \oms\daos\TranslationProgress();
    $condition = "`deleted`=0 AND `status`=" . \oms\daos\TranslationProgress::STATUS_PENDING;
    $batchSize = 5;
    $accBatches = 0;
    do {
        $entities = $translationProgressDAO->getMultiBy($condition, $batchSize);
        if (!$entities)
            break;

        foreach ($entities as $entity)
            yield $entity;

        ++$accBatches;
    } while($accBatches < $maxBatches);
}

function proc_translation_implode_fields(...$fields)
{
    $splitter = '!1,1!';
    return implode($splitter, $fields);
}

function proc_translation_explode_fields($string)
{
    $splitter = '!1,1!';
    return explode($splitter);
}

function proc_translation_progress()
{
    $verbose = $GLOBALS['gaSettings']['verbose'];

    $translationProgressDAO = new \oms\daos\TranslationProgress();
    $translateClient = new Google\Cloud\Translate\TranslateClient(['key' => GOOGLE_CLOUD_API_KEY]);

    $tpGenerator = proc_translation_get_translation_progress_generator();
    foreach ($tpGenerator as $tp) {
        if ($verbose >= 2)
            fprintf(STDOUT, "Processing {$tp['lang_code']} of site {$tp['site_id']} ...");

        $langProductDAO = new \enterprise\daos\LangProduct($tp['lang_code']);

        $condition = "`site_id`={$tp['site_id']} AND `lang_code`='" . $translationProgressDAO->escape($tp['lang_code']) . "'";
        $values = array(
                'status' => \oms\daos\TranslationProgress::STATUS_IN_PROGRESS,
                'updated' => date('Y-m-d H:i:s'),
            );
        $translationProgressDAO->updateBy($condition, $values);

        $productGenerator = enterprise_admin_get_group_products_generator($tp['site_id'], 'en', null);
        foreach ($productGenerator as $product) {
            $srcText = proc_translation_implode_fields($product['catpion'], $product['description']);
            $translation = $translateClient->translate($srcText, ['target' => $tp['lang_code']]);
            $targetText = $translation['text'];
            list($caption, $description) = proc_translation_explode_fields($targetText);

            $values = array(
                    'caption' => $caption,
                    'description' => $description,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $c = "`product_id`={$product['id']}";
            $p = $langProductDAO->getOneBy($c);
            if ($p)
                $langProductDAO->update($product['id'], $values);
            else
                $langProductDAO->insert($values);

            if ($verbose >= 2)
                fprintf(STDOUT, ".");
        }

        $values = array(
                'status' => \oms\daos\TranslationProgress::STATUS_FINISHED,
                'updated' => date('Y-m-d H:i:s'),
            );
        $translationProgressDAO->updateBy($condition, $values);

        if ($verbose >= 2)
            fprintf(STDOUT, "DONE" . PHP_EOL);
    }

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish translation progress processing" . PHP_EOL);
}

function main($argc, $argv)
{
    $type = '';
    $siteId = 0;

    software_info();

    $params = getopt("vt:", array());
    if(is_array($params)
            && count($params) > 0) foreach($params as $k => &$v) {
        switch($k) {
            case 'v':
                $GLOBALS['gaSettings']['verbose'] = count($v);
                break;
            case 't':
                $type = $v;
                break;
        }
    } else {
        usage();
        return EXIT_FAILURE;
    }

    try {
        switch ($type) {
            case 'translation':
                //proc_translation_task();
                proc_translation_progress();
                break;
            default:
                proc_enterprise_task();
                proc_oms_task();
                break;
        }
    } catch (\Exception $e) {
        $rc = new \ReflectionClass($e);
        fprintf(STDERR, "%s#%d %s" . PHP_EOL, $rc->getName(), $e->getCode(), $e->getMessage());
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

exit(main($argc, $argv));