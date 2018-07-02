<div class="box_210" >
    <div class="box_title">Products Categories</div>
    <div class="box_content">
        <div class="sider_list">
            <ul>
            {foreach $groups as $group}{if array_key_exists($group.id, $hidden_groups)}{continue}{/if}
            <li><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a>({$group.cnt})</li>
            {/foreach}

            </ul>
            <div class="cb_10"></div>
        </div>
    </div>
</div>
<div class="cb_10"></div>
<div class="box_210">
    <div class="box_title">Contact Us</div>
    <div class="box_content">
        <div class="address_wrap">
            <table>
                <tr>
                    <td> <img src="/media/sets/june/color1/images/p_01.gif"></td>
                    <td style="color:#FF6000;">
                        <span style="font-size: 11px; display: block;">{$contacts[0].name}</span>
                        <span style="font-size: 11px; display: block;">Tel:{$corporation.tel_wt}</span>
                    </td>
                </tr>
            </table>
            <p>
                <span>{$preset_translations.address}:</span>
                {$corporation.address}
            </p>
            <p>
                <span>Email:</span>
                {if $contacts[0]|default:[]}
                {$contacts[0].email}
                {/if}
            </p>
            <table width="100%" cellspacing="0" cellpadding="0">
                <tbody><tr>
                        <td height="30" align="left" valign="top">
                            <input type="button" class="btn1" onclick="window.location.href='/contactus.html'">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="cb"></div>
</div>