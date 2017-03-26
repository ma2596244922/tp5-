                <div class="menu-list">
                    <dl>
                        <dt>Product Groups</dt>
{foreach $groups as $g}
                        <dd><a href="{$g|url:'enterprise_url_product_list'}"{if $g.id==$group.id|default:'0'} class="current"{/if} title="{$g.name}"><h2>{$g.name}</h2> ({$g.cnt})</a></dd>
{/foreach}
                    </dl>
                </div>