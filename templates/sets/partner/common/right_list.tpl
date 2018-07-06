<div class="right-list">
    <div class="search-box">
        <input type="text" class="txt" placeholder="Search..." id="search-txt" />
        <a href="javascript:void(0)" class="search-btn" id="search-btn"></a>
    </div>
    <div class="categories">
        <h2>{$preset_translations.all_categories}</h2>
        <ul>
            {foreach $groups as $group}
            <li><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}"><strong>{$group.name}</strong></a></li>
            {/foreach}
        </ul>
        <div class="see-more" style="display: none;"><a href="javascript:void(0);">see more</a><i class=""></i></div>
    </div>
</div>