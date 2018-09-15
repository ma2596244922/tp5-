<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    {include file="sets/june-sky/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="product_list"}
    {include file="sets/june-sky/common/styles.tpl"}
</head>
<body>
{include file="sets/june-sky/common/header.tpl" cur="product"}
<!-- header -->

<div style="background:url(/media/sets/june-sky/img/bn_cp.jpg) no-repeat center center; height:258px; display:block"></div>
<div class="place bw_1190" id="place">
    <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{-if $group|default:[]}{$group.name}{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.products}{-/if}</div>
    </div>
</div>

<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="content_left">
            {include file="sets/june-sky/common/product_left.tpl"}
        </div>
        <div class="content_right">
            <div class="section"> <span class="gorth2">{-if $group|default:[]}<h1>{$group.name}</h1>{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.all_products}{-/if}&nbsp;({$total_products})</span></div>
            <div class="right-content">
{include file="sets/june-sky/common/list.tpl"}
                <!--products-box-->
<!--{include file="sets/june-sky/common/pager.tpl"}-->
                <!--view-page-->
            </div>
            <ul class="product_ul fl-clr">
                {foreach $products as $product}
                <li> <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"> <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" title="{$product.caption}" width="250" height="250"> </a>
                    <p class="jg">{if $product.price}$<span>{$product.price}</span>{else}Negotiation{/if}</p>
                    <p class="a"> <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a> </p>
                </li>
                {foreachelse}
                <p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
                {/foreach}
            </ul>
            {include file="sets/june-sky/common/pager_product.tpl"}
            
        </div>
    </div>
    {include file="sets/june-sky/common/hidden_groups.tpl"}
</div>

{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl" page_name="product"}

</body>
</html>