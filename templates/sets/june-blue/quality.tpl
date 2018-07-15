<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/june-blue/common/styles.tpl"}
    <link href="/media/sets/june-blue/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/june-blue/common/header.tpl" cur="quality"}
<!-- header -->

<div class="main_wrap">
    <div class="guide_wrap"><a href="/" class="h">{$preset_translations.home}</a>{$preset_translations.quality_control}</div>
    <div class="sider_wrap fl">
        {include file="sets/june-blue/common/left.tpl"}
        <div class="cb_10"></div>
    </div>
    <div class="main_right_wrap_box">
        <div class="main_right_wrap">
            <div class="main_right_box">
                <div class="title_wrap"><h1>{$preset_translations.quality_control}</h1></div>
                <div class="cb"></div>
                <div class="text_font_light">
                    <p>{$corporation.qc_profile}</p>
                </div>
                <div class="cb_10"></div>
                <div class="title_wrap"><h2>{$preset_translations.certifications}</h2></div>
                <div class="content_box">
                    <div class="control_wrap">
                        {foreach $certifications as $cert}    
                            <table cellspacing="0" cellpadding="0" class="box_c">
                                <tbody><tr>
                                        <th><img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="90" height="103"></th>
                                        <td>
                                            <table width="100%">
                                                <tbody><tr><td width="88px">Standard:</td> <td><strong>{$cert.standard}</strong></td></tr>
                                                    <tr><td>Number:</td><td>{$cert.number}</td></tr>
                                                    <tr><td>Issue Date:</td> <td>{$cert.issue_date}</td></tr>
                                                    <tr><td>Expiry Date:</td> <td>{$cert.expiry_date}</td></tr>
                                                    <tr><td>Issued By:</td> <td>{$cert.issued_by}</td></tr>
                                                </tbody></table>
                                        </td>
                                    </tr>
                                </tbody></table>
                        {/foreach}
                        <div class="cb_10"></div>
                    </div>
                    <div class="cb_10"></div>
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
    </div>

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june-blue/common/footer.tpl"}
{include file="sets/june-blue/common/scripts.tpl"}
</body>
</html>