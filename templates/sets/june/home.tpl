<!DOCTYPE html>
<html{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    {include file="sets/june/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="home"}
    {include file="sets/june/common/styles.tpl"}
    <link href="/media/sets/june/color7/css/index.css" rel="stylesheet" type="text/css" />
</head>
<body>
{assign var="ishome" value='1'}
{include file="sets/june/common/header.tpl"}

<div class="main_wrap">
            <div class="cb_10"></div>
            <div class="sider_wrap fl">
                {include file="sets/june/common/left.tpl"}
            </div>
            <div class="fl" style="width: 402px; margin-left: 10px;">
                <div class="box_400">
                    <div class="box_title"><h2>{$preset_translations.hot_products}</h2></div>
                    <div class="box_content">
                    {if $groups[0]|default:[]}
                    {assign var="products_1" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, $groups[0].id) )}
                    {foreach $products_1 as $product}
                    {assign var="products_info" value=enterprise_get_product_info($product.id,$default_lang_code) }
                    {if $product@index eq 0}
                        <div class="pro_wrap">
                            <div class="pro_pic pic_big" style="width: 250px; height: 175px;">
                                <table cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td align="center" valign="middle"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="pro_con" style="width: 215px;">
                                <div class="pro_tit"> <strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</a></strong></div>
                                <p class="p_big">{$products_info.description|strip_tags|truncate:220:""}...<a href="{$product|url:'enterprise_url_product'}" rel="nofollow">{$preset_translations.view_more}&gt;&gt;</a></p>
                            </div>
                        </div>
                    {else}
                        <div class="pro_wrap">
                            <div class="pro_pic">
                                <table cellpadding="0" cellspacing="0">
                                    <tbody><tr>
                                            <td height="100%" align="center" valign="middle"><img src="{$product.head_image_id|url:'enterprise_url_image':$groups[0].products[0].caption:'c'}" alt="{$product.caption}" width="80" height="80"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="pro_con">
                                <div class="pro_tit"><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</a></strong></div>
                                <p class="p_small">{$products_info.description|strip_tags|truncate:180:""}...</p>
                            </div>
                        </div>
                    {/if}
                    {/foreach}

                    {/if}
                        
                        <div class="cb"></div>
                    </div>
                </div>
                <div class="cb_10"></div>
            </div>

            <div class="fr" style="width: 210px;">
                <div class="box_315">
                    <div class="box_title"><h2>{$preset_translations.about_us}</h2></div>
                    <div class="cb_5"></div>
                    <div class="box_content">
                        <div class="flash_wrap">
                            <img src="{$corporation.logo|url:'enterprise_url_image'}" width="160" height="105" />
                        </div>
                        <div class="flash_text">
                            <strong>{$corporation.name}</strong>
                            <div class="f_5">{$corporation.introduction|truncate:120:"..."} <a href="/aboutus.html" rel="nofollow">{$preset_translations.see_more}&gt;&gt;</a></div>
                        </div>
                    </div>
                    <div class="cb_10"></div>
                </div>
                <div class="cb_10"></div>
                <div class="box_315" >
                    <div class="box_title"><h2>{$preset_translations.new_products}</h2></div>
                    <div class="box_content">
                        <ul class="new_pro">
                            {assign var="products_new" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, '','',1,20) )}
                            {foreach $products_new as $product}
                                <li><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</strong></a></li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="cb"></div>
                </div>
            </div>
            <div class="cb"></div>

        </div>
        {include file="sets/june/common/footer.tpl"}
        {include file="sets/june/common/scripts.tpl"}
    </body>
</html>