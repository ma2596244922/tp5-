        <div class="select-flag" data-role="selectParent">
            <div class="select-box fl-clr" data-role="ShowParent">
                <span class="selectTxt" data-role="SearchShow"><img src="/media/langflags/{$lang_code}.png" width="16" height="11" />{$supported_lang_codes[$lang_code].locale_label|default:'English'}</span>
                <i></i>
            </div>
            <div class="selectMenu" style="display:none;" data-role="ListType">
                <a href="http://www.{$site_root_domain}/"><img src="/media/langflags/en.png" width="16" height="11" />English</a>
{foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                <a href="http://{$lc}.{$site_root_domain}/"><img src="/media/langflags/{$lc}.png" width="16" height="11" />{$meta.locale_label}</a>
{/foreach}
            </div>
        </div>