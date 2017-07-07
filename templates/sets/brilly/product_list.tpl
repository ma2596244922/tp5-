<!DOCTYPE html>
<html>
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
{include file="sets/brilly/common/logobar.tpl" page_name="product_list"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}
<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
{-if $group|default:[]}
      <a href="/products.html">{$preset_translations.products}</a>
      <span>&gt;</span>
      {$group.name}
{-elseif $phrase|default:''}
      <a href="/products.html">{$preset_translations.products}</a>
      <span>&gt;</span>
      {$phrase}
{-else}
      {$preset_translations.products}
{-/if}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.product_groups}</h2>
          <div class="clear">&nbsp;</div>
          <ul class="TextList">
{foreach $groups as $g}{assign var="gid" value={$g.id|default:$g.group_id}}
            <li><a href="{$g|url:'enterprise_url_product_list'}" title="{$g.name}"><strong>{$g.name}</strong>({$g.cnt})</a></li>
{/foreach}
          </ul>
        </div>
      </div>
      <div class="Right">
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
{-if $group|default:[]}
          <h1 class="Til">{$group.name}</h1>
{-elseif $phrase|default:''}
          <h1 class="Til">{$phrase}</h1>
{-else}
          <h2 class="Til">{$preset_translations.all_products}</h2>
{-/if}
          <div class="clear">&nbsp;</div>
          <ul class="PicTextList Many">
{foreach $products as $product}
            <li>
              <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a>
              <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></p>
              <a href="/contactnow.html?about_product={$product.id}" class="btn" rel="nofollow">{$preset_translations.contact_now}</a>
            </li>
{foreachelse}
            <li>
              <p>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
            </li>
{/foreach}
          </ul>
{if $total_products > $page_size}
          <div class="Pager ConBox tc">
            <div class="lists">
    {-if $page_no > 1}
        {-if $phrase|default:''}
              <a href="{$phrase|url:'enterprise_url_product_search':($page_no-1)}" class="disabled left"><i class="icon arrow_left"></i> Prev</a>
        {-else}
              <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}" class="disabled left"><i class="icon arrow_left"></i> Prev</a>
        {-/if}
    {-/if}
    {-if $page_no < $total_pages}
        {-if $phrase|default:''}
              <a href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" class="right">Next <i class="icon arrow_right"></i></a>
        {-else}
              <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" class="right">Next <i class="icon arrow_right"></i></a>
        {-/if}
    {-/if}
            </div>
          </div>
{/if}
        </div>
      </div>
    </div>
  </div>
</div>
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

<script type="text/javascript">

$("#productsSearch").keyup(function(){
  console.log(this.value.length)
  if(this.value.length > 0){
    $(this).next('i').addClass('focus')
    return false;
  }
  $(this).next('i').removeClass('focus')
});
</script>
</body>
</html>