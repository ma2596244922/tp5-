<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
<link type="text/css" rel="stylesheet" href="media/lightbox/2.8.1/css/lightbox.min.css" />
</head>

<body>
<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl"}
        <!--header-->
{include file="sets/ecs/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">{$preset_translations.home}</a>&gt;<a href="/aboutus.html">{$preset_translations.about_us}</a>&gt;<span>{$corporation.name} {$preset_translations.quality_control}</span></p>
{include file="sets/trade/common/lang_sites.tpl"}
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">
{include file="sets/trade/corporation/qualitypage.tpl"}
            </div>
            <!--right-content--> 
        </div>
        <!--main-content-->
{include file="sets/trade/common/contactform.tpl"}
{include file="sets/trade/common/main_products.tpl"}
    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/ecs/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="media/lightbox/2.8.1/js/lightbox.js"></script>
</body>
</html>