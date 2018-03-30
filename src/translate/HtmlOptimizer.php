<?php
/**
 * Enterprise
 *
 * @package timandes\enterprise
 */

namespace enterprise\translate;

/**
 * Optimize HTML Document
 */
class HtmlOptimizer
{
    private $html = '';
    private $references = [];
    private $affectedNodes = [];
    private $document = null;
    private $sentenceIndexes = [];
    private $translations = [];

    public function __construct($html)
    {
        $this->html = $html;
    }

    public function split()
    {
        $this->references = [];
        $this->affectedNodes = [];
        $this->document = enterprise_translate_split_html($this->html, $this->references, $this->affectedNodes);
        // + Skip entries already in cache
        $sentences = [];
        $this->sentenceIndexes = [];
        $this->translations = [];
        foreach ($this->references as $idx => $ref) {
            $tr = enterprise_translate_cache_get($ref);
            if ($tr)
                $this->translations[$idx] = $tr;
            else {
                $sentences[] = $ref;
                $this->sentenceIndexes[] = $idx;
            }
        }
        return $sentences;
    }

    public function combine($sentences, $fragments)
    {
        // + Fill translations
        foreach ($fragments as $i => $translation) {
            $idx = $this->sentenceIndexes[$i];
            $this->translations[$idx] = $translation;
            enterprise_translate_cache_set($sentences[$i], $translation);
        }
        // + Recover
        return enterprise_translate_combine_fragments($this->document, $this->translations, $this->affectedNodes);
    }
}