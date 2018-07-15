<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl" page_name="product_directory"}
    {include file="sets/june-blue/common/styles.tpl"}
    <link href="/media/sets/june-blue/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/june-blue/common/header.tpl" cur="sitemap"}
<!-- header -->

<div class="main_wrap">
    <div class="guide_wrap"><a href="/" class="h">{$preset_translations.home}</a>{$preset_translations.site_map}</div>
    <div class="sider_wrap fl">
        {include file="sets/june-blue/common/left.tpl"}
        <div class="cb_10"></div>
    </div>
    <div class="main_right_wrap_box">
        <div class="main_right_wrap">
            <div class="main_right_box">
                <div class="content_box">
                    <div class="title_wrap">Company</div>
                    <div class="box_content">
                        <table width="100%" cellspacing="0" cellpadding="0" class="sitemap_list">
                            <tbody>
                                <tr>
                                    <td valign="top" class="lists">
                                        <span><a href="/aboutus.html" title="{$preset_translations.company_profile}">{$preset_translations.company_profile}</a></span>
                                        <span><a href="/quality.html" title="{$preset_translations.quality_control}">{$preset_translations.quality_control}</a></span>
                                        <span><a href="/contactus.html" title="{$preset_translations.contact_us}">{$preset_translations.contact_us}</a></span>
                                        <span><a href="/contactnow.html" title="{$preset_translations.request_a_quote}">{$preset_translations.request_a_quote}</a></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="cb_10"></div>
                <div class="content_box">
                    <div class="title_wrap"><h1>{$preset_translations.all_products} Page {$page_no}</h1></div>
                    <div class="box_content">
                        <div class="cb_10"></div>
                        <div class="sitemap_cat_list">
                            <div class="sitemap_box">
                                <ul>
                                    {foreach $products as $product}
                                    <li><strong><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></strong></li>
                                    {/foreach}
                                </ul>
                            </div>
                            <div class="cb_10"></div>
                        </div>
                        <div class="cb_10"></div>

                        <div class="public_pages">
                            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                <tbody><tr>
                                        <td>
                                            Page {$page_no} of {$total_pages} :&nbsp;&nbsp;
                                            <a href="{1|url:'enterprise_url_product_directory'}"> |&lt; </a>
                                            {-if isset($pager_info['prev_page'])}
                                            <a href="{$pager_info['prev_page']|url:'enterprise_url_product_directory'}" class="prev"> &lt;&lt; </a>
                                            {-/if}
                                           
                                            {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                                            <a{if $i==$page_no} class="cur"{/if} href="{$i|url:'enterprise_url_product_directory'}">{$i}</a>
                                            {-/for}

                                            {-if isset($pager_info['next_page'])}
                                                <a href="{$pager_info['next_page']|url:'enterprise_url_product_directory'}" class="next"> &gt;&gt; </a>
                                            {-/if}
                                            <a href="{1|url:'enterprise_url_product_directory'}"> &gt;| </a>

                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="cb_10"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june-blue/common/footer.tpl"}
{include file="sets/june-blue/common/scripts.tpl"}

</body>
</html>