
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
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
    <div class="left-contact">
        {include file="sets/partner/common/send_msg.tpl"}
    </div>
    <!-- left-content -->
    <div class="right-contact">
        <div class="contact-info">
            <span class="title">Contact Info</span>
            <p>{$site.contact_content} </p>
            {-foreach $contacts as $contact}
            <ul>
                {-foreach $contact as $f => $v}{if $f=='name'}{continue}{/if}
                <li>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</li>
                {-/foreach}
            </ul>
            {-/foreach}
        </div>
    </div>
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
</body>
</html>