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
            'ar' => array(
                    'label' => '阿拉伯语',
                    'locale_label' => 'Arabic',
                    'dir' => 'rtl',
                ),
            'es' => array(
                    'label' => '西班牙语',
                    'locale_label' => 'Español',
                ),
            'fr' => array(
                    'label' => '法语',
                    'locale_label' => 'Français',
                ),
            'pt' => array(
                    'label' => '葡萄牙语',
                    'locale_label' => 'Português',
                ),
            'zh' => array(
                    'label' => '中文',
                    'locale_label' => '中文',
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

    /**
     * 获取语言代码的文字方向
     *
     * @return string
     */
    public static function getLangDir($langCode)
    {
        return (self::$_supportedLangCodes[$langCode]['dir']??'ltr');
    }
}