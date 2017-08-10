<!DOCTYPE html>
<html{$html_attr_dir}>
<head>
  {$site.common_head_fragment}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  {include file="sets/trade/common/definitions.tpl"}
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}
<div class="Content Shop noRoute">
  <div class="Page">
    <div class="ConBox Banner">
{foreach $banners as $banner}{if $banner@index>0}{continue}{/if}
      <a href="{$banner.link}" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a>
{/foreach}
    </div>
    <div class="ConBox">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">{$preset_translations.featured_products}</h2>
      <div class="clear"></div>
      <ul class="PicTextList Many">
{foreach $products as $product}
        <li>
          <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$groups[0].products[0].caption:'c'}" alt="{$product.caption}"></a>
          <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></p>
        </li>
{/foreach}
      </ul>
    </div>
{include file="sets/brilly/common/profilepanel.tpl"}
    <!-- Post Sourcing Request Start -->
{include file="sets/brilly/common/inquiryform.tpl"}
    <!-- Post Sourcing Request End -->
  </div>
</div>

{include file="sets/brilly/common/links.tpl"}
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

</body>
</html>