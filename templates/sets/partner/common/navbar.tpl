<div class="nav">
    <div class="nav-inner">
        <ul>
            <li><a href="/">{$preset_translations.home}</a></li>
            <li><a href="/products.html">{$preset_translations.product_categories}</a></li>
            <li><a href="/aboutus.html">{$preset_translations.company_introduction}</a></li>
            <li><a href="/quality.html">{$preset_translations.quality_control}</a></li>
            <li><a href="/contactus.html">{$preset_translations.contact_us}</a></li>
            <li><a href="/contactnow.html">{$preset_translations.request_a_quote}</a></li>
        </ul>
        <div class="search">
        </div>
        <div class="select-flag current" data-role="selectParent">
            <div class="select-box fl-clr" data-role="ShowParent">
                <span class="selectTxt" data-role="SearchShow"><img src="/media/sets/partner/images/langflags/en.png" width="16" height="11">English</span>
                <i></i>
            </div>
            <div class="selectMenu" style="display:none;" data-role="ListType">
                {foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                <a href="http://{$lc}.{$site_root_domain}/" style="display: block;"><img src="/media/sets/partner/images/langflags/{$lc}.png" width="16" height="11">{$meta.locale_label}</a>
                {/foreach}
            </div>
        </div>
        <!-- select-flag -->
    </div>
</div>