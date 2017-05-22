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
{include file="sets/mobile/common/navbar.tpl" page_name="contactus"}
{foreach $contacts as $contact}
    <section>
        <ul class="contact-info">
    {foreach $contact as $f => $v}
        {if isset($contact_desc.$f) && $contact.$f}
            <li><span class="t">{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</span>{$v}</li>
        {/if}
    {/foreach}
        </ul>
    </section>
{/foreach}
</div>
<!--content-->
{include file="sets/mobile/common/footer.tpl"}
{include file="sets/mobile/common/floatingbar.tpl"}
{include file="sets/mobile/common/scripts.tpl"}
{$site.common_fragment}
</body>
</html>
