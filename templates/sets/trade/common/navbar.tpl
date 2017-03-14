        <div class="nav{if $position|default:''=='fixed'} nav-fixed{/if}">
            <ul>
                <li><a href="#" title="">Home</a></li>
                <li><a href="#" title="">Product Categories<i></i></a>
                    <ul class="nav-list"{if $position|default:''=='fixed'} style="width:228px;"{/if}>
{foreach $groups as $group}
                        <li><a href="{$group|url:'enterprise_url_product_list'}" title="">{$group.name}</a></li>
{/foreach}
                    </ul>
                </li>
                <li><a href="#">Company Profile<i></i></a>
                    <ul class="nav-list nav-list1">
                        <li><a href="/aboutus.html" title="">Company Introduction</a></li>
                        <li><a href="#" title="">Company News </a></li>
                        <li><a href="#" title="">Photo Gallery</a></li>
                    </ul>
                </li>
                <li><a href="#" title="">Quality Control</a></li>
                <li><a href="#" title="">Contacts</a></li>
            </ul>
        </div>