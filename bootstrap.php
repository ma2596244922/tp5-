<?php
/**
 * 框架入口
 *
 * @package timandes\enterprise
 */

// Default timezone
date_default_timezone_set("Asia/Shanghai");

// MySQL error handler
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

// Autoload
require_once __DIR__ . '/vendor/autoload.php';

// Functions
require_once __DIR__ . '/common/functions.php';

require_once __DIR__ . '/settings.php';

require_once __DIR__ . '/enterprise.h.php';
require_once __DIR__ . '/enterprise_product.h.php';
require_once __DIR__ . '/enterprise_admin.h.php';
require_once __DIR__ . '/sites.php';
require_once __DIR__ . '/images.php';

// Debug Mode
if (timandes_get_query_data('dbg'))
    define('DBG_MODE', true);
else
    define('DBG_MODE', false);
