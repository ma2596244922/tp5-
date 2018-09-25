    <!--foot-->
    <div class="foot_0">
        <div class="foot fl-clr">
            <dl class="fl-clr">
                <dt>
                    <span>{$corporation.name}</span></dt>
                <dd>Mobile : {$contacts[0].tel} </dd>
                <dd>{$preset_translations.website} : {$canonical_host} </dd>
                <dd>{$preset_translations.telephone} : {$corporation.tel_wt} </dd>
                <dd>Mail : {$contacts[0].email}</dd>
                <dd>{$preset_translations.fax} : {$corporation.fax}</dd>
                <dd>{$preset_translations.address} : {$corporation.address} </dd>
            </dl>
            <dl class="fl-clr popular-pro">
                <dt>
                    <span>Most Popular</dt>
                {assign var="products_new" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, '', '', 1, 16) )}
                 {foreach $products_new as $product}{if $product@index>=10}{break}{/if}
                 <dd><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><strong>{$product.caption}</strong></a></dd>
                {/foreach}
            </dl>
        </div>
        {include file="sets/june-sky/common/alphabet.tpl"}
        <p class="zhichi">Copyright © {$site.start_year} - {$smarty.now|date_format:'%Y'}<span class="company-name">{$corporation.name}</span> {$preset_translations.all_rights_reserved}</p>
    </div>
    
    <!--  浮动层    -->
    {if $site.enable_floating_widget|default:'0'}
    <div class="sideBar" id="1">
        <span class="close">online service</span>
        <div class="txt">
            <div class="phone">
                <p>{$contacts[0].tel}</p>
                <p>{$corporation.tel_wt}</p>
            </div>
            <div class="pa_10_15">
                <a href="/contactnow.html{if $cur=='product_detail'}?about_product={$product.id}{/if}" rel="nofollow" target="_blank" class="a xp">
                    <span>{$preset_translations.request_a_quote}</span>
                </a>
            </div>
            <a class="top" id="back-to-top" href="javascript:;">Top</a>
        </div>
    </div>
    {/if}