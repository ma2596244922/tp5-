<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
        <meta name="viewport" content="initial-scale=1,maximum-scale=1, minimum-scale=1">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black" />
        <link type="text/css" rel="stylesheet" href="/media/sets/mobile/shop-index.css">
    </head>
<body class="bj-fff">
<div class="content">
    <div class="logo-bar">
        <a href="/"><img src="{$corporation.logo|url:'enterprise_url_image'}" class="logo-img"></a>
        <h1 class="logo-name">{$corporation.name}</h1>
    </div>
    <ul class="top-nav">
        <li class="hover"><a href="/">Home</a></li>
        <li><a href="/products.html">Product</a></li>
        <li><a href="/aboutus.html">About</a></li>
        <li><a href="/contactus.html">Contacts</a></li>
    </ul>
    <section>
        <ul class="shop-info">
            <li><i class="i1"></i>{$corporation.address}</li>
            <li><i class="i2"></i>{$corporation.no_of_employees}</li>
            <li><i class="i3"></i>{$corporation.annual_sales}</li>
            <li><i class="i4"></i>{$corporation.main_market}</li>
        </ul>
    </section>
    <section class="hot-products">
        <h2 class="title-t">Hot Products</h2>
        <ul class="hot-ul fl-clr">
{foreach $products as $product}{if $product@index>=7}{continue}{/if}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a><span class="pro-title"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><strong>{$product.caption}</strong></a></span></li>
{/foreach}
        </ul>
    </section>
</div>
<!--content-->
<footer>
    <p class="links"><a href="/">Home</a>|<a href="/products.html">Products</a>|<a href="http://www.{$site_root_domain}/">PC Sites</a></p>
{include file="sets/trade/common/copyright.tpl"}
</footer>
<div class="bh_81">
    <div class="pop-button"><a href="/products.html" class="all">All Products</a><a href="/contactnow.html" class="now">Contact Now</a></div>
</div>
<!--footer-->
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/jquery.min.js"></script> 
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/mobile/common.js"></script> 
</body>
</html>