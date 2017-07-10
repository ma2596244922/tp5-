<?php
/**
 * Smarty plugin
 */

/**
 * Modifier Base64 Encode
 */
function smarty_modifier_base64_encode($value)
{
    return base64_encode($value);
}