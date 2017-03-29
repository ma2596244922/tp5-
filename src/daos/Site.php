<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Site DAO
 */
class Site extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'template' => 'text',
            'updated' => 'text',
            'start_year' => 'text',
            'common_fragment' => 'text',
            'contactnow_fragment' => 'text',
            'contactsave_fragment' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_sites';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    public function update($siteId, $values)
    {
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);

        $siteId = (int)$siteId;
        $sets = $this->buildSetList($db, $values);
        $setsString = implode(',', $sets);
        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `site_id`={$siteId}";
        $r = $db->query($sql);
        if (!$r)
            throw new \RuntimeException("Fail to query: {$sql}");
    }
}