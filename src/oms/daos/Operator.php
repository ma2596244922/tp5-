<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * Operator DAO
 */
class Operator extends AbstractDAO
{
    protected $_fields = array(
            'name' => 'text',
            'password' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_operators';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}