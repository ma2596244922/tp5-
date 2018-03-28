<?php
/**
 * Smarty plugin
 */

/**
 * Block Group List
 */
function smarty_block_group_list($params, $content, $smarty, &$repeat)
{
    static $groups = null;
    static $idx = -1;

    $siteId = $params['site_id']??0;
    if (!$siteId)
        $smarty->trigger_template_error("Attr 'id' is missing");
    $langCode = $params['lang']??'en';
    $max = $params['max']??null;
    $maxProducts = $params['max_products']??null;
    $appendFirstProducts = isset($maxProducts);

    if ($repeat) {// Begin of block
        $groups = enterprise_get_group_list_ex($siteId, $langCode, $max, '', true, $appendFirstProducts, $maxProducts);
        if (!$groups)
            $repeat = false; // Stop processing
        $idx = 0;
        $smarty->assign('group', $groups[$idx]);
        $smarty->assign('index', $idx);
        return;
    }

    // End of block
    if (array_key_exists(++$idx, $groups)) {
        $repeat = true; // Continue
        $smarty->assign('group', $groups[$idx]);
        $smarty->assign('index', $idx);
    } else {// Clean up
        $groups = null;
        $idx = -1;
    }

    return $content;
}