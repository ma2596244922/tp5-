<!DOCTYPE html>
<html{$html_attr_dir}>
    <head>
        {$site.common_head_fragment}
        <meta charset="utf-8" />
        <title>{$title|default:''}</title>
        <meta name="keywords" content="{$keywords|default:''|escape}">
        <meta name="description" content="{$description|default:''|escape}">
{include file="sets/mobile/common/meta.tpl"}
{include file="sets/mobile/common/definitions.tpl"}
{include file="sets/mobile/common/styles.tpl"}
        <link type="text/css" rel="stylesheet" href="/media/sets/mobile/product.css">
    </head>
    <body>
{include file="sets/mobile/common/logobar.tpl"}
{include file="sets/mobile/common/navbar.tpl" page_name="keyword_list"}
        <div class="content">
            <section class="product-list">
                <ul>
{foreach $site_keywords as $keyword}
                    <li><a href="{$keyword.keyword|url:'enterprise_url_product_search'}" title="{$keyword.keyword|escape}"><strong>{$keyword.keyword|escape}</strong><i></i></a></li>
{foreachelse}
                    <li>{$preset_translations.sorry_no_matches_were_found}</li>
{/foreach}
                </ul>
            </section>
{if $total_keywords > $page_size}
            <div class="page">
                <ul>
    {-if isset($pager_info['prev_page'])}
                    <li><a href="{$first_char|url:'enterprise_url_keyword_list':$pager_info['prev_page']}" title="Previous">Previous</a></li>
    {-/if}
                    <li class="pagenum"><span class="current">{$page_no}</span>/<span class="total">{$total_keywords}</span></li>
    {-if isset($pager_info['next_page'])}
                    <li><a href="{$first_char|url:'enterprise_url_keyword_list':$pager_info['next_page']}" title="Next">Next</a></li>
    {-/if}
                </ul>
            </div>
            <!--page-->
{/if}
        </div>
        <!--content-->
{include file="sets/mobile/common/footer.tpl"}
{include file="sets/mobile/common/floatingbar.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
{$site.common_fragment}
</html>