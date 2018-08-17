<div class="tit"><h2>{$preset_translations.product_categories}</h2></div>
<div class="sider_list menu-list">
    <ul>
        {foreach $groups as $group}{if array_key_exists($group.id, $hidden_groups)}{continue}{/if}
        <li><strong><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a></strong></li>
        {/foreach}
    </ul>
    <div class="see-more" style="display: none;"><a href="javascript:void(0);">see more</a><i class=""></i></div>
    <div class="cb_10"></div>
</div>
<div class="cb_10"></div>
<table width="100%">
    <tr>
        {assign var="certification_left" value=enterprise_get_certification_list($site.site_id,1,2) }
        {foreach $certification_left as $cert}{if $cert@index>=2}{continue}{/if}
            <td width="50%" align="center">
                <img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="90" height="100" />
            </td>
        {/foreach}
    </tr>
</table>
<div class="cb_10"></div>
<div class="sider_box">
    <div class="title"><h2>{$preset_translations.contact_us}</h2></div>
    <div class="cp_wrap fl">{$contacts[0].name}</div>
    <div class="cb"></div>
    <div class="icon fl">
        <ul>
            <li class="i_1"></li>
            <li class="i_2"><span></span></li>
            <li class="i_3"></li>
        </ul>
    </div>
    <div class="icon_con fl">
        <div class="icon_text">
            <span>{$corporation.address} </span>
            <div class="cb_10"></div>
        </div>
    </div>
    <div class="cb_10"></div>
    <table width="100%">
        <tr>
            <td align="center" height="50">
                <input class="btn1" type="button" onclick="window.location.href='/contactnow.html'"/>
            </td>
        </tr>
    </table>
    <div class="vcd"><a href="/contactus.html">View Contact Details</a></div>
    <div class="cb"></div>
</div>