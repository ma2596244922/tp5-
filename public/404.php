<?php
/**
 * 404页面
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/bootstrap.php';
require_once realpath(__DIR__ . '/../') . '/config.php';

// 根据当前请求的域名，找出对应的站点替换规则
try {
    list($siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix) = enterprise_extract_site_infos();
} catch(HttpException $he) {
    header('Step: ESI');
    exit(1);
}

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');
$smarty->addPluginsDir(realpath(__DIR__ . '/../') . '/plugins/');
$smarty->loadFilter("pre", 'whitespace_control');

echo enterprise_action_404_proc($smarty, $siteId, $platform, $currentDomainSuffix);