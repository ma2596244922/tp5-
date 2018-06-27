<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/june/common/styles.tpl"}
    <link href="/media/sets/june/color7/css/products.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/june/common/header.tpl"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.products}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/june/common/left.tpl"}
        <div class="cb_10"></div>
        {include file="sets/june/common/left_chat.tpl"}
    </div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="box_title">{-if $group|default:[]}{$group.name}{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.all_products}{-/if}</div>

            <div class="box_content">
                <div class="cb_10"></div>
                {foreach $products as $product}
                <div class="prolist_wrap">
                    <div class="pro_tit"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></div>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tbody><tr>
                            <td width="110">
                                <div class="pro_pic">
                                    <table cellpadding="0" cellspacing="0">
                                        <tbody><tr>
                                            <td align="center" valign="middle"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}"></td>
                                        </tr>
                                    </tbody></table>
                                </div>
                            </td>
                            <td valign="top" width="435">
                                <div class="pro_con">
                                    <p>{$product.description|strip_tags|truncate:180:"..."}<a href="{$product|url:'enterprise_url_product'}" title="Read More about {$product.caption}">[read more]</a></p>
                                    <p class="time">{$product.updated}</p>
                                </div>
                            </td>
                            <td valign="top" align="right"><input class="btn1" type="button" onclick="window.location.href='/contactnow.html?about_product={$product.id}'"></td>
                        </tr>
                    </tbody></table>
                </div>
                <div class="cb_10"></div>
                {foreachelse}
                <p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
                {/foreach}
                <div class="cb_10"></div>
                {include file="sets/june/common/pager_product.tpl"}
            </div>
        </div>
        <div class="cb_10"></div>

    </div>

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june/common/footer.tpl"}
{include file="sets/june/common/scripts.tpl"}

</body>
</html>