
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
    <link type="text/css" rel="stylesheet" href="/media/sets/partner/css/lightbox.css" />
</head>
<body>
{include file="sets/partner/common/header.tpl"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
{include file="sets/partner/common/banner.tpl"}
<!-- banner -->
<div class="content fl-clr">
    <div class="left-content">
        <div class="company-intro quality-info">
            <div class="intro-box">
                <span>Quality Control</span>
                <p>{$corporation.qc_profile}</p>
            </div>
            <div class="intro-box">
                <span>Certifications</span>
                <div class="certification-list fl-clr">
                    {foreach $certifications as $cert}
                    <div class="certification-detail">
                        <div class="left-img">
                                <span>
                                    <a href="{$cert.uri|url:'enterprise_url_photo'}" data-lightbox="certificate-set" data-title="{$cert.standard|default:''}">
                                        <img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}">
                                    </a>
                                </span>
                        </div>
                        <ul>
                            {if $cert.standard|default:''}
                            <li><label>Name</label><span>{$cert.standard}</span></li>
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
                        </ul>
                    </div>
                    {/foreach}
                </div>
                <!-- certification-list -->
            </div>
            {include file="sets/partner/common/send_msg.tpl"}
        </div>
        <!-- news-info -->
    </div>
    <!-- left-content -->
    {include file="sets/partner/common/right_list.tpl"}
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
<script charset="utf-8" type="text/javascript" src="/media/sets/partner/js/lightbox.min.js"></script>
</body>
</html>