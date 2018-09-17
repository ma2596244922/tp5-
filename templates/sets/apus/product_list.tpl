<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    {include file="sets/trade/common/tdk.tpl"}
    <link type="text/css" rel="stylesheet" href="/media/sets/apus/css/theme.min.css" />
    <link type="text/css" rel="stylesheet" href="/media/sets/apus/css/enquiry2017.min.css" />
</head>
<body>
{include file="sets/apus/common/header.tpl"}

<div style="height:258px; display:block">
    {foreach $banners as $banner}{if $banner@index>=1} break{/if}
        <img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}">
    {/foreach}
</div>
<div class="place bw_1190" id="place">
    <div class="here fl-left">
        <span><a href="/" title="{$preset_translations.home}">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        {-if $group|default:[]}
        <a href="/products.html">{$preset_translations.products}</a>&gt;<div class="fl-bold">{$group.name}</div>
        {-elseif $phrase|default:''}
        <a href="/products.html">{$preset_translations.products}</a>&gt;<div class="fl-bold">{$phrase}</div>
        {-else}
        <div class="fl-bold">{$preset_translations.products}</div>
        {-/if}
    </div>
</div>

<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="content_left">
            <div class="title"><span>{$preset_translations.product_categories}</span></div>
            <div class="left_nav">
                <ul>
                    {foreach $groups as $g}
                    <li>
                        <div class="t"><i></i>
                            <a title="{$g.name}" href="{$g|url:'enterprise_url_product_list'}">{$g.name}</a>
                        </div>
                    </li>
                    {/foreach}
                </ul>
                <div class="more"><span>More</span></div>
            </div>

        </div>
        <div class="content_right">
            <div class="section">
                <span class="gorth2">
                    {-if $group|default:[]}
                    {$group.name}
                    {-elseif $phrase|default:''}
                    {$phrase}
                    {-else}
                    {$preset_translations.all_products}
                    {-/if}
                </span>
            </div>
            <div class="right-content">
                {include file="sets/june-sky/common/list.tpl"}
                <!--products-box-->
                <!--view-page-->
            </div>
            <ul class="cp_dt fl-clr">
                {foreach $products as $product}
                <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}" target="_blank"><span></span>{$product.caption|escape}</a></li>
                {/foreach}
            </ul>
            <div class="paging_box">
                {if $total_products > $page_size}
                <div id="Pagination" class="pagination">
                    <div class="resultNum"></div>
                    <div class="pagearea">
                        {-if $page_no > 1}
                        <a href='{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}' class='rollPage' rel='nofollow' title='Prev' >Prev Page</a>
                        {-/if}

                        {-if $page_no < $total_pages}
                        <a href='{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}' class='rollPage' rel='nofollow' title='Next' >Next Page</a>
                        {-/if}
                    </div>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>
{include file="sets/apus/common/footer.tpl"}

{include file="sets/apus/common/script.tpl"}
</body>
</html>