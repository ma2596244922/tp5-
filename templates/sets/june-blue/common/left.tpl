<div class="cb"></div>
<div class="search_wrap">
    <div>
            <input class="se_text" type="text" id="kw"/>
            <input class="btn2" type="button" value="" onclick="SearchProducts()"/>
    </div>
</div>
<div class="cb_10"></div>
<div class="sider_list">
    <div class="box_border">
        <div class="tit"><h2>{$preset_translations.product_categories}</h2></div>
        <div class="menu-list">
            <ul>
                 {foreach $groups as $group}{if array_key_exists($group.id, $hidden_groups)}{continue}{/if}
                <li><strong><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a></strong></li>
                {/foreach}
            </ul>
            <div class="see-more" style="display: none;"><a href="javascript:void(0);">see more</a><i class=""></i></div>
            <div class="cb"></div>
        </div>
    </div>
</div>
<div class="cb_10"></div>
<div class="sider_con_wrap ">
    <div class="box_border">
        <div class="tit"><h2>{$preset_translations.contact_us}</h2></div>
        <p style="color:#FF6000;">
            <span style="font-size: 12px; line-height: 24px; font-weight: bold;">{$contacts[0].name}</span>
            <span>Tel:{$corporation.tel_wt}</span>
        </p>
        <p>
            <span>{$preset_translations.address}:</span>
            {$corporation.address}
        </p>
        <p>
            <span>Email:</span>
            {$contacts[0].email}
        </p>
        <table width="100%" cellspacing="0" cellpadding="0">
            <tbody><tr>
                    <td height="45" align="left" valign="top">
                        <input type="button" class="btn1" onclick="window.location.href='/contactnow.html'">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="cb_10"></div>
<div class="sider_con_wrap ">
    
    <div class="box_border">
        <div class="tit"><h2>{$preset_translations.certifications}</h2></div>
        <table class="cer_warp" cellspacing="0" cellpadding="0">
            <tbody><tr>
                {assign var="certification_left" value=enterprise_get_certification_list($site.site_id,1,2) }
                
                {foreach $certification_left as $cert}{if $cert@index>2}{continue}{/if}
                    <td align="center">
                        <img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="75" height="100" />
                    </td>
                {/foreach}
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="cb_10"></div>
<div class="sider_box">
    <dl class="l_msy">
        <dt><span>I am Online Chat Now</span></dt>
        <dd>
            <div class="one"><a href="#" rel="nofollow"></a></div>
            <div class="two"><a href="#" rel="nofollow"></a></div>
            <div class="three"><a href="#" rel="nofollow"></a></div>
            <div class="four"><a href="#" rel="nofollow"></a></div>
            <div class="five"><a href="#" rel="nofollow"></a></div>
        </dd>
    </dl>
    <div class="cb_10"></div>
</div>
<div class="cb"></div>