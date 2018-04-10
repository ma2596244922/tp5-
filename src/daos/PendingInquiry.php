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
    const STATUS_APPROVED = 10;
    const STATUS_REJECTED = 20;

    protected $_fields = array(
            'data' => 'json',
            'deleted' => 'tinyint',
            'inquiry_guid' => 'text',
            'status' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_pending_inquiries';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    public static function status2Text($status)
    {
        switch ($status) {
            case self::STATUS_APPROVED:
                return '通过';
            case self::STATUS_REJECTED:
                return '拒绝';
            default:
                return 'N/A';
        }
    }
}
