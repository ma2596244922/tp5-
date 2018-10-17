<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
    <link type="text/css" rel="stylesheet" href="/media/sets/partner/css/swiper.css" />
</head>
<body>

{include file="sets/partner/common/header.tpl" ishome="1"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
{if $site.enable_slide|default:'0'}
<div class="banner-slide">
    <div id="slideBox" class="slideBox">
        <div class="bd">
            <div>
                <ul>
                    {foreach $banners as $banner}
                    <li{if $banner@first || $banner@last} class="clone"{/if}><a href="{$banner.link}"  target="_blank" title="{$banner.desc}"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a></li>
                    {/foreach}
                </ul>
            </div>
        </div>
        <!-- 下面是前/后按钮代码，如果不需要删除即可 -->
        <a class="prev" href="javascript:void(0)"></a>
        <a class="next" href="javascript:void(0)"></a>
    </div>
</div>
<!--banner-slide-->
{/if}
<div class="main-category">
    <div class="h2-title">
        <h2>Main Products</h2>
        <i></i>
    </div>
    <div class="home-product fl-clr">
        {if $groups[0]|default:[]}
        {assign var="products_group1" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id,$default_lang_code,$groups[0].id,false,1,3,'', ($default_lang_code == 'en') ? '`updated` ASC' : 'elp.`updated` ASC') ) }
        {foreach $products_group1 as $product}
        <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
            <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}">
            <div>{$product.caption}</div>
        </a>
        {/foreach}
        {/if}
        
    </div>
</div>
<!-- main-category -->
<div class="new-product">
    {if $products|default:[]}
    <div class="title-left">
        <h2>{$preset_translations.new_products}</h2>
        <i></i>
    </div>
    <div class="product-list">
        <ul class="fl-clr">
            {foreach $products as $product}
            <li>
                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}"/></a>
                <span><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></span>
            </li>
            {/foreach}
        </ul>
    </div>
    {/if}
</div>

<!-- new-product -->
<div class="trusted-partner">
    <span>{$corporation.name|escape}</span>
    <p>{$corporation_slogan}</p>
</div>
<!-- trusted-partner -->

{include file="sets/partner/common/footer.tpl"}
<!-- footer -->

{include file="sets/partner/common/scripts.tpl"  search="fixed" ishome="1"}
</body>
</html>