<?php
/**
 * 对接采集器 - 更新任务进度
 *
 * @package timandes\enterprise
 */

require_once __DIR__ . '/bootstrap.php';

function enterprise_admin_blowjob_lick_route()
{
    $serverRequest = GuzzleHttp\Psr7\ServerRequest::fromGlobals();
    $method = $serverRequest->getMethod();
    if ($method != 'PUT') {
        http_response_code(405);
        exit(1);
    }

    $bodyStream = $serverRequest->getBody();
    $bodyString = $bodyStream->__toString();
    $params = array();
    parse_str($bodyString, $params);

    if (PASSWD != $params['pw'])
        throw new \RuntimeException("密码错误");

    enterprise_admin_blowjob_lick_response(0, 'SUCCESS');
}

function enterprise_admin_blowjob_lick_response($code, $message)
{
    $response = array(
            'code' => $code,
            'message' => $message,
        );
    header('Content-type: application/json');
    echo json_encode($response);
}

try {
    enterprise_admin_blowjob_lick_route();
} catch (\Exception $e) {
    enterprise_admin_blowjob_lick_response(1, $e->getMessage());
}