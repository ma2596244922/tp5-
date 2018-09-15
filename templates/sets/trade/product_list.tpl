<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
{include file="sets/trade/group/tdk.tpl"}
<link rel="canonical" href="{$group|default:[]|url:'enterprise_url_product_list'}" />
{include file="sets/trade/product/link_rel.tpl"}
{include file="sets/trade/common/definitions.tpl" page_name="product_list"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
<div class="content">
   <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_list"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p>
                <a href="/">{$preset_translations.home}</a>&gt;
{-if $group|default:[]}
                <a href="/products.html">{$preset_translations.products}</a>&gt;<span>{$group.name}</span>
{-elseif $phrase|default:''}
                <a href="/products.html">{$preset_translations.products}</a>&gt;<span>{$phrase}</span>
{-else}
                <span>{$preset_translations.products}</span>
{-/if}      </p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
{include file="sets/trade/common/grouppanel.tpl"}
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">

{include file="sets/trade/product/list.tpl"}
                <!--products-box-->
{include file="sets/trade/product/pager.tpl"}
                <!--view-page-->
            </div>
            <!--right-content--> 
        </div>
        <!--main-content--> 
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
