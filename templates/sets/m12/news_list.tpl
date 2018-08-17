<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl" page_name="news_list"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
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

    <div class="content_wrap">
        <div class="main_right_box">

            <div class="title"><h1>{$preset_translations.company_news}</h1></div>
            <div class="box_content">
                <div class="news_li">
                    <ul>
                        {foreach $news as $n}
                        <li><h2><a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}"> {$n.caption}</a></h2><span>{$n.created}</span></li>
                        {foreachelse}
                            <p><i></i>{$preset_translations.the_user_has_not_provide_such_information}.</p>
                        {/foreach}
                    </ul>
                </div>
                <div class="cb_10"></div>
                {include file="sets/m12/common/pager_news.tpl"}
            </div>
            <div class="cb_10"></div>

        </div>
    </div>


    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}

</body>
</html>