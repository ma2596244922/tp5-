<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
{$site.common_head_fragment}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$preset_translations.send_your_inquiry_directly_to_us}</title>
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/trade/common/shopstyles.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/trade/send_inquiry.css" />
</head>

<body>
{include file="sets/trade/inquiry/logobar.tpl"}
<div class="content">
    <div class="main-form fl-clr">
    <form action="/contactsave.html" id="form-inquiry" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="message_type" value="text/plain" />
    <input type="hidden" name="target_product_id" value="{$target_product_id}" />
    <ul class="form-main">
        <li><label><i>*</i>{$preset_translations.from}</label><input type="text" class="txt" id="username" name="email" placeholder="{$preset_translations.please_enter_your_email_address}" /><span class="erro_alert" id="username_error">{$preset_translations.please_enter_your_email_address}</span></li>
        <li class="fl-clr sendTo"><label><i></i>{$preset_translations.to}</label>
            <div class="company">
                <dl class="edit default">
                    <dt><i><a href="{$smarty.server.HTTP_REFERER|default:'/'}">{$corporation.name}</a></i><span class="delete" onclick="removeDl(this)"></span><input type="hidden" value="" name="" /></dt>
                </dl>
            </div>
        </li>
        <li><label><i>*</i>{$preset_translations.subject}</label><input type="text" class="txt" id="subject" name="subject" value="{$subject|escape}" /><span class="erro_alert" id="subject_error">{$preset_translations.please_enter_a_subject_for_your_inquiry}</span></li>
        <li class="fl-clr"><label><i></i>{$preset_translations.quick_question}</label>
            <div class="select fl-clr">
                <ul class="fl-clr">
                    <li class="select"> <a class="select-box" id="slt1" onclick="boxOut(1)"> <span class="selectTxt" id="selectTxt1">{$preset_translations.please_select_faq}</span> <i class="select-btn"><em class="search-btn"></em></i> </a> <span class="selectMenu" id="selectMenu1" style="display:none;"> 
                    <a href="javascript:void(0)" title="Please select FAQ" >{$preset_translations.please_select_faq}</a>
{foreach $quick_questions as $q}
                    <a href="javascript:void(0)" title="{$q|escape}" >{$q}</a>
{/foreach}
                    </span>
                    </li>
                </ul>
                <input type="hidden" id="selectHidden" value="" />
            </div>
            <span class="tips">{$preset_translations.no_typing_quick_question_help_you}</span>
        </li>
        <li class="area"><label><i>*</i>{$preset_translations.message}</label><textarea class="area" name="message" id="area" placeholder="{$preset_translations.placeholder_of_inquiry_message}"></textarea><span class="erro_alert erro_alert1" id="area_error">{$preset_translations.please_enter_the_content_for_your_inquiry}</span></li>
    </ul>
    <div class="slide-menu">
        <div class="title"><span></span><i>{$preset_translations.contact_n_optional_details}</i></div>
        <div class="slide-form">
            <ul>
                <li><label>{$preset_translations.name}</label>
                    <div class="select fl-clr">
                        <ul class="fl-clr">
                            <li class="select"> <a class="select-box" id="slt2" onclick="boxOut(2)"> <span class="selectTxt" id="selectTxt2">Mr.</span> <i class="select-btn"><em class="search-btn"></em></i> </a> 
                            <span class="selectMenu" id="selectMenu2" style="display:none;"> 
                                <a href="javascript:void(0)" onclick="getvalue('Ms.','2')">Ms.</a>  
                                <a href="javascript:void(0)" onclick="getvalue('Miss.','2')">Miss.</a>  
                                <a href="javascript:void(0)" onclick="getvalue('Mrs.','2')">Mrs.</a>  
                                <a href="javascript:void(0)" onclick="getvalue('Mr.','2')">Mr.</a>
                                <input type="hidden" value="0" name="gender" id="sex_hidden" />
                            </span>
                            </li>
                        </ul>
                    </div>
                    <input type="text" class="txt1" name="name" placeholder="First Name  Last Name" />
                </li>
                <li><label>{$preset_translations.company}</label><input type="text" class="txt1 txt2" name="company" placeholder="" /></li>
                <li><label>{$preset_translations.telephone}</label><input type="text" class="txt1 txt2" id="tel" name="tel" placeholder="Area - Local Number - Ext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /><label class="label2">{$preset_translations.fax}</label><input type="text" class="txt1 txt2" name="fax" placeholder="Area - Local Number - Ext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></li>
                <li><label>{$preset_translations.website}</label><input type="text" class="txt1 txt3" name="senderwebsite" placeholder="" /></li>
            </ul>
        </div>
    </div>
    <!--slide-menu-->
    <div class="slide-menu">
        <div class="title"><span></span><i>{$preset_translations.each_file_sized_1m_max}. (Supports jpg, jpeg, png, gif, pdf, doc, docx, xls, xlsx, txt.)</i></div>
        <div class="slide-form">
            <ul>
                <li><label>File 1</label>
                    <input type="file" name="file1">
                    <span class="error">The format doesn't support uploading</span>
                </li>
                <li><label>File 2</label><input type="file" name="file2"></li>
                <li><label>File 3</label><input type="file" name="file3"></li>
            </ul>
        </div>
    </div>
    <!--slide-menu-->
    <ul class="check-list">
    <li><input type="checkbox" checked="checked" class="check" name="iscontact" />{$preset_translations.please_reply_me_within_24_hours}. </li>
    <li><input type="checkbox" class="check English" name="newsletter" />{$preset_translations.yes_i_would_like_your_verified_suppliers_matching_service} </li>
    </ul>
    <div class="submit"><a href="javascript:void(0);" onclick="submit();">{$preset_translations.send_inquiry}</a></div>
    </form>
    </div>
    <!--main-form -->    
</div>
<!--content-->
{include file="sets/trade/common/inquiryfooter.tpl"}
{include file="sets/trade/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/send_inquiry.js"></script> 
{$site.contactnow_fragment}
</body>
</html>