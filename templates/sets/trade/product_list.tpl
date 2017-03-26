<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
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
            <p><a href="/">Home</a>&gt;{if $group|default:[]}<a href="/products.html">Products</a>&gt;<span>{$group.name}</span>{else}<span>Products</span>{/if}</p>
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
{include file="sets/trade/common/grouppanel.tpl"}
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">
                <div class="product-box">
                    <div class="title"><i></i>{if $group|default:[]}<h1>{$group.name}</h1>{else}All Products{/if}<a href="/contactnow.html">Contact Now</a></div>
                    <div class="product-all">
{foreach $products as $product}
                        <div class="product-intro">
                            <div class="left-img">
                                <a href="{$product|url:'enterprise_url_product'}" class="img-box">
                                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" />
                                </a>
                            </div>
                            <div class="msg-detail">
                                <span><a href="{$product|url:'enterprise_url_product'}"><h3>{$product.caption}</h3></a></span>
                                <ul>
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=2}{break}{/if}
        {-if $product.$k|default:$meta.default}
                                    <li><label>{$meta.label}</label>{$product.$k|default:$meta.default}</li>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
                                </ul>
                                <div class="contact-btn"><a href="/contactnow.html">Contact Now</a></div>
                            </div>
                        </div>
{/foreach}
                    </div>
                </div>
                <!--products-box-->
{if $total_products > $page_size}
                <div class="view-page fl-clr">
                    <div class="page">
                        <label>Page</label><span><i>{$page_no}</i>/{$total_pages}</span>
    {if $page_no > 1}
                        <a href="{$group.id|url:'enterprise_url_group':($page_no-1)}" class="prev"></a>
    {/if}
    {if $page_no < $total_pages}
                        <a href="{$group.id|url:'enterprise_url_group':($page_no+1)}" class="next"></a>
    {/if}
                    </div>
                </div>
{/if}
                <!--view-page-->
            </div>
            <!--right-content--> 
        </div>
        <!--main-content--> 
    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>
