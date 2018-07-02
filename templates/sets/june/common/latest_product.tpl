{if $latest_products|default:[]}
<div class="intro-pro">
    <div class="title-left">
        <span>Latest Products</span>
    </div>
    <div class="product-list">
        <ul class="fl-clr">
            {-foreach $latest_products as $product}
            <li>
                <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" /></a>
                <span><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></span>
            </li>
            {-/foreach}
        </ul>
    </div>
    <!-- product-list -->
</div>
{/if}