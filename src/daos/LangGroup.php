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
}
