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
        'stats-only' => false,
        'site-id' => null,
        'language' => null,
        'from-language' => 'en',
    );
$GLOBALS['gaStats'] = array(
        'stats-total-chars' => 0,
        'stats-total-chars-after-optimizing' => 0,
    );

require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/config_admin.php';
require_once __DIR__ . '/duplicate_product.h.php';
require_once __DIR__ . '/enterprise_translate.h.php';
require_once __DIR__ . '/enterprise_product.h.php';

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
    $options .= "\t--stats-only                 skip translation process, count characters only(need -t translation)" . PHP_EOL;
    $options .= "\t--site-id=<ID>               translate given site(need -t translation)" . PHP_EOL;
    $options .= "\t--language=<code>            translate given site to given language(need -t translation)" . PHP_EOL;
    $options .= "\t--from-language=<code>       translate given site from given language(need -t translation, default is 'en')" . PHP_EOL;
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

    $tdkTemplateDAO = new \oms\daos\TDKTemplate();
    $condition = "`deleted`=0";
    $tdkTemplates = $tdkTemplateDAO->getMultiBy($condition);
    $tdkTemplateCnt = count($tdkTemplates);

    $taskDAO = new \oms\daos\Task();
    $condition = "`deleted`=0 AND `status`=" . \oms\daos\Task::STATUS_PENDING . " AND `delay_until`<='{$baseDateTime}'";
    $batchSize = 1;
    $tdkTemplateCounter = 0;
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

            $tdkTpl = ((isset($details['random_tdk']) && $details['random_tdk'])?$tdkTemplates[$tdkTemplateCounter++]:null);var_dump($tdkTpl);
            duplicate_product_source_group($id, $details['source_lang_code'], $details['target_site_id'], $details['target_group_id'], $details['target_lang_code'], 0, (bool)$details['update_purl_prefix'], $tdkTpl);

            if ($tdkTemplateCounter >= $tdkTemplateCnt)
                $tdkTemplateCounter = 0; // Reset counter
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

function proc_stats_acc_total_chars($cnt)
{
    $GLOBALS['gaStats']['stats-total-chars'] += $cnt;
}

function proc_stats_acc_total_chars_after_optimizing($cnt)
{
    $GLOBALS['gaStats']['stats-total-chars-after-optimizing'] += $cnt;
}

function proc_translation_translate_corporation($translateClient, $tp)
{
    $verbose = $GLOBALS['gaSettings']['verbose'];

    $corporationDAO = new \enterprise\daos\Corporation();
    $langCorporationDAO = new \enterprise\daos\LangCorporation($tp['lang_code']);

    $condition = "`site_id`={$tp['site_id']}";
    $corporation = $corporationDAO->getOneBy($condition);
    if (!$corporation) {
        if ($verbose >= 1)
            fprintf(STDOUT, "Fail to find corporation info of site {$tp['site_id']}, skipping ..." . PHP_EOL);
        return;
    }

    $srcText = proc_translation_implode_fields($corporation['address'], $corporation['factory_address'], $corporation['qc_profile'], $corporation['main_market'], $corporation['introduction'], $corporation['history'], $corporation['service'], $corporation['our_team']);
    if (!$translateClient) {
        $totalChars = mb_strlen($srcText, 'UTF-8');
        proc_stats_acc_total_chars($totalChars);
        proc_stats_acc_total_chars_after_optimizing($totalChars);
        fprintf(STDOUT, "%s: %d characters" . PHP_EOL, __FUNCTION__, $totalChars);
        return;
    }

    $translation = $translateClient->translate($srcText, ['target' => $tp['lang_code']]);
    $targetText = $translation['text'];
    list($address, $factory_address, $qc_profile, $main_market, $introduction, $history, $service, $our_team) = proc_translation_explode_fields($targetText);

    $values = array(
            'site_id' => $tp['site_id'],
            'address' => $address,
            'factory_address' => $factory_address,
            'qc_profile' => $qc_profile,
            'main_market' => $main_market,
            'introduction' => $introduction,
            'history' => $history,
            'service' => $service,
            'our_team' => $our_team,
            'updated' => date('Y-m-d H:i:s'),
        );
    $g = $langCorporationDAO->get($corporation['site_id']);
    if ($g)
        $langCorporationDAO->update($corporation['site_id'], $values);
    else {
        $langCorporationDAO->insert($values);
    }
}

/**
 * @return array
 */
function proc_translation_translate_site($translateClient, $tp, $langSiteDAO)
{
    $verbose = $GLOBALS['gaSettings']['verbose'];

    $siteDAO = new \enterprise\daos\Site();

    $condition = "`site_id`={$tp['site_id']}";
    $site = $siteDAO->getOneBy($condition);
    if (!$site) {
        if ($verbose >= 1)
            fprintf(STDOUT, "Fail to find site info of site {$tp['site_id']}, skipping ..." . PHP_EOL);
        return null;
    }

    $srcText = proc_translation_implode_fields($site['index_html_title'], $site['index_meta_keywords'], $site['index_meta_description'], $site['desc_4_inquiry_sender'], $site['product_html_title'], $site['product_meta_keywords'], $site['product_meta_description'], $site['contact_content']);
    if (!$translateClient) {
        $totalChars = mb_strlen($srcText, 'UTF-8');
        proc_stats_acc_total_chars($totalChars);
        proc_stats_acc_total_chars_after_optimizing($totalChars);
        fprintf(STDOUT, "%s: %d characters" . PHP_EOL, __FUNCTION__, $totalChars);
        return $site;
    }

    $translation = $translateClient->translate($srcText, ['target' => $tp['lang_code']]);
    $targetText = $translation['text'];
    list($index_html_title, $index_meta_keywords, $index_meta_description, $desc_4_inquiry_sender, $product_html_title, $product_meta_keywords, $product_meta_description, $contact_content) = proc_translation_explode_fields($targetText);

    $values = array(
            'site_id' => $tp['site_id'],
            'index_html_title' => $index_html_title,
            'index_meta_keywords' => $index_meta_keywords,
            'index_meta_description' => $index_meta_description,
            'desc_4_inquiry_sender' => $desc_4_inquiry_sender,
            'product_html_title' => $product_html_title,
            'product_meta_keywords' => $product_meta_keywords,
            'product_meta_description' => $product_meta_description,
            'contact_content' => $contact_content,
            'updated' => date('Y-m-d H:i:s'),
        );
    $g = $langSiteDAO->get($site['site_id']);
    if ($g)
        $langSiteDAO->update($site['site_id'], $values);
    else {
        $langSiteDAO->insert($values);
    }

    return array_merge($site, $values);
}

function proc_translation_get_uvs_generator($userSiteId, $langCode)
{
    $curUserVoiceId = 0;
    do {
        if ($langCode == 'en')
            $uvs = enterprise_get_user_voice_list($userSiteId, $langCode, 10, "`id`>{$curUserVoiceId}", '`id` ASC');
        else {
            $uvs = enterprise_get_user_voice_list($userSiteId, $langCode, 10, "eluv.`user_voice_id`>{$curUserVoiceId}", 'eluv.`user_voice_id` ASC');
        }
        if (!$uvs)
            break;

        foreach ($uvs as $uv) {
            yield $uv;

            $curUserVoiceId = $uv['id'];
        }
    } while(true);
}

function proc_translation_translate_uv($translateClient, $tp, $langUserVoiceDAO, $uv)
{
    $srcText = proc_translation_implode_fields($uv['title'], $uv['voice']);
    if (!$translateClient) {
        $totalChars = mb_strlen($srcText, 'UTF-8');
        proc_stats_acc_total_chars($totalChars);
        proc_stats_acc_total_chars_after_optimizing($totalChars);
        fprintf(STDOUT, "%s: %d characters" . PHP_EOL, __FUNCTION__, $totalChars);
        return;
    }

    $translation = $translateClient->translate($srcText, ['target' => $tp['lang_code']]);
    $targetText = $translation['text'];
    list($title, $voice) = proc_translation_explode_fields($targetText);

    $values = array(
            'site_id' => $tp['site_id'],
            'title' => $title,
            'voice' => $voice,
            'updated' => date('Y-m-d H:i:s'),
        );
    $g = $langUserVoiceDAO->get($uv['id']);
    if ($g)
        $langUserVoiceDAO->update($uv['id'], $values);
    else {
        $values['uv_id'] = $uv['id'];
        $values['created'] = $uv['created'];
        $langUserVoiceDAO->insert($values);
    }
}

function proc_translation_get_news_array_generator($userSiteId, $langCode)
{
    $curNewsId = 0;
    do {
        if ($langCode == 'en')
            $news_array = enterprise_get_news_list($userSiteId, $langCode, 10, "`id`>{$curNewsId}", '`id` ASC');
        else {
            $news_array = enterprise_get_news_list($userSiteId, $langCode, 10, "ln.`news_id`>{$curNewsId}", 'ln.`news_id` ASC');
        }
        if (!$news_array)
            break;

        foreach ($news_array as $news) {
            yield $news;

            $curNewsId = $news['id'];
        }
    } while(true);
}

function proc_translation_translate_news($translateClient, $tp, $langNewsDAO, $news)
{
    $srcText = proc_translation_implode_fields($news['caption'], $news['content']);
    if (!$translateClient) {
        $totalChars = mb_strlen($srcText, 'UTF-8');
        proc_stats_acc_total_chars($totalChars);
        proc_stats_acc_total_chars_after_optimizing($totalChars);
        fprintf(STDOUT, "%s: %d characters" . PHP_EOL, __FUNCTION__, $totalChars);
        return;
    }

    $translation = $translateClient->translate($srcText, ['target' => $tp['lang_code']]);
    $targetText = $translation['text'];
    list($caption, $content) = proc_translation_explode_fields($targetText);

    $values = array(
            'site_id' => $tp['site_id'],
            'caption' => $caption,
            'content' => $content,
            'updated' => date('Y-m-d H:i:s'),
        );
    $g = $langNewsDAO->get($news['id']);
    if ($g)
        $langNewsDAO->update($news['id'], $values);
    else {
        $values['news_id'] = $news['id'];
        $values['created'] = $news['created'];
        $langNewsDAO->insert($values);
    }
}

function proc_translation_get_groups_generator($userSiteId, $langCode)
{
    $curGroupId = 0;
    do {
        if ($langCode == 'en')
            $groups = enterprise_get_group_list($userSiteId, $langCode, 10, "`id`>{$curGroupId}", '`id` ASC');
        else {
            $groups = enterprise_get_group_list($userSiteId, $langCode, 10, "lg.`group_id`>{$curGroupId}", 'lg.`group_id` ASC');
        }
        if (!$groups)
            break;

        foreach ($groups as $group) {
            yield $group;

            $curGroupId = $group['id'];
        }
    } while(true);
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
    return enterprise_translate_implode_fields(...$fields);
}

function proc_translation_explode_fields($string)
{
    return enterprise_translate_explode_fields($string);
}

function proc_translation_translate_product($translateClient, $tp, $langSiteDAO, $langGroupDAO, $langProductDAO, $site, $product)
{
    $srcText = proc_translation_implode_fields($product['caption'], $product['description'], $product['tags'], $product['specifications']);

    $htmlOptimizer = new \enterprise\translate\HtmlOptimizer($product['description']);
    // Optimize description
    $sentences = $htmlOptimizer->split();

    // + Rebuild & Translate
    $optimizedDescription = implode('<p>', $sentences);
    $optimizedSrcText = proc_translation_implode_fields($product['caption'], $optimizedDescription, $product['tags'], $product['specifications']);
//if ($product['id']==101) {var_dump($product['description'], $optimizedDescription);exit;}
    if (!$translateClient) {
        $totalChars = mb_strlen($srcText, 'UTF-8');
        proc_stats_acc_total_chars($totalChars);
        $optimizedTotalChars = mb_strlen($optimizedSrcText, 'UTF-8');
        proc_stats_acc_total_chars_after_optimizing($optimizedTotalChars);
        fprintf(STDOUT, "%s(#%d): %d characters(%d characters after optimizing)" . PHP_EOL, __FUNCTION__, $product['id'], $totalChars, $optimizedTotalChars);
        // ++ Pretend all translations are done(should be saved to cache)
        foreach ($sentences as $s)
            enterprise_translate_cache_set($s, $s);
        return;
    }

    $translation = $translateClient->translate($optimizedSrcText, ['target' => $tp['lang_code']]);
    $targetText = $translation['text'];
    list($caption, $translatedDescription, $tags, $specifications) = proc_translation_explode_fields($targetText);

    // Recover description
    $fragments = explode('<p>', $translatedDescription);
    $description = $htmlOptimizer->combine($sentences, $fragments);

    $autoSummaryEnabled = empty($site['disable_auto_summary']);

    $values = array(
            'site_id' => $tp['site_id'],
            'caption' => $caption,
            'description' => $description,
            'tags' => $tags,
            'specifications' => $specifications,
            'group_id' => $product['group_id'],
            'updated' => date('Y-m-d H:i:s'),
        );
    if ($autoSummaryEnabled)
        $values['summary'] = enterprise_product_description_2_summary($description);
    $duplicatedFields = ['group_id', 'min_order_quantity', 'delivery_time', 'packaging_details', 'embedded_video'];
    foreach ($duplicatedFields as $f)
        $values[$f] = $product[$f];
    $c = "`product_id`={$product['id']}";
    $p = $langProductDAO->getOneBy($c);
    if ($p)
        $langProductDAO->update($product['id'], $values);
    else {
        $values['product_id'] = $product['id'];
        $values['created'] = $product['created'];
        $langProductDAO->insert($values);
        $langGroupDAO->incrCnt($product['group_id'], 1);
        $langSiteDAO->incrProductCnt($tp['site_id'], 1);
    }
}

function proc_translation_translate_group($translateClient, $tp, $langGroupDAO, $group)
{
    $srcText = proc_translation_implode_fields($group['name'], $group['desc'], $group['product_html_title'], $group['product_meta_keywords'], $group['product_meta_description']);
    if (!$translateClient) {
        $totalChars = mb_strlen($srcText, 'UTF-8');
        proc_stats_acc_total_chars($totalChars);
        proc_stats_acc_total_chars_after_optimizing($totalChars);
        fprintf(STDOUT, "%s: %d characters" . PHP_EOL, __FUNCTION__, $totalChars);
        return;
    }

    $translation = $translateClient->translate($srcText, ['target' => $tp['lang_code']]);
    $targetText = $translation['text'];
    list($name, $desc, $product_html_title, $product_meta_keywords, $product_meta_description) = proc_translation_explode_fields($targetText);

    $values = array(
            'site_id' => $tp['site_id'],
            'name' => $name,
            'desc' => $desc,
            'product_html_title' => $product_html_title,
            'product_meta_keywords' => $product_meta_keywords,
            'product_meta_description' => $product_meta_description,
            'updated' => date('Y-m-d H:i:s'),
        );
    $g = $langGroupDAO->get($group['id']);
    if ($g)
        $langGroupDAO->update($group['id'], $values);
    else {
        $values['group_id'] = $group['id'];
        $values['created'] = $group['created'];
        $langGroupDAO->insert($values);
    }
}

function proc_translation_check_progress_terminated($translationProgressDAO, $siteId, $langCode)
{
    $verbose = $GLOBALS['gaSettings']['verbose'];
    $statsOnly = $GLOBALS['gaSettings']['stats-only'];

    if ($statsOnly)
        return false;

    $condition = "`site_id`=" . (int)$siteId . " AND `lang_code`='" . $translationProgressDAO->escape($langCode) . "'";
    $translationProgress = $translationProgressDAO->getOneBy($condition);
    if (!$translationProgress) {
        if ($verbose >= 1)
            fprintf(STDERR, "Progress of {$langCode} of site {$siteId} is missing, stopping whole process ..." . PHP_EOL);
        return true;
    }

    $interestingStatusList = [\oms\daos\TranslationProgress::STATUS_PENDING, \oms\daos\TranslationProgress::STATUS_FINISHED];
    if (in_array($translationProgress['status'], $interestingStatusList)) {
        if ($verbose >= 1)
            fprintf(STDERR, "Interesting status#{$translationProgress['status']} of progress of {$langCode} of site {$siteId} was found, stopping whole process ..." . PHP_EOL);
        return true;
    }

    if ($translationProgress['status'] == \oms\daos\TranslationProgress::STATUS_TERMINATED) {
        if ($verbose >= 1)
            fprintf(STDOUT, "Translation process of {$langCode} of site {$siteId} is terminated by user, stopping whole process ..." . PHP_EOL);
        return true;
    }

    return false;
}

function proc_translation_progress()
{
    $verbose = $GLOBALS['gaSettings']['verbose'];
    $statsOnly = $GLOBALS['gaSettings']['stats-only'];
    $fromLangCode = $GLOBALS['gaSettings']['from-language'];// FIXME: 并没有覆盖全部待翻译部分（如：公司）

    $translationProgressDAO = new \oms\daos\TranslationProgress();
    if (!$statsOnly)
        $translateClient = new Google\Cloud\Translate\TranslateClient(['key' => GOOGLE_CLOUD_API_KEY]);
    else
        $translateClient = null;

    if ($GLOBALS['gaSettings']['site-id']
            && $GLOBALS['gaSettings']['language']) {
        $tpGenerator = array(
                array(
                        'site_id' => $GLOBALS['gaSettings']['site-id'],
                        'lang_code' => $GLOBALS['gaSettings']['language'],
                        'status' => \oms\daos\TranslationProgress::STATUS_PENDING,
                        'created' => date('Y-m-d H:i:s'),
                        'updated' => date('Y-m-d H:i:s'),
                        'deleted' => 0,
                    ),
            );
    } else {
        $maxBatches = ($statsOnly?1:null);
        $tpGenerator = proc_translation_get_translation_progress_generator($maxBatches);
    }
    foreach ($tpGenerator as $tp) {
        if ($verbose >= 2)
            fprintf(STDOUT, "Processing {$tp['lang_code']} of site {$tp['site_id']} ...");

        enterprise_translate_cache_clear();

        $langProductDAO = new \enterprise\daos\LangProduct($tp['lang_code']);
        $langGroupDAO = new \enterprise\daos\LangGroup($tp['lang_code']);
        $langNewsDAO = new \enterprise\daos\LangNews($tp['lang_code']);
        $langUserVoiceDAO = new \enterprise\daos\LangUserVoice($tp['lang_code']);
        $langSiteDAO = new \enterprise\daos\LangSite($tp['lang_code']);

        if (!$statsOnly) {
            $condition = "`site_id`={$tp['site_id']} AND `lang_code`='" . $translationProgressDAO->escape($tp['lang_code']) . "'";
            $values = array(
                    'status' => \oms\daos\TranslationProgress::STATUS_IN_PROGRESS,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $translationProgressDAO->updateBy($condition, $values);
        }

        proc_translation_translate_corporation($translateClient, $tp);

        $site = proc_translation_translate_site($translateClient, $tp, $langSiteDAO);

        $counter = 0;
        $checkPoint = 10;

        // translate_user_voice
        $uvsGenerator = proc_translation_get_uvs_generator($tp['site_id'], 'en');
        foreach ($uvsGenerator as $uvs) {
            proc_translation_translate_uv($translateClient, $tp, $langUserVoiceDAO, $uvs);

            ++$counter;
            if ($counter >= $checkPoint) {
                $counter = 0;
                if (proc_translation_check_progress_terminated($translationProgressDAO, $tp['site_id'], $tp['lang_code']))
                    break 2;
            }

            if ($verbose >= 2)
                fprintf(STDOUT, "#");
        }

        // translate_news
        $newsGenerator = proc_translation_get_news_array_generator($tp['site_id'], 'en');
        foreach ($newsGenerator as $news) {
            proc_translation_translate_news($translateClient, $tp, $langNewsDAO, $news);

            ++$counter;
            if ($counter >= $checkPoint) {
                $counter = 0;
                if (proc_translation_check_progress_terminated($translationProgressDAO, $tp['site_id'], $tp['lang_code']))
                    break 2;
            }

            if ($verbose >= 2)
                fprintf(STDOUT, "*");
        }

        $groupGenerator = proc_translation_get_groups_generator($tp['site_id'], $fromLangCode);
        foreach ($groupGenerator as $group) {
            proc_translation_translate_group($translateClient, $tp, $langGroupDAO, $group);

            ++$counter;
            if ($counter >= $checkPoint) {
                $counter = 0;
                if (proc_translation_check_progress_terminated($translationProgressDAO, $tp['site_id'], $tp['lang_code']))
                    break 2;
            }

            if ($verbose >= 2)
                fprintf(STDOUT, "_");
        }

        $productGenerator = enterprise_admin_get_group_products_generator($tp['site_id'], $fromLangCode, null, '`description`, `tags`, `specifications`, `embedded_video`, `created`');
        foreach ($productGenerator as $product) {
            proc_translation_translate_product($translateClient, $tp, $langSiteDAO, $langGroupDAO, $langProductDAO, $site, $product);

            ++$counter;
            if ($counter >= $checkPoint) {
                $counter = 0;
                if (proc_translation_check_progress_terminated($translationProgressDAO, $tp['site_id'], $tp['lang_code']))
                    break 2;
            }

            if ($verbose >= 2)
                fprintf(STDOUT, ".");
        }

        if (!$statsOnly) {
            $values = array(
                    'status' => \oms\daos\TranslationProgress::STATUS_FINISHED,
                    'updated' => date('Y-m-d H:i:s'),
                );
            $translationProgressDAO->updateBy($condition, $values);
        }

        if ($verbose >= 2)
            fprintf(STDOUT, "DONE" . PHP_EOL);
    }

    if ($verbose >= 2)
        fprintf(STDOUT, "Finish translation progress processing" . PHP_EOL);
    if ($statsOnly) {
        $pricePerK = 0.02;
        $costs = floor($GLOBALS['gaStats']['stats-total-chars'] / 1000) * $pricePerK;
        fprintf(STDOUT, "Total Chars=%d, Total Costs=$%.2f" . PHP_EOL, $GLOBALS['gaStats']['stats-total-chars'], $costs);
        $costsAfterOptimizing = floor($GLOBALS['gaStats']['stats-total-chars-after-optimizing'] / 1000) * $pricePerK;
        fprintf(STDOUT, "[O]Total Chars=%d, Total Costs=$%.2f" . PHP_EOL, $GLOBALS['gaStats']['stats-total-chars-after-optimizing'], $costsAfterOptimizing);
    }
}

function main($argc, $argv)
{
    $type = '';
    $siteId = 0;

    software_info();

    $params = getopt("vt:", array('stats-only', 'site-id:', 'language:', 'from-language:'));
    if(is_array($params)
            && count($params) > 0) foreach($params as $k => &$v) {
        switch($k) {
            case 'v':
                $GLOBALS['gaSettings']['verbose'] = count($v);
                break;
            case 't':
                $type = $v;
                break;
            case 'stats-only':
                $GLOBALS['gaSettings']['stats-only'] = true;
                break;
            case 'site-id':
                $GLOBALS['gaSettings']['site-id'] = $v;
                break;
            case 'language':
                $GLOBALS['gaSettings']['language'] = $v;
                break;
            case 'from-language':
                $GLOBALS['gaSettings']['from-language'] = $v;
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