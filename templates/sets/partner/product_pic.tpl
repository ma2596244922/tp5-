
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
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
        <div class="pro-big">
            <h1 id="proName">{$product.caption} image</h1>
            <div class="tab fl-clr">
                <ul class="big-show">
                    {-foreach $product_images as $image_id}
                    <li{if $image_id@index==0} style="display:block;"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'t'}"  alt="{$product.caption|escape} #{$image_id@iteration} image"  /></li>
                    {-/foreach}
                </ul>
                <ul class="small-list">
                    {-foreach $product_images as $image_id}
                    <li{if $image_id@index==0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|escape}" /></li>
                    {-/foreach}
                </ul>
            </div>
            <div class="send-btn"><a href="/contactnow.html">Send Message</a></div>
        </div>
        {include file="sets/partner/common/send_msg.tpl"  send_style="1"}
        <!-- send-msg -->
        {include file="sets/partner/common/latest_product.tpl"}
        <!-- intro-pro -->
    </div>
    <!-- left-content -->
    {include file="sets/partner/common/right_list.tpl"}
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
</body>
</html>