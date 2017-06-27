<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * PendingInquiry DAO
 */
class PendingInquiry extends \oms\daos\AbstractDAO
{
    protected $_fields = array(
            'data' => 'json',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_pending_inquiries';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}
