<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    <link rel="canonical" href="{$product|url:'enterprise_url_product':$page_no}" />
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/june/common/styles.tpl"}
    <link href="/media/sets/june/color7/css/products_detail.css" rel="stylesheet" type="text/css" />
    <script type="application/ld+json">
    {$google_structured_data|json_encode}
    </script>
</head>
<body>
{include file="sets/june/common/header.tpl"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.products}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/june/common/left.tpl"}
        <div class="cb_10"></div>
        {include file="sets/june/common/left_chat.tpl"}
    </div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="box_title">{$product.caption}</div>
            <div class="box_content">
                <div class="photo_box">
                    <div class="big_box">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tbody><tr>
                                <td height="100%" align="center" valign="middle">
                                    {-foreach $product_images as $image_id}
                                    {if $image_id@index==0}
                                    <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank">
                                        <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" width="258" />
                                    </a>
                                    {/if}
                                    {-/foreach}
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                    <div class="photo_text">
                        <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank">{$product.caption} images</a>
                    </div>
                </div>
                <div class="fram_box">
                    <div class="fram_tit">{$preset_translations.product_details}:</div>
                    <table cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr><th>{$preset_translations.place_of_origin}:</th><td>{$product.place_of_origin}</td></tr>
                            <tr><th>{$preset_translations.brand_name}:</th><td>{$product.brand_name}</td></tr>
                            <tr><th>{$preset_translations.certification}:</th><td>{$product.certification}</td></tr>
                            <tr><th>{$preset_translations.model_number}:</th><td>{$product.model_number}</td></tr>
                        </tbody>
                    </table>
                    <div class="cb_10 mt_5"></div>
                    <div class="fram_tit">{$preset_translations.payment_terms}:</div>
                    <table cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr><th>{$preset_translations.minimum_order_quantity}:</th><td>{$product.min_order_quantity|default:'Negotiation'}</td></tr>
                            <tr><th>{$preset_translations.price}:</th><td>{$product.price|default:'Negotiation'}</td></tr>
                            {if $product.packaging_details|default:''}<tr><th>{$preset_translations.packaging_details}:</th><td>{$product.packaging_details}</td></tr>{/if}
                            {if $product.delivery_time|default:''}<tr><th>{$preset_translations.delivery_time}:</th><td>{$product.delivery_time}</td></tr>{/if}
                            {if $product.payment_terms|default:''}<tr><th>{$preset_translations.payment_terms}:</th><td>{$product.payment_terms}</td></tr>{/if}
                            {if $product.supply_ability|default:''}<tr><th>{$preset_translations.supply_ability}:</th><td>{$product.supply_ability}</td></tr>{/if}
                        </tbody>
                    </table>
                    <table width="100%" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                                <td height="50" align="left" style="border: 0;">
                                    <input type="button" class="btn1" onclick="window.location.href='/contactnow.html?about_product={$product.id}'">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="cb"></div>
            </div>

            <div class="pro_detail">
                <div class="title">{$preset_translations.product_description}</div>
                <div class="con_wrap">
                    {$product.description}
                </div>
            </div>
            <div class="cb_10"></div>
        </div>
        <div class="cb_10"></div>
        <div class="content_box">
            <div class="box_title">Other about <strong>More {$product.group.name}</strong></div>
            <div class="box_content">
                <div class="list_ul_li">
                    <table width="100%" cellspacing="0" cellpadding="0">
                        <tbody>
                        {foreach $new_products as $product}{if $product@index>=5}{break}{/if}
                        {if $product@index%2==0}<tr>{/if}
                            <td width="50%"><h2><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></h2></td>
                        {if $product@index%2==1}</tr>{/if}
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="cb_10"></div>
        <div class="message_warp">
            <div class="title">{$preset_translations.contact_us}</div>
            <div class="mess_con_wrap">
                <div class="mess_contact">
                    <div class="mess_icon">
                        <ul>
                            <li class="i_1">{$corporation.name} </li>
                            <li class="i_1">{$contacts[0].name}</li>
                            <li class="i_1">{$preset_translations.telephone}:{$corporation.tel_wt}</li>
                            <li class="i_1">{$preset_translations.fax}:{$corporation.fax}</li>
                        </ul>
                    </div>
                </div>
                <div class="inquiry_wrap">
                    <form action="/contactsave.html" method="POST" data-role="inquiry-form">
                    <input type="hidden" id="subject" name="subject" value="Inquiry About {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if}">
                        <table cellspacing="0" cellpadding="0" class="RM83">
                            <tbody>
                                <tr>
                                    <th style="padding-top: 13px;" class="M1152"><span class="na87">From:</span></th>
                                    <td>
                                        <div class="S293">
                                            <input type="text" id="request_email" name="email" style="width: 170px; margin-top: 5px;" class="J789">
                                            <div class="xH8f">{$preset_translations.please_enter_your_email_address}</div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <div class="send_title">{$preset_translations.subject}</div>
                                    <textarea class="wi97" name="message" id="message" cols="50" rows="5">I want to buy {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if} you are selling, please contact me !</textarea>
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
    </div>

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june/common/footer.tpl"}

{include file="sets/june/common/scripts.tpl"}
</body>
</html>