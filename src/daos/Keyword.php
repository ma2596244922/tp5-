<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Keyword DAO
 */
class Keyword extends AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'keyword' => 'text',
            'has_desc' => 'tinyint',
            'desc' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
            'alphabet' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_keywords';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Keyword ID
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

}