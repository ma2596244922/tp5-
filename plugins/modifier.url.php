<?php
/**
 * Smarty plugin
 */

/**
 * Modifier URL
 */
function smarty_modifier_url($string, $function)
{
    return call_user_func($function, $string);
}