<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    {include file="sets/june-sky/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="product_list"}
    {include file="sets/june-sky/common/styles.tpl"}
</head>

<body>
<div class="content content-map">
    <div class="container">
        {include file="sets/june-sky/common/header.tpl" cur="product"}
        <!-- header -->

        <div style="background:url(/media/sets/june-sky/img/bn_cp.jpg) no-repeat center center; height:258px; display:block"></div>
        <div class="place bw_1190" id="place">
            <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
                <div class="fl-bold">{-if $group|default:[]}{$group.name}{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.products}{-/if}</div>
            </div>
        </div>
        <!--nav-->
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
</div>
<!--content-->
{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl" page_name="product"}
</body>
</html>