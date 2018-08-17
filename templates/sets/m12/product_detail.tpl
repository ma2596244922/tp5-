<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    {include file="sets/m12/common/tdk.tpl"}
    <link rel="canonical" href="{$product|url:'enterprise_url_product':$page_no}" />
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/products_detail.css" rel="stylesheet" type="text/css" />
    <script type="application/ld+json">
    {$google_structured_data|json_encode}
    </script>
</head>
<body>
{include file="sets/m12/common/header.tpl" cur="product"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a> <a href="{$product_group|url:'enterprise_url_product_list'}" title="{$product_group.name}">{$product_group.name}</a> <span>{$product.caption}</span></div>
<div class="main_wrap">
    <div class="sider_wrap fl">
    {include file="sets/m12/common/left.tpl"}
</div>
    <div class="content_wrap">
        <div class="con_title"><h1>{$product.caption}</h1></div>
        <div class="content_box produce-show">
            <div class="img-show">
                    <div class="tabContent">
                        <div class="big-img">
                            <ul>
    {-if $product_images}
        {-foreach $product_images as $image_id}
                            <li>
                                <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank">
                                    <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" />
                                </a>
                            </li>
        {-/foreach}
    {-else}
                            <li><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" /></li>
    {-/if}
                            </ul>
                        </div>
                        <div class="small-img">
                            <div class="scroll">
                                    <ul>
    {-if $product_images}
        {-foreach $product_images as $image_id}
                                    <li{if $image_id@index == 0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" /></li>
        {-/foreach}
    {-else}
                                    <li class="current"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" /></li>
    {-/if}
                                    </ul>
                            </div>
                            <div class="prev-next">
                            <a href="javascript:void(0);" class="prev"></a>
                            <a href="javascript:void(0);" class="next"></a>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="fram_box">
                <div class="fram_tit"><h2>{$preset_translations.product_details}</h2></div>
                <table cellpadding="0" cellspacing="0">
                    <tr><th>{$preset_translations.place_of_origin}:</th><td>{$product.place_of_origin}</td></tr>
                    <tr><th>{$preset_translations.brand_name}:</th><td>{$product.brand_name}</td></tr>
                    <tr><th>{$preset_translations.certification}:</th><td>{$product.certification}</td></tr>
                    <tr><th>{$preset_translations.model_number}:</th><td>{$product.model_number}</td></tr>
                </table>
                <div class="cb_10 mt_5"></div>
                <div class="fram_tit"><h2>{$preset_translations.payment_terms}</h2></div>
                <table cellpadding="0" cellspacing="0">
                    <tr><th>{$preset_translations.minimum_order_quantity}:</th><td>{$product.min_order_quantity|default:'Negotiation'}</td></tr>
                    <tr><th>{$preset_translations.price}:</th><td>{$product.price|default:'Negotiation'}</td></tr>
                    {if $product.packaging_details|default:''}<tr><th>{$preset_translations.packaging_details}:</th><td>{$product.packaging_details}</td></tr>{/if}
                    {if $product.delivery_time|default:''}<tr><th>{$preset_translations.delivery_time}:</th><td>{$product.delivery_time}</td></tr>{/if}
                    {if $product.payment_terms|default:''}<tr><th>{$preset_translations.payment_terms}:</th><td>{$product.payment_terms}</td></tr>{/if}
                    {if $product.supply_ability|default:''}<tr><th>{$preset_translations.supply_ability}:</th><td>{$product.supply_ability}</td></tr>{/if}
                </table>
            </div>
            <div class="cb_10"></div>
            <div class="pro_detail">
                <div class="title"><h2>{$preset_translations.product_description}</h2></div>
                <div class="con_wrap">
                   {$product.description}
                </div>
            </div>
            <div class="cb_10"></div>
            {if count($product_tags)>0}
            <div class="pro_detail">
            <div class="title"><h2>{$preset_translations.tags}</h2></div>
            <div class="con_wrap list_ul_li li_tags">
                <table width="100%" cellspacing="0" cellpadding="0">
                    <tbody>
                    {foreach $product_tags as $tag}{if $tag@index>=3}{break}{/if}
                    {if $tag@index%3==0}<tr>{/if}
                        <td width="33.3%"><strong><a href="{$tag|call:'enterprise_url_product_search'}" title="{$tag}">{$tag}</a></strong></td>
                    {if $tag@index%3==2}</tr>{/if}
                    {/foreach}
                    </tbody>
                </table>
            </div>
            </div>
            <div class="cb_10"></div>
            {/if}
        </div>
        <div class="cb_10"></div>
        <div class="message_warp">
            <div class="title"><h2>{$preset_translations.contact_us}</h2></div>
            <div class="mess_con_wrap">
                <div class="mess_contact">
                    <div class="me_ico_wrap">{$contacts[0].name}</div>
                    <div class="mess_icon">
                        <ul>
                            <li class="i_3">{$corporation.tel_wt}</li>
                            <li class="i_1">{$corporation.address}</li>
                        </ul>
                    </div>
                    <div class="vcd"><a href="/contactus.html">View Details</a></div>
                </div>
                <div class="inquiry_wrap">
                    <form action="/contactsave.html" method="POST" data-role="inquiry-form" onsubmit="return jsSubmit(this);">
                    <input type="hidden" id="subject" name="subject" value="Inquiry About {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if}">
                        <table cellspacing="0" cellpadding="0" class="RM83">
                            <tbody>
                                <tr>
                                    <th style="padding-top: 13px;" class="M1152"><span class="na87">From:</span></th>
                                    <td>
                                        <div class="S293">
                                           <input type="text" id="email" name="email" style="width: 170px; margin-top: 5px;" class="J789">
                                            <div class="xH8f">{$preset_translations.please_enter_your_email_address}</div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <div class="send_title">Send your inquiry directly to us</div>
                                    <textarea class="wi97" name="message" id="message" cols="50" rows="5">I want to buy {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if} you are selling, please contact me !</textarea>
                                    <!--<div class="kG8b">(<font id="tno">0</font>/3000)</div>-->
                                    <div class="kG8b red">Enter between 20 to 3,000</div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <input type="submit" class="btn1" value="">
                                    <div class="cb_10 mt_5"></div>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

            </div>
        </div>
        <div class="cb_10"></div>
        <div class="content_box">
            <div class="title">
                Highlighted Products
            </div>
            <div class="cb_10"></div>
            {foreach $new_products as $product}{if $product@index>=4}{break}{/if}
            <div class="pro_wrap">
                <div class="pro_pic">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center" valign="middle">
                                <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">
                                <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" height="100" width="100" alt="{$product.caption}">
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="pro_tit"><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}" target="_blank">{$product.caption}</a></div>
            </div>
            {/foreach}
            
            <div class="cb_10"></div>
        </div>
    </div>
    <div class="cb_10"></div>
</div>
<!-- content -->
{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/m12/product.js"></script>
</body>
</html>