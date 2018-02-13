<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title|default:''}</title>
<meta name="keywords" content="{$keywords|default:''|escape}" />
<meta name="description" content="{$description|default:''|escape}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
<div class="content content-map">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="keyword_list"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p>
                <a href="/">{$preset_translations.home}</a>&gt;
                <span>{$preset_translations.site_map}</span>
            </p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
        <!--crumb-->
        <div class="product-map">
            <div class="title"><span></span><h1>A Keyword List Page {$page_no}</h1></div>
            <div class="product-list">
                <ul class="fl-clr">
{foreach $site_keywords as $keyword}
    {-if $keyword@index>0 && $keyword@index%10==0}
                </ul>
                <ul class="fl-clr">
    {-/if}
                    <li><em></em><a href="{$keyword|url:'enterprise_url_product_search'}" title="{$keyword.keyword|escape}">{$keyword.keyword}</a></li>
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
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>