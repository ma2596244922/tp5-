<div class="right-list">
    <div class="search-box">
        <input type="text" class="txt" id="selectTxt1" placeholder="Search..." />
        <a href="javascript:void(0)"  onclick="boxOut(1)" class="search-btn"></a>
    </div>
    <div class="categories">
        <h2>{$preset_translations.all_categories}</h2>
        <ul>
            {foreach $groups as $group}{if $group@index>=14}{break}{/if}
            <li><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}"><strong>{$group.name}</strong></a></li>
            {/foreach}
        </ul>
    </div>
</div>