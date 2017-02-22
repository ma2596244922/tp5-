{if count($product_specifications)>0}
<table cellpadding="0" cellspacing="0" class="details_table">
    <tbody>
    {foreach $product_specifications as $k=>$v}
        {if $v@index%2==0}
            <tr {if $v@index%4==2}class="bg_gray"{/if} >
        {/if}
                <th>{$k}:</th>
        <td>{$v}</td>
        {if $v@index%2==1}
                </tr>
        {/if}
    {/foreach}
        </tbody>
</table>
{/if}