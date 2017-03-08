<?php
/**
 * 对接采集器 - 展示接口文档
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/bootstrap.php';

$serverRequest = GuzzleHttp\Psr7\ServerRequest::fromGlobals();

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../../../') . '/templates_c/');

$uri = $serverRequest->getUri();
$smarty->assign('host', $uri->getHost());

$smarty->display('admin/blowjob/doc.tpl');