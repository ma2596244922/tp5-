<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/june-sky/common/styles.tpl"}
<body>
{include file="sets/june-sky/common/header.tpl" cur="news"}
<div class="place bw_1190" id="place">
    <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span><span><a href="/news">{$preset_translations.company_news}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold here_title">{$news.caption}</div>
    </div>
</div>

<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="detail-region item">
            <div class="kind-detail-head fl-clr">
                <h2>{$news.caption}</h2>
                <div class="mark fl-clr"><span>{$n.created}</span></div>
            </div>
            <div class="kind-detail-body fl-clr"> 
                {if $news.head_image_id}
                <img src="{$news.head_image_id|url:'enterprise_url_image':$news.caption:''}" width="600" alt="" />
                {/if}
                <p>{$news.content}</p>
            </div>
            {* <div class="more-pages fl-clr">
                <ul class="fl-clr">
                    <li class="fl-left"><span class="f-bold">Previous:</span><a href="" data-scode="" target="_blank">Absorber rod guide components Car Parts Sinter Guider </a></li>
                    <li class="fl-left"><span class="f-bold">Next:</span><a href="" data-scode="" target="_blank">Absorber rod guide components Car Parts Sinter Guider </a></li>
                </ul>
            </div> *}
        </div>
    </div>

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
        
</div>

{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl"}
</body>
</html>