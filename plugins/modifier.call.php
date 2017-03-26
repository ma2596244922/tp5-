<?php
/**
 * Smarty plugin
 */

/**
 * Modifier Call
 */
function smarty_modifier_call($value, $function, ...$parameters)
{
    return call_user_func($function, $value, ...$parameters);
}