        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til" id="tianjia">Related Products</h2>
          <ul class="PicTextList Type2">
{foreach $latest_products as $product}{if $product@index>=3}{break}{/if}
            <li>
              <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a>
              <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption|escape}</a></p>
            </li>
{/foreach}
          </ul>
        </div>
