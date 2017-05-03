<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
<div class="content content-map">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_directory"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p>
                <a href="/">Home</a>&gt;
                <span>Site Map</span>
            </p>
        </div>
        <!--crumb-->
        <div class="product-map">
            <div class="title"><span></span><h1>All Products Page {$page_no}</h1></div>
            <div class="product-list">
                <ul class="fl-clr">
{foreach $products as $product}
    {-if $product@index>0 && $product@index%10==0}
                </ul>
                <ul class="fl-clr">
    {-/if}
                    <li><em></em><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></li>
{foreachelse}
                    <li>Sorry! No matches were found.</li>
{/foreach}
                </ul>
            </div>
            <!--product-list-->
{if $total_products > $page_size}
            <div class="page">
                <div class="page-show">
    {-if isset($pager_info['prev_page'])}
                    <a href="{$pager_info['prev_page']|url:'enterprise_url_product_directory'}" rel="nofollow" class="prev" title="Prev"></a>
    {-/if}
    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                    <a{if $i==$page_no} class="default"{else} href="{$i|url:'enterprise_url_product_directory'}" title="{$i}"{/if}>{$i}</a>
    {-/for}
    {-if isset($pager_info['next_page'])}
                    <a href="{$pager_info['next_page']|url:'enterprise_url_product_directory'}" rel="nofollow" class="next" title="Next">Next</a>
    {-/if}
                </div>
            </div>
{/if}
        </div> 
        <!--product-map-->
        <div class="product-map product-map1">
            <div class="title"><span></span><h2>All Categories</h2></div>
            <div class="product-list">
                <ul class="fl-clr">
{foreach $groups as $g}
                    <li><em></em><a href="{$g|url:'enterprise_url_product_list'}" title="{$g.name|escape}">{$g.name}</a></li>
{/foreach}
                </ul>
            </div>
            <!--product-list-->
        </div> 
        <!--product-map-->
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>