<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Product DAO
 */
class Product extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
        );

    public function getTableName()
    {
        return 'enterprise_products';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}