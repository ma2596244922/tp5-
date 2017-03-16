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

    protected $_fields = array(
            'site_id' => 'int',
            'group_id' => 'int',
            'target_url' => 'text',
            'status' => 'tinyint',
            'deleted' => 'tinyint',
            'created' => 'text',
            'updated' => 'text',
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
}
