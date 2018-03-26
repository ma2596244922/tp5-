<!DOCTYPE html>
<html lang="{$lang_code}"{$html_attr_dir}>
<head>
  {$site.common_head_fragment}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  <link rel="stylesheet" type="text/css" href="style.css">
  {include file="sets/trade/common/definitions.tpl"}
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl" page_name="contactus"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}

<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
      {$corporation.name} Contact Info
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
{include file="sets/brilly/common/intronav.tpl"}
{include file="sets/brilly/common/grouppanel.tpl"}
{include file="sets/brilly/common/latestproducts.tpl"}
      </div>
      <div class="Right">
{if $site.contact_content|default:''}
        <div class="ConBox ProductIntro">
          <div class="clear">&nbsp;</div>
          <h2 class="Til"></h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
                {$site.contact_content}
              </div>
            </dd>
          </dl>
        </div>
{else}
    {-foreach $contacts as $contact}
        <div class="CompanyProfile">
          <div class="ConBox Left">
            <div class="clear">&nbsp;</div>
            <h1 class="Til">{$preset_translations.contact_info}</h1>
            <div class="clear"></div>
            <div class="info">
              <table>
        {-foreach $contact as $f => $v}{if $f=='name'}{continue}{/if}
            {-if isset($contact_desc.$f) && $contact.$f}
                <tr>
                  <th>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</th>
                  <td>{$v}</td>
                </tr>
            {-/if}
        {-/foreach}
              </table>
            </div>
          </div>
          <div class="Right">
            <img src="/media/sets/trade/default_photo.jpg"  alt="" title="" class="fl">
            <p>{$contact.name}</p>
            <div class="clear"></div>
          </div>
        </div>
    {-/foreach}
{/if}
{include file="sets/brilly/common/inquiryform.tpl"}
      </div>
    </div>
  </div>
</div>
{include file="sets/brilly/common/links.tpl"}
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

</body>
</html>