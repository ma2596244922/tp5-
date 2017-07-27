        <div class="recom-product">
            <div class="title"><i></i>
                <h2>{$preset_translations.product_categories}</h2>
            </div>
            <ul class="fl-clr">
{foreach $groups as $group}
                <li><em></em>
                    <a href="{$group|url:'enterprise_url_product_list'}"><strong>{$group.name}</strong></a>
                </li>
{/foreach}
            </ul>
            <div class="slide-more">
                <a href="javascript:void(0);">More</a><i></i>
            </div>
        </div>