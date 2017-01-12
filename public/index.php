<?php
/**
 * 项目入口
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/vendor/autoload.php';

$foo = new Foo();
$foo = new \enterprise\Foo();
$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../') . '/templates_c/');
$smarty->display('index.tpl');
