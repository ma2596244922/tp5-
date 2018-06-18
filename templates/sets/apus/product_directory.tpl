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

<div style="background:url(http://www.siketest.com/resource/pc/set-10/img/bn_cp.jpg) no-repeat center center; height:258px; display:block"></div>
<div class="place bw_1190" id="place">
    <div class="here fl-left">
        <span><a href="/" title="{$preset_translations.home}">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$preset_translations.site_map}</div>
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
            <div class="section"><span class="gorth2">{$preset_translations.all_products} Page {$page_no}</span> </div>
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
                        {-if isset($pager_info['prev_page'])}
                        <a href='{$pager_info['prev_page']|url:'enterprise_url_product_directory'}' class='rollPage' rel='nofollow' title='Prev' >Prev Page</a>
                        {-/if}

                        {-if isset($pager_info['next_page'])}
                        <a href='{$pager_info['next_page']|url:'enterprise_url_product_directory'}' class='rollPage' rel='nofollow' title='Next' >Next Page</a>
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