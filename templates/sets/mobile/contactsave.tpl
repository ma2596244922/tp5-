<!DOCTYPE html>
<html{$html_attr_dir}>
    <head>
        {$site.common_head_fragment}
        <meta charset="utf-8" />
        <title>Your inquiry is sent successfully</title>
{include file="sets/mobile/common/meta.tpl"}
        <link type="text/css" rel="stylesheet" href="/media/sets/mobile/send-inquiry.css">
    </head>
<body>
<header class="title-header">
    <a href="{$smarty.post.back_to|default:$smarty.server.HTTP_REFERER}" class="back"></a>
    <span>Contact Suppliers</span>
</header>
<!--header-->
<div class="content">
    <div class="success-box">
        <p class="success"><span></span>Send Successfully!</p>
        <p>Notification of supplier's  <em>{$corporation.name}</em></p>
    </div>
    <!--success-box-->
{if $groups[0]|default:[]}
    <section class="recom-products">
        <div class="title"><h2>You may also interested in</h2></div>
        <ul class="fl-clr">
    {-foreach $groups[0]['products'] as $product}{if $product@index>=6}{break}{/if}
            <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a><span class="pro-title"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></span></li>
    {-/foreach}
        </ul>
    </section>
{/if}
</div>
<!--content-->
{include file="sets/mobile/common/footer.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
{$site.contactsave_fragment}
</body>
</html>
