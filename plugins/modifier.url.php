<?php
/**
 * Smarty plugin
 */

/**
 * Modifier URL
 */
function smarty_modifier_url($value, $function, ...$parameters)
{
    return call_user_func($function, $value, ...$parameters);
}