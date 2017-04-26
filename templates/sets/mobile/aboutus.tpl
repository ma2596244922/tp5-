<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
{include file="sets/mobile/common/meta.tpl"}
{include file="sets/mobile/common/definitions.tpl"}
{include file="sets/mobile/common/styles.tpl"}
    </head>
<body class="bj-fff">
<div class="content">
{include file="sets/mobile/common/logobar.tpl"}
{include file="sets/mobile/common/navbar.tpl" page_name="aboutus"}
    <div class="banner">
        <div class="swiper-container">
                <ul class="swiper-wrapper" style=" width:1000%">
{foreach $photos as $photo}
                    <li class="swiper-slide"><img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" width="100%" alt=""></li>
{/foreach}
                </ul>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <section>
        <h2 class="title-t">Company Details</h2>
        <ul class="about-info">
            <li><span class="t">Business Type</span>{$corporation.business_type}</li>
            <li><span class="t">Main Market</span>{$corporation.main_market}</li>
            <li><span class="t">Brands</span>{$corporation.brands}</li>
            <li><span class="t">No. of Employees</span>{$corporation.no_of_employees}</li>
            <li><span class="t">Annual Sales</span>{$corporation.annual_sales}</li>
            <li><span class="t">Year Established</span>{$corporation.year_established}</li>
            <li><span class="t">Export p.c</span>{$corporation.export_p_c}</li>
        </ul>
    </section>
    <section>
        <h2 class="title-t">Company Introduction</h2>
        <ul class="about-info">
            <li class="text-txt">
                <div class="txt" data-role="txt">{$corporation.introduction}</div>
                <span class="text-a" data-role="text-a">View more<i></i></span>
            </li>
            <li><span class="t tt">Contact Info</span><a href="/contactus.html" class="see">See detail<i></i></a></li>
        </ul>
    </section>
    <section>
        <h2 class="title-t">History</h2>
        <ul class="about-info">
            <li class="text-txt">
                <div class="txt" data-role="txt">{$corporation.history}</div>
                <span class="text-a" data-role="text-a">View more<i></i></span>
            </li>
        </ul>
    </section>
    <section>
        <h2 class="title-t">Service</h2>
        <ul class="about-info">
            <li class="text-txt">
                <div class="txt" data-role="txt">{$corporation.service}</div>
                <span class="text-a" data-role="text-a">View more<i></i></span>
            </li>
        </ul>
    </section>
    <section>
        <h2 class="title-t">Our Team</h2>
        <ul class="about-info">
            <li class="text-txt">
                <div class="txt" data-role="txt">{$corporation.our_team}</div>
                <span class="text-a" data-role="text-a">View more<i></i></span>
            </li>
        </ul>
    </section>
</div>
<!--content-->
{include file="sets/mobile/common/footer.tpl"}
{include file="sets/mobile/common/floatingbar.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/swiper/3.3.1/swiper.jquery.min.js"></script>
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/mobile/shopindex.js"></script> 
{$site.common_fragment}
</body>
</html>
