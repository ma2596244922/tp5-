{if count($product_specifications)>0}
    {-if empty($specification_columns)}{assign var="specification_columns" value=3}{/if}
        <div class="product-detail">
            <div class="title"><i></i><h2>{$preset_translations.product_details}</h2></div>
            <table cellpadding="0" cellspacing="0">
    {foreach $product_specifications as $k=>$v}
        {if $v@index%$specification_columns==0}
                <tr>
        {/if}
                    <td width="11%" class="title-td">{$k}:</td>
                    <td width="22%">{$v}</td>
        {if $v@index%$specification_columns==2}
                </tr>
        {/if}
    {/foreach}
            </table>
        </div>
{/if}