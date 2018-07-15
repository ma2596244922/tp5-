<div class="header">
    <div class="head">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td ><div class="logo"><a href="/" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" style="max-height: 50px;" alt="{$corporation.name|escape}"></a></div></td>
                <td class="head_title">{if $cur=='home'}<h1>{$corporation.name}</h1>{else}<strong>{$corporation.name}</strong>{/if}</td>
                <td width="190">
                    <div class="lan_wrap">
                        <div class="f mt_15">Sales & Support {$corporation.tel_wt}</div>
                        <div class="f">
                            <a href="/contactnow.html" rel="nofollow">{$preset_translations.request_a_quote}</a>
                        {if $contacts[0]|default:[]}
                         - <a href="mailto:{$contacts[0].email}" rel="nofollow">Email</a>
                        {/if}
                        </div>
                        <div class="cb"></div>
                        <div class="sel">{$supported_lang_codes[$lang_code].locale_label|default:'English'}<a href="#" class="col" onclick="open_img(this,event)"></a></div>
                        <div class="cb"></div>

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
    <div class="cb"></div>
    <div class="menu_wrap">
        <ul>
            <li{if $cur=='home'} class="cur"{/if}><span><a href="/">{$preset_translations.home}</a></span></li>
            <li{if $cur=='product'} class="cur"{/if}><span><a href="/products.html">{$preset_translations.products}</a></span></li>
            <li{if $cur=='aboutus'} class="cur"{/if}><span><a href="/aboutus.html">About Us</a></span></li>
            <li{if $cur=='news'} class="cur"{/if}><span><a href="/news">{$preset_translations.company_news}</a></span></li>
            <li{if $cur=='quality'} class="cur"{/if}><span><a href="/quality.html">{$preset_translations.quality_control}</a></span></li>
            <li{if $cur=='sitemap'} class="cur"{/if}><span><a href="/directory.html" title="{$preset_translations.site_map}">{$preset_translations.site_map}</a></span></li>
            <li{if $cur=='contactus'} class="cur"{/if}><span><a href="/contactus.html">{$preset_translations.contact_us}</a></a></span></li>
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
            show.style.width=155+'px';
            show.style.height='auto';
            show.style.display='block';
            show.style.left=pos['left']+"px";
            show.style.top=pos['top']+19+"px";
        }else{
            a.className='col'
            show.style.display='none';
        }
    }
</script>
{/literal}