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

        <div class="fl-bold">{$product.caption}</div>
    </div>
</div>
<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="detail-region item">
            <div class="kind-detail-head fl-clr">
                <h1>{$product.caption}</h1>

                <div class="mark fl-clr"><span>Creation time：{$preset_translations.created}</span>

                    <div class="kind-detail-body fl-clr">
                        <p>{$product.description}</p>
                    </div>
                    {if $total_comments > $page_size}
                        <div class="more-pages fl-clr">
                            <ul class="fl-clr">
                                {if $page_no > 1}
                                    <li class="fl-left"><span class="f-bold">Prev Product：</span><a
                                                href="{$product|url:'enterprise_url_product':($page_no-1)}"
                                                data-scode="" target="_blank">Previous Product</a></li>
                                {/if}
                                {if $page_no < $total_pages}
                                    <li class="fl-left"><span class="f-bold">Next Product：</span><a
                                                href="{$product|url:'enterprise_url_product':($page_no+1)}"
                                                data-scode="" target="_blank">Next Product</a></li>
                                {/if}
                            </ul>
                        </div>
                    {/if}
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
