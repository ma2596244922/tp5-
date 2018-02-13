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
<div class="footer">
    <div class="foot">
        <ul>
            <li><a href="/aboutus.html" rel="nofollow">{$preset_translations.about_us}</a>|</li>
            <li><a href="/contactus.html" rel="nofollow">{$preset_translations.contact_us}</a>|</li>
            <li><a href="/directory.html">{$preset_translations.site_map}</a></li>
        </ul>
{include file="sets/trade/common/copyright.tpl"}
    </div>
</div>