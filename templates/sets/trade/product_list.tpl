<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$group.name} on sales  - Quality {$corporation.xx} supplier</title>
{include file="sets/trade/common/styles.tpl"}
</head>

<body>
<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;{if $group|default:[]}<a href="/products.html">Products</a>&gt;<span>{$group.name}</span>{else}<span>Products</span>{/if}</p>
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
                <div class="menu-list">
                    <dl>
                        <dt>Product Groups</dt>
{foreach $groups as $group}
                        <dd><a href="{$group|url:'enterprise_url_product_list'}"{if $group@index==0} class="current"{/if} title="{$group.name}">{$group.name} ({$group.cnt})</a></dd>
{/foreach}
                    </dl>
                </div>
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">
                <div class="product-box">
                    <div class="title"><i></i>All Products<a href="/contactnow.html">Contact Now</a></div>
                    <div class="product-all">
{foreach $products as $product}
                        <div class="product-intro">
                            <div class="left-img">
                                <a href="{$product|url:'enterprise_url_product'}" class="img-box">
                                    <img src="/media/sets/trade/new-product.jpg" />
                                </a>
                                <a href="javascript:void(0)" data-role="154606" class="add-basket" onclick="aclick(154606)"></a>
                            </div>
                            <div class="msg-detail">
                                <span><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></span>
                                <ul>
                                    <li><label>Min. Order</label>{$product.min_order_quantity|default:'Negotiation'}</li>
                                    <li><label>FOB Price</label>{$product.price|default:'Negotiation'}</li>
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
{include file="sets/trade/common/scripts.tpl"}
</body>
</html>
