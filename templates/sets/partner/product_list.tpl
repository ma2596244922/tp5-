
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
</head>
<body>
{include file="sets/partner/common/header.tpl"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
{include file="sets/partner/common/banner.tpl"}
<!-- banner -->
<div class="content fl-clr">
    <div class="left-content">
        <div class="title-left">
            <h1>ALL Products</h1>
            <i></i>
        </div>
        <div class="product-list">
            <ul class="fl-clr">
                {foreach $products as $product}
                <li>
                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" ><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" /></a>
                    <span><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></span>
                </li>
                {/foreach}
            </ul>
        </div>
        <!-- product-list enterprise_url_product_list -->
        {if $total_products > $page_size}
        <div class="page">
            {-if $page_no > 1}
            <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}" title="Prev" class="prev">&lt;&nbsp;Prev</a>
            {-/if}
            {-if $page_no < $total_pages}
            <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" title="Next" class="next">Next&nbsp;&gt;</a>
            {-/if}
        </div>
        {/if}
        <!-- page -->
    </div>
    <!-- left-content -->
    {include file="sets/partner/common/right_list.tpl"}
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
</body>
</html>