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
class Thumbnail extends AbstractDAO
{
    protected $_fields = array(
            'image_id' => 'int',
            't' => 'text',
            'm' => 'text',
            'd' => 'text',
            'c' => 'text',
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

    public function updateByImage($imageId, $values)
    {
        $imageId = (int)$imageId;
        $condition = "`image_id`={$imageId}";
        return $this->updateBy($condition, $values);
    }
}
