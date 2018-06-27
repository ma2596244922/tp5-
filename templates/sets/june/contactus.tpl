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
<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.contact_us}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
        {include file="sets/june/common/left.tpl"}
        <div class="cb_10"></div>
        {include file="sets/june/common/left_chat.tpl"}
    </div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="box_title">{$corporation.name}</div>
            <div class="box_content">
                <div class="cb_10"></div>
                <div class="text_font_light r_pro">
                    <div class="conh">
                        <form action="/contactsave.html" method="POST" data-role="inquiry-form" onsubmit="return jsSubmit(this);">
                        <input type="hidden" id="subject" name="subject" value="{$preset_translations.can_you_provide_me_a_quote}">

                        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables data">
                            <tbody>

                                <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.address} : </th><td style="text-align:left;"> {$corporation.address}</td></tr>

                                <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.worktime} : </th><td style="text-align:left;"> {$corporation.worktime}</td></tr>

                                <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.business_phone} : </th><td style="text-align:left;">{$corporation.tel_wt}({$preset_translations.working_time})</td></tr>

                                <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.fax} : </th><td style="text-align:left;"> {$corporation.fax}</td></tr>

                                
                                <tr>
                                    <th valign="top" style="text-align: right; padding-top: 8px;">{$preset_translations.contact_us} : </th>
                                    <td>
                                        <div class="ri text4">
                                            <input type="hidden" value="1" name="from">
                                            <b style="font-size: 11px; padding-top: 2px;">{$preset_translations.send_your_inquiry_directly_to_us}</b>

                                        </div>
                                    </td>
                                </tr>

                                <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.from} : </th>
                                    <td style="text-align:left;"> 
                                        <input type="text" class="txt" id="email" name="email" placeholder="{$preset_translations.please_enter_your_email_address}" style="width: 530px;">
                                    </td>
                                </tr>

                                <tr>
                                    <th valign="top" style="text-align: right; padding-top: 8px;"> </th>
                                    <td> 
                                        <div class="ri text4">
                                            <textarea maxlength="5000" name="message" id="message" onkeyup="checknum(this,5000,'tno')">I want to buy {if $groups[0]|default:[]}{$groups[0].name}{/if} product you are selling, please contact me !</textarea>
                                             <span>(<font color="red" id="tno">0</font> / 5000)</span>
                                        </div>
                                        <input type="submit" class="btn1" value="">
                                    </td>
                                </tr>


                                
                            </tbody>
                        </table>
                        </form>
                        <div class="cb_10"></div>

                    </div>
                </div>
            </div>
        </div>
        <div class="cb_10"></div>

    </div>

    <div class="cb"></div>
</div>
<!-- content -->
{include file="sets/june/common/footer.tpl"}
{include file="sets/june/common/scripts.tpl"}

<script type="text/javascript">
    checknum( document.getElementById('message'),3000,'tno');
</script>
</body>
</html>