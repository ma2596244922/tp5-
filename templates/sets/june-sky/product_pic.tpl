<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
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
    <div class="place bw_1190" id="place">
        <div class="here fl-left">
            <span>
                <a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
            <span>
                <a href="{$product_group|url:'enterprise_url_product_list'}" title="{$product_group.name}">{$product_group.name}</a>&nbsp;&gt;&nbsp;</span>
            <span class="fl-bold here_title">{$product.caption}</span>
        </div>
    </div>
    <div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="product-show">
            <div class="title fl-clr"> <h1>【{$product.caption}】image</h1></div>
            <div class="img-box">
                <div class="thumb-list fl-clr">
                    <div class="pic-cont">
                        <ul>
                            {-if $product_images}
                                {-foreach $product_images as $image_id}
                                    <li{if $image_id@index==0} class="cur-pic"{/if} picurl="{$image_id|url:'enterprise_url_image':$product.caption:'c'}"> <a href="javascript:;"><img alt="{$product.caption|default:''|escape}" src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" /></a> </li>
                                {-/foreach}
                            {-else}
                                <li picurl="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}"> <a href="javascript:;"><img alt="{$product.caption|default:''|escape}" src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" /></a> </li>
                            {-/if}
                            
                        </ul>
                    </div>
                </div>
                <!--thumb-list-->
                <div class="img-detail-box js-box">
                    <div class="bigpic-cont">
                        <div class="imgBar"> <a href="javascript:;" data-role="prev" class="c_left" title="上一个"></a> <a href="javascript:;" data-role="next" class="c_right" title="下一个"></a> </div>
                        <div class="vertical-img"> <span> <img src="{if $product_images}{{$product_images[0]|url:'enterprise_url_image':$product.caption:'c'}}{else}{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}{/if}" /> </span> </div>
                    </div>
                </div>
                <!--img-detail-box-->
            </div>
            <!--img-box-->
        </div>
        <div class="product-intro">
            <ul>
                <li>
                    <label>{$preset_translations.price}</label>
                    <span>&yen;<em>{$product.price|default:'Negotiation'}</em></span></li>
                <li>
                    <label>{$preset_translations.place_of_origin}</label>
                    {$product.place_of_origin}</li>
            </ul>
            <div class="btn">
            <a class="leave-words" target="_blank" href="/contactnow.html?about_product={$product.id}" rel="nofollow" title="{$preset_translations.contact_now}"><h2>{$preset_translations.contact_now}</h2></a></div>
        </div>
    </div>
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
    
    {include file="sets/june-sky/common/footer.tpl"}
    {include file="sets/june-sky/common/scripts.tpl" page_name="product"}
</body>
</html>