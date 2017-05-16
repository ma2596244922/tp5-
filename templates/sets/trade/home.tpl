<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/trade/common.css" />
<link type="text/css" rel="stylesheet" href="/media/sets/trade/shop-new.css" />
</head>
<body>
<div class="request-quote">
    <div class="inner-content">
        <p><span><em></em>{$corporation.tel_wt}</span>|<a href="/contactnow.html" rel="nofollow">Request a quote</a></p>
    </div>
</div>
<!--request-quote-->
<div class="header">
    <div class="head">
        <div class="logo">
            <h1 title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name|escape}" /></h1>
            <div class="logo-right">
                <span class="company-name">{$corporation.name}</span>
                <span class="company-intro">{$corporation_slogan}</span>
            </div>
        </div>
    </div>
    <!--head-->
</div>
<!--header-->
<div class="content">
{include file="sets/trade/common/navbar.tpl"}
    <!--nav-->
    <div class="banner" id="banner">
        <div class="inner">
{foreach $banners as $banner}
            <a href="{$banner.link}" class="d1" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a>
{/foreach}
        </div>
        <ul class="number" id="banner_id">
{foreach $banners as $banner}
            <li{if $banner@index==0} class="current"{/if}></li>
{/foreach}
        </ul>
    </div>
    <!--banner-->
    <div class="all-categories">
        <div class="title"><em><h2>ALL CATEGORIES</h2></em><span><a href="/products.html">View All&nbsp;&nbsp;&gt;</a></span></div>
        <ul>
{foreach $groups as $group}{if $group@index>=5}{continue}{/if}
            <li>
                <a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">
                    <img src="{$group.products[0].head_image_id|url:'enterprise_url_image':$group.products[0].caption:'c'}" alt="{$group.products[0].caption}" />
                </a>
                <i><strong><a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">{$group.products[0].caption}</a></strong></i><span><a href="{$group|url:'enterprise_url_product_list'}">See More</a><em>&gt;</em></span></li>
{/foreach}
        </ul>
    </div>
    <!--all-categories-->
    <div class="all-categories featured">
        <div class="title"><em><h2>FEATURED PRODUCTS</h2></em></div>
        <p>China Manufacturer with main products: {if $groups[0]|default:[]}{$groups[0].name}{if $groups[1]|default:[]}, {$groups[1].name}{if $groups[2]|default:[]}, {$groups[2].name}{/if}{/if}{/if}</p>
        <ul class="fl-clr">
{foreach $products as $product}
            <li>
                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$group.products[0].caption:'c'}" alt="{$product.caption}" /></a>
                <i><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></strong></i>
            </li>
{/foreach}
        </ul>
    </div>
    <!--featured-->
    <div class="choose-us">
        <div class="title"><h2>WHY CHOOSE US</h2></div>
        <ul>
            <li><span class="icon1"></span><i><a href="/aboutus.html" title="">All about us</a></i><em>Our aim is to provide you with the tour service of the top quality, and we'll d o our</em></li>
            <li><span class="icon2"></span><i><a href="/contactus.html" title="">Contact details</a></i><em>Our aim is to provide you with the tour service of the top quality</em></li>
            <li><span class="icon3"></span><i><a href="/quality.html" title="">Quality control</a></i><em>cotton bedding sets ,bamboo pillows ,bamboo blankets ,polyester quilts</em></li>
        </ul>
    </div>
    <!--choose-us-->
    <div class="all-categories customer">
        <div class="title"><em><h2>OUR CUSTOMER SAY</h2></em></div>
        <div id="focus_Box">
            <span class="prev"></span>
            <span class="next"></span>
            <ul>
{foreach $user_voices as $uv}
                <li data-idx="{$uv@iteration}"{if $uv@index!=0} class="gray"{/if}>
                    <a href="javascript:void(0)" title=""><img width="99" height="100" alt="" src="{if $uv.avatar_image_id|default:''}{$uv.avatar_image_id|default:''|url:'enterprise_url_image':{$uv.title|default:''}:'m'}{else}/media/sets/trade/customer{$uv@iteration}.png{/if}"/></a>
                </li>
{/foreach}
            </ul>
            <div class="focus-text">
{foreach $user_voices as $uv}
                <dl data-idx="{$uv@iteration}"{if $uv@index==0} style="display: block;"{/if}>
                    <dt>{$uv['title']}</dt>
                    <dd>{$uv['voice']}</dd>
                </dl>
{/foreach}
            </div>
        </div>
    </div>
    <!--all-categories-->
</div>
<!--content-->
<div class="service-box">
    <div class="service-list fl-clr">
{foreach $groups as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index>=3}{continue}{/if}
        <dl class="dl{$group@iteration}">
            <dt>{$group.name}</dt>
    {foreach $group.products as $product}
            <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {/foreach}
        </dl>
{/foreach}
        <dl class="dl4">
            <dt>About</dt>
            <dd><a href="/aboutus.html" rel="nofollow">Company Profile</a></dd>
            <dd><a href="/contactus.html" rel="nofollow">Contact Info</a></dd>
            <dd><a href="/directory.html" rel="nofollow">Site Map</a></dd>
        </dl>
    </div>
</div>
<!--service-box-->
<div class="footer">
    <div class="foot">
{include file="sets/trade/common/copyright.tpl"}
    </div>
</div>
<!--footer-->
{include file="sets/trade/common/navbar.tpl" position="fixed"}
<!--nav--> 
{include file="sets/trade/common/shopscripts.tpl"}
<script charset="utf-8" type="text/javascript" src="media/sets/trade/search.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/en.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/shop-new.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/ZoomPic.js"></script>
</body>
</html>