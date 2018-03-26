<!DOCTYPE html>
<html lang="{$lang_code}"{$html_attr_dir}><head>
  {$site.common_head_fragment}
  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  <link rel="canonical" href="{$product|url:'enterprise_url_product':$page_no}" />
  {include file="sets/trade/common/definitions.tpl"}
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl" page_name="product_detail"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}

<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
      <a href="/products.html">{$preset_translations.products}</a>
      <span>&gt;</span>
      <a href="{$product_group|default:[]|url:'enterprise_url_product_list'}">{$product_group.name|default:''}</a>
      <span>&gt;</span>
      {$product.caption}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
{include file="sets/brilly/common/grouppanel.tpl"}
{include file="sets/brilly/common/latestproducts.tpl"}
      </div>
      <div class="Right">
        <div class="ConBox ProductInfo">
          <div class="clear">&nbsp;</div>
          <h1 class="Til"><a href="">{$product.caption}</a></h1>
          <div class="clear"></div>
          <div class="pics PL" style="width:600px; float:none; margin:0 auto">
            <ul class="picsList PL_List" >
{-if $product_images}
    {-foreach $product_images as $image_id}
              <li class="PL_item" style="display: none; width: 600px; height: 600px;">
                <img src="{$image_id|url:'enterprise_url_image':$product.caption:'t'}" alt="{$product.caption|default:''|escape}">
              </li>
    {-/foreach}
{-else}
              <li class="PL_item" style="display: none; width: 600px; height: 600px;"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'t'}" alt="{$product.caption|default:''|escape}"></li>
{-/if}
            </ul>
            <button class="PL_prev" style="top: 616px;"><i class="icon arrow_left"></i></button>
            <button class="PL_next" style="top: 616px;"><i class="icon arrow_right"></i></button>
            <div class="PL_dots" style="top: 610px; overflow:hidden; height:70px;   text-align:center;vertical-align:middle; width:566px; float: left;">
{-if $product_images}
    {-foreach $product_images as $image_id}
              <img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" class="PL_dot{if $image_id@index == 0} cur{/if}">
    {-/foreach}
{-else}
              <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" class="PL_dot cur">
{-/if}
            </div>
          </div>
          <div class="clear"></div>
        </div>
{include file="sets/brilly/common/inquiryform.tpl"}
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.new_products}</h2>
          <div class="clear">&nbsp;</div>
          <ul class="PicTextList Many Type2">
{foreach $new_products as $product}{if $product@index>=5}{break}{/if}
            <li>
              <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a>
              <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption|escape}</a></p>
            </li>
{/foreach}
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
{include file="sets/brilly/common/links.tpl"}
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

<script type="text/javascript">
new IndexBanner('PL',0); //轮换
</script>
</body>
</html>