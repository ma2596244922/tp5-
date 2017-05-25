<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
{$site.common_head_fragment}
</head>
<body>

<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_detail"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;<a href="/products.html">Products</a>&gt;<a href="{$product_group|url:'enterprise_url_product_list'}">{$product_group.name}</a>&gt;<span>{$product.caption}</span></p>
        </div>
{-if $page_no<=1}
        <!--crumb-->
        <div class="produce-show fl-clr">
            <div class="img-show">
                <div class="tabContent">
                    <div class="big-img">
                        <ul>
{-if $product_images}
    {-foreach $product_images as $image_id}
                        <li>
                            <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank">
                                <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" />
                            </a>
                        </li>
    {-/foreach}
{-else}
                        <li><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" /></li>
{-/if}
                        </ul>
                    </div>
                    <div class="small-img">
                        <div class="scroll">
                                <ul>
{-if $product_images}
    {-foreach $product_images as $image_id}
                                <li{if $image_id@index == 0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" /></li>
    {-/foreach}
{-else}
                                <li class="current"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" /></li>
{-/if}
                                </ul>
                        </div>
                        <div class="prev-next">
                        <a href="javascript:void(0);" class="prev"></a>
                        <a href="javascript:void(0);" class="next"></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="simple-intro">
                <div class="title"><h1>{$product.caption}</h1></div>
                <ul>
                    <!-- Product Details -->
                    {if $product.place_of_origin|default:''}<li><label>{$preset_translations.place_of_origin}:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.brand_name|default:''}<li><label>{$preset_translations.brand_name}:</label><span>{$product.brand_name}</span></li>{/if}
                    {if $product.certification|default:''}<li><label>{$preset_translations.certification}:</label><span>{$product.certification}</span></li>{/if}
                    {if $product.model_number|default:''}<li><label>{$preset_translations.model_number}:</label><span>{$product.model_number}</span></li>{/if}

                    <!-- Payment & Shipping Terms -->
                    <li><label>{$preset_translations.minimum_order_quantity}:</label><span>{$product.min_order_quantity|default:'Negotiation'}</span></li>
                    <li><label>{$preset_translations.price}:</label><span>{$product.price|default:'Negotiation'}</span></li>
                    {if $product.packaging_details|default:''}<li><label>{$preset_translations.packaging_details}:</label><span>{$product.packaging_details}</span></li>{/if}
                    {if $product.delivery_time|default:''}<li><label>{$preset_translations.delivery_time}:</label><span>{$product.delivery_time}</span></li>{/if}
                    {if $product.payment_terms|default:''}<li><label>{$preset_translations.payment_terms}:</label><span>{$product.payment_terms}</span></li>{/if}
                    {if $product.supply_ability|default:''}<li><label>{$preset_translations.supply_ability}:</label><span>{$product.supply_ability}</span></li>{/if}
                </ul>
                <div class="contact-btn fl-clr"><a href="/contactnow.html" rel="nofollow">{$preset_translations.contact_now}</a></div>
            </div>
        </div>
        <!--produce-show-->
{include file="sets/trade/product/specifications.tpl"}
        <!--product-detail-->
        <div class="product-description">
            <div class="title"><i></i><h2>{$preset_translations.product_description}</h2></div>
            {$product.description}
        </div>
{-/if}
        <!-- BEGIN COMMENT LIST -->
{foreach $comments as $comment}
        <div class="contact-communication fl-clr">
            <div class="left-intro">
                <img src="{$comment.avatar|url:'enterprise_url_photo':'':'':'/media/sets/trade/default_photo.jpg'}" />
                <span>{$comment.contact}</span>
            </div>
            <div class="right-intro" style="min-height: 150px;/* FIXME: */">
                <ul>
                    <li>{$comment.message}</li>
                </ul>
            </div>
        </div>
{/foreach}
        <!-- END COMMENT LIST -->
        <!-- BEGIN PAGER -->
        <div class="main-content fl-clr">
            <div class="right-content" style="width: 980px; margin-left: 0;/* FIXME: */">
{if $total_comments > $page_size}
                <div class="view-page fl-clr">
                    <div class="page">
                        <label>Page</label><span><i>{$page_no}</i>/{$total_pages}</span>
    {if $page_no > 1}
                        <a href="{$product|url:'enterprise_url_product':($page_no-1)}" class="prev"></a>
    {/if}
    {if $page_no < $total_pages}
                        <a href="{$product|url:'enterprise_url_product':($page_no+1)}" class="next"></a>
    {/if}
                    </div>
                </div>
{/if}
            </div>
        </div>
        <!-- END PAGER -->
        <!--product-description-->
{include file="sets/trade/common/contactform.tpl"}
{include file="sets/trade/product/categories.tpl"}
        <!--product categories-->
        <div class="new-products">
            <div class="title"><i></i><h2>{$preset_translations.new_products}</h2></div>
            <div class="tab-content">
                <div class="tabs-list" id="tabs-list">
                    <ul class="fl-clr">
{foreach $new_products as $product}{if $product@index>=5}{break}{/if}
                        <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="" /><i>{$product.caption}</i></a></li>
{/foreach}
                    </ul>
                </div>
            </div>
        </div>
        <!--new-products-->
{if count($product_tags)>0}
        <div class="search-product">
        <div class="hot-search">
            <dl>
                <dt>Tags:</dt>
    {foreach $product_tags as $tag}
                <dd><h3><a href="{$tag|call:'enterprise_url_product_search'}">{$tag}</a></h3></dd>
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
