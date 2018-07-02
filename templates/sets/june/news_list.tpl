<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/june/common/styles.tpl"}
    <link href="/media/sets/june/color7/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/june/common/header.tpl"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.news}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/june/common/left.tpl"}
        <div class="cb_10"></div>
        {include file="sets/june/common/left_chat.tpl"}
    </div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="box_title">{$preset_translations.company_news}</div>
            <div class="box_content">
                <div class="news_li">
                    <ul>
                        {foreach $news as $n}
                        <li><a href="{$n|url:'enterprise_url_news'}"> {$n.caption} </a><span>{$n.created}</span></li>
                        {foreachelse}
                            <p><i></i>{$preset_translations.the_user_has_not_provide_such_information}.</p>
                        {/foreach}
                    </ul>
                </div>
                <div class="cb_10"></div>
                {include file="sets/june/common/pager_product.tpl"}
            </div>
        </div>
        <div class="cb_10"></div>

    </div>

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june/common/footer.tpl"}
{include file="sets/june/common/scripts.tpl"}

</body>
</html>