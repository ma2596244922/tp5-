<?php
/**
 * Smarty plugin
 */

/**
 * Modifier JSON Encode
 */
function smarty_modifier_json_encode($value)
{
    return json_encode($value);
}