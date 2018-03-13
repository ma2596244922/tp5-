<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * TDKTemplate DAO
 */
class TDKTemplate extends AbstractDAO
{
    protected $_fields = array(
            'html_title' => 'text',
            'meta_keywords' => 'text',
            'meta_description' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_tdk_templates';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}
