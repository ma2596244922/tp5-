<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    {include file="sets/june-sky/common/tdk.tpl"}
    <link rel="canonical" href="{$product|url:'enterprise_url_product':$page_no}" />
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/june-sky/common/styles.tpl"}
    <link href="/media/sets/june-blue/css/products_detail.css" rel="stylesheet" type="text/css" />
    <script type="application/ld+json">
    {$google_structured_data|json_encode}
    </script>
</head>

<body>
    {include file="sets/june-sky/common/header.tpl" cur="product"}
    <div style="background:url(/media/sets/june-sky/img/bn_cp.jpg) no-repeat center center; height:258px; display:block"></div>
    <div class="place bw_1190" id="place">
        <div class="here fl-left">
            <span>
                <a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
            <span>
                <a href="{$product_group|url:'enterprise_url_product_list'}" title="{$product_group.name}">{$product_group.name}</a>&nbsp;&gt;&nbsp;</span>
            <span class="fl-bold here_title">{$product.caption}</span>
        </div>
    </div>
    <div class="bw_1190 fl-clr">
        <div class="product_top">
            <div class="product_show">
                <div id="showbox">
                    {-if $product_images}
                        {-foreach $product_images as $image_id}
                            <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}"  width="400" height="400"/>

                        {-/foreach}
                    {-else}
                        <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" width="400" height="400" />
                    {-/if}

                    <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank"><i></i></a>
                </div>
                <!--展示图片盒子-->
                <div id="showsum"></div>
                <!--展示图片里边-->
                <p class="showpage">
                    <a href="javascript:void(0);" id="showlast"></a>
                    <a href="javascript:void(0);" id="shownext"></a>
                </p>
            </div>
            <div class="product_right">
                <div class="product_h2 fl-clr">
                    <h1>{$product.caption}</h1>
                </div>
                <div class="product_txt">{$product.description|strip_tags|truncate:180:"..."}</div>
                <ul>
                    <li>
                        <label>{$preset_translations.price}:</label>
                        <span>
                            <strong>{$product.price|default:'Negotiation'}</strong>
                            <em>
                                |</em>
                            <a style="color: #06c" href="/contactnow.html?about_product={$product.id}" rel="nofollow">Get Latest Price</a>
                        </span>
                    </li>
                    {if $product.packaging_details|default:''}<li><label>{$preset_translations.packaging_details}:</label><span>{$product.packaging_details}</span></li>{/if}
                    {if $product.delivery_time|default:''}<li><label>{$preset_translations.delivery_time}:</label><span>{$product.delivery_time}</span></li>{/if}
                    {if $product.payment_terms|default:''}<li><label>{$preset_translations.payment_terms}:</label><span>{$product.payment_terms}</span></li>{/if}
                    {if $product.supply_ability|default:''}<li><label>{$preset_translations.supply_ability}:</label><span>{$product.supply_ability}</span></li>{/if}

                    {if $product.place_of_origin|default:''}<li><label>{$preset_translations.place_of_origin}:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.brand_name|default:''}<li><label>{$preset_translations.brand_name}:</label><span>{$product.brand_name}</span></li>{/if}
                    {if $product.certification|default:''}<li><label>{$preset_translations.certification}:</label><span>{$product.certification}</span></li>{/if}
                    {if $product.model_number|default:''}<li><label>{$preset_translations.model_number}:</label><span>{$product.model_number}</span></li>{/if}

                </ul>
                <div class="product_links fl-clr">
                    <a href="/contactnow.html?about_product={$product.id}" target="_blank" class="ly" rel="Nofollow" title="{$preset_translations.contact_now}">
                        <span>{$preset_translations.contact_now}
                            <i></i>
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="con_0">
        <div class="con bw_1190 fl-clr">
            <div class="content_left">
                {include file="sets/june-sky/common/product_left.tpl"}
            </div>
            <div class="content_right">

                {if count($product_specifications)>0}
                <div class="information_box">
                    <div class="t"><h2>{$preset_translations.product_details}</h2></div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    {foreach $product_specifications as $k=>$v}
                        {if $v@index%2==0}
                                <tr>
                        {/if}
                                    <td width="50%">{$k}:{$v}</td>
                        {if $v@index%2==1}
                                </tr>
                        {/if}
                    {/foreach}
                    </table>
                </div>
                {/if}

                {-if $product.embedded_video|default:''}
                    <div class="information_txt">
                        {$product.embedded_video}
                    </div>
                {-/if}

                <div class="information_txt">
                    <div class="t"><h2>{$preset_translations.product_description}</h2></div>
                    {$product.description}
                </div>

                {if count($product_tags)>0}
                <div class="information_txt">
                    <div class="t"><h2>{$preset_translations.tags}</h2></div>
                    <div class="link">
                        <dl class=" fl-clr">
                            <dd>
                                {foreach $product_tags as $tag}
                                {if $tag@index>0} | {/if}<a href="{$tag|call:'enterprise_url_product_search'}" target="_blank">{$tag}</a>
                                {/foreach}
                            </dd>
                        </dl>
                    </div>
                </div>
                {/if}
                {* <div class="flip1_box">
                    <a href="" title="">
                        <span class="t">Previous：</span>
                        <span class="aa">electric bike electric tricycle two seats with lead acid battery CE</span>
                    </a>
                    <a href="" title="">
                        <span class="t">Next：</span>
                        <span class="aa">electric bike electric tricycle two seats with lead acid battery CE </span>
                    </a>
                </div> *}
            </div>

        </div>
        <div class="con bw_1190 fl-clr">
            <div class="pro_tit">
                <p class="bt"><h2>NEW ARRIVALS</h2></p>
                <div class="pro_line">
                    <div class="lin_bg">
                        <span></span>
                    </div>
                </div>
            </div>
            <div class="tab_nws bw_1190 fl-clr">
                <div class="tab-cont-1 fl-clr" style="display: block;">
                    <ul class="fl-clr">
                    {assign var="orther_products" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id,$default_lang_code,$group.id,false,1,4) )}
                    {foreach $orther_products as $product}{if $product@index>4}{break}{/if}
                    <li>
                        <dl>
                            <dt>
                                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" height="250" width="250" alt="{$product.caption}">
                                </a>
                            </dt>
                            <dd class="title">
                                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                    <strong>{$product.caption}</strong>
                                </a>
                            </dd>
                            <dd class="contact">
                                <a href="javascript:void(0);" onclick="window.location.href='/contactnow.html?about_product={$product.id}'" class="jt" rel="Nofollow" title="QQ交谈" target="_blank">{$preset_translations.contact_now}</a>
                            </dd>
                        </dl>
                    </li>
                    {/foreach}
                        
                    </ul>
                </div>
            </div>
        </div>
        <!-- new arrival -->
        
        {include file="sets/june-sky/common/hidden_groups.tpl"}
    </div>
    {include file="sets/june-sky/common/footer.tpl"}
    {include file="sets/june-sky/common/scripts.tpl" page_name="product"}
</body>

</html>