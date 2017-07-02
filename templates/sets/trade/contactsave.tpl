<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$preset_translations.your_inquiry_is_sent_successfully}</title>
{include file="sets/trade/common/shopstyles.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/trade/send_inquiry.css" />
</head>

<body>
{include file="sets/trade/inquiry/logobar.tpl"}
<div class="content">
    <div class="main-form fl-clr">
    <div class="success">
        <p class="p1"><i></i>{$preset_translations.send_successfully}</p>
        <p>{$preset_translations.notification_of_suppliers_reply_will_be_sent_to} <span>{$corporation.name}</span></p>
    </div>
{if $groups[0]|default:[]}
    <div class="select-suppliers">
        <div class="title">{$preset_translations.you_may_be_interested_in_the_following_products}</div>
        <ul>
    {foreach $groups[0]['products'] as $product}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" /></a><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" class="product-name">{$product.caption}</a></li>
    {/foreach}
        </ul>
    </div>
{/if}
{if $groups[1]|default:[]}
    <div class="select-suppliers last-supply">
        <div class="title">{$preset_translations.buyers_who_sent_inquiries_to_the_same_products_also_like}</div>
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
