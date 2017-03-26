<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * Contact DAO
 */
class Contact extends \crawler\daos\AbstractDAO
{
    const COURTESY_TITLE_MR = 0;
    const COURTESY_TITLE_MRS = 1;
    const COURTESY_TITLE_MISS = 2;
    const COURTESY_TITLE_MS = 3;

    protected $_fields = array(
            'site_id' => 'int',
            'name' => 'text',
            'title' => 'text',
            'tel' => 'text',
            'skype' => 'text',
            'email' => 'text',
            'yahoo' => 'text',
            'icq' => 'text',
            'viber' => 'text',
            'whatsapp' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'enterprise_contacts';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    /**
     * @return int Contact ID
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

    public static function courtesyTitle2Text($courtesyTitle)
    {
        switch ($courtesyTitle) {
            case self::COURTESY_TITLE_MS:
                return 'Ms.';
            case self::COURTESY_TITLE_MISS:
                return 'Miss.';
            case self::COURTESY_TITLE_MRS:
                return 'Mrs.';
            default:
                return 'Mr.';
        }
    }
}
