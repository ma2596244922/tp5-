<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise;

/**
 * Language Code
 */
class LangCode
{
    /** @var array 内置支持的语言代码 */
    private static $_supportedLangCodes = array(
            'fr' => array(
                    'label' => '法语',
                ),
            'pt' => array(
                    'label' => '葡萄牙语',
                ),
            'es' => array(
                    'label' => '西班牙语',
                ),
            'zh' => array(
                    'label' => '中文',
                ),
        );

    /**
     * 获取内置支持的语言代码
     *
     * @return array
     */
    public static function getSupportedLangCodes()
    {
        return self::$_supportedLangCodes;
    }
}