<?php
/**
 * Smarty plugin
 */

/**
 * Modifier Size Format
 */
function smarty_modifier_size_format($size, $unitIndex = 0)
{
    $unitArray = ['B', 'KB', 'MB', 'GB'];
    if ($size > 1024) {
        $s = $size / 1024;
        return smarty_modifier_size_format($s, $unitIndex + 1);
    } else
        return number_format($size, 1) . $unitArray[$unitIndex];
}
