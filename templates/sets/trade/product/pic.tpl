        <div class="product-img fl-clr">
            <div class="img-detail">
                <div class="title">{$product.caption} image</div>
                <div class="photo-show fl-clr">
                    <div class="img-tab">
                        <div class="big-box">
                            <ul>
{-foreach $product_images as $image_id}
                                <li{if $image_id@index==0} class="current"{/if}><span><img src="{$image_id|url:'enterprise_url_image':$product.caption:'t'}" alt="{$product.caption|escape} #{$image_id@iteration} image" /></span></li>
{-/foreach}
                            </ul>
                        </div>
                        <div class="small-box">
                            <ul>
{-foreach $product_images as $image_id}
                                <li{if $image_id@index==0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|escape} #{$image_id@iteration} small image" /></li>
{-/foreach}
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="back-page"><a href="{$product|url:'enterprise_url_product'}"><i></i>{$preset_translations.back_to_product_page}</a></div>
            </div>
            <div class="img-intro">
                <div class="title">{$preset_translations.you_might_also_like}</div>
                <div class="photo-list photo-big">
                    <div class="scrollArea">
                        <div class="img-list">
                            <ul>
{foreach $new_products as $product}
                                <li><a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'d'}" alt="{$product.caption|escape}" /><i>{$product.caption}</i></a></li>
{/foreach}
                            </ul>
                        </div>
                    </div>
                    <div class="next-btn">
                        <a href="javascript:void(0)" class="prev"></a>
                        <a href="javascript:void(0)" class="next"></a>
                    </div>
                </div>
            </div> 
        </div>