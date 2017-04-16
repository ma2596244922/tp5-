<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Image DAO
 */
class Image extends AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'body' => 'text',
            'created' => 'text',
            'body_sum' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_images';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Image ID
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

    public function getByBodySum($sum)
    {
        $condition = "`body_sum`='" . $this->escape($sum) . "'";
        return $this->getOneBy($condition);
    }
}
