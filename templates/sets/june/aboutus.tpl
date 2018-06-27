<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/june/common/styles.tpl"}
    <link href="/media/sets/june/color7/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/june/common/header.tpl"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.about_us}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/june/common/left.tpl"}
        <div class="cb_10"></div>
        {include file="sets/june/common/left_chat.tpl"}
    </div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="box_title">{$preset_translations.about_us}</div>
            <div class="box_content">
                <div class="text_font_light">
                    <div class="pic_box fr">
                        <table width="100%"  height="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center" valign="middle">
                                    {foreach $photos as $photo}
                                    {if $photo@index==0}
                                    <img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" alt="" width="300" height="190" />
                                    {/if}
                                    {/foreach}
                                </td>
                            </tr>
                        </table>
                    </div>
                    <dl>
                        <dt class="fa"> {$corporation.name}</dt>
                        <dd class="fa"> {$corporation.introduction}</dd>
                    </dl>
                    <div class="cb"></div>
                    <div class="bas_wrap">
                        <div class="tit">{$preset_translations.company_details}</div>
                        <table cellspacing="0" cellpadding="0" class="detail_wrap_border">
                            <tbody>
                                <tr><th>{$preset_translations.address}:</th><td>{$corporation.address}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.business_type}:</th><td>{$corporation.business_type}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.main_market}:</th><td>{$corporation.main_market}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.brands}:</th><td>{$corporation.brands}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.no_of_employees}:</th><td>{$corporation.no_of_employees}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.annual_sales}:</th><td>{$corporation.annual_sales}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.year_established}:</th><td>{$corporation.year_established}</td></tr>
                                <tr style="text-align: left;"><th>{$preset_translations.export_p_c}:</th><td>{$corporation.export_p_c}</td></tr>

                            </tbody>
                        </table>
                        <div class="cb"></div>
                    </div>
                    <!-- <div class="bas_wrap">
                        <div class="tit">Trade & Market</div>
                        <table cellspacing="0" cellpadding="0" class="detail_wrap_border">
                            <tbody>
                                <tr style="text-align: left;"><th>Place of Origin:</th><td>Jiangsu.China</td></tr>
                                <tr style="text-align: left;"><th>Brand Name:</th><td>UNISUN</td></tr>
                                <tr style="text-align: left;"><th>Model Number:</th><td>Depends on customers</td></tr>


                            </tbody>
                        </table>
                        <div class="cb"></div>
                    </div> -->

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
                                    <textarea class="wi97" name="message" id="message" cols="50" rows="5">I want to buy {if $groups[0]|default:[]}{$groups[0].name}{/if} product you are selling, please contact me !</textarea>
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

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june/common/footer.tpl"}

{include file="sets/june/common/scripts.tpl"}
</body>
</html>