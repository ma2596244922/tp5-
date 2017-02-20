<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Thumbnail DAO
 */
class Thumbnail extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'image_id' => 'int',
            '378x270' => 'text',
            '54x39' => 'text',
            '140x100' => 'text',
            '329x235' => 'text',
            'created' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_thumbnails';
    }

    public function getDbName()
    {
        return 'crawler';
    }

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
    }
}
