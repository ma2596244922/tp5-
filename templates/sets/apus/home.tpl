<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    {include file="sets/trade/common/tdk.tpl"}
    <link href="/media/sets/apus/css/theme.css" rel="stylesheet" type="text/css"/>
</head>
<body>

{include file="sets/apus/common/header.tpl"}

<div style="height:258px; display:block">
    {foreach $banners as $banner}{if $banner@index>=1} break{/if}
    <img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}">
    {/foreach}
</div>
<div class="place bw_1190" id="place">
    <div class="here fl-left">
        <span><a href="/" title="{$preset_translations.home}">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$preset_translations.featured_products}</div>
    </div>
</div>

<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="section"><span class="gorth2">{$preset_translations.featured_products}</span></div>
        <ul class="news-lst fl-clr">
            {foreach $products as $product}
            <li class="fl-clr">
                <div class="nwlf">
                    {$product.created|date_format:'%d'}
                    <span>{$product.created|date_format:'%Y/%m'}</span>
                </div>
                <div class="nwrt">
                    <div class="nwtit"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></div>
                    <div class="nwcon">{$product.description|substr:"120"}...
                    </div>
                    <div class="nwion">
                        {foreach $product.tags|explode:',' as $tag}
                        <a href="{$tag|call:'enterprise_url_product_search'}" title="{$tag}">{$tag}</a>&nbsp;&nbsp;
                        {/foreach}
                    </div>
                </div>
            </li>
            {/foreach}
        </ul>
    </div>
</div>
<!--foot-->
{include file="sets/apus/common/footer.tpl"}

{include file="sets/apus/common/script.tpl"}
</body>
</html>


