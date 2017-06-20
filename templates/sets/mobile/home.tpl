<!DOCTYPE html>
<html>
    <head>
        {$site.common_head_fragment}
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
{include file="sets/mobile/common/meta.tpl"}
{include file="sets/mobile/common/definitions.tpl"}
{include file="sets/mobile/common/styles.tpl"}
    </head>
<body class="bj-fff">
<div class="content">
{include file="sets/mobile/common/logobar.tpl"}
{include file="sets/mobile/common/navbar.tpl" page_name="home"}
    <section>
        <ul class="shop-info">
            <li><i class="i1"></i>{$corporation.address}</li>
            <li><i class="i2"></i>{$corporation.no_of_employees}</li>
            <li><i class="i3"></i>{$corporation.annual_sales}</li>
            <li><i class="i4"></i>{$corporation.main_market}</li>
        </ul>
    </section>
    <section class="hot-products">
        <h2 class="title-t">{$preset_translations.hot_products}</h2>
        <ul class="hot-ul fl-clr">
{foreach $products as $product}{if $product@index>=7}{continue}{/if}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a><span class="pro-title"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><strong>{$product.caption}</strong></a></span></li>
{/foreach}
        </ul>
    </section>
</div>
<!--content-->
{include file="sets/mobile/common/footer.tpl"}
{include file="sets/mobile/common/floatingbar.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
{$site.common_fragment}
</body>
</html>