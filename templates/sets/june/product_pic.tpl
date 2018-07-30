<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
{include file="sets/june/common/tdk.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_pic"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">{$preset_translations.home}</a>&gt;<a href="/products.html">{$preset_translations.products}</a>&gt;<a href="{$product_group|default:[]|url:'enterprise_url_product_list'}">{$product_group.name|default:''}</a>&gt;<span>{$product.caption} image</span></p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
        <!--crumb-->
{include file="sets/trade/product/pic.tpl"}
        <!--product-img-->
{include file="sets/trade/product/specifications.tpl"}
        <!--product-detail-->
{include file="sets/trade/common/contactform.tpl"}
{include file="sets/trade/common/main_products.tpl"}
{include file="sets/trade/common/hidden_groups.tpl"}
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>