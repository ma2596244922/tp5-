<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$product.caption}</title>
{include file="sets/trade/common/shopstyles.tpl"}
</head>
<body>

<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;<a href="/products.html">Products</a>&gt;<a href="{$product_group|url:'enterprise_url_product_list'}">{$product_group.name}</a>&gt;<span>{$product.caption}</span></p>
        </div>
        <!--crumb-->
        <div class="produce-show fl-clr">
            <div class="img-show">
                <div class="tabContent">
                    <div class="big-img">
                        <ul>
{foreach $product_images as $image_id}
                        <li><a href="#" title=""><img src="{$image_id|url:'enterprise_url_image':$product.caption:'t'}" alt="" /></a></li>
{/foreach}
                        </ul>
                    </div>
                    <div class="small-img">
                        <div class="scroll">
                            <div class="img-box">
                                <ul>
{foreach $product_images as $image_id}
                                <li{if $image_id@index == 0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'d'}" alt="" /></li>
{/foreach}
                                </ul>
                            </div>
                        </div>
                        <div class="prev-next">
                        <a href="javascript:void(0);" class="prev"></a>
                        <a href="javascript:void(0);" class="next"></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="simple-intro">
                <div class="title">{$product.caption}</div>
                <ul>
                    <!-- Product Details -->
                    {if $product.place_of_origin|default:''}<li><label>Place of Origin:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.brand_name|default:''}<li><label>Brand Name:</label><span>{$product.brand_name}</span></li>{/if}
                    {if $product.certification|default:''}<li><label>Certification:</label><span>{$product.certification}</span></li>{/if}
                    {if $product.model_number|default:''}<li><label>Model Number:</label><span>{$product.model_number}</span></li>{/if}

                    <!-- Payment & Shipping Terms -->
                    <li><label>Min.Order Quantity:</label><span>{$product.min_order_quantity|default:'Negotiation'}</span></li>
                    <li><label>Price:</label><span>{$product.price|default:'Negotiation'}</span></li>
                    {if $product.packaging_details|default:''}<li><label>Packaging Details:</label><span>{$product.packaging_details}</span></li>{/if}
                    {if $product.delivery_time|default:''}<li><label>Delivery Time:</label><span>{$product.delivery_time}</span></li>{/if}
                    {if $product.place_of_origin|default:''}<li><label>Place of Origin:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.payment_terms|default:''}<li><label>Payment Terms:</label><span>{$product.payment_terms}</span></li>{/if}
                    {if $product.supply_ability|default:''}<li><label>Supply Ability:</label><span>{$product.supply_ability}</span></li>{/if}
                </ul>
                <div class="contact-btn fl-clr"><a href="/contactnow.html">Contact Now</a></div>
            </div>
        </div>
        <!--produce-show-->
{if count($product_specifications)>0}
        <div class="product-detail">
            <div class="title"><i></i>Product Details</div>
            <table cellpadding="0" cellspacing="0">
    {foreach $product_specifications as $k=>$v}
        {if $v@index%3==0}
                <tr>
        {/if}
                    <td width="11%" class="title-td">{$k}:</td>
                    <td width="22%">{$v}</td>
        {if $v@index%3==2}
                </tr>
        {/if}
    {/foreach}
            </table>
        </div>
{/if}
        <!--product-detail-->
        <div class="product-description">
            <div class="title"><i></i>Product Description</div>
            {$product.description}
        </div>
        <!--product-description-->
{include file="sets/trade/common/contactform.tpl"}
        <div class="product-categories">
            <div class="title"><i></i>Product Categories</div>
            <table cellpadding="0" cellspacing="0">
{foreach $groups as $group}
    {if $group@index%3==0}
                <tr>
    {/if}
                    <td width="33%"><a href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a></td>
    {if $group@index%3==2}
                </tr>
    {/if}
{/foreach}
            </table>
        </div>
        <!--product categories-->
        <div class="new-products">
            <div class="title"><i></i>New Products</div>
            <div class="tab-content">
                <div class="tabs-new" id="tabs-new">
                        <a href="javascript:void(0)" class="current"></a>
                        <a href="javascript:void(0)"></a>
                        <a href="javascript:void(0)"></a>
                        <a href="javascript:void(0)"></a>
                    </ul>
                </div>
                <div class="tabs-list" id="tabs-list">
{foreach $new_products as $product}
    {if $product@index%5==0}
                    <ul class="fl-clr">
    {/if}
                        <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="" /><i>{$product.caption}</i></a></li>
    {if $product@index%5==4}
                    </ul>
    {/if}
    {if $product@iteration>=20}{break}{/if}
{/foreach}
                </div>
            </div>
        </div>
        <!--new-products-->
{if count($product_tags)>0}
        <div class="search-product">
        <div class="hot-search">
            <dl>
                <dt>Hot Searches:</dt>
    {foreach $product_tags as $tag}
                <dd>{$tag}</dd>
    {/foreach}
            </dl>
        </div>
        </div>
{/if}
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>