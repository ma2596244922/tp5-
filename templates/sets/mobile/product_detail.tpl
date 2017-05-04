<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
{include file="sets/mobile/common/meta.tpl"}
{include file="sets/mobile/common/definitions.tpl"}
        <link type="text/css" rel="stylesheet" href="/media/swiper/3.3.1/swiper.css">
        <link type="text/css" rel="stylesheet" href="/media/sets/mobile/shop-product.css">
    </head>
<body>
<div class="content">
   <div class="banner">
       <div class="swiper-container">
            <ul class="swiper-wrapper" style=" width:1000%">
{-if $product_images}
    {-foreach $product_images as $image_id}
                <li class="swiper-slide">
                    <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" width="100%" alt="{$product.caption|default:''|escape}">
                </li>
    {-/foreach}
{-else}
                <li class="swiper-slide">
                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" width="100%" alt="{$product.caption|default:''|escape}">
                </li>
{-/if}
            </ul>
            <div class="swiper-pagination"></div>
        </div>
        <!--swiper-container-->
   </div>
   <!--banner-->
   <div class="product-title">
       <span><h1 title="">{$product.caption}</h1></span>
   </div>
   <!--product-title-->
   <div class="product-detail">
       <table cellpadding="0" cellspacing="0" class="table1">
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=5}{break}{/if}
        {-if $product.$k|default:$meta.default}
           <tr>
               <td>{$meta.label}</td>
               <td>{if $meta.default}<em>{/if}{$product.$k|default:$meta.default}{if $meta.default}</em>{/if}</td>
           </tr>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
       </table>
       <section><a href="{$product|url:'enterprise_url_detailed_product'}" class="show-more">View More</a></section>
   </div>
   <!--product-detail-->
   <div class="product-detail">
       <div class="title"><h2>Company Profile</h2></div>
       <div class="company-name"><a href="/aboutus.html">{$corporation.name}</a></div>
       <table cellpadding="0" cellspacing="0">
{-if $corporation.worktime|default:''}
           <tr>
               <td valign="top">Worktime</td>
               <td>{$corporation.worktime}</td>
           </tr>
{-/if}
{-if $corporation.tel_wt|default:''}
           <tr>
               <td valign="top">Business Phone</td>
               <td>{$corporation.tel_wt}</td>
           </tr>
{-/if}
{-if $corporation.fax|default:''}
           <tr>
               <td valign="top">Fax</td>
               <td>{$corporation.fax}</td>
           </tr>
{-/if}
       </table>
       <section><a href="/aboutus.html" class="show-more">View More</a></section>
   </div>
   <!--product-detail-->
   <section class="recom-products">
        <div class="title"><h2>Recommended Products</h2></div>
        <ul class="fl-clr">
{foreach $new_products as $product}{if $product@index>=6}{break}{/if}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}" /></a><span class="pro-title"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><strong>{$product.caption}</strong></a></span></li>
{/foreach}
        </ul>
    </section>
    <!--recom-products-->
</div>
<!--content-->
{include file="sets/mobile/common/floatingbar.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/swiper/3.3.1/swiper.jquery.min.js"></script>
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/mobile/shop-product.js"></script>
{$site.common_fragment}
</body>
</html>