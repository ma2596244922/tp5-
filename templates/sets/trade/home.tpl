<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Quality {$groups[0].name|default:''}{if $groups[1]|default:[]} & {$groups[1].name}{/if} Manufacturer</title>
<meta name="keywords" content="Quality {$groups[0].name|default:''} manufacturer{if $groups[1]|default:[]}, {$groups[1].name} wholesaler,{/if} China {$groups[0].name|default:''} manufacturer{if $groups[1]|default:[]}, China {$groups[1].name} exporter{/if}">
<meta name="description" content="Jinan leader machinery co.,ltd is best {$groups[0].name|default:''}{if $groups[1]|default:[]}, {$groups[1].name}{if $groups[2]|default:[]} and {$groups[2].name} supplier,{/if}{/if} we has good quality products & service from China.">
<link type="text/css" rel="stylesheet" href="/media/sets/trade/common.css" />
<link type="text/css" rel="stylesheet" href="/media/sets/trade/shop-new.css" />
</head>
<body>
<div class="request-quote">
    <div class="inner-content">
        <p><span><em></em>{$corporation.tel_wt}</span>|<a href="/contactnow.html">Request a quote</a></p>
    </div>
</div>
<!--request-quote-->
<div class="header">
    <div class="head">
        <div class="logo">
        <h1 title=""><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="" /></h1>
        <span>{$corporation.name}</span>
        </div>
    </div>
    <!--head-->
</div>
<!--header-->
<div class="content">
{include file="sets/trade/common/navbar.tpl"}
    <!--nav-->
    <div class="banner" id="banner">
{foreach $banners as $banner}
        <a href="{$banner.link}" class="d1" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a>
{/foreach}
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
{foreach $groups as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index>=5}{continue}{/if}
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
        <p>China Manufacturer with main products:girls frocks ,children costume ,girls party dress ,children clothing ,girl's dress</p>
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
            <li><span class="icon1"></span><i><a href="#" title="">All about us</a></i><em>Our aim is to provide you with the tour service of the top quality, and we'll d o our</em></li>
            <li><span class="icon2"></span><i><a href="#" title="">Contact details</a></i><em>Our aim is to provide you with the tour service of the top quality</em></li>
            <li><span class="icon3"></span><i><a href="#" title="">Quality control</a></i><em>cotton bedding sets ,bamboo pillows ,bamboo blankets ,polyester quilts</em></li>
        </ul>
    </div>
    <!--choose-us-->
    <div class="all-categories customer">
        <div class="title"><em><h2>OUR CUSTOMER SAY</h2></em></div>
        <div id="focus_Box">
            <span class="prev"></span>
            <span class="next"></span>
            <ul>
                <li data-idx="1">
                    <a href="javascript:void(0)" title=""><img width="99" height="100" alt="" src="//himg.china.cn/img/env2/main/shop/customer1.png"/></a>
                </li>
                <li data-idx="2" class="gray">
                    <a href="javascript:void(0)" title=""><img width="99" height="100" alt="" src="//himg.china.cn/img/env2/main/shop/customer2.png"/></a>
                </li>
                <li data-idx="3" class="gray">
                    <a href="javascript:void(0)" title=""><img width="99" height="100" alt="" src="//himg.china.cn/img/env2/main/shop/customer3.png"/></a>
                </li>
            </ul>
            <div class="focus-text">
                <dl data-idx="1" style="display:block;">
                    <dt>123</dt>
                    <dd>1We, Shengkun Silk, covers an area of 10,000M2, is one of the earliest and leading manufa cturers of 100% handmade silk quilts in China. In ancient times</dd>
                </dl>
                <dl data-idx="2">
                    <dt>Lisa</dt>
                    <dd>2We, Shengkun Silk, covers an area of 10,000M2, is one of the earliest and leading manufa cturers of 100% handmade silk quilts in China. In ancient times</dd>
                </dl>
                <dl data-idx="3">
                    <dt>456</dt>
                    <dd>3We, Shengkun Silk, covers an area of 10,000M2, is one of the earliest and leading manufa cturers of 100% handmade silk quilts in China. In ancient times</dd>
                </dl>
            </div>
        </div>
    </div>
    <!--all-categories-->
</div>
<!--content-->
<div class="service-box">
    <div class="service-list fl-clr">
        <dl class="dl1">
            <dt>Buy on china.cn</dt>
            <dd><a href="https://trade.china.cn/help/buy.html" data-scode="10015" rel="nofollow">How to buy</a></dd>
            <dd><a href="https://trade.china.cn/product/" data-scode="10015">Browse by catagories</a></dd>
            <dd><a href="https://trade.china.cn/suppliers/" data-scode="10015">Browse by Hot regoins</a></dd>
            <dd><a href="https://trade.china.cn/selling-leads/" data-scode="10015" rel="nofollow">Private Sourcing Events</a></dd>
        </dl>
        <dl class="dl2">
            <dt>Selling on</dt>
            <dd><a href="https://trade.china.cn/help/sell.html" data-scode="10016" rel="nofollow">How to sell</a></dd>
            <dd><a href="https://user.china.cn/index.php?op=sellgroup" target="_blank" data-scode="10016" rel="nofollow">Premium Member</a></dd>
            <dd><a href="https://user.china.cn/index.php?op=releaseproduct" target="_blank" data-scode="10016" rel="nofollow">Post Products</a></dd>
            <dd><a href="https://user.china.cn/index.php?op=sellinfolist" target="_blank" data-scode="10016" rel="nofollow">Manage Products</a></dd>
        </dl>
        <dl class="dl3">
            <dt>Services</dt>
            <dd><a href="https://trade.china.cn/inquiry-list/" rel="nofollow" data-scode="10017">Post buying lead</a></dd>
            <dd><a href="https://trade.china.cn/help/Dispute_Complaint.html" rel="nofollow" data-scode="10017">Product Alert</a></dd>
        </dl>
        <dl class="dl4">
            <dt>About</dt>
            <dd><a href="https://trade.china.cn/about/about_us.html" rel="nofollow" data-scode="10018">About us</a></dd>
            <dd><a href="https://trade.china.cn/about/link_us.html" rel="nofollow" data-scode="10018">Link to us</a></dd>
            <dd><a href="https://trade.china.cn/about/contact_us.html" rel="nofollow" data-scode="10018">Contact us</a></dd>
            <dd><a href="https://trade.china.cn/about/site_map.html" data-scode="10018">Site map</a></dd>
        </dl>
    </div>
</div>
<!--service-box-->
<div class="footer">
    <div class="foot">
        <p>China Good Quality {$groups[0].name|default:''} Supplier.            Copyright © {$site.start_year} - {$smarty.now|date_format:'%Y'} {$site_root_domain}. All Rights Reserved.</p>
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