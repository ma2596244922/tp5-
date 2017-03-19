<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Corporation DAO
 */
class Corporation extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'corporation_name' => 'text',
            'address' => 'text',
            'factory_address' => 'text',
            'worktime' => 'text',
            'tel_wt' => 'text',
            'tel_nwt' => 'text',
            'fax' => 'text',
            'skype' => 'text',
            'email' => 'text',
            'yahoo' => 'text',
            'logo' => 'int',
            'updated' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_corporations';
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