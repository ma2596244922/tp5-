<!DOCTYPE html>
<html{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    {include file="sets/june-blue/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="home"}
    {include file="sets/june-blue/common/styles.tpl"}
    <link href="/media/sets/june-blue/css/index.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/css/swiper.min.css">
</head>
<body>

{include file="sets/june-blue/common/header.tpl" cur="home"}

<div class="main_wrap">
    <div class="swiper-container company-photo">
        <div class="swiper-wrapper">
            {foreach $banners as $banner}
            <div class="swiper-slide"><a href="{$banner.link}" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}" width="950" height="170"></a></div>
            {/foreach}
        </div>
        <div class="swiper-pagination"></div>
    </div>

    <div class="sider_wrap">
        {include file="sets/june-blue/common/left.tpl"}
    </div>
    <div class="main_right_wrap_box">
        <div class="main_right_wrap">
            <div class="main_right_box">
                <table cellpadding="0" cellspacing="0" class="flash_wrap">
                    <tr>
                        <td width="310"><div class="flash_pic"> <img src="{$corporation.logo|url:'enterprise_url_image'}" width="300" height="190" /></div></td>
                        <td valign="top">
                            <div class="flash_text">
                                <strong class="f_3">{$corporation.name}</strong>
                                <div class="f_5">{$corporation.introduction|truncate:370:"..."} <a href="/aboutus.html" rel="nofollow">{$preset_translations.see_more}&gt;&gt;</a></div>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="cb"></div>
                <div class="title_wrap"><h2>Our product range includes:</h2></div>
                {assign var="products_new" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, '', '', 1, 16) )}
                <div class="list_ul_li">
                    <table width="100%" cellspacing="0" cellpadding="0">
                        <tbody>
                            {foreach $products_new as $product}{if $product@index>=16}{break}{/if}
                            {if $product@index%2==0}<tr>{/if}
                                <td width="49%"><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</strong></a></td>
                            {if $product@index%2==1}</tr>{/if}
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <div class="cb_10"></div>
                {foreach $products as $product}
                {if $product@index<8}
                <div class="pro_wrap">
                    <div class="pro_pic">
                        <table cellspacing="0" cellpadding="0">
                            <tbody><tr>
                                    <td align="center" valign="middle"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}"></td>
                                </tr>
                            </tbody></table>
                    </div>
                    <div class="pro_tit"><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</strong></a></div>
                </div>
                {if $product@index == 3}<div class="cb_10"></div>{/if}
                {/if}
                {/foreach}
                
                <div class="cb_10"></div>
            </div>
        </div>
    </div>
    <div class="cb_10"></div>
</div>

{include file="sets/june-blue/common/footer.tpl"}
{include file="sets/june-blue/common/scripts.tpl"}
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/js/swiper.min.js"></script>
<script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
      pagination: {
        clickable: true,
        el: '.swiper-pagination',
      },
    });
</script>
</body>
</html>