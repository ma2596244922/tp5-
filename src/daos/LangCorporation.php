<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * LangCorporation DAO
 */
class LangCorporation extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'name' => 'text',
            'address' => 'text',
            'factory_address' => 'text',
            'updated' => 'text',
            'business_type' => 'text',
            'main_market' => 'text',
            'brands' => 'text',
            'no_of_employees' => 'text',
            'annual_sales' => 'text',
            'year_established' => 'text',
            'export_p_c' => 'text',
            'introduction' => 'text',
            'history' => 'text',
            'service' => 'text',
            'our_team' => 'text',
            'qc_profile' => 'text',
            'slogan' => 'text',
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
        return 'enterprise_' . $this->_langCode . '_corporations';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    // Override
    public function get($id)
    {
        $id = (int)$id;
        $condition = "`site_id`={$id}";
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

    public function getBySite($siteId)
    {
        $condition = "`site_id`=" . (int)$siteId;
        return $this->getOneBy($condition);
    }
}