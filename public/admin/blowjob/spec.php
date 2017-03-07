<?php
/**
 * 对接采集器 - 生成接口规范
 *
 * @package timandes\enterprise
 */

require_once __DIR__ . '/bootstrap.php';

$serverRequest = GuzzleHttp\Psr7\ServerRequest::fromGlobals();

$smarty = new Smarty();
$smarty->setTemplateDir(realpath(__DIR__ . '/../../../') . '/templates/');
$smarty->setCompileDir(realpath(__DIR__ . '/../../../') . '/templates_c/');

$uri = $serverRequest->getUri();
$smarty->assign('host', $uri->getHost());

header('Content-type: application/octet-stream');
$smarty->display('admin/blowjob/spec.tpl');