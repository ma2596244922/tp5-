<?php
/**
 * 项目入口
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/vendor/autoload.php';

require_once realpath(__DIR__ . '/../') . '/config.php';

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');

$siteId = 1;
$domain = 'snackmakingmachineoff.com';
$translationDAO = new \crawler\daos\Translation();
$rows = $translationDAO->getBySite($siteId);
$translations = array();
foreach ($rows as $row) {
    $row['abbr'] = \crawler\daos\Translation::locale2Abbr($row['locale']);
    $row['text'] = \crawler\daos\Translation::locale2Text($row['locale']);
    $row['url'] = 'http://' . $row['locale'] . '.' . $domain . '/';
    $translations[] = $row;
}
$smarty->assign('translations', $translations);

$smarty->display('index.tpl');
