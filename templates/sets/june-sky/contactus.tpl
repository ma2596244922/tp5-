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
{include file="sets/june-sky/common/header.tpl" cur="contactus"}
<div style="background:url(/media/sets/june-sky/img/bn_women.jpg) no-repeat center center; height:258px; display:block"></div>
<div class="place bw_1190" id="place">
    <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$preset_translations.contact_us}</div>
    </div>
</div>

<div class="con_0">
    <div class="con bw_1190 fl-clr">
        {if $site.contact_content|default:''}
        <div class="con">
            {$site.contact_content}
        </div>
        {else}
        <div class="map_0 fl-clr">
            <div class="map_con">
                <dl class="fl-clr">
                    <dt>{$corporation.name}</dt>
                    <dd>
                        <span>{$preset_translations.name}: </span>{$contacts[0].name}</dd>
                    <dd>
                        <span>{$preset_translations.telephone}: </span><h1>{$contacts[0].tel}</h1></dd>
                    <dd>
                        <span>{$preset_translations.fax}: </span> {$corporation.fax} </dd>
                    <dd>
                        <span>{$preset_translations.website}: </span>
                        <span>http://{$canonical_host}</span>
                    </dd>
                    <dd>
                        <span>{$preset_translations.address}: </span>{$corporation.address}</dd>
                </dl>
            </div>
            <div class="produce-show home-show fl-clr">
                <div class="title">
                    <i></i>
                    {$preset_translations.company_profile}
                </div>
                <div class="img-show">
                    <div class="tabContent">
                        <div class="big-img big-img1">
                            <ul>
                                <li>
                                    <img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name}">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="simple-intro">
                    <div class="title">
                        <a href="/aboutus.html" title="{$corporation.name}">
                            <strong>{$corporation.name}</strong>
                        </a>
                    </div>
                    <ul>
                        <li>
                            <label>{$preset_translations.no_of_employees}</label>
                            <span>{$corporation.no_of_employees}</span>
                        </li>
                        <li>
                            <label>{$preset_translations.main_market}</label>
                            <span>{$corporation_main_market}</span>
                        </li>
                    </ul>
                    <div class="contact-btn fl-clr">
                        <a href="/contactnow.html" rel="nofollow" target="_blank"><h2>{$preset_translations.contact_now}</h2></a>
                        {* <a href="javascript:" class="add single_an" onclick="">Add to My Cart</a> *}
                    </div>
                </div>
            </div>
        </div>
        
        {/if}
    </div>
</div>

{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl"}
</body>
</html>