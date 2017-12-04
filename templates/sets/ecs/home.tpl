<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/trade/common.css?t=201707191624" />
<link type="text/css" rel="stylesheet" href="/media/sets/trade/shop-new.css" />
</head>
<body>
<div class="lang-select">
    <div class="lang-inner fl-clr">
        <ul>
            <li><span>{$corporation.tel_wt}</span>|</li>
            <li><a href="/contactnow.html" rel="nofollow">{$preset_translations.request_a_quote}</a></li>
        </ul>
{include file="sets/trade/common/lang_sites.tpl"}
    </div>
</div>
<!--lang-select-->
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
{include file="sets/ecs/common/navbar.tpl"}
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
        <div class="title"><em><h2>{$preset_translations.all_categories}</h2></em><span><a href="/news">{$preset_translations.view_all}&nbsp;&nbsp;&gt;</a></span></div>
        <ul>
{foreach $news as $n}{if $n@index>=5}{continue}{/if}
            <li>
                <a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}">
                    <img src="{$n.head_image_id|url:'enterprise_url_image':$n.caption:'c'}" alt="{$n.caption}" />
                </a>
                <i><strong><a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}">{$n.caption}</a></strong></i><span><a href="{$n|url:'enterprise_url_news'}">{$preset_translations.see_more}</a><em>&gt;</em></span>
            </li>
{/foreach}
        </ul>
    </div>
    <!--featured-->
    <div class="choose-us">
        <div class="title"><h2>{$preset_translations.why_choose_us}</h2></div>
        <ul>
            <li><span class="icon1"></span><i><a href="/aboutus.html" title="">{$preset_translations.all_about_us}</a></i><em>{$preset_translations.all_about_us_desc}</em></li>
            <li><span class="icon2"></span><i><a href="/contactus.html" title="">{$preset_translations.contact_details}</a></i><em>{$preset_translations.contact_details_desc}</em></li>
            <li><span class="icon3"></span><i><a href="/quality.html" title="">{$preset_translations.quality_control}</a></i><em>{$preset_translations.quality_control_desc}</em></li>
        </ul>
    </div>
    <!--choose-us-->
    <div class="all-categories customer">
        <div class="title"><em><h2>{$preset_translations.our_customer_say}</h2></em></div>
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
{foreach $groups as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index==2&&$main_products|default:[]}{break}{/if}{if $group@index>=3}{break}{/if}
        <dl class="dl{$group@iteration}">
            <dt>{$group.name}</dt>
    {foreach $group.products as $product}
            <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {/foreach}
        </dl>
{/foreach}
{if $main_products|default:[]}
        <dl class="dl3">
            <dt>{$preset_translations.top_products}</dt>
    {foreach $main_products as $mp}
            <dd><a href="{$mp.url}">{$mp.label}</a></dd>
    {/foreach}
        </dl>
{/if}
        <dl class="dl4">
            <dt>{$preset_translations.about_us}</dt>
            <dd><a href="/aboutus.html" rel="nofollow">{$preset_translations.company_profile}</a></dd>
            <dd><a href="/contactus.html" rel="nofollow">{$preset_translations.contact_info}</a></dd>
            <dd><a href="/directory.html" rel="nofollow">{$preset_translations.site_map}</a></dd>
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
{include file="sets/ecs/common/navbar.tpl" position="fixed"}
<!--nav--> 
{include file="sets/trade/common/shopscripts.tpl"}
<script charset="utf-8" type="text/javascript" src="media/sets/trade/search.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/en.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/shop-new.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/ZoomPic.js"></script>
</body>
</html>