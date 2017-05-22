        <div class="nav{if $position|default:''=='fixed'} nav-fixed{/if}">
            <ul>
                <li><a href="/" title="">{$preset_translations.home}</a></li>
                <li><a href="/products.html" title="">{$preset_translations.product_categories}<i></i></a>
                    <ul class="nav-list"{if $position|default:''=='fixed'} style="width:228px;"{/if}>
{foreach $groups as $group}
                        <li><a href="{$group|url:'enterprise_url_product_list'}" title="">{$group.name}</a></li>
{/foreach}
                    </ul>
                </li>
                <li><a href="/aboutus.html">{$preset_translations.company_profile}<i></i></a>
                    <ul class="nav-list nav-list1">
                        <li><a href="/aboutus.html">{$preset_translations.company_introduction}</a></li>
                        <li><a href="/news">{$preset_translations.company_news}</a></li>
                    </ul>
                </li>
                <li><a href="/quality.html" title="">{$preset_translations.quality_control}</a></li>
                <li><a href="/contactus.html" title="">{$preset_translations.contact_us}</a></li>
            </ul>
        </div>