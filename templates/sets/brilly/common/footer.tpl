{include file="sets/brilly/common/alphabet.tpl"}
<div class="Footer">
  <div class="Page">
    <p class="fl">
      <a href="/aboutus.html" rel="nofollow">{$preset_translations.about_us}</a>
      <span>|</span>
      <a href="/contactus.html" rel="nofollow">{$preset_translations.contact_us}</a>
      <span>|</span>
      <a href="/directory.html">{$preset_translations.site_map}</a>
    </p>
    <p class="fr">
      <a href="http://www.{$site_root_domain}/">International</a>
{foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
      <span>-</span>
      <a href="http://{$lc}.{$site_root_domain}/">{$meta.locale_label}</a>
{/foreach}
    </p>
    <div class="clear"></div>
  </div>
</div>