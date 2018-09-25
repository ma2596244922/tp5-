<div class="footer_wrap">
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td width="120" valign="top">
                <b>About Us</b>
                <a href="/contactus.html" title="{$preset_translations.contact_us}">{$preset_translations.contact_us}</a>
                <a href="/aboutus.html" title="{$preset_translations.company_profile}">{$preset_translations.company_profile}</a>
            </td>
            {assign var="i" value="0"}
            {foreach $groups as $g}
            {assign var="products_footer" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, $g.id, '', 1, 2) )}
            {if $products_footer && $i<4}
            <td width="{if $i==3}120{else}200{/if}" valign="top">
                <b>{$g.name}</b>
                {foreach $products_footer as $p}{if $p@index>1}{continue}{/if}
                <strong><a href="{$p|url:'enterprise_url_product'}" title="{$p.caption}">{$p.caption}</a></strong>
                {/foreach}
            </td>
            {assign var="i" value=$i+1}
            {/if}
            {/foreach}

        </tr>
    </table>
    <div class="cb"></div>
    {include file="sets/m12/common/alphabet.tpl"}
</div>
<div class="footer_copyright">Copyright © {$site.start_year} - {$smarty.now|date_format:'%Y'} <span class="company-name">{$corporation.name}</span> {$preset_translations.all_rights_reserved} <a href="/directory.html" title="{$preset_translations.site_map}">{$preset_translations.site_map}</a></div>