<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * Site DAO
 */
class Site extends \crawler\daos\AbstractDAO
{
    /** @var int 未知 */
    const TYPE_UNKNOW = 0;
    /** @var int 自营 */
    const TYPE_SELF = 1;
    /** @var int 赠送 */
    const TYPE_AS_A_GIFT = 2;

    private static $_typeLabels = array(
            self::TYPE_SELF => '自营',
            self::TYPE_AS_A_GIFT => '赠送',
        );

    protected $_fields = array(
            'desc' => 'text',
            'guid' => 'text',
            'qq' => 'text',
            'wechat' => 'text',
            'name' => 'text',
            'tel' => 'text',
            'sex' => 'text',
            'vps_id' => 'int',
            'industry_id' => 'int',
            'type' => 'int',
            'csr' => 'text',
            'key' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'crawled' => 'tinyint',
            'enable_translator' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_sites';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Site ID
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

    public static function getTypes()
    {
        return self::$_typeLabels;
    }

    public static function getLabelByType($type)
    {
        if (isset(self::$_typeLabels[$type]))
            return self::$_typeLabels[$type];

        return '其他';
    }
}