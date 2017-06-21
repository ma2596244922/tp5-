<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * VPS DAO
 */
class VPS extends AbstractDAO
{
    protected $_fields = array(
            'alias' => 'text',
            'ip_addr' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_vpss';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}