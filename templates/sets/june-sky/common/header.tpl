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
            <a href="/directory.html" title="{$preset_translations.site_map}" {if $cur=='sitemap'} class="cut"{/if}>{$preset_translations.site_map}</a>
            </li>

            <li>
                <a href="/news" title="{$preset_translations.company_news}" {if $cur=='news'} class="cut"{/if}>{$preset_translations.company_news}</a>
            </li>
            <li>
                <a href="/contactus.html" title="{$preset_translations.contact_us}" {if $cur=='contactus'} class="cut"{/if}>{$preset_translations.contact_us}</a>
            </li>
           
        </ul>
    </div>
</div>