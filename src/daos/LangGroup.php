<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * LangGroup DAO
 */
class LangGroup extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'group_id' => 'int',
            'site_id' => 'int',
            'name' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'cnt' => 'int',
            'deleted' => 'tinyint',
            'product_html_title' => 'text',
            'product_meta_keywords' => 'text',
            'product_meta_description' => 'text',
        );

    private $_langCode = '';

    public function __construct($langCode)
    {
        $supportedLangCodes = \enterprise\LangCode::getSupportedLangCodes();
        if (!isset($supportedLangCodes[$langCode]))
            throw new \DomainException("Unsupported lang {$langCode}");

        $this->_langCode = $langCode;
    }

    public function getTableName()
    {
        return 'enterprise_' . $this->_langCode . '_groups';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    // Override
    public function get($id)
    {
        $id = (int)$id;
        $condition = "`group_id`={$id}";
        return $this->getOneBy($condition);
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
        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `group_id`={$id}";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException("Fail to query: {$sql}");
    }

    public function incrCnt($id, $incr = 1)
    {
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);

        $id = (int)$id;
        $incr = (int)$incr;
        if ($incr >= 0)
            $setsString = '`cnt`=`cnt`+' . $incr;
        else
            $setsString = '`cnt`=`cnt`' . $incr;

        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `group_id`={$id}";
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

        $sql = "SELECT {$fields} FROM `{$tableName}` AS lg{$forceIndex}
        LEFT JOIN `enterprise_groups` AS g ON g.`id`=lg.`group_id`
        {$condition}{$orderBy}{$limit}";
        return $this->getMultiBySql($sql);
    }

    // Override
    public function countBy($condition, $distinct = null)
    {
        $tableName = $this->getTableName();

        $countBy = ($distinct?'DISTINCT(' . $distinct . ')':0);

        $sql = "SELECT count({$countBy}) FROM `{$tableName}` AS lg WHERE {$condition}";
        return $this->countBySql($sql);
    }

    public function getByIdxLookup($siteId, $pathSum)
    {
        $siteId = (int)$siteId;
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();
        $db = \DbFactory::create($dbName);

        $sql = "SELECT lg.*, g.`id`, g.`path` FROM `{$tableName}` AS lg
        LEFT JOIN `enterprise_groups` AS g ON g.`id`=lg.`group_id`
        WHERE lg.`site_id`={$siteId} AND g.`path_sum`='" . $db->escape_string($pathSum) . "'";
        return $this->getOneBySql($sql);
    }
}
