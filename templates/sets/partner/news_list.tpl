
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
</head>
<body>
{include file="sets/partner/common/header.tpl"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
{include file="sets/partner/common/banner.tpl"}
<!-- banner -->
<div class="content fl-clr">
    <div class="left-content">
        <div class="title-left">
            <h1>ALL News</h1>
            <i></i>
        </div>
        <div class="product-list">
            <ul class="fl-clr">
                {foreach $news as $n}
                <li>
                    <a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}" ><img src="{$n.head_image_id|url:'enterprise_url_image':$news.caption:''}" alt="{$n.caption}" /></a>
                    <span><a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}">{$n.caption}</a></span>
                </li>
                {/foreach}
            </ul>
        </div>
        <!-- product-list -->
        {if $total_news > $page_size}
        <div class="page">
            {-if isset($pager_info['prev_page'])}
            <a href="{$pager_info['prev_page']|url:'enterprise_url_news_list'}" title="Prev" class="prev">&lt;&nbsp;Prev</a>
            {-/if}
            {-if isset($pager_info['next_page'])}
            <a href="{$pager_info['next_page']|url:'enterprise_url_news_list'}" title="Next" class="next">Next&nbsp;&gt;</a>
            {-/if}
        </div>
        {/if}
        <!-- page -->
    </div>
    <!-- left-content -->
    {include file="sets/partner/common/right_list.tpl"}
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
</body>
</html>