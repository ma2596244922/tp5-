<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
<link rel="canonical" href="{$product|url:'enterprise_url_product':$page_no}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>
<body>

<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_detail"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">{$preset_translations.home}</a>&gt;<a href="/products.html">{$preset_translations.products}</a>&gt;<a href="{$product_group|default:[]|url:'enterprise_url_product_list'}">{$product_group.name|default:''}</a>&gt;<span>{$product.caption}</span></p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
{include file="sets/trade/product/detail.tpl"}
{include file="sets/trade/common/main_products.tpl"}
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>
