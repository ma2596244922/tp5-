                <div class="menu-list">
                    <dl>
                        <dt>Product Groups</dt>
{foreach $groups as $g}{assign var="gid" value={$g.id|default:$g.group_id}}
                        <dd><a href="{$g|url:'enterprise_url_product_list'}"{if isset($group)&&$gid=={$group.id|default:'0'}} class="current"{/if} title="{$g.name}"><h2>{$g.name}</h2> ({$g.cnt})</a></dd>
{/foreach}
                    </dl>
                    <div class="see-more"><a href="javascript:void(0);">see more</a><i></i></div>
                </div>