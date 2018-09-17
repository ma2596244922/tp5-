<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    {include file="sets/m12/common/tdk.tpl"}
    {include file="sets/trade/common/definitions.tpl" page_name="product_list"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/products.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/m12/common/header.tpl" cur="product"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{-if $group|default:[]}{$group.name}{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.products}{-/if}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
    {include file="sets/m12/common/left.tpl"}
</div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="title">
                {-if $group|default:[]}<h1>{$group.name}</h1>{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.all_products}{-/if}&nbsp;({$total_products})
                <div class="search_wrap">
                    <input type="text" class="search_t" placeholder="Search all Products" id="kw"/>
                    <input type="button" class="search_b" onclick="SearchProducts()"/>
                </div>
            </div>
            <div class="right-content">
                {include file="sets/m12/common/list.tpl"}
                <!--products-box-->
                <!--view-page-->
            </div>
            <div class="cb_10"></div>
            {foreach $products as $product}
            <div class="prolist_wrap">
                <div class="pro_tit"><h2><a href="{$product|url:'enterprise_url_product'}" target="_blank" title="{$product.caption}">{$product.caption}</a></h2></div>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tbody><tr>
                        <td>
                            <div class="pro_pic">
                                <table cellpadding="0" cellspacing="0">
                                    <tbody><tr>
                                        <td align="center" valign="middle"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}" width="80" height="80"></td>
                                    </tr>
                                </tbody></table>
                            </div>
                        </td>
                        <td valign="top" width="435">
                            <div class="pro_con">
                                <p>{$product.summary|truncate:180:"..."}<a href="{$product|url:'enterprise_url_product'}">[read more]</a></p>
                                <p class="time">{$product.updated}</p>
                            </div>
                        </td>
                        <td valign="top" align="right"><input class="btn1" type="button" onclick="window.location.href='/contactnow.html?about_product={$product.id}'"></td>
                    </tr>
                </tbody></table>
            </div>
            <div class="cb_10"></div>
            {foreachelse}
            <p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
            {/foreach}
            
            {include file="sets/m12/common/pager_product.tpl"}
        </div>
        <div class="cb_10"></div>
        
    </div>
    <div class="cb_10"></div>
</div>
<div class="footer_wrap">
{include file="sets/m12/common/hidden_groups.tpl"}
</div>
<!-- content -->
{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}

</body>
</html>