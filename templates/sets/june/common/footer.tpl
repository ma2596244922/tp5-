<div class="footer_wrap">
    {include file="sets/june/common/alphabet.tpl"}
    <div class="footer_text">
        <a href="/aboutus.html" title="{$preset_translations.about_us}">{$preset_translations.about_us}</a>
        <a href="/products.html" title="{$preset_translations.products}">{$preset_translations.products}</a>
        <a href="/news" title="{$preset_translations.news}">{$preset_translations.news}</a>
        <a href="/contactus.html" title="{$preset_translations.contact_us}">{$preset_translations.contact_us}</a>
        <a href="/directory.html" title="{$preset_translations.site_map}" class="last">{$preset_translations.site_map}</a>
    </div>
    <div class="footer_cy">
    Copyright © {$site.start_year} - {$smarty.now|date_format:'%Y'} <span class="company-name">{$corporation.name}</span> {$preset_translations.all_rights_reserved}
    </div>
</div>