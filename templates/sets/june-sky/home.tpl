<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    {include file="sets/june-sky/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="home"}
    {include file="sets/june-sky/common/styles.tpl"}
</head>

<body>
    
    {include file="sets/june-sky/common/header.tpl" cur="home"}
    <div class="index_show">
        <div id="wowslider-container">
            <div class="ws_images">
                <ul>
                    {foreach $banners as $banner}
                    <li>
                        <a href="{$banner.link}" target="_blank">
                            <img src="{$banner.uri|url:'enterprise_url_photo'}" width="2000" height="550" alt="{$banner.desc}" title=""
                            />
                        </a>
                    </li>
                    {/foreach}

                </ul>
            </div>
            <div class="ws_bullets">
                <div>
                    {foreach $banners as $banner}
                    <a href="javascript:;"></a>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>

    <div class="con_0">
        <!--产品分类 begin-->
        <div class="pro_tit">
            <p class="bt">PRODUCT CLASSIFICATION</p>
            <div class="pro_line">
                <div class="lin_bg">
                    <span></span>
                </div>
            </div>
        </div>
        <div class="tab_nws bw_1190 fl-clr">
            <ul class="tab-tit  fl-clr">
                {foreach $groups as $group}{if $group@index>4}{break}{/if}
                <li{if $group@index==0} class="now"{/if}>
                    <a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}" target="_blank" class="">{$group.name}</a>
                </li>
                {/foreach}
            </ul>
            <div class="tab-show fl-clr">
                {foreach $groups as $group}{if $group@index>4}{break}{/if}
                {assign var="products_new" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id, $default_lang_code, $group.id, '', 1, 4) )}
                <div class="tab-cont-1 fl-clr"{if $group@index==0} style="display: block;"{/if}>
                    <ul class="fl-clr">
                        {foreach $products_new as $product}
                        <li>
                            <dl>
                                <dt>
                                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                        <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" height="250" width="250"
                                            alt="{$product.caption}">
                                    </a>
                                </dt>
                                <dd class="title">
                                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                        <strong>{$product.caption}</strong>
                                    </a>
                                </dd>
                                <dd class="contact">
                                    <a href="javascript:void(0);" onclick="window.location.href='/contactnow.html?about_product={$product.id}'" class="jt" rel="Nofollow" target="_blank">{$preset_translations.contact_now}</a>
                                </dd>
                            </dl>
                        </li>
                        {/foreach}
                    </ul>
                </div>
                {/foreach}
                
            </div>
        </div>
        <!--精品橱窗 begin-->
        <div class="jpcc">
            <div class="pro_tit">
                <p class="bt">TOP-SELLING PRODUTS</p>
            </div>
            <div class="tab_nws bw_1190 fl-clr">
                <div class="tab-cont-1 fl-clr" style="display: block;">
                    <ul class="fl-clr">
                        {foreach $products as $product}{if $product@index>7}{break}{/if}
                        <li>
                            <dl>
                                <dt>
                                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                        <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" height="250" width="250"
                                            alt="{$product.caption}">
                                    </a>
                                </dt>
                                <dd class="title">
                                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                        <strong>{$product.caption}</strong>
                                    </a>
                                </dd>
                                <dd class="contact">
                                    <a href="javascript:void(0);" onclick="window.location.href='/contactnow.html?about_product={$product.id}'" class="jt" rel="Nofollow" target="_blank">{$preset_translations.contact_now}</a>
                                </dd>
                            </dl>
                        </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
        <!--新品推荐 begin-->
        {if $groups[0]|default:[]}
        <div class="pro_tit">
            <p class="bt">NEW ARRIVALS</p>
            <div class="pro_line">
                <div class="lin_bg">
                    <span></span>
                </div>
            </div>
        </div>
        <div class="tab_nws bw_1190 fl-clr">
            <div class="tab-cont-1 fl-clr" style="display: block;">
                <ul class="fl-clr">
                    {assign var="products_group1" value=enterprise_product_append_group_info( $default_lang_code, enterprise_get_product_list($site.site_id,$default_lang_code,$groups[0].id,false,1,4,'', ($default_lang_code == 'en') ? '`updated` ASC' : 'elp.`updated` ASC') )}
                    {foreach $products_group1 as $product}
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
        {/if}

        <!--关于我们 begin-->
        <div class="jpcc syus">
            <div class="pro_tit">
                <p class="bt">COMPANY INTRODUCTION</p>
            </div>
            <div class="ab_con bw_1190">{$corporation.introduction|strip_tags|truncate:500:"..."} </div>
            <a class="ab_more" href="/aboutus.html" target="_blank">MORE</a>
        </div>
        <!--NEWS begin-->
        {if $news|default:[]}
        <div class="pro_tit">
            <p class="bt">COMPANY NEWS</p>
            
            <div class="pro_line">
                <div class="lin_bg">
                    <span></span>
                </div>
            </div>
        </div>
        <div class="bw_1190 company-news">
            <a href="/news" class="more">MORE&nbsp;&gt;</a>
            <ul class="new_t fl-clr">
                {foreach $news as $n}{if $n@index>2}{break}{/if}
                <li>
                    <a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}" target="_blank">{$n.caption}</a>
                    <p>{$n.content|strip_tags|truncate:180:"..."}</p>
                </li>
                {/foreach}
            </ul>
        </div>
        {/if}

        <!--Keywords begin-->
        {if $index_keywords|default:[]}
        <div class="link_0">
            <div class="link">
                <dl class=" fl-clr">
                    <dt>Keywords</dt>
                    <dd>
                        {foreach $index_keywords as $ik}
                        {if $ik@index>0} | {/if}<a href="{$ik.url|default:{$ik.keyword|url:'enterprise_url_product_search'}}" title="{$ik.keyword}" target="_blank">{$ik.keyword}</a>
                        {/foreach}
                    </dd>
                </dl>
            </div>
        </div>
        {/if}
    </div>
    {include file="sets/june-sky/common/footer.tpl"}
    {include file="sets/june-sky/common/scripts.tpl" page_name="home"}

</body>
</html>