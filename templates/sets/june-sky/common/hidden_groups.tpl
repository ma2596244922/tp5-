{if $hidden_groups}
<div class="link_0">
    <div class="link">
        <dl class=" fl-clr">
            <dt>All Groups</dt>
            <dd>
                {-foreach $groups as $group}{if !array_key_exists($group.id, $hidden_groups)}{continue}{/if}
                        <a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a>
                {-/foreach}
            </dd>
        </dl>
    </div>
</div>
{/if}
