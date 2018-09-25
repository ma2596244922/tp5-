<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title|default:''}</title>
<meta name="keywords" content="{$keywords|default:''|escape}" />
<meta name="description" content="{$description|default:''|escape}" />
{include file="sets/trade/common/definitions.tpl" page_name="keyword_list"}
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>
{include file="sets/m12/common/header.tpl" cur="news"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.news}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/m12/common/left.tpl"}
        <div class="cb_10"></div>
    </div>
        <div class="crumb">
            <p>
                <a href="/">{$preset_translations.home}</a>&gt;
                <span>{$first_char} Keyword List</span>
            </p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
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
<!--content-->
{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}
</body>
</html>