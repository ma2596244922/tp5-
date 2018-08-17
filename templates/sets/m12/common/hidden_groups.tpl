{if $hidden_groups}
<table cellpadding="0" cellspacing="0" >
    <tr class="hidden_groups">
        <td valign="top" >
            {-foreach $groups as $group}{if !array_key_exists($group.id, $hidden_groups)}{continue}{/if}
                    <a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a>
            {-/foreach}
        </td>
    </tr>
    <tr class="hidden_groups_more_tr"><td><div class="hidden_groups_more"><span>see more</span></div></td></tr>
</table>
<div class="cb"></div>
{/if}