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
            <p><a href="/">Home</a>&gt;<span>{$corporation.name} Contact Info</span></p>
        </div>
        <!--crumb-->
{foreach $contacts as $contact}
        <div class="contact-communication fl-clr">
            <div class="left-intro">
                <img src="/media/sets/trade/default_photo.jpg" />
                <span>Mr. James</span>
            </div>
            <div class="right-intro">
                <ul>
    {foreach $contact as $f => $v}
        {if isset($contact_desc.$f) && $contact.$f}
                    <li><label>{$contact_desc.$f}</label>{$v}</li>
        {/if}
    {/foreach}
                </ul>
            </div>
        </div>
{/foreach}
        <!--contact-msg-->
        <div class="contact-us contact-us1">
            <div class="title"><i></i>Send Inquiry</div>
            <div class="contact-info contact-info1 fl-clr">
                <div class="right-list">
                    <ul class="fl-clr">
                        <li><label><i></i>To</label>Top Biology Pharmacy Co.,Ltd</li>
                        <li><label><i>*</i>From</label><input type="text" class="txt1 txt-val" value="Edison light ce rohs ul led filament bulb light st58 in 2016" /></li>
                        <li class="area-li"><label><i>*</i>Message</label>
                        <textarea class="area">For the best results, we recommend including the following details:
-Self introduction\n
-Required specifications\n
-Inquire about price/MOQ</textarea></li>
                    </ul>
                    <div class="send-btn"><a href="#">SEND NOW</a></div>
                </div>
            </div> 
        </div>
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
        <p>京ICP证 040089号 京公网安备11010802017131</p>
    </div>
</div>
<div class="nav nav-fixed">
    <ul>
        <li><a href="#" title="">Home</a></li>
        <li><a href="#" title="">Product Categories<i></i></a>
            <ul class="nav-list">
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
<script charset="utf-8" language="javascript" type="text/javascript" src="http://himg.china.cn/js/common/jquery/1.11.3/jquery.min.js"></script> 
<script charset="utf-8" language="javascript" type="text/javascript" src="http://himg.china.cn/js/env2/main/product.js"></script>
<script charset="utf-8" language="javascript" type="text/javascript" src="http://himg.china.cn/js/env2/common/floating_box.js"></script>
</body>
</html>
