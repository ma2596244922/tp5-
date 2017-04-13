<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
{include file="sets/mobile/common/meta.tpl"}
{include file="sets/mobile/common/styles.tpl"}
    </head>
<body>
<body>
<div class="content">
{include file="sets/mobile/common/logobar.tpl"}
{include file="sets/mobile/common/navbar.tpl" page_name="product_list"}
    <div class="title">
        <em><h1>All Products</h1></em>
        <span class="showCategories"></span>
    </div>
    <section class="pro-list">
{foreach $products as $product}
        <div class="classify-detail">
            <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'d'}" alt="{$product.caption|escape}" />
            <dl>
                <dt><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></dt>
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=2}{break}{/if}
        {-if $product.$k|default:$meta.default}
                <dd><label>{$meta.label} : </label>{$product.$k|default:$meta.default}</dd>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
            </dl>
        </div>
        <!--classify-detail-->
{/foreach}
    </section>
</div>
<div class="click-more">
    <p>View More<i></i></p>
</div>
<div class="spinner">
    <div class="bounce1"></div>
    <div class="bounce2"></div>
    <div class="bounce3"></div>
</div>
<!--content-->
{include file="sets/mobile/common/floatingbar.tpl"}
<div class="categories">
    <dl>
        <dt>Product  Categories</dt>
{foreach $groups as $g}
        <dd><a href="{$g|url:'enterprise_url_product_list'}"{if $g.id==$group.id|default:'0'} class="current"{/if} title="{$g.name}">{$g.name}</a></dd>
{/foreach}
    </dl>
</div>
<!--categories-->
<div id="opacity-layer"></div>
{include file="sets/mobile/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/mobile/shopindex.js"></script> 
</body>
</html>