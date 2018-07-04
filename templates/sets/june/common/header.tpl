<div class="header">
    <div class="head">
        <table cellpadding="0" cellspacing="0">
            <tbody>
                <tr>
                    <td><div class="logo"><a href="/" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" style="max-height: 50px;" alt="{$corporation.name|escape}"></a></div></td>
                    <td class="head_title">
                        <div>{if isset($ishome)}<h1>{$corporation.name}</h1>{else}<strong>{$corporation.name}</strong>{/if}</div>
                        <p>{$corporation_slogan}</p>
                    </td>
                    <td width="225">
                        <div class="lan_wrap">
                            <div class="sel">{$supported_lang_codes[$lang_code].locale_label|default:'English'}<a href="#" class="col" onclick="open_img(this,event)"></a></div>
                            <div class="cb_5"></div>
                            <p><a href="/contactnow.html" rel="nofollow">{$preset_translations.request_a_quote}</a></p>
                            <div class="cb_5"></div>
                            <p>{$preset_translations.contact_us} {$corporation.tel_wt}</p>
                        </div>

                        <dl id="p_l">
                            <dt><a href="http://www.{$site_root_domain}/" rel="nofollow"><img src="/media/langflags/en.png" width="16" height="11" />English</a></dt>
                        {foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                            <dt><a href="http://{$lc}.{$site_root_domain}/" rel="nofollow"><img src="/media/langflags/{$lc}.png" width="16" height="11" />{$meta.locale_label}</a></dt>
                        {/foreach}
                        </dl>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="menu_wrap">
        <ul >
            <li class="l_b">&nbsp;</li>
            <li><a class="hl_2" href="/">{$preset_translations.home}</a></li>
            <li style=" position: relative;">
                <a class="hl_2" href="/products.html">{$preset_translations.product_categories}</a>
                <div class="show_menu" style="display: none;">
                {foreach $groups as $group}{if array_key_exists($group.id, $hidden_groups)}{continue}{/if}
                <a href="{$group|url:'enterprise_url_product_list'}" title="">{$group.name}</a>
                {/foreach}
                </div>
            </li>
            <li><a class="hl_2" href="/aboutus.html">{$preset_translations.company_profile}</a></li>
            <li><a class="hl_2" href="/quality.html">{$preset_translations.quality_control}</a></li>
            <li><a class="hl_2" href="/news">{$preset_translations.company_news}</a></li>
            <li><a class="hl_2" href="/contactus.html" title="">{$preset_translations.contact_us}</a></li>
            <li class="r_b">&nbsp;</li>
        </ul>
    </div>
    <div class="cb"></div>
</div>

{literal}
<script type="text/javascript">
    function open_img(a,event){
        var div=a.parentNode;
        function get_pos(div){
            var pos={'left':0,'top':0}
            while(1){
                if(!div){
                    break;
                }
                pos['left']+=div.offsetLeft;
                pos['top']+=div.offsetTop;
                div=div.offsetParent;
            }
            return pos;
        }
        var pos=get_pos(div);
        var img=a.firstChild;
        var show=document.getElementById("p_l");
        if(a.className=='col'){
            a.className='ope'
            show.style.width=151+'px';
            show.style.height='auto';
            show.style.display='block';
            show.style.left=pos['left']+"px";
            show.style.top=pos['top']+20+"px";
        }else{
            a.className='col'
            show.style.display='none';
        }
    }
</script>
{/literal}