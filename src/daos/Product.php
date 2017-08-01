<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Product DAO
 */
class Product extends \crawler\daos\AbstractDAO
{
    protected $_fields = array(
            'site_id' => 'int',
            'caption' => 'text',
            'description' => 'text',
            'group_id' => 'int',
            'locale' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
            'tags' => 'text',
            'brand_name' => 'text',
            'model_number' => 'text',
            'certification' => 'text',
            'place_of_origin' => 'text',
            'min_order_quantity' => 'text',
            'price' => 'text',
            'payment_terms' => 'text',
            'supply_ability' => 'text',
            'delivery_time' => 'text',
            'packaging_details' => 'text',
            'specifications' => 'json',
            'head_image_id' => 'int',
            'images' => 'json',
            'source_url' => 'text',
            'html_title' => 'text',
            'meta_keywords' => 'text',
            'meta_description' => 'text',
            'path' => 'text',
            'path_sum' => 'text',
        );

    public function getTableName()
    {
        return 'enterprise_products';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Product ID
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

    public function getByIdxLookup($siteId, $pathSum)
    {
        $siteId = (int)$siteId;
        $dbName = $this->getDbName();
        $db = \DbFactory::create($dbName);

        $condition = "`site_id`={$siteId} and `path_sum`='" . $db->escape_string($pathSum) . "'";
        return $this->getOneBy($condition);
    }

    public function getIdByIdxLookup($siteId, $pathSum)
    {
        $r = $this->getByIdxLookup($siteId, $pathSum);
        if (!$r)
            return null;

        return $r['id'];
    }
}