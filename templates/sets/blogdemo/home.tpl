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
{include file="sets/blogdemo/common/banner.tpl"}
{include file="sets/blogdemo/common/nav.tpl"}

    <div class="w970 clean overhide">
        <div class="lside fl">
{foreach $products as $product}
                            <div class="section">
                    <h2>{$product.caption}</h2>
                    <div class="info">{$product.updated}</div>
                    <div class="content">{$product.summary}</div>
                    <a href="{$product|url:'enterprise_url_product'}" class="read">Continue Reading >></a>
                </div>
{/foreach}
                    </div>
{include file="sets/blogdemo/common/sidebar.tpl"}
    </div>
{include file="sets/blogdemo/common/footer.tpl"}
</div>
</body>
</html>