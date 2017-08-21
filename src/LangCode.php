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
                    'locale_label' => 'العربية',
                    'dir' => 'rtl',
                ),
            'de' => array(
                    'label' => '德语',
                    'locale_label' => 'Deutsch',
                ),
            'el' => array(
                    'label' => '希腊语',
                    'locale_label' => 'Ελληνικά',
                ),
            'es' => array(
                    'label' => '西班牙语',
                    'locale_label' => 'Español',
                ),
            'fr' => array(
                    'label' => '法语',
                    'locale_label' => 'Français',
                ),
            'id' => array(
                    'label' => '印尼语',
                    'locale_label' => 'Bahasa Indonesia',
                ),
            'it' => array(
                    'label' => '意大利语',
                    'locale_label' => 'Italiano',
                ),
            'pt' => array(
                    'label' => '葡萄牙语',
                    'locale_label' => 'Português',
                ),
            'ru' => array(
                    'label' => '俄语',
                    'locale_label' => 'Русский язык',
                ),
            'sq' => array(
                    'label' => '阿尔巴尼亚语',
                    'locale_label' => 'Shqip',
                ),
            'sv' => array(
                    'label' => '瑞典语',
                    'locale_label' => 'Svenska',
                ),
            'th' => array(
                    'label' => '泰语',
                    'locale_label' => 'ไทย',
                ),
            'tr' => array(
                    'label' => '土耳其语',
                    'locale_label' => 'Türkçe',
                ),
            'uk' => array(
                    'label' => '乌克兰语',
                    'locale_label' => 'Українська',
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