<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace blowjob\daos;

/**
 * ProductIdentity DAO
 */
class ProductIdentity extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'identity' => 'text',
            'product_id' => 'int',
        );

    public function getTableName()
    {
        return 'blowjob_product_identities';
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

    public function update($identity, $siteId, $values)
    {
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);

        $siteId = (int)$siteId;
        $escapedIdentity = $db->escape_string($identity);
        $sets = $this->buildSetList($db, $values);
        $setsString = implode(',', $sets);
        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `identity`='{$escapedIdentity}' AND `site_id`={$siteId}";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException("Fail to query: {$sql}");
    }
}
