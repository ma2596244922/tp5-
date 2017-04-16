        <div class="product-categories">
            <div class="title"><i></i><h2>Product Categories</h2></div>
            <table cellpadding="0" cellspacing="0">
{foreach $groups as $group}
    {if $group@index%3==0}
                <tr>
    {/if}
                    <td width="33%"><a href="{$group|url:'enterprise_url_product_list'}"><strong>{$group.name}</strong></a></td>
    {if $group@index%3==2}
                </tr>
    {/if}
{/foreach}
            </table>
        </div>