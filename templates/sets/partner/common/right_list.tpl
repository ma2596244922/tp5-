<div class="right-list">
    <div class="search-box">
        <input type="text" class="txt" placeholder="Search..." />
        <a href="javascript:void(0)" class="search-btn"></a>
    </div>
    <div class="categories">
        <span>Categories</span>
        <ul>
            {-foreach $groups as $group}
            <li><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name}</a></li>
            {-/foreach}
        </ul>
    </div>
</div>