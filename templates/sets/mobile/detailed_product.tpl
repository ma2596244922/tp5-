<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
{include file="sets/mobile/common/meta.tpl"}
        <link type="text/css" rel="stylesheet" href="/media/sets/mobile/shop-product.css">
    </head>
<body>
<header class="title-header">
    <a href="{$product|url:'enterprise_url_product'}" class="back"></a>
    <span>Product Details</span>
</header>
<!--header-->
<div class="content">  
   <div class="product-detail product-detail1">
       <div class="product-title">
           <span><h1 title="">{$product.caption}</h1></span>
       </div>
       <!--product-title-->
       <table cellpadding="0" cellspacing="0">
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $product.$k|default:$meta.default}
           <tr>
               <td>{$preset_translations.$k}</td>
               <td>{if $meta.default}<em>{/if}{$product.$k|default:$meta.default}{if $meta.default}</em>{/if}</td>
           </tr>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
       </table>
   </div>
   <!--product-detail-->
    <section class="product-features">
        <div class="title"><h2>Product Features</h2></div>
        <article>
            {$product.description}
        </article>
    </section>
    <!--recom-products-->
{include file="sets/mobile/common/main_products.tpl"}
</div>
<!--content-->
{include file="sets/mobile/common/floatingbar.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
{$site.common_fragment}
</body>
</html>