<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    {include file="sets/trade/common/tdk.tpl"}
    <link href="/media/sets/apus/css/theme.css" rel="stylesheet" type="text/css"/>
</head>
<body>

{include file="sets/apus/common/header.tpl"}

<div class="place bw_1190" id="place">
    <div class="here fl-left">
        <span><a href="/" title="{$preset_translations.home}">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$corporation.name} Contact Info</div>
    </div>
</div>
<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="detail-region item">
            <div class="kind-detail-head fl-clr">
                <h1>{$preset_translations.contact_info}</h1>
                <div class="mark fl-clr"><span></span>
                    <div class="kind-detail-body fl-clr">
                        <p>{$site.contact_content}</p>
                        {-foreach $contacts as $contact}
                            {-foreach $contact as $f => $v}{if $f=='name'}{continue}{/if}
                            <p>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</p>
                            {-/foreach}
                        {-/foreach}
                    </div>
                </div>
            </div>
        </div>
        <!--foot-->
        {include file="sets/apus/common/footer.tpl"}

        {include file="sets/apus/common/script.tpl"}
    </div>
</div>
</body>
</html>
