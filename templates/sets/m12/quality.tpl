<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/m12/common/header.tpl" cur="quality"}
<!-- header -->
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.quality_control}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
    {include file="sets/m12/common/left.tpl"}
</div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="title">
                <h1>{$preset_translations.quality_control}</h1>
            </div>
            <div class="cb"></div>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td valign="top" style=" padding:10px 15px 12px 15px;line-height: 18px;"> <p>{$corporation.qc_profile}</p> </td>
                    </tr>
                </table>
            <div class="cb"></div>
        </div>
        <div class="cb_10"></div>
        <div class="content_box">
            <div class="title">
                <h2>{$preset_translations.certifications}</h2>
            </div>
            <div class="cb"></div>
            <div class="control_wrap">
                {foreach $certifications as $cert}    
                    <table class="box_c" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                                <th><img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="90" height="103"></th>
                                <td>
                                    <table width="100%">
                                        <tbody>
                                            <tr><td width="88px">Standard:</td> <td><strong>{$cert.standard}</strong></td></tr>
                                            <tr><td>Number:</td><td>{$cert.number}</td></tr>
                                            <tr><td>Issue Date:</td> <td>{$cert.issue_date}</td></tr>
                                            <tr><td>Expiry Date:</td> <td>{$cert.expiry_date}</td></tr>
                                            <tr><td>Issued By:</td> <td>{$cert.issued_by}</td></tr>
                                        </tbody></table>
                                </td>
                            </tr>
                        </tbody></table>
                {if $cert@index%2==1}<div class="cb_10"></div>{/if}
                {/foreach}
                
                <div class="cb_10"></div>
                
            </div>
            <div class="cb_10"></div>
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
                    <input type="hidden" id="subject" name="subject" value="I want to buy {if $groups[0]|default:[]}{$groups[0].name}{/if} product you are selling, please contact me !">
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
                                    <textarea class="wi97" name="message" id="message" cols="50" rows="5">I want to buy {if $groups[0]|default:[]}{$groups[0].name}{/if} product you are selling, please contact me !</textarea>
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
                Parnter Suppliers
            </div>
            <div class="cb"></div>
            <div class="ps_wrap">
                <table cellpadding="0" cellspacing="0" width="100%">
                    {foreach $contacts as $contact}
                    <tr>
                        <th valign="top" style="border: 0;"><img src="{$corporation.logo|url:'enterprise_url_image'}" width="140" height="50"></th>
                        <td valign="top" style="border: 0;">
                            <dl>
                                <dt>{$corporation.name}</dt>
                                <dd><span>Contact Person : {$contact.name}</span><span>Telephone: {$contact.tel}</span></dd>
                            </dl>
                        </td>
                    </tr>
                    {/foreach}
                </table>
            </div>
            <div class="cb"></div>
        </div>
    </div>
    <div class="cb_10"></div>
</div>
<!-- content -->
{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}
</body>
</html>