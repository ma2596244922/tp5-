                <div class="product-box">
                    <div class="title">
                        <i></i>
{-if $group|default:[]}
                        <h1>{$group.name}</h1>
{-elseif $phrase|default:''}
                        <h1>{$phrase}</h1>
{-else}
                        {$preset_translations.all_products}
{-/if}
                        <a href="/contactnow.html" rel="nofollow">{$preset_translations.contact_now}</a>
                    </div>
                    <div class="product-all{if !$products|default:[]} quality-none{/if}">
{-if $group|default:[]&&$group.desc|default:''}
                        <div class="intro-txt" style="padding-top: 15px; padding-left: 15px;">{$group.desc}</div>
                        {-elseif $keyword|default:[]&&$keyword.desc|default:''}
                        <div class="intro-txt" style="padding-top: 15px; padding-left: 15px;">{$ Contacts.keyword.desc}</div>
                        {-else}
                        <div class="intro-txt" style="padding-top: 15px; padding-left: 15px;">最下面逻辑{$group}{$keyword.desc}</div>
                        {-/if}
{foreach $products as $product}
                        <div class="product-intro">
                            <div class="left-img">
                                <a href="{$product|url:'enterprise_url_product'}" class="img-box">
                                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" />
                                </a>
                            </div>
                            <div class="msg-detail">
                                <span><a href="{$product|url:'enterprise_url_product'}"><h3>{$product.caption}</h3></a></span>
                                <table cellpadding="0" cellspacing="0">
                                    <tbody>
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=4}{break}{/if}
        {-if $product.$k|default:$meta.default}
            {-if $total_items==0}
                                        <tr>
            {-/if}
                                            <td><label>{$meta.label}</label><i>{$product.$k|default:$meta.default}</i></td>
            {-assign var="total_items" value=$total_items+1}
            {-if $total_items==2}
                                        </tr>
                                        <tr>
            {-/if}
            {-if $total_items==4}
                                        </tr>
            {-/if}
        {-/if}
    {-/foreach}
                                    </tbody>
                                </table>
                                <div class="contact-btn"><a href="/contactnow.html?about_product={$product.id}" rel="nofollow">{$preset_translations.contact_now}</a></div>
                            </div>
                        </div>
{foreachelse}
                        <p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
{/foreach}
                    </div>
                </div>