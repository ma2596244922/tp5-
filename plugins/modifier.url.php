<?php
/**
 * Smarty plugin
 */

/**
 * Modifier URL
 */
function smarty_modifier_url($string, $function, ...$parameters)
{
    return call_user_func($function, $string, ...$parameters);
}