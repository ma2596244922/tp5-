<div class="head_0">
    <div class="bw_1190">
        <div class="logo">
            <a href="/" class="logo-img" target="_blank">
                <img src="{$corporation.logo|url:'enterprise_url_image'}" width="50" height="45" alt="{$corporation.name|escape}">
            </a>
            <a href="/" title="{$corporation.name|escape}" class="xmt">
                {if $cur=='home'}<h1>{$corporation.name}</h1>{else}<strong>{$corporation.name}</strong>{/if}
            </a>
        </div>
        <ul class="hd_dh fl-clr">
            <li>
                <a href="/" title="{$preset_translations.home}" {if $cur=='home'} class="cut"{/if}>{$preset_translations.home}</a>
            </li>
            <li>
                <a href="/products.html" title="{$preset_translations.products}" {if $cur=='product'} class="cut"{/if}>{$preset_translations.products}</a>
            </li>
            <li>
                <a href="/aboutus.html" title="{$preset_translations.company_profile}" {if $cur=='aboutus'} class="cut"{/if}>{$preset_translations.company_profile}</a>
            </li>
            <li>
                <a href="/news" title="{$preset_translations.company_news}" {if $cur=='news'} class="cut"{/if}>{$preset_translations.company_news}</a>
            </li>
            <li>
                <a href="/contactus.html" title="{$preset_translations.contact_us}" {if $cur=='contactus'} class="cut"{/if}>{$preset_translations.contact_us}</a>
            </li>
            <li>
                <a href="/directory.html" title="{$preset_translations.site_map}" {if $cur=='sitemap'} class="cut"{/if}>{$preset_translations.site_map}</a>
            </li>
           
        </ul>
        <div class="select-flag current" data-role="selectParent">
            <div class="select-box fl-clr" data-role="ShowParent">
                <span class="selectTxt" data-role="SearchShow"><img src="/media/sets/june-sky/img/langflags/{$lang_code|default:'en'}.png" width="16" height="11">{$supported_lang_codes[$lang_code].locale_label|default:'English'}</span>
                <i></i>
            </div>
            <div class="selectMenu" style="display:none;" data-role="ListType">
            {foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                <a href="http://{$lc}.{$site_root_domain}/" rel="nofollow"><img src="/media/sets/june-sky/img/langflags/{$lc}.png" width="16" height="11" />{$meta.locale_label}</a>
            {/foreach}
            </div>
        </div>
    </div>
</div>