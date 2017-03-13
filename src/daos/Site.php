<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Site DAO
 */
class Site extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'template' => 'text',
            'updated' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_sites';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}