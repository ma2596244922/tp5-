<?php
/**
 * 项目入口
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../') . '/vendor/autoload.php';
require_once realpath(__DIR__ . '/../') . '/config.php';

function enterprise_generate_guid()
{
    return md5(uniqid(mt_rand(), true), true);
}

// TODO:
$siteId = 1;
$originalDomainSuffix = 'snackmakingmachine.com';
$currentDomainSuffix = 'snackmakingmachineoff.com';

// 优先使用本地存储的页面、图片和资源等
$requestRelativeURI = $_SERVER['REQUEST_URI'];
$fakeRequestHost = str_replace($currentDomainSuffix, $originalDomainSuffix, $_SERVER['HTTP_HOST']);
$requestURL = 'http://' . $fakeRequestHost . $requestRelativeURI;
$requestPath = parse_url($requestURL, PHP_URL_PATH);
$urlSum = md5($requestURL, true);
$pathSum = md5($requestPath, true);
// + Page
$pageDAO = new \crawler\daos\Page();
$page = $pageDAO->getByUrlSum($urlSum);
if ($page) {
    if ($page['status_code'] != 200) {
        http_response_code($page['status_code']);
        exit(1);
    }

    echo str_replace($originalDomainSuffix, $currentDomainSuffix, $page['content']);
    exit(0);
}
// + Image N Resource
$daos = array(
        new \crawler\daos\Image(),
        new \crawler\daos\Resource(),
    );
foreach ($daos as $dao) {
    $image = $dao->getByMutex($siteId, $pathSum);
    if ($image) {
        if ($image['status_code'] != 200) {
            http_response_code($image['status_code']);
            exit(1);
        }

        header('Content-Type: ' . $image['content_type']);
        echo $image['content'];
        exit(0);
    }
}

// 其次匹配特殊页面
if ($requestPath == '/contactsave.html') {
    // Upload filess
    $attachmentDAO = new \enterprise\daos\Attachment();
    foreach ($_FILES as $meta) {
        if ($meta['error'])
            continue;
        $body = file_get_contents($meta['tmp_name']);
        $contentType = $meta['type'];
        $guid = enterprise_generate_guid();
        $values = array(
                'guid' => $guid,
                'body' => $body,
                'content_type' => $contentType,
                'created' => date('Y-m-d H:i:s'),
            );
        $id = $attachmentDAO->insert($values);
    }
    var_dump($_POST);
    var_dump($_FILES);
    exit(0);
}

http_response_code(404);
exit(1);

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
