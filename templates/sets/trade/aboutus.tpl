<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/shopstyles.tpl"}
</head>

<body>

<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;<span>{$corporation.name}</span></p>
        </div>
        <!--crumb-->
        <div class="main-content fl-clr">
            <div class="left-content">
                <div class="menu-list">
                    <dl>
                        <dt>Company Overview</dt>
                        <dd><a href="/aboutus.html" class="current" title="">Company Introduction</a></dd>
                        <dd><a href="#" title="">Company News </a></dd>
                        <dd><a href="#" title="">Photo Gallery</a></dd>
                    </dl>
                </div>
{include file="sets/trade/common/contactpanel.tpl"}
            </div>
            <!--left-content-->
            <div class="right-content">
                <div class="product-box news-box">
                    <div class="title"><i></i>Contact Information</div>
                    <div class="news-detail">
                        <div class="news-art intro-art">
                            <div class="scrollArea" id="scrollArea">
{foreach $photos as $photo}
                                <a class="c1"><img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" alt="" /></a>
{/foreach}
                                <ul class="small-list" id="small-list">
{foreach $photos as $photo}
                                    <li{if $photo@index==0} class="current"{/if}></li>
{/foreach}
                                </ul>
                            </div>
                            <div class="intro-txt">
                                {$corporation.introduction}
                            </div>
                            <div class="intro-txt">
                                <div class="title"><i></i>Company Details</div>
                                <ul class="fl-clr">
                                    <li><label>Business Type</label><span>{$corporation.business_type}</span></li>
                                    <li><label>Main Market</label><span>{$corporation.main_market}</span></li>
                                    <li><label>Brands</label><span>{$corporation.brands}</span></li>
                                    <li><label>No. of Employees</label><span>{$corporation.no_of_employees}</span></li>
                                    <li><label>Annual Sales</label><span>{$corporation.annual_sales}</span></li>
                                    <li><label>Year Established</label><span>{$corporation.year_established}</span></li>
                                    <li><label>Export p.c</label><span>{$corporation.export_p_c}</span></li>
                                </ul>
                            </div>
                            <div class="intro-txt">
                                <div class="title"><i></i>History</div>
                                {$corporation.history}
                            </div>
                            <div class="intro-txt">
                                <div class="title"><i></i>Service</div>
                                {$corporation.service}
                            </div>
                            <div class="intro-txt last-txt">
                                <div class="title"><i></i>Our Team</div>
                                {$corporation.our_team}
                            </div>
                            
                        </div>
                    </div>
                </div>    
            </div>
            <!--right-content--> 
        </div>
        <!--main-content-->
    </div>
    <!--container--> 
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
<!--nav--> 
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>
