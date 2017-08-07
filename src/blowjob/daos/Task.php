<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace blowjob\daos;

/**
 * Task DAO
 */
class Task extends \crawler\daos\AbstractDAO
{
    const STATUS_PENDING = 0;
    const STATUS_IN_PROGRESS = 10;
    const STATUS_FINISHED = 100;

    /** @var int 爬取任务 */
    const TYPE_DEFAULT  = 0;
    /** @var int 批量插入关键词 */
    const TYPE_INSERT_KEYWORDS  = 10;
    /** @var int 批量替换关键词 */
    const TYPE_REPLACE_KEYWORDS = 20;
    /** @var int 批量插入产品图 */
    const TYPE_INSERT_IMAGES    = 30;
    /** @var int 批量插入产品描述 */
    const TYPE_INSERT_DESC      = 40;
    /** @var int 批量设置商务条款 */
    const TYPE_REPLACE_TERMS    = 50;

    protected $_fields = array(
            'site_id' => 'int',
            'group_id' => 'int',
            'target_url' => 'text',
            'max_pages' => 'tinyint',
            'status' => 'tinyint',
            'deleted' => 'tinyint',
            'created' => 'text',
            'updated' => 'text',
            'type' => 'tinyint',
            'details' => 'json',
        );

    public function getTableName()
    {
        return 'blowjob_tasks';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Task ID
     */
    public function insert($values)
    {
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);

        $sets = $this->buildSetList($db, $values);
        $setsString = implode(',', $sets);
        $sql = "INSERT INTO `{$tableName}` SET {$setsString}";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException("Fail to query sql(#{$db->errno}, {$db->error}): {$sql}");
        return $db->insert_id;
    }

    public function update($id, $values)
    {
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);

        $id = (int)$id;
        $sets = $this->buildSetList($db, $values);
        $setsString = implode(',', $sets);
        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `id`={$id}";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException("Fail to query: {$sql}");
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

    public static function type2Text($type)
    {
        switch ($type) {
            case self::TYPE_DEFAULT:
                return '爬取任务';
            case self::TYPE_INSERT_KEYWORDS:
                return '批量插入关键词';
            case self::TYPE_REPLACE_KEYWORDS:
                return '批量替换关键词';
            case self::TYPE_INSERT_IMAGES:
                return '批量插入产品图';
            case self::TYPE_INSERT_DESC:
                return '批量插入产品描述';
            default:
                return '未知';
        }
    }
}
