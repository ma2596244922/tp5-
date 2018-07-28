<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel='shortcut icon' href='' />
{include file="sets/trade/common/tdk.tpl"}
{include file="sets/blogdemo/common/stylesheets.tpl"}
{include file="sets/blogdemo/common/def_scripts.tpl"}
</head>

<body>
<div class="wrapper bgWhite">
{include file="sets/blogdemo/common/header.tpl"}
{include file="sets/blogdemo/common/nav.tpl"}
    <div class="w970 clean overhide">
        <div class="lside fl">
            <div class="section">
                <h2>{$product.caption}</h2>
                <div class="info">{$product.updated}</div>
                <div class="content">{$product.description}</div>
            </div>
{if $comments|default:[]}
            <div class="blog_review">
                <div class="rev_list">
    {-foreach $comments as $comment}
                    <div class="item">
                        <div class="clean title">
                            <div class="name fl">{$comment.contact}</div>
                            <div class="date fl"><span>{$comment.issued_on}</span></div>
                        </div>
                        <div class="txt">{$comment.message}</div>
                        <div class="bar">
                            <span class="icon_1" rid="8">&nbsp;</span>
                            <span class="icon_2" rid="8">&nbsp;</span>
                            <span class="num">0</span>
                        </div>
                    </div>
    {-/foreach}
                </div>
            </div>
{/if}
        </div>
{include file="sets/blogdemo/common/sidebar.tpl"}
    </div>
{include file="sets/blogdemo/common/footer.tpl"}
</div>
</body>
</html>