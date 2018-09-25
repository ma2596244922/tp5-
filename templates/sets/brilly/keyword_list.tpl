<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
    {include file="sets/trade/group/tdk.tpl"}
    <link rel="canonical" href="{$group|default:[]|url:'enterprise_url_product_list'}" />
    {include file="sets/trade/product/link_rel.tpl"}
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
        <!--crumb-->
        <div class="product-map">
            <div class="title"><span></span><h1>{$first_char} Keyword List Page {$page_no}</h1></div>
            <div class="product-list">
                <ul class="fl-clr">
{foreach $site_keywords as $keyword}
    {-if $keyword@index>0 && $keyword@index%10==0}
                </ul>
                <ul class="fl-clr">
    {-/if}
                    <li><em></em><a href="{$keyword.keyword|url:'enterprise_url_product_search'}" title="{$keyword.keyword|escape}">{$keyword.keyword}</a></li>
{foreachelse}
                    <li>{$preset_translations.sorry_no_matches_were_found}</li>
{/foreach}
                </ul>
            </div>
            <!--product-list-->
{if $total_keywords > $page_size}
            <div class="page">
                <div class="page-show">
    {-if isset($pager_info['prev_page'])}
                    <a href="{$first_char|url:'enterprise_url_keyword_list':$pager_info['prev_page']}" rel="nofollow" class="prev" title="Prev"></a>
    {-/if}
    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                    <a{if $i==$page_no} class="default"{else} href="{$first_char|url:'enterprise_url_keyword_list':$i}" title="{$i}"{/if}>{$i}</a>
    {-/for}
    {-if isset($pager_info['next_page'])}
                    <a href="{$first_char|url:'enterprise_url_keyword_list':$pager_info['next_page']}" rel="nofollow" class="next" title="Next">Next</a>
    {-/if}
                </div>
            </div>
{/if}
        </div> 
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/brilly/common/links.tpl"}
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}
</body>
</html>