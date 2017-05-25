<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Your inquiry is sent successfully</title>
{include file="sets/trade/common/shopstyles.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/trade/send_inquiry.css" />
{$site.common_head_fragment}
</head>

<body>
{include file="sets/trade/inquiry/logobar.tpl"}
<div class="content">
    <div class="main-form fl-clr">
    <div class="success">
        <p class="p1"><i></i>Send successfully!</p>
        <p>Notification of supplier's reply will be sent to <span>{$corporation.name}</span></p>
    </div>
{if $groups[0]|default:[]}
    <div class="select-suppliers">
        <div class="title">You may be interested in the following products</div>
        <ul>
    {foreach $groups[0]['products'] as $product}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" /></a><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" class="product-name">{$product.caption}</a></li>
    {/foreach}
        </ul>
    </div>
{/if}
{if $groups[1]|default:[]}
    <div class="select-suppliers last-supply">
        <div class="title">Buyers who sent inquiries to the same product(s) also like</div>
        <ul>
    {foreach $groups[1]['products'] as $product}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" /></a><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" class="product-name">{$product.caption}</a></li>
    {/foreach}
        </ul>
    </div>
{/if}
    </div>
    <!--main-form -->    
    
</div>
<!--content-->
{include file="sets/trade/common/inquiryfooter.tpl"}
{include file="sets/trade/common/scripts.tpl"} 
{$site.contactsave_fragment}
</body>
</html>
