<div class="intro-pro">
    <div class="title-left">
        <span>Latest Products</span>
    </div>
    <div class="product-list">
        <ul class="fl-clr">
            {assign var="latest_products" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id,$default_lang_code,$group.id,false,1,4) ) }
            {-foreach $latest_products as $product}
            <li>
                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" /></a>
                <span><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></span>
            </li>
            {-/foreach}
        </ul>
    </div>
    <!-- product-list -->
</div>