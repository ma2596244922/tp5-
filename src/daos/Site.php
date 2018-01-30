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
            'site_id' => 'int',
            'template' => 'text',
            'updated' => 'text',
            'start_year' => 'text',
            'common_fragment' => 'text',
            'contactnow_fragment' => 'text',
            'contactsave_fragment' => 'text',
            'product_cnt' => 'int',
            'index_products' => 'json',
            'user_voices' => 'json',
            'index_html_title' => 'text',
            'index_meta_keywords' => 'text',
            'index_meta_description' => 'text',
            'desc_4_inquiry_sender' => 'text',
            'product_tdk_scope' => 'tinyint',
            'product_html_title' => 'text',
            'product_meta_keywords' => 'text',
            'product_meta_description' => 'text',
            'contact_content' => 'text',
            'common_head_fragment' => 'text',
            'product_default_image' => 'int',
            'common_bg_image' => 'int',
            'enable_inquiry_checking' => 'tinyint',
            'enable_mobile_sites' => 'tinyint',
            'enable_https' => 'tinyint',
            'offline' => 'tinyint',
            'purl_prefix' => 'text',
            'gurl_prefix' => 'text',
            'favicon' => 'text',
            'default_lang_code' => 'text',
            'lang_codes' => 'json',
            'enable_floating_widget' => 'tinyint',
            'floating_widget_url' => 'text',
            'disable_group_dk' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_sites';
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

    public function incrProductCnt($siteId, $incr = 1)
    {
        $tableName = $this->getTableName();
        $dbName = $this->getDbName();

        $db = \DbFactory::create($dbName);

        $siteId = (int)$siteId;
        $incr = (int)$incr;
        if ($incr >= 0)
            $setsString = '`product_cnt`=`product_cnt`+' . $incr;
        else
            $setsString = '`product_cnt`=`product_cnt`' . $incr;

        $sql = "UPDATE `{$tableName}` SET {$setsString} WHERE `site_id`={$siteId}";
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
}