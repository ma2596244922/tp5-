<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;<a href="/aboutus.html">About Us</a>&gt;<span>{$corporation.name} Quality Control</span></p>
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
{include file="sets/trade/common/grouppanel.tpl"}
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">
                <div class="product-box quality-box">
                    <div class="title"><i></i><h2>Quality Control</h2></div>
                    <div class="quality-list">
                        {$corporation.qc_profile}
                    </div>
                </div>
                <!--products-box-->
                <div class="product-box certification-box">
                    <div class="title"><i></i><h2>Certifications</h2></div>
                    <div class="certification-list fl-clr">
{foreach $certifications as $cert}
                        <div class="certification-detail">
                            <div class="left-img">
                                <a href="{$cert.uri|url:'enterprise_url_photo'}" title="{$cert.standard|default:''}" data-lightbox="certificate-set">
                                    <img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="120" height="168" style="margin: 10px auto;" />
                                </a>
                            </div>
                            <ul>
    {if $cert.standard|default:''}
                                <li><label>Standard</label><span>{$cert.standard}</span></li>
    {/if}
    {if $cert.number|default:''}
                                <li><label>Number</label><span>{$cert.number}</span></li>
    {/if}
    {if $cert.issue_date|default:''}
                                <li><label>Issue Date</label><span>{$cert.issue_date}</span></li>
    {/if}
    {if $cert.expiry_date|default:''}
                                <li><label>Expiry Date</label><span>{$cert.expiry_date}</span></li>
    {/if}
    {if $cert.scope_n_range|default:''}
                                <li><label>Scope/Range</label><span>{$cert.scope_n_range}</span></li>
    {/if}
    {if $cert.issued_by|default:''}
                                <li><label>Issued By</label><span>{$cert.issued_by}</span></li>
    {/if}
                            </ul>
                        </div>
{/foreach}
                    </div>
                </div>
                <!--products-box-->
            </div>
            <!--right-content--> 
        </div>
        <!--main-content-->
{include file="sets/trade/common/contactform.tpl"}
    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="media/lightbox/2.8.1/js/lightbox.js"></script>
</body>
</html>
