<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>{$title}</title>
{include file="sets/mobile/common/meta.tpl"}
{include file="sets/mobile/common/definitions.tpl"}
        <link type="text/css" rel="stylesheet" href="/media/sets/mobile/send-inquiry.css">
    </head>
<body>
<header class="title-header">
    <a href="{$smarty.server.HTTP_REFERER}" class="back"></a>
    <span>Contact Suppliers</span>
</header>
<!--header-->
<div class="content">
{if $target_product|default:[]}
    <div class="product-inquiry">
        <img src="{$target_product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" />
        <span>{$target_product.caption}</span>
    </div>
{/if}
    <!--product-inquiry-->
    <form action="/contactsave.html" id="form-inquiry" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="message_type" value="text/plain" />
    <input type="hidden" name="target_product_id" value="{$target_product_id}" />
    <input type="hidden" name="subject" value="{$subject|escape}" />
    <input type="hidden" name="back_to" value="{$smarty.server.HTTP_REFERER}" />
    <div class="form-inquiry">
        <ul>
            <li class="fl-clr"><label>From</label><input type="text" class="txt" placeholder="Please Enter your Email Address" id="email" name="email" /><span class="error" id="email_info"></span></li>
            <li class="company fl-clr"><label>To</label><i>{$corporation.name}</i></li>
        </ul>
        <div class="inquiry-detail">
            <dl>
                <dt>Quick question</dt>
{foreach $quick_questions as $q}{if $q@index>=4}{break}{/if}
                <dd>{$q|truncate:22}
                    <span>{$q}</span>
                </dd>
{/foreach}
            </dl>
            <textarea placeholder="This is the default language." class="area" id="area" name="message"></textarea>
            <span class="area_error" id="area_error">Your inquiry content must be between 20 to 5000 characters.</span>
            <a href="javascript:send_inquiry();" class="send-inquiry">Send Inquiry</a>
        </div>
        <p><input type="checkbox" value="1" id="checkboxFiveInput" name="iscontact" /><label for="checkboxFiveInput"  class="check"></label>Please reply me within 24 hours.</p>
        <p><input type="checkbox" value="1" id="checkboxFiveInput2" name="newsletter" /><label for="checkboxFiveInput2" class="check"></label>Yes! I would like your verified suppliers matching service!</p>
    </div>
    </form>
    <!--form-inquiry-->
</div>
<!--content-->
{include file="sets/mobile/common/footer.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
<script charset="utf-8" type="text/javascript" src="/media/jquery.validation/master/jquery.validation.min.js"></script>
<script charset="utf-8" type="text/javascript" src="/media/sets/mobile/send-inquiry.js"></script>
</body>
</html>
