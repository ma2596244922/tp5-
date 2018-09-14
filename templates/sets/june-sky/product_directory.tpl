<!DOCTYPE html>
<html lang="zh-cn">
<head>
    {$site.common_head_fragment}
    <meta charset="utf-8">
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl" page_name="product_directory"}
    {include file="sets/june-sky/common/styles.tpl"}
</head>
<body>
{include file="sets/june-sky/common/header.tpl" cur="sitemap"}
<!-- header -->

<div style="background:url(/media/sets/june-sky/img/bn_cp.jpg) no-repeat center center; height:258px; display:block"></div>
<div class="place bw_1190" id="place">
    <div class="here fl-left"><span><a href="/">{$preset_translations.home}</a>&nbsp;&gt;&nbsp;</span>
        <div class="fl-bold">{$preset_translations.site_map}</div>
    </div>
</div>
<div class="con_0">
    <div class="con bw_1190 fl-clr">
        <div class="content_left">
            {include file="sets/june-sky/common/product_left.tpl"}
        </div>
        <div class="content_right">
            <div class="section">
                <span class="gorth2">{$preset_translations.site_map}</span>
            </div>
            {*分组说明*}>
            <div class="product-all{if !$products|default:[]} quality-none{/if}">
                    {-if $group|default:[]&&$group.desc|default:''}
                    <div class="intro-txt" style="padding-top: 15px; padding-left: 15px;">{$group.desc}</div>
                    {-/if}
                    {foreach $products as $product}
                        <div class="product-intro">
                            <div class="left-img">
                                <a href="{$product|url:'enterprise_url_product'}" class="img-box">
                                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" />
                                </a>
                            </div>
                            <div class="msg-detail">
                                <span><a href="{$product|url:'enterprise_url_product'}"><h3>{$product.caption}</h3></a></span>
                                <table cellpadding="0" cellspacing="0">
                                    <tbody>
                                    {-assign var="total_items" value="0"}
                                    {-foreach $product_desc as $k => $meta}
                                    {-if $total_items>=4}{break}{/if}
                                    {-if $product.$k|default:$meta.default}
                                    {-if $total_items==0}
                                    <tr>
                                        {-/if}
                                        <td><label>{$meta.label}</label><i>{$product.$k|default:$meta.default}</i></td>
                                        {-assign var="total_items" value=$total_items+1}
                                        {-if $total_items==2}
                                    </tr>
                                    <tr>
                                        {-/if}
                                        {-if $total_items==4}
                                    </tr>
                                    {-/if}
                                    {-/if}
                                    {-/foreach}
                                    </tbody>
                                </table>
                                <div class="contact-btn"><a href="/contactnow.html?about_product={$product.id}" rel="nofollow">{$preset_translations.contact_now}</a></div>
                            </div>
                        </div>
                        {foreachelse}
                        <p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p>
                    {/foreach}
                </div>
            </div>
            <ul class="cp_dt fl-clr">
                {foreach $products as $product}
                <li>
                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}" target="_blank">{$product.caption}</a>
                </li>
                {/foreach}

            </ul>
            <div class="paging_box">
                <div id="Pagination" class="pagination">
                    <div class="resultNum">Page {$page_no}/{$total_pages}</div>
                    <div class="pagearea">
                        <span class="pageNum"></span>

                        {-if $page_no >1 }
                            <a href="{$pager_info['prev_page']|url:'enterprise_url_product_directory'}" class='rollPage' rel='nofollow' title='{$preset_translations.previous_page}' >{$preset_translations.previous_page}</a>
                        {-/if}

                        {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                            {if $i==$page_no}<span class="current">{$i}</span>{else}<a href="{$i|url:'enterprise_url_product_directory'}" title='{$i}' rel='nofollow'>{$i}</a>{/if}
                        {-/for}

                        {-if $page_no <$total_pages }
                            <a href="{$pager_info['next_page']|url:'enterprise_url_product_directory'}" class='rollPage' rel='nofollow' title='{$preset_translations.next_page}' >{$preset_translations.next_page}</a>
                        {-/if}
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

{include file="sets/june-sky/common/footer.tpl"}
{include file="sets/june-sky/common/scripts.tpl" page_name="product"}

</body>
</html>