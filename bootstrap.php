<?php
/**
 * 框架入口
 *
 * @package timandes\enterprise
 */

// 图片最大宽度
define('IMAGE_MAX_WIDTH', 1120);

// Autoload
require_once __DIR__ . '/vendor/autoload.php';

require_once __DIR__ . '/enterprise.h.php';
require_once __DIR__ . '/enterprise_admin.h.php';
require_once __DIR__ . '/sites.php';
require_once __DIR__ . '/images.php';
