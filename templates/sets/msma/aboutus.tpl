<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/msma/css/common.css" />
<link type="text/css" rel="stylesheet" href="/media/sets/msma/css/shop.css" />
{include file="sets/msma/common/styles.tpl"}
</head>

<body>
{include file="sets/msma/common/logobar.tpl"}
<div class="content">
    <div class="container">

        <div class="crumb">
            <p><a href="/">{$preset_translations.home}</a>&gt;<span>{$corporation.name}</span></p>
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
{include file="sets/trade/corporation/info.tpl"}
            </div>
            <!--right-content--> 
        </div>
        <!--main-content-->

    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/msma/common/links.tpl"}
{include file="sets/msma/common/copyright.tpl"}
{include file="sets/msma/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/msma/js/product.js"></script>

<!--<div style=""></div>-->

</body>
</html>

