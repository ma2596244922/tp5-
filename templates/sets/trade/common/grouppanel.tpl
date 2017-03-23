                <div class="menu-list">
                    <dl>
                        <dt>Product Groups</dt>
{foreach $groups as $group}
                        <dd><a href="{$group|url:'enterprise_url_product_list'}"{if $group@index==0} class="current"{/if} title="{$group.name}">{$group.name} ({$group.cnt})</a></dd>
{/foreach}
                    </dl>
                </div>