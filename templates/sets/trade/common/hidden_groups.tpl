{if $hidden_groups}
        <div class="newsticker">
            <div class="marquee-sibling">All Groups</div>
            <div id="wrapper" class="wrapper">
                <div class="inner">
                    <p class="marquee-links">
    {-foreach $groups as $group}{if !array_key_exists($group.id, $hidden_groups)}{continue}{/if}
                        <a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a>
    {-/foreach}
                    </p>
                </div>
            </div>
        </div>
{/if}