<!DOCTYPE html>
<html lang="{$lang_code}"{$html_attr_dir}>
<head>
  {$site.common_head_fragment}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  <link rel="stylesheet" type="text/css" href="style.css">
  {include file="sets/trade/common/definitions.tpl"}
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl" page_name="product_directory"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}

<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
      {$preset_translations.site_map}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
{include file="sets/brilly/common/intronav.tpl"}
{include file="sets/brilly/common/grouppanel.tpl"}
{include file="sets/brilly/common/latestproducts.tpl"}
      </div>
      <div class="Right">
        <div class="ConBox ProductIntro" style="margin-top: 0;">
          <div class="clear">&nbsp;</div>
          <h2 class="Til" id="">{$preset_translations.all_products} Page {$page_no}</h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
{foreach $products as $product}
                <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></p>
{foreachelse}
                <p>{$preset_translations.sorry_no_matches_were_found}</p>
{/foreach}
              </div>
            </dd>
          </dl>

{if $total_products > $page_size}
          <div class="Pager ConBox tc">
            <div class="lists">
    {-if isset($pager_info['prev_page'])}
              <a href="{$pager_info['prev_page']|url:'enterprise_url_product_directory'}" class="left"><i class="icon arrow_left"></i> Prev</a>
    {-/if}
    {-if isset($pager_info['next_page'])}
              <a href="{$pager_info['next_page']|url:'enterprise_url_product_directory'}" class="right">Next <i class="icon arrow_right"></i></a>
    {-/if}
            </div>
          </div>
{/if}

        </div>
{include file="sets/brilly/common/inquiryform.tpl"}
      </div>
    </div>
  </div>
</div>
{include file="sets/brilly/common/links.tpl"}
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

</body>
</html>