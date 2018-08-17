<!DOCTYPE html>
<html{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    {include file="sets/m12/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="home"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/index.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/css/swiper.min.css">
</head>
<body>

{include file="sets/m12/common/header.tpl" cur="home"}

<div class="guide_wrap"><a href="/">{$preset_translations.home}</a></div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/m12/common/left.tpl"}
    </div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="r_flash">
                {assign var="products_new" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, '', '', 1, 5) )}
                <div class="r_f_i">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center" valign="middle">
                                {if $products_new}
                                <a href="{$products_new[0]|url:'enterprise_url_product'}" id="indexhref"><img width="400" height="260" src="{$products_new[0].head_image_id|url:'enterprise_url_image':$products_new[0].caption:'c'}" id="indexpic" ></a>
                                {/if}
                            </td>
                        </tr>
                    </table>
                </div>
                <ul class="r_f_l" >
                    {foreach $products_new as $product}
                    <li id="li{$product@index}"{if $product@index==0} class="cur"{/if}>
                        <div class="tit">
                            <a href="{$product|url:'enterprise_url_product'}" id="a{$product@index}">{$product.caption}</a>
                        </div>
                        <div class="r_f_pic" >
                            <table cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td>
                                        <a href="{$product|url:'enterprise_url_product'}"><img  src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" width="41" height="41" /></a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                    {/foreach}
                    
                </ul>
            </div>
        </div>
        <div class="cb_10"></div>
        <div class="content_box">
            <div class="title">
                Highlighted Products
                <div class="search_wrap">
                    <input type="text" class="search_t" placeholder="Search all Products" id="kw"/>
                    <input type="button" class="search_b" onclick="SearchProducts()"/>
                </div>
            </div>
            <div class="cb_10"></div>
            {foreach $products as $product}{if $product@index>7}{break}{/if}
            <div class="pro_wrap">
                <div class="pro_pic">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center" valign="middle">
                                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" height="100" width="100" alt="{$product.caption}">
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="pro_tit"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</a></div>
            </div>
            {/foreach}
            
            <div class="cb_10"></div>
        </div>
        <div class="cb_10"></div>
        <div class="content_box">
            <div class="content_company_wrap">
                <table cellpadding="0" cellspacing="10">
                    <tr>
                        <td>
                            <div class="company_flash">
                                <img src="{$corporation.logo|url:'enterprise_url_image'}" width="249" height="163" />
                            </div>
                        </td>
                        <td valign="top">
                            <div class="content_company_box">
                                <p class="tit"><h1>{$corporation.name}</h1></p>
                                <p class="con"> {$corporation.introduction|strip_tags|truncate:190:"..."}<a href="/aboutus.html">[read more]</a></p>
                                <div class="cb_10"></div>
                                <input class="btn1 mt_10" type="button" onclick="window.location.href='/contactnow.html'"/>
                                <div class="ft_wrap"><a href="/aboutus.html">Factory Tour</a><a href="/aboutus.html">Contact Us</a></div>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="cb"></div>
            </div>
        </div>
    </div>
    <div class="cb_10"></div>
</div>

{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}
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