<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace oms\daos;

/**
 * TranslationProgress DAO
 */
class TranslationProgress extends AbstractDAO
{
    const STATUS_PENDING = 0;
    const STATUS_IN_PROGRESS = 10;
    const STATUS_FINISHED = 100;

    protected $_fields = array(
            'site_id' => 'int',
            'lang_code' => 'text',
            'status' => 'tinyint',
            'created' => 'text',
            'updated' => 'text',
            'deleted' => 'tinyint',
        );

    public function getTableName()
    {
        return 'oms_translation_progresses';
    }

    public function getDbName()
    {
        return 'crawler';
    }
}
