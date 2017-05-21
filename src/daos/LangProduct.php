<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * LangProduct DAO
 */
class LangProduct extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'product_id' => 'int',
            'site_id' => 'int',
            'caption' => 'text',
            'description' => 'text',
            'group_id' => 'int',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
            'tags' => 'text',
            'min_order_quantity' => 'text',
            'delivery_time' => 'text',
            'packaging_details' => 'text',
            'specifications' => 'json',
            'source_url' => 'text',
        );

    private $_langCode = '';

    /** @var array 内置支持的语言代码 */
    private $_supportedLangCodes = array(
            'fr',
        );

    public function __construct($langCode)
    {
        if (!in_array($langCode, $this->_supportedLangCodes))
            throw new \DomainException("Unsupported lang {$langCode}");

        $this->_langCode = $langCode;
    }

    public function getTableName()
    {
        return 'enterprise_' . $this->_langCode . '_products';
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