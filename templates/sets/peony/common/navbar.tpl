    <div class="nav">
            <ul>
                <li><a href="/"{if page_name=="home"} class="current"{/if} title="{$preset_translations.home}" data-scode="">{$preset_translations.home}</a></li>
                <li><a href="/products.html"{if page_name=="product_list"} class="current"{/if} title="{$preset_translations.product_categories}"  data-scode="">{$preset_translations.product_categories}<i></i></a>
                    <ul class="nav-list">
{foreach $groups as $group}
                        <li><a href="{$group|url:'enterprise_url_product_list'}" data-scode="" title="{$group.name}" rel="nofollow">{$group.name}</a></li>
{/foreach}
                    </ul>
                </li>
                <li><a href="/aboutus.html"{if page_name=="aboutus"} class="current"{/if} rel="nofollow" data-scode="" title="{$preset_translations.company_profile}">{$preset_translations.company_profile}<i></i></a>
                    <ul class="nav-list nav-list1">
                        <li><a href="/aboutus.html"{if page_name=="aboutus"} class="current"{/if} data-scode="" rel="nofollow" title=">{$preset_translations.company_introduction}">{$preset_translations.company_introduction}</a></li>
                        <li><a href="/news"{if page_name=="news_list"} class="current"{/if} data-scode="" rel="nofollow" title="{$preset_translations.company_news}">{$preset_translations.company_news}</a></li>
                        <li><a href="/quality.html"{if page_name=="quality"} class="current"{/if} data-scode="" rel="nofollow" title="{$preset_translations.quality_control}">{$preset_translations.quality_control}</a></li>
                    </ul>
                </li>
                <li><a href="/contactus.html"{if page_name=="contactus"} class="current"{/if} data-scode="" rel="nofollow" title="{$preset_translations.contact_us}">{$preset_translations.contact_us}</a></li>
            </ul>
        </div>