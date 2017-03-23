<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Photo DAO
 */
class Photo extends \crawler\daos\AbstractDAO
{
    const TYPE_ABOUT_US = 1;
    const TYPE_PRODUCT_LINE = 2;
    const TYPE_OEM_ODM = 3;
    const TYPE_R_N_D = 4;

    protected $_fields = array(
            'site_id' => 'int',
            'uri' => 'text',
            'desc' => 'text',
            'type' => 'tinyint',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_photos';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Photo ID
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

    public static function getPredefinedTypes()
    {
        return array(
                self::TYPE_ABOUT_US => 'About Us',
                self::TYPE_PRODUCT_LINE => 'Product Line',
                self::TYPE_OEM_ODM => 'OEM/ODM',
                self::TYPE_R_N_D => 'R&D',
            );
    }
}
