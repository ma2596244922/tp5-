<div class="title"><span>{$preset_translations.product_groups}</span></div>
<div class="left_nav">
    <ul>
        {foreach $groups as $group_nav}{if array_key_exists($group_nav.id, $hidden_groups)}{continue}{/if}
        <li>
            <div class="t"><a href="{$group_nav|url:'enterprise_url_product_list'}" title="{$group_nav.name}"><strong>{$group_nav.name}</strong></a></div>
        </li>
        {/foreach}
        
    </ul>
    <div class="more"><span>see more</span></div>
</div>
<div class="left_message mt_20">
    <div class="img"><i></i><img src="{$corporation.logo|url:'enterprise_url_image'}" width="80" height="80"></div>
    <p class="t"><span>{$contacts[0].name}</span></p>
    <div class="txt">
        <p>Mobile : {$contacts[0].tel}</p>
        <p>Tel : {$corporation.tel_wt}</p>
        <p><a href="/contactnow.html{if $product}?about_product={$product.id}{/if}" rel="nofollow" rel="nofollow" target="_blank" class="a a2"><span>{$preset_translations.request_a_quote}</span></a></p>
    </div>
    <div class="tt">Address：{$corporation.address}</div>
</div>