<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\daos;

/**
 * LangUserVoice DAO
 */
class LangUserVoice extends \oms\daos\AbstractDAO
{
    protected $_fields = array(
            'user_voice_id' => 'int',
            'site_id' => 'int',
            'title' => 'text',
            'voice' => 'text',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
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
        return 'enterprise_' . $this->_langCode . '_user_voices';
    }

    public function getDbName()
    {
        return 'crawler';
    }

    // Override
    public function get($id)
    {
        $id = (int)$id;
        $condition = "`user_voice_id`={$id}";
        return $this->getOneBy($condition);
    }

    // Override
    public function update($id, $values)
    {
        $id = (int)$id;
        $condition = "`user_voice_id`={$id}";
        return $this->updateBy($condition, $values);
    }

    // Override
    public function getMultiInOrderBy($condition = null, $fields = '*', $orderBy = null, $max = null, $start = 0, $forceIndex = null)
    {
        $tableName = $this->getTableName();

        $limit = '';
        if (null !== $max) {
            $start = (int)$start;
            $max = (int)$max;
            $limit = " LIMIT {$start}, {$max}";
        }
        if ($orderBy)
            $orderBy = ' ORDER BY ' . $orderBy;
        if ($condition)
            $condition = ' WHERE ' . $condition;
        if ($forceIndex)
            $forceIndex = ' FORCE INDEX (' . $forceIndex . ')';

        $sql = "SELECT {$fields} FROM `{$tableName}` AS eluv{$forceIndex}
        LEFT JOIN `enterprise_user_voices` AS euv ON euv.`id`=eluv.`user_voice_id`
        {$condition}{$orderBy}{$limit}";
        return $this->getMultiBySql($sql);
    }
}