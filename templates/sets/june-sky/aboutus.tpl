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
{include file="sets/june-sky/common/header.tpl" cur="aboutus"}
<div style="background:url(/media/sets/june-sky/img/usbn.jpg) no-repeat center center; height:260px; display:block"></div>
<div class="place bw_1190" id="place">
    <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$preset_translations.company_profile}</div>
    </div>
</div>
<div class="con_0">
    <div class="con con2 fl-clr">
        <div class="detail-us">
            <div class="us_tit"><h2>{$preset_translations.company_introduction}</h2></div>
            <div class="us_con">
                {$corporation.introduction}
            </div>
        </div>
        <div class="details_box ">
            <div class="details_tit"><h2>{$preset_translations.company_details}</h2></div>
            <ul class="details_ul fl-clr">
                
                <li><span class="t">{$preset_translations.business_type}：</span>{$corporation.business_type} </li>
                <li><span class="t">{$preset_translations.brands}：</span>{$corporation.brands} </li>
                <li><span class="t">{$preset_translations.no_of_employees}：</span>{$corporation.no_of_employees} </li>
                <li><span class="t">{$preset_translations.annual_sales}：</span>{$corporation.annual_sales} </li>
                <li><span class="t">{$preset_translations.year_established}：</span>{$corporation.year_established} </li>
                <li><span class="t">{$preset_translations.address}：</span>{$corporation.address} </li>
                <li><span class="t">{$preset_translations.export_p_c}：</span>{$corporation.export_p_c} </li>
                <li><span class="t">{$preset_translations.main_market}：</span> <span class="title">{$corporation.main_market|truncate:40:"..."}</span> <span class="more">See More&gt;
                    <div class="txt" style="display: none;"> {$corporation.main_market} </div>
                    </span> </li>
            </ul>
            
        </div>
        <!-- detail_box -->
        <div class="details_box ">
            <div class="details_tit"><h2>{$preset_translations.service}</h2></div>
            <ul class="details_ul fl-clr">
                {$corporation.service}
            </ul>
        </div>
        <div class="details_box ">
            <div class="details_tit"><h2>{$preset_translations.history}</h2></div>
            <ul class="details_ul fl-clr">
                {$corporation.history}
            </ul>
        </div>
        <div class="details_box ">
            <div class="details_tit"><h2>{$preset_translations.our_team}</h2></div>
            <ul class="details_ul fl-clr">
                {$corporation.our_team}
            </ul>
        </div>
    </div>
    {include file="sets/june-sky/common/hidden_groups.tpl"}
</div>

{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl"}
</body>
</html>