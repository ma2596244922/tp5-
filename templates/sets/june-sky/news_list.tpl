<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl" page_name="news_list"}
    {include file="sets/june-sky/common/styles.tpl"}
<body>
{include file="sets/june-sky/common/header.tpl" cur="news"}
<div style="background:url(/media/sets/june-sky/img/bn_new.jpg) no-repeat center center; height:258px; display:block"></div>
<div class="place bw_1190" id="place">
    <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$preset_translations.company_news}</div>
    </div>
</div>

<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="section">
            <span class="gorth2">
                <h1>{$preset_translations.company_news}</h1>
            </span>
            <span class="wzrt">NEWS INFORMATION</span>
        </div>
        <ul class="news-lst fl-clr">
            {foreach $news as $n}
            <li class="fl-clr">
                <div class="nwlf">{$n.created|date_format:'%d'}
                    <span>{$n.created|date_format:'%Y/%m'}</span>
                </div>
                <div class="nwrt">
                    <div class="nwtit">
                        <a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}">{$n.caption}</a>
                    </div>
                    <div class="nwcon">{$n.content|strip_tags|truncate:260:"..."}
                    </div>
                </div>
            </li>
            {foreachelse}
                        <p><i></i>{$preset_translations.the_user_has_not_provide_such_information}.</p>
            {/foreach}
        </ul>
        {include file="sets/june-sky/common/pager_news.tpl"}

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
    {include file="sets/june-sky/common/hidden_groups.tpl"}
</div>

{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl"}
</body>
</html>