<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$corporation.name}</title>
{include file="sets/trade/common/styles.tpl"}
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
                <div class="contact-msg"> <span class="title">{$corporation.name}</span>
                    <ul>
                        <li><i>Address</i>{$corporation.address}</li>
                        <li><i>Factory Address</i>{$corporation.factory_address}</li>
                        <li><i>Worktime</i>{$corporation.tel_wt}</li>
                        <li><i>Business Phone(Working Time)</i>{$corporation.tel_wt}</li>
                        <li><i>Business Phone(Nonworking Time)</i>{$corporation.tel_nwt}</li>
                        <li><i>Fax</i>{$corporation.fax}</li>
                    </ul>
                    <div class="btn"><a href="/contactnow.html">Contact Now</a></div>
                </div>
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
<div class="service-box">
    <div class="service-list product-list fl-clr">
        <dl>
            <dt>Buy on china.cn</dt>
            <dd><a href="#" rel="nofollow">How to buy</a></dd>
            <dd><a href="#">Browse by catagories</a></dd>
            <dd><a href="#">Browse by Hot regoins</a></dd>
            <dd><a href="#" rel="nofollow">Private Sourcing Events</a></dd>
        </dl>
        <dl>
            <dt>Selling on china.cn</dt>
            <dd><a href="#" rel="nofollow">How to sell</a></dd>
            <dd><a href="#" rel="nofollow">Premium Member</a></dd>
            <dd><a href="#" rel="nofollow">Post Products</a></dd>
            <dd><a href="#" rel="nofollow">Manage Products</a></dd>
        </dl>
        <dl>
            <dt>Services</dt>
            <dd><a href="#" rel="nofollow">Post buying lead</a></dd>
            <dd><a href="#" rel="nofollow">Product Alert</a></dd>
            <dd><a href="#" rel="nofollow">Dispute and Complaint Assistance</a></dd>
        </dl>
        <dl>
            <dt>About</dt>
            <dd><a href="#" rel="nofollow">About us</a></dd>
            <dd><a href="#" rel="nofollow">Link to us</a></dd>
            <dd><a href="#" rel="nofollow">Contact us</a></dd>
            <dd><a href="#">Site map</a></dd>
        </dl>
    </div>
</div>
<!--service-box-->
<div class="footer">
    <div class="foot">
        <ul>
            <li><a href="#" rel="nofollow">About Us</a>|</li>
            <li><a href="#" rel="nofollow">Contact Us</a>|</li>
            <li><a href="#" rel="nofollow">Intellectual Property Policy</a>|</li>
            <li><a href="#" rel="nofollow">Privacy Policy</a>|</li>
            <li><a href="#" rel="nofollow">Terms of Use</a>|</li>
            <li><a href="#" rel="nofollow">Advertise</a>|</li>
            <li><a href="#" rel="nofollow">Partners</a></li>
        </ul>
        <p>China Good Quality {$corporation.xx} Supplier.            Copyright © {$site.start_year} - {$smarty.now|date_format:'%Y'} {$site.root_domain}. All Rights Reserved.</p>
    </div>
</div>
<div class="nav nav-fixed">
    <ul>
        <li><a href="#" title="">Home</a></li>
        <li><a href="#" title="">Product Categories<i></i></a>
            <ul class="nav-list" style="width:228px;">
                <li><a href="#" title="">Bean & Preparation</a></li>
                <li><a href="#" title="">Cereal</a></li>
                <li><a href="#" title="">Cigarette & Tobaccot shirtturkey 100% Cotton</a></li>
                <li><a href="#" title="">Dried Fruit</a></li>
                <li><a href="#" title="">Econ-valuable Vegetable</a></li>
                <li><a href="#" title="">Edible Fungus & Algae</a></li>
                <li><a href="#" title="">Flour & Preparation</a></li>
                <li><a href="#" title="">Flower & Gardening Plant</a></li>
            </ul>
        </li>
        <li><a href="#" title="">Company Profile<i></i></a>
            <ul class="nav-list nav-list1">
                <li><a href="#" title="">Company Introduction</a></li>
                <li><a href="#" title="">Company News </a></li>
                <li><a href="#" title="">Photo Gallery</a></li>
            </ul>
        </li>
        <li><a href="#" title="">Quality Control</a></li>
        <li><a href="#" title="">Contacts</a></li>
    </ul>
</div>
<!--nav--> 
{include file="sets/trade/common/scripts.tpl"}
</body>
</html>
