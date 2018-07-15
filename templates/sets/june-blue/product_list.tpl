<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl" page_name="product_list"}
    {include file="sets/june-blue/common/styles.tpl"}
    <link href="/media/sets/june-blue/css/products.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/june-blue/common/header.tpl" cur="product"}
<!-- header -->

<div class="main_wrap">
    <div class="guide_wrap"><a href="/" class="h">{$preset_translations.home}</a>
{-if $group|default:[]}
                <span>{$group.name}</span>
{-elseif $phrase|default:''}
                <span>{$phrase}</span>
{-else}
                <span>{$preset_translations.products}</span>
{-/if}</div>
    <div class="sider_wrap fl">
        {include file="sets/june-blue/common/left.tpl"}
        <div class="cb_10"></div>
    </div>

    
    <div class="main_right_wrap_box">
        <div class="main_right_wrap">
            <div class="main_right_box">

                <div class="title_wrap"><h1 style="color: #FF6000;font-size: 14px;display: inherit;">{-if $group|default:[]}{$group.name}{-elseif $phrase|default:''}{$phrase}{-else}{$preset_translations.all_products}{-/if}</h1>  <span>({$total_products})</span> </div>
               
                    <div class="cb"></div>
                    {foreach $products as $product}
                    {assign var="products_info" value=enterprise_get_product_info($product.id,$default_lang_code) }
                    <div class="prolist_wrap">
                        <div class="pro_tit"><h2><a href="{$product|url:'enterprise_url_product'}" target="_blank" title="{$product.caption}">{$product.caption}</a></h2></div>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tbody><tr>
                                <td width="110">
                                    <div class="pro_pic">
                                        <table cellpadding="0" cellspacing="0">
                                            <tbody><tr>
                                                <td align="center" valign="middle"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}"></td>
                                            </tr>
                                        </tbody></table>
                                    </div>
                                </td>
                                <td valign="top" width="435">
                                    <div class="pro_con">
                                        <p class="con">{$products_info.description|strip_tags|truncate:180:"..."}<a href="{$product|url:'enterprise_url_product'}" target="_blank" title="Read More about {$product.caption}" rel="nofollow">[read more]</a></p>
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
                    <div class="cb_10"></div>
                    {include file="sets/june-blue/common/pager_product.tpl"}

            </div>
        </div>

        <div class="cb_10"></div>
        <div class="message_warp">
            <div class="title"><h2>{$preset_translations.contact_us}</h2></div>
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
                    <form action="/contactsave.html" method="POST" data-role="inquiry-form" onsubmit="return jsSubmit(this);">
                    <input type="hidden" id="subject" name="subject" value="{$preset_translations.can_you_provide_me_a_quote}">
                        <table cellspacing="0" cellpadding="0" class="RM83">
                            <tbody>
                                <tr>
                                    <th style="padding-top: 13px;" class="M1152"><span class="na87">{$preset_translations.from}:</span></th>
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
                                    <div class="send_title">{$preset_translations.subject}</div>
                                    <textarea class="wi97" name="message" id="message" cols="50" rows="5">I want to buy {if $products[0]|default:[]}{$products[0].caption}{/if} you are selling, please contact me !</textarea>
                                    <div class="kG8b red">Enter between 20 to 5,000</div>
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

</div>
<!-- content -->
{include file="sets/june-blue/common/footer.tpl"}
{include file="sets/june-blue/common/scripts.tpl"}

</body>
</html>