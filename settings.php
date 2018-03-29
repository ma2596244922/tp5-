<?php
/**
 * 全局配置
 *
 * @package timandes\crawler
 */

/** @var string 产品默认图片URL */
$GLOBALS['gsProductDefaultImageUrl'] = '/media/sets/trade/no_image.png';

/** @var string 超级登录的摘要信息生成秘钥 */
$GLOBALS['gsSuperLoginPhrase'] = 'super_login_phrase';

/** @var array URL前缀 */
$GLOBALS['gaUrlPrefixes'] = array(
        'group' => 'factory',
        'product' => 'sell',
    );

/** @var array URL规则 */
$GLOBALS['gaUrlPatterns'] = array(
        'group' => '/^\/factory-([0-9]+)(p([0-9]+))?((-[0-9a-z]+)+)?$/',
        'product' => '/^\/([a-z]+)-([0-9]+)(p([0-9]+))?((-[0-9a-z]+)+)?\.html$/',
    );

// www默认的语言
/** @var string 默认的语言代码 */
$GLOBALS['gsDefaultLangCode'] = 'en';
/** @var string 默认的语言 */
$GLOBALS['gsDefaultLocale'] = 'English';

/** @var array 模板配置 */
$GLOBALS['gaTemplates'] = array(
        'trade' => array(
                'label' => 'M1',
            ),
        'brilly' => array(
                'label' => 'M2',
            ),
        'msma' => array(
                'label' => 'M3',
                'home_max_appended_products_to_group' => 8,
            ),
        'peony' => array(
                'label' => 'M4',
            ),
        'ecs' => array(
                'label' => '企信',
            ),
    );