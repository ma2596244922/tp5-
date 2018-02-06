<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * TranslationProgress DAO
 */
class TranslationProgress extends AbstractDAO
{
    const STATUS_PENDING = 0;
    const STATUS_IN_PROGRESS = 10;
    const STATUS_FINISHED = 100;
    const STATUS_TERMINATED = 200;

    protected $_fields = array(
            'site_id' => 'int',
            'lang_code' => 'text',
            'status' => 'tinyint',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_translation_progresses';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    public static function status2Text($status)
    {
        switch ($status) {
            case self::STATUS_TERMINATED:
                return '已中止';
            case self::STATUS_FINISHED:
                return '已完成';
            case self::STATUS_IN_PROGRESS:
                return '处理中';
            case self::STATUS_PENDING:
                return '待处理';
            default:
                return '未知';
        }
    }
}
