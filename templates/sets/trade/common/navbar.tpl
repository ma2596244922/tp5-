        <div class="nav{if $position|default:''=='fixed'} nav-fixed{/if}">
            <ul>
                <li><a href="/" title="">Home</a></li>
                <li><a href="/products.html" title="">Product Categories<i></i></a>
                    <ul class="nav-list"{if $position|default:''=='fixed'} style="width:228px;"{/if}>
{foreach $groups as $group}
                        <li><a href="{$group|url:'enterprise_url_product_list'}" title="">{$group.name}</a></li>
{/foreach}
                    </ul>
                </li>
                <li><a href="/aboutus.html">Company Profile</a></li>
                <li><a href="/quality.html" title="">Quality Control</a></li>
                <li><a href="/contactus.html" title="">Contacts</a></li>
            </ul>
        </div>