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
                    <form action="/contactsave.html" id="form-inquiry" method="POST">
                    <input type="hidden" id="subject" name="subject" value="Can you provide me a quote" />
                    <ul class="fl-clr">
                        <li><label><i></i>To</label>{$corporation.name}</li>
                        <li><label><i>*</i>From</label><input type="text" class="txt1 txt-val" id="email" name="email" value="" /></li>
                        <li class="area-li"><label><i>*</i>Message</label>
                        <textarea class="area" id="message" name="message"></textarea></li>
                    </ul>
                    <div class="send-btn"><a href="">SEND NOW</a></div>
                    </form>
                </div>
            </div> 
        </div>
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
