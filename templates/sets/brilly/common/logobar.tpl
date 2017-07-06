<div class="Page Top Shop">
  <div class="fl Logo"><a href="/" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name|escape}"></a></div>
  <p class="fl">{if ($page_name|default:''=='product_list' && ($group|default:[] || $phrase|default:'')) || $page_name|default:''=='product_detail'}{$corporation.name}{else}<h1>{$corporation.name}</h1>{/if}</p>
  <div class="clear"></div>
</div>