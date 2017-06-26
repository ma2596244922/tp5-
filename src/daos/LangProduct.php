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

    public function __construct($langCode)
    {
        $supportedLangCodes = \enterprise\LangCode::getSupportedLangCodes();
        if (!isset($supportedLangCodes[$langCode]))
            throw new \DomainException("Unsupported lang {$langCode}");

        $this->_langCode = $langCode;
    }

    /**
     * 获取内置支持的语言代码
     *
     * @return array
     */
    public static function getSupportedLangCodes()
    {
        return \enterprise\LangCode::getSupportedLangCodes();
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
        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `product_id`={$id}";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException("Fail to query: {$sql}");
    }

    // Override
    public function getMultiInOrderBy($condition = null, $fields = '*', $orderBy = null, $max = null, $start = 0, $forceIndex = null)
    {
        $tableName = $this->getTableName();

        $limit = '';
        if (null !== $max) {
            $start = (int)$start;
            $max = (int)$max;
            $limit = " LIMIT {$start}, {$max}";
        }
        if ($orderBy)
            $orderBy = ' ORDER BY ' . $orderBy;
        if ($condition)
            $condition = ' WHERE ' . $condition;
        if ($forceIndex)
            $forceIndex = ' FORCE INDEX (' . $forceIndex . ')';

        $sql = "SELECT {$fields} FROM `{$tableName}` AS elp{$forceIndex}
        LEFT JOIN `enterprise_products` AS ep ON ep.`id`=elp.`product_id`
        {$condition}{$orderBy}{$limit}";
        return $this->getMultiBySql($sql);
    }

    // Override
    public function countBy($condition, $distinct = null)
    {
        $tableName = $this->getTableName();

        $countBy = ($distinct?'DISTINCT(' . $distinct . ')':0);

        $sql = "SELECT count({$countBy}) FROM `{$tableName}` AS elp WHERE {$condition}";
        return $this->countBySql($sql);
    }

    public function getByIdxLookup($siteId, $pathSum)
    {
        $siteId = (int)$siteId;
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();
        $db = \DbFactory::create($dbName);
        $fields = ENTERPRISE_LANG_PRODUCT_FIELDS_FOR_LIST;

        $sql = "SELECT {$fields}, elp.`tags`, elp.`description` FROM `{$tableName}` AS elp
        LEFT JOIN `enterprise_products` AS ep ON ep.`id`=elp.`product_id`
        WHERE elp.`site_id`={$siteId} AND ep.`path_sum`='" . $db->escape_string($pathSum) . "'";
        return $this->getOneBySql($sql);
    }
}