<div class="header">
    <div class="head">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td ><div class="logo"><a href="/" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" style="max-height: 50px;" alt="{$corporation.name|escape}"></a></div></td>
                <td class="head_title">{$corporation_slogan}</td>
                <td >
                    <div class="lan_wrap">
                        <div class="raq_wrap"><a href="/contactnow.html" rel="nofollow">{$preset_translations.request_a_quote}</a></div>
                        <div class="sel"><span>{$supported_lang_codes[$lang_code].locale_label|default:'English'}</span><a href="#" class="col" onclick="open_img(this,event)"></a></div>

                        <dl id="p_l">
                            <dt><a href="http://www.{$site_root_domain}/" rel="nofollow"><img src="/media/langflags/en.png" width="16" height="11" />English</a></dt>
                        {foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                            <dt><a href="http://{$lc}.{$site_root_domain}/" rel="nofollow"><img src="/media/langflags/{$lc}.png" width="16" height="11" />{$meta.locale_label}</a></dt>
                        {/foreach}
                        </dl>

                    </div>
                </td>
            </tr>
        </table>

    </div>
    <div class="menu_wrap">
        <ul class="hl_f">
            <li{if $cur=='home'} class="cur"{/if}><span><a href="/">{$preset_translations.home}</a></span></li>
            <li{if $cur=='product'} class="cur"{/if}><span><a href="/products.html">{$preset_translations.products}</a></span></li>
            <li{if $cur=='aboutus'} class="cur"{/if}><span><a href="/aboutus.html">{$preset_translations.company_profile}</a></span></li>
            <li{if $cur=='news'} class="cur"{/if}><span><a href="/news">{$preset_translations.company_news}</a></span></li>
            <li{if $cur=='quality'} class="cur"{/if}><span><a href="/quality.html">{$preset_translations.quality_control}</a></span></li>
            <li{if $cur=='contactus'} class="cur"{/if}><span><a href="/contactus.html">{$preset_translations.contact_us}</a></a></span></li>
            <li><span><a href="/contactnow.html">{$preset_translations.request_a_quote}</a></a></span></li>
        </ul>
    </div>
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
            show.style.width=153+'px';
            show.style.height='auto';
            show.style.display='block';
            show.style.left=pos['left']+"px";
            show.style.top=pos['top']+18+"px";
        }else{
            a.className='col'
            show.style.display='none';
        }
    }
</script>
{/literal}