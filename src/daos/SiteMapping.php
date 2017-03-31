<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * SiteMapping DAO
 */
class SiteMapping extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'domain' => 'text',
            'created' => 'text',
            'updated' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_site_mappings';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int SiteMapping ID
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

    public function delete($id)
    {
        $id = (int)$id;
        $condition = "`id`={$id}";
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);
        $sql = "DELETE FROM `{$tableName}` WHERE {$condition} LIMIT 1";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException($sql);
        return true;
    }
}