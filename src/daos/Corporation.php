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
            'site_id' => 'int',
            'name' => 'text',
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
            'overseas_offices' => 'tinyint',
            'main_market_flags' => 'int',
        );

/* {{{ Main Market */
    const MAIN_MARKET_NORTH_AMERICA     = 1;
    const MAIN_MARKET_SOUTH_AMERICA     = 2;
    const MAIN_MARKET_EASTERN_EUROPE    = 4;
    const MAIN_MARKET_SOUTHEAST_ASIA    = 8;
    const MAIN_MARKET_AFRICA            = 16;
    const MAIN_MARKET_OCEANIA           = 32;
    const MAIN_MARKET_MID_EAST          = 64;
    const MAIN_MARKET_EASTERN_ASIA      = 128;
    const MAIN_MARKET_WESTERN_EUROPE    = 256;
    const MAIN_MARKET_CENTRAL_AMERICA   = 512;
    const MAIN_MARKET_NORTHERN_EUROPE   = 1024;
    const MAIN_MARKET_SOUTHERN_EUROPE   = 2048;
    const MAIN_MARKET_SOUTH_ASIA        = 4096;
    const MAIN_MARKET_DOMESTIC_MARKET   = 8192;

    const MAIN_MARKET_ARRAY             = -1;
    const MAIN_MARKET_VALUE             = 0;
    const MAIN_MARKET_LABEL              = 1;

    public static function getMainMarketOptions()
    {
        return [
                self::MAIN_MARKET_NORTH_AMERICA  => 'North America',
                self::MAIN_MARKET_SOUTH_AMERICA  => 'South America',
                self::MAIN_MARKET_EASTERN_EUROPE => 'Eastern Europe',
                self::MAIN_MARKET_SOUTHEAST_ASIA => 'Southeast Asia',
                self::MAIN_MARKET_AFRICA         => 'Africa',
                self::MAIN_MARKET_OCEANIA        => 'Oceania',
                self::MAIN_MARKET_MID_EAST       => 'Mid East',
                self::MAIN_MARKET_EASTERN_ASIA   => 'Eastern Asia',
                self::MAIN_MARKET_WESTERN_EUROPE => 'Western Europe',
                self::MAIN_MARKET_CENTRAL_AMERICA=> 'Central America',
                self::MAIN_MARKET_NORTHERN_EUROPE=> 'Northern Europe',
                self::MAIN_MARKET_SOUTHERN_EUROPE=> 'Southern Europe',
                self::MAIN_MARKET_SOUTH_ASIA     => 'South Asia',
                self::MAIN_MARKET_DOMESTIC_MARKET=> 'Domestic Market',
            ];
    }

    public static function getMainMarketSelections($flags, $component = self::MAIN_MARKET_VALUE)
    {
        $options = self::getMainMarketOptions();
        $retval = [];
        foreach ($options as $value => $label) {
            if ($flags & $value) {
                switch ($component) {
                    case self::MAIN_MARKET_ARRAY:
                        $retval[$value] = $label;
                        break;
                    case self::MAIN_MARKET_LABEL:
                        $retval[] = $label;
                        break;
                    default:
                        $retval[] = $value;
                        break;
                }
            }
        }
        return $retval;
    }

/* }}} */
    public function getTableName()
    {
        return 'enterprise_corporations';
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