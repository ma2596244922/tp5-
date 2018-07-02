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

{include file="sets/partner/common/header.tpl"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
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
<div class="main-category">
    <div class="h2-title">
        <h1>Main Category</h1>
        <i></i>
    </div>
    <div class="cate-content fl-clr">
        {foreach $groups as $group}{if $group@index>=3}{continue}{/if}
        <a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">
            <div class="cate-detail">
                    <span>
                        <i class="icon{$group@index+1}"></i>
                        <em>{$group.products[0].caption}</em>
                    </span>
            </div>
        </a>
        {/foreach}
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
    <span>We are trusted partner</span>
    <p>Sed ultrices porta cursus. Aenean nec sagittis augue. Integer fringilla nunc non leo blandit efficitur. Aenean vel sodales felis. </p>
    <p>Nunc ac dignissim nunc. Aenean vel pellentesque lectus. Fusce nibh orci, porttitor nec odio sit amet.</p>
</div>
<!-- trusted-partner -->

{include file="sets/partner/common/footer.tpl"}
<!-- footer -->

<script charset="utf-8" type="text/javascript" src="media/sets/partner/js/jquery.min.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/partner/js/jquery.SuperSlide.min.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/partner/js/swiper.jquery.min.js"></script>
<script charset="utf-8" type="text/javascript" src="media/sets/partner/js/theme.js"></script>
</body>
</html>