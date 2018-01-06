<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace hide\daos;

/**
 * Site DAO
 */
class Site extends AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'enabled' => 'tinyint',
            'hide_by_ipaddr' => 'tinyint',
            'hide_by_browser' => 'tinyint',
            'hide_by_os' => 'tinyint',
            'ipaddr_black_list' => 'text',
            'ipaddr_white_list' => 'text',
            'target_page' => 'text',
            'target_page_url' => 'text',
            'created' => 'text',
            'updated' => 'text',
        );

    public function getTableName()
    {
        return 'hide_sites';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}