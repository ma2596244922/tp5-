<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * ThreateningTarget DAO
 */
class ThreateningTarget extends AbstractDAO
{
    protected $_fields = array(
            'email' => 'text',
            'ip_addr' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_threatening_targets';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}
