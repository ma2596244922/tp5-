<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_list"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p>
                <a href="/">{$preset_translations.home}</a>&gt;
{-if $group|default:[]}
                <a href="/products.html">{$preset_translations.products}</a>&gt;<span>{$group.name}</span>
{-elseif $phrase|default:''}
                <a href="/products.html">{$preset_translations.products}</a>&gt;<span>{$phrase}</span>
{-else}
                <span>{$preset_translations.products}</span>
{-/if}      </p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
{include file="sets/trade/common/grouppanel.tpl"}
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">
                <div class="product-box">
                    <div class="title">
                        <i></i>
{-if $group|default:[]}
                        <h1>{$group.name}</h1>
{-elseif $phrase|default:''}
                        <h1>{$phrase}</h1>
{-else}
                        {$preset_translations.all_products}
{-/if}
                        <a href="/contactnow.html" rel="nofollow">{$preset_translations.contact_now}</a>
                    </div>
                    <div class="product-all{if !$products|default:[]} quality-none{/if}">
{foreach $products as $product}
                        <div class="product-intro">
                            <div class="left-img">
                                <a href="{$product|url:'enterprise_url_product'}" class="img-box">
                                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" />
                                </a>
                            </div>
                            <div class="msg-detail">
                                <span><a href="{$product|url:'enterprise_url_product'}"><h3>{$product.caption}</h3></a></span>
                                <table cellpadding="0" cellspacing="0">
                                    <tbody>
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=4}{break}{/if}
        {-if $product.$k|default:$meta.default}
            {-if $total_items==0}
                                        <tr>
            {-/if}
                                            <td><label>{$meta.label}</label><i>{$product.$k|default:$meta.default}</i></td>
            {-assign var="total_items" value=$total_items+1}
            {-if $total_items==2}
                                        </tr>
                                        <tr>
            {-/if}
            {-if $total_items==4}
                                        </tr>
            {-/if}
        {-/if}
    {-/foreach}
                                    </tbody>
                                </table>
                                <div class="contact-btn"><a href="/contactnow.html?about_product={$product.id}" rel="nofollow">{$preset_translations.contact_now}</a></div>
                            </div>
                        </div>
{foreachelse}
                        <p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
{/foreach}
                    </div>
                </div>
                <!--products-box-->
{if $total_products > $page_size}
                <div class="view-page fl-clr">
                    <div class="page">
                        <label>Page</label><span><i>{$page_no}</i>/{$total_pages}</span>
    {-if $page_no > 1}
        {-if $phrase|default:''}
                        <a href="{$phrase|url:'enterprise_url_product_search':($page_no-1)}" class="prev"></a>
        {-else}
                        <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}" class="prev"></a>
        {-/if}
    {-/if}
    {-if $page_no < $total_pages}
        {-if $phrase|default:''}
                        <a href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" class="next"></a>
        {-else}
                        <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" class="next"></a>
        {-/if}
    {-/if}
                    </div>
                </div>
{/if}
                <!--view-page-->
            </div>
            <!--right-content--> 
        </div>
        <!--main-content--> 
{include file="sets/trade/common/main_products.tpl"}
    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>
