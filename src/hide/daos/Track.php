<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace hide\daos;

/**
 * Track DAO
 */
class Track extends AbstractDAO
{
    const HIT_IP      = 10;
    const HIT_BROWSER = 20;
    const HIT_OS      = 30;

    const TARGET_PAGE_DEFAULT   = 0;
    const TARGET_PAGE_REDIRECT  = 10;

    protected $_fields = array(
            'site_id' => 'int',
            'ipaddr' => 'int',
            'ua' => 'text',
            'path' => 'text',
            'hit' => 'tinyint',
            'created' => 'text',
        );

    public function getTableName()
    {
        return 'hide_tracks';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    public static function hit2Text($hit)
    {
        switch ($hit) {
            case self::HIT_IP;
                return 'IP';
            case self::HIT_BROWSER;
                return '浏览器';
            case self::HIT_OS;
                return '操作系统';
            default:
                return 'N/A';
        }
    }
}