{if $main_products|default:[]}
        <div class="product-categories">
            <div class="title"><i></i><h2>{$preset_translations.top_products}</h2></div>
            <table cellpadding="0" cellspacing="0">
    {-foreach $main_products as $mp}
        {-if $mp@index%3==0}
                <tr>
        {-/if}
                    <td width="33%"><a href="{$mp.url}"><strong>{$mp.label}</strong></a></td>
        {-if $mp@index%3==2}
                </tr>
        {-/if}
    {-/foreach}
            </table>
        </div>
{/if}