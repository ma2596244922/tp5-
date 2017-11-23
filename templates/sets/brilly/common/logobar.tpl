<div class="Page Top Shop">
  <div class="fl Logo"><a href="/" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name|escape}"></a></div>
  <p class="fl" style=" width:960px; overflow:hidden; line-height:36px; ">{if ($page_name|default:''=='product_list' && ($group|default:[] || $phrase|default:'')) || $page_name|default:''=='product_detail'}{$corporation.name}{else}<h1>{$corporation.name}</h1>{/if}</p>
  <p style=" line-height:20px; color:#999; font-size:14px; width:960px; overflow:hidden; margin-top: 6px;">{$corporation_slogan}</p>
  <div class="clear"></div>
</div>