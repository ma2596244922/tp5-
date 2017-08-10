<div class="ServiceBox">
  <div class="Page">
{foreach $groups_in_links_bar as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index==2&&$main_products|default:[]}{break}{/if}{if $group@index>=3}{break}{/if}
    <dl>
        <dt>{$group.name}</dt>
    {foreach $group.products as $product}
        <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {/foreach}
    </dl>
{/foreach}
{if $main_products|default:[]}
    <dl>
        <dt>{$preset_translations.top_products}</dt>
    {foreach $main_products as $mp}
        <dd><a href="{$mp.url}">{$mp.label}</a></dd>
    {/foreach}
    </dl>
{/if}
    <dl>
        <dt>{$preset_translations.about_us}</dt>
        <dd><a href="/aboutus.html" rel="nofollow">{$preset_translations.company_profile}</a></dd>
        <dd><a href="/contactus.html" rel="nofollow">{$preset_translations.contact_info}</a></dd>
        <dd><a href="/directory.html" rel="nofollow">{$preset_translations.site_map}</a></dd>
    </dl>
  </div>
</div>