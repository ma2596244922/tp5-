<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="news_detail"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p>
                <a href="/">{$preset_translations.home}</a>&gt;
                <a href="/news">{$preset_translations.news}</a>&gt;
                <span>{$news.caption}</span>
            </p>
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
                <div class="product-box news-box">
                    <div class="news-detail">
                        <div class="title-news"><span>{$news.caption}</span><i>{$news.created}</i></div>
                        <div class="news-art">
{if $news.head_image_id}
                        <img src="{$news.head_image_id|url:'enterprise_url_image':$news.caption:''}" width="700" alt="" />
{/if}
                        {$news.content}
                        </div>
                    </div>
                    <div class="next-prev">
                        <ul>
{if $prev_news|default:[]}
                            <li><span>{$preset_translations.previous_page}</span><a href="{$prev_news|url:'enterprise_url_news'}">{$prev_news.caption}</a></li>
{/if}
{if $next_news|default:[]}
                            <li class="next"><span>{$preset_translations.next_page}</span><a href="{$next_news|url:'enterprise_url_news'}">{$next_news.caption}</a></li>
{/if}
                        </ul>
                        <i></i>
                    </div>
                </div>    
            </div>
            <!--right-content--> 
        </div>
        <!--main-content-->
        <div class="new-products">
            <div class="title"><i></i>{$preset_translations.new_products}</div>
            <ul class="fl-clr">
{foreach $new_products as $product}{if $product@index>=5}{break}{/if}
                <li><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"><i>{$product.caption|escape}</i></a></li>
{/foreach}
            </ul>
        </div>
{include file="sets/trade/common/main_products.tpl"}
{include file="sets/trade/common/hidden_groups.tpl"}
    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>
