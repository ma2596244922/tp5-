<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * Task DAO
 */
class Task extends AbstractDAO
{
    const STATUS_PENDING = 0;
    const STATUS_IN_PROGRESS = 10;
    const STATUS_FINISHED = 100;

    protected $_fields = array(
            'status' => 'tinyint',
            'deleted' => 'tinyint',
            'created' => 'text',
            'updated' => 'text',
            'details' => 'json',
        );

    public function getTableName()
    {
        return 'oms_tasks';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    public function testStatus($status)
    {
        $validStatus = array(
                self::STATUS_PENDING, self::STATUS_IN_PROGRESS, self::STATUS_FINISHED,
            );
        return in_array($status, $validStatus);
    }

    public static function status2Text($status)
    {
        switch ($status) {
            case self::STATUS_FINISHED:
                return '已完成';
            case self::STATUS_IN_PROGRESS:
                return '处理中';
            default:
                return '待处理';
        }
    }
}
