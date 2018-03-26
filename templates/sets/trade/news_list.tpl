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
{include file="sets/trade/common/logobar.tpl" page_name="news_list"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p>
                <a href="/">{$preset_translations.home}</a>&gt;
                <span>{$preset_translations.news}</span>
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
                <div class="product-box news-box{if !$news|default:[]} quality-none{/if}">
                    <div class="title"><i></i>{$preset_translations.company_news}</div>
                    <div class="news-list">
{foreach $news as $n}
                        <dl>
                            <dt>
                                <a href="{$n|url:'enterprise_url_news'}">{$n.caption}</a>
                                <span class="time">{$n.created}</span>
                            </dt>
                            <dd>{$n.content|strip_tags|truncate:260}</dd>
                        </dl>
{foreachelse}
                        <p><i></i>{$preset_translations.the_user_has_not_provide_such_information}.</p>
{/foreach}
                    </div>
{if $total_news > $page_size}
                    <div class="news-page">
                        <ul>
                            <li>Page<i>{$page_no}</i>of<i>{$total_pages}</i></li>
    {-if isset($pager_info['prev_page'])}
                            <li><a href="{$pager_info['prev_page']|url:'enterprise_url_news_list'}" class="prev"></a></li>
    {-/if}
    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                            <li{if $i==$page_no} class="current"{/if}><a href="{$i|url:'enterprise_url_news_list'}">{$i}</a></li>
    {-/for}
    {-if isset($pager_info['next_page'])}
                            <li><a href="{$pager_info['next_page']|url:'enterprise_url_news_list'}" class="next"></a></li>
    {-/if}
                        </ul>
                    </div>
{/if}
                </div>    
            </div>
            <!--right-content--> 
        </div>
        <!--main-content-->
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
