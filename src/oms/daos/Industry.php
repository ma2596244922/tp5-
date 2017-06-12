<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * Industry DAO
 */
class Industry extends AbstractDAO
{
    protected $_fields = array(
            'name' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_industries';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}