<?php
/**
 * 翻译公用函数库
 *
 * @package timandes\enterprise
 */

$GLOBALS['gaTranslationCache'] = [];

function enterprise_translate_split_html($html, &$references, &$affectedNodes) : DOMDocument
{
    $document = new \DOMDocument();
    // See:
    //  - http://php.net/manual/en/class.domdocument.php#118509
    //  - https://stackoverflow.com/questions/8218230/php-domdocument-loadhtml-not-encoding-utf-8-correctly
    $convertedHtml = mb_convert_encoding($html, 'HTML-ENTITIES', 'UTF-8');
    @$document->loadHTML($convertedHtml);

    $bodyElementList = $document->getElementsByTagName('body');
    $bodyElement = $bodyElementList->item(0);
    if ($bodyElement)
        enterprise_translate_split_node($document, $bodyElement, $references, $affectedNodes);
    return $document;
}

function enterprise_translate_dom_get_inner_html($document, $node)
{
    $retval = '';
    foreach ($node->childNodes as $n) {
        $retval .= $document->saveHTML($n);
    }
    return $retval;
}

function enterprise_translate_dom_set_inner_html($parent, $html)
{
    // clear
    while ($parent->childNodes->length)
        $parent->removeChild($parent->childNodes->item(0));

    if ($html == strip_tags($html)) {
        $parent->nodeValue = $html;
        return;
    }

    // append
    $tmpDocument = new DOMDocument();
    $tmpDocument->loadHTML($html);
    foreach ($tmpDocument->getElementsByTagName('body')->item(0)->childNodes as $node) {
        $node = $parent->ownerDocument->importNode($node, true);
        $parent->appendChild($node);
    }
}

function enterprise_translate_dom_find_node_with_min_text($document, $node)
{
    $cur = $node;
    while ($node->childNodes->length <= 1
            && $cur->childNodes->item(0)->nodeType != XML_TEXT_NODE
            && $cur->childNodes
            && trim($cur->childNodes->item(0)->textContent) == trim($cur->textContent)) {
        $cur = $cur->childNodes->item(0);
        //var_dump($cur);
    }//exit;
    return $cur;
}

function enterprise_translate_split_node($document, $node, &$references, &$affectedNodes)
{
    if ($node->nodeType != XML_ELEMENT_NODE)
        return;
    if (strtolower($node->nodeName) == 'p'
            && trim($node->textContent)) {
        $targetNode = enterprise_translate_dom_find_node_with_min_text($document, $node);
        $idx = count($references);
        $references[] = enterprise_translate_dom_get_inner_html($document, $targetNode);
        $affectedNodes[] = $targetNode;
        //$targetNode->nodeValue = '${' . $idx . '}';
        return;
    }
    foreach ($node->childNodes as $n) {
        enterprise_translate_split_node($document, $n, $references, $affectedNodes);
    }
}

function enterprise_translate_fake_translate2($srcText)
{
    return $srcText;
}

function enterprise_translate_fake_translate($srcText)
{
    $sentences = explode('<p>', $srcText);
    $retArray = [];
    foreach ($sentences as $idx => $sentence) {
        $retArray[] = $idx;
    }
    return implode('<p>', $retArray);
}

function enterprise_translate_combine_fragments($document, $fragments, $affectedNodes)
{
    foreach ($affectedNodes as $idx => $node) {
        if (!isset($fragments[$idx]))
            continue;
        enterprise_translate_dom_set_inner_html($node, $fragments[$idx]);
    }

    $bodyElementList = $document->getElementsByTagName('body');
    $bodyElement = $bodyElementList->item(0);
    if ($bodyElement)
        return enterprise_translate_dom_get_inner_html($document, $bodyElement);
    else
        return '';
}

/* {{{ Cache */

function enterprise_translate_cache_set($sentence, $translation)
{
    $GLOBALS['gaTranslationCache'][$sentence] = $translation;
}

function enterprise_translate_cache_get($sentence)
{
    return $GLOBALS['gaTranslationCache'][$sentence]??null;
}

function enterprise_translate_cache_clear()
{
    $GLOBALS['gaTranslationCache'] = [];
}

/* }}} */