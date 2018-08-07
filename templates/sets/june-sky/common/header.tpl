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
                <span class="selectTxt" data-role="SearchShow"><img src="/media/sets/june-sky/img/langflags/en.png" width="16" height="11">English</span>
                <i></i>
            </div>
            <div class="selectMenu" style="display:none;" data-role="ListType">
                <a href="#" style="display: none;"><img src="/media/sets/june-sky/img/langflags/en.png" width="16" height="11">English</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/ar.png" width="16" height="11">العربية</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/de.png" width="16" height="11">Deutsch</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/el.png" width="16" height="11">Ελληνικά</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/es.png" width="16" height="11">Español</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/fr.png" width="16" height="11">Français</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/id.png" width="16" height="11">Bahasa Indonesia</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/it.png" width="16" height="11">Italiano</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/ja.png" width="16" height="11">日本語</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/pt.png" width="16" height="11">Português</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/ru.png" width="16" height="11">Русский язык</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/sq.png" width="16" height="11">Shqip</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/sv.png" width="16" height="11">Svenska</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/th.png" width="16" height="11">ไทย</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/tr.png" width="16" height="11">Türkçe</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/uk.png" width="16" height="11">Українська</a>
                <a href="#" style="display: block;"><img src="/media/sets/june-sky/img/langflags/zh.png" width="16" height="11">中文</a>
            </div>
        </div>
    </div>
</div>