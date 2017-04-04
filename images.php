<?php
/**
 * 图片配置文件
 *
 * @package timandes\enterprise
 */

/** @var int 产品图片最大宽度 */
define('IMAGE_MAX_WIDTH_4_PRODUCT', 1120);

/** @var int Banner图片最大宽度 */
define('IMAGE_MAX_WIDTH_4_BANNER', 2500);

/** @var array 图片最大宽度配置 */
$maxWidthInfo = array(
        'product' => IMAGE_MAX_WIDTH_4_PRODUCT,
        'certification' => IMAGE_MAX_WIDTH_4_PRODUCT,
        'banner' => IMAGE_MAX_WIDTH_4_BANNER,
    );

/** @var array 缩略图配置 */
$thumbnailInfo = array(
        'product' => array(
                't' => array(600, 600),
                'c' => array(360, 360),
                'd' => array(160, 160),
                'm' => array(100, 100),
            ),
        'certification' => array(
                't' => array(370, 515),
                'm' => array(74, 103),
            ),
        'banner' => array(
                't' => array(360, 75),
                'm' => array(197, 41),
            ),
    );