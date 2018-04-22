<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Group DAO
 */
class Group extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'name' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'cnt' => 'int',
            'deleted' => 'tinyint',
            'path' => 'text',
            'path_sum' => 'text',
            'purl_prefix' => 'text',
            'product_html_title' => 'text',
            'product_meta_keywords' => 'text',
            'product_meta_description' => 'text',
            'html_title' => 'text',
            'meta_keywords' => 'text',
            'meta_description' => 'text',
            'desc' => 'text',
            'product_give_h1_to' => 'tinyint',
            'product_video_uri' => 'text',
            'product_video_cover_uri' => 'text',
            'product_video_duration' => 'text',
            'ranking' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_groups';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Group ID
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

        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `id`={$id}";
        try {
            $r = $db->query($sql);
        } catch (\mysqli_sql_exception $mse) {
            if ($mse->getCode() != 1690) // BIGINT UNSIGNED value is out of range
                throw $mse;
            $r = true;
        }
        if (!$r
                && $db->errno != 1690)
            throw new \RuntimeException("Fail to query: {$sql}");
    }

    public function getByIdxLookup($siteId, $pathSum)
    {
        $siteId = (int)$siteId;
        $dbName = $this->getDbName();
        $db = \DbFactory::create($dbName);

        $condition = "`site_id`={$siteId} and `path_sum`='" . $db->escape_string($pathSum) . "'";
        return $this->getOneBy($condition);
    }
}
