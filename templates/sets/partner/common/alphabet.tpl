{-if $lang_code=='en'}
<!--zimu--> 
<div class="zimu_div">
    <ul>
{foreach $smarty.const.KEYWORD_ALPHABET as $char => $idx}{if !$idx}{continue}{/if}
        <li><a href="{$char|call:'enterprise_url_keyword_list'}" title="{$char}"{if $cur_char|default:''==$char} class="current"{/if}>{$char}</a></li>
{/foreach}
        <li class="allletter"><a href="{'number'|call:'enterprise_url_keyword_list'}" title="0-9">0-9</a></li>
    </ul>
    <div class="fl-clr"></div>
</div>
<!--zimu-->
{-/if}