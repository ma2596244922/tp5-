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
        <div class="title"><em><h2>{$preset_translations.all_categories}</h2></em><span><a href="/products.html">{$preset_translations.view_all}&nbsp;&nbsp;&gt;</a></span></div>
        <ul>
{foreach $groups as $group}{if $group@index>=5}{continue}{/if}
            <li>
                <a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">
                    <img src="{$group.products[0].head_image_id|url:'enterprise_url_image':$group.products[0].caption:'c'}" alt="{$group.products[0].caption}" />
                </a>
                <i><strong><a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">{$group.products[0].caption}</a></strong></i><span><a href="{$group|url:'enterprise_url_product_list'}">{$preset_translations.see_more}</a><em>&gt;</em></span></li>
{/foreach}
        </ul>
    </div>
    <!--all-categories-->
    <div class="all-categories featured">
        <div class="title"><em><h2>{$preset_translations.featured_products}</h2></em></div>
        <p>{$preset_translations.china_manufacturer_with_main_products}: {if $groups[0]|default:[]}{$groups[0].name}{if $groups[1]|default:[]}, {$groups[1].name}{if $groups[2]|default:[]}, {$groups[2].name}{/if}{/if}{/if}</p>
        <ul class="fl-clr">
{foreach $products as $product}
            <li>
                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$groups[0].products[0].caption:'c'}" alt="{$product.caption}" /></a>
                <i><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></strong></i>
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
    <!--guanjianci-->
    <style>{literal}
    .gjc_div { background:#f1f2f4; width:100%; padding-bottom:50px;}
    .gjc_div_box { width:980px; margin:0 auto; overflow: hidden;}
    .gjc_div .title,.zimu_div .title{ width:980px; height:34px; line-height:34px; margin:60px auto 35px auto; font-size:30px; color:#414141; text-align:center;}
    .gjc_div_box ul { width:1000px; height:100px; overflow:hidden }
    .gjc_div_box ul li em { width: 4px;  height: 4px;display: block;  float: left; margin: 8px 8px 0 0;  border: solid 1px #a0a0a0;  border-radius: 50px;  vertical-align: 2px; }
    .gjc_div_box ul li { float:left; width: 230px; height: 40px; margin-right:20px; }
    .gjc_div_box ul a { color:#525355; float:left;width: 210px; text-overflow: ellipsis;overflow: hidden;white-space: nowrap; display:block }
    .gjc_div_box ul li a:hover { color: #6c7c93}
    .gjc_div_box .cur{ height:auto;}
    .slide-mor a { color:#acacac;   display:block;text-align:center;  margin: 30px auto 0 auto ;    }
    .slide-mor a:hover { color:#525355; }
    .zimu_div { width:100%; margin:0 auto; background:#3f4145;line-height:50px; padding-top: 14px; }
    .zimu_div ul { width:980px;  margin:0 auto; border-top: solid 1px #787b80; }
    .zimu_div ul li { float: left; width: 36px;}
    .zimu_div ul li a { color: #787b80;}
    .zimu_div ul li a:hover {color: #b0b3ba }
    </style>{/literal}
    <div class="gjc_div">
       <div class="gjc_div_box" >
            <div class="title"><em><h2>POPULAR WORDS</h2></em></div>
            <ul class="">
{foreach $index_keywords as $ik}
                <li><em></em><a href="{$ik.url|default:{$ik.keyword|url:'enterprise_url_product_search'}}">{$ik.keyword}</a></li>
{/foreach}
            </ul>
            
            <div class="slide-mor">
                <a href="javascript:void(0);">MORE+</a><i></i>
            </div>
            
         </div>
    </div>
    <!--guanjianci-->
   <div class="fl-clr"></div> 
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
{include file="sets/trade/common/navbar.tpl" position="fixed"}
<!--nav--> 
{include file="sets/trade/common/shopscripts.tpl"}
<script charset="utf-8" type="text/javascript" src="media/sets/trade/search.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/en.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/shop-new.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/trade/ZoomPic.js"></script>
<script>
$(".gjc_div_box .slide-mor a").click(function(){
    var a_text=$(this).html();
    if(a_text=="MORE+"){
        $(this).parent().siblings("ul").addClass("cur");
        $(this).html("LESS-");
        $(this).siblings("i").addClass("LESS");
        }else if(a_text=="LESS-"){
            $(this).parent().siblings("ul").removeClass("cur");
            $(this).html("MORE+");
            $(this).siblings("i").removeClass("LESS-");
            }
})
</script>
</body>
</html>