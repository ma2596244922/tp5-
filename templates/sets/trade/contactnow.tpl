<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Send your inquiry directly to us</title>
{include file="sets/trade/common/shopstyles.tpl"}
<link type="text/css" rel="stylesheet" href="/media/sets/trade/send_inquiry.css" />
</head>

<body>
{include file="sets/trade/inquiry/logobar.tpl"}
<div class="content">
    <div class="main-form fl-clr">
    <form action="/contactsave.html" id="form-inquiry" method="POST" enctype="multipart/form-data">
    <ul class="form-main">
        <li><label><i>*</i>From</label><input type="text" class="txt" id="username" name="email" placeholder="Please Enter your Email Address" /><span class="erro_alert" id="username_error">Please Enter your Email Address</span></li>
        <li class="fl-clr sendTo"><label><i></i>To</label>
            <div class="company">
                <dl class="edit default">
                    <dt><i><a href="{$smarty.server.HTTP_REFERER|default:'/'}">{$corporation.name}</a></i><span class="delete" onclick="removeDl(this)"></span><input type="hidden" value="" name="" /></dt>
                </dl>
            </div>
        </li>
        <li><label><i>*</i>Subject</label><input type="text" class="txt" id="subject" name="subject" value="{$subject|escape}" /><span class="erro_alert" id="subject_error">Please enter a subject for your inquiry</span></li>
        <li class="fl-clr"><label><i></i>Quick question</label>
            <div class="select fl-clr">
                <ul class="fl-clr">
                    <li class="select"> <a class="select-box" id="slt1" onclick="boxOut(1)"> <span class="selectTxt" id="selectTxt1">Please select FAQ</span> <i class="select-btn"><em class="search-btn"></em></i> </a> <span class="selectMenu" id="selectMenu1" style="display:none;"> 
                    <a href="javascript:void(0)" title="Please select FAQ" >Please select FAQ</a>  
                    <a href="javascript:void(0)" title="I'm very interested in your products; could you send me some detail reference information?" >I'm very interested in your products; could you send me some detail reference information?</a>  
                    <a href="javascript:void(0)" title="Please send me detail product specification, thank you!" >Please send me detail product specification, thank you!</a>
                    <a href="javascript:void(0)" title="May I be an agency of your products,and what's yourterms?" >May I be an agency of your products,and what's yourterms?</a>
                    <a href="javascript:void(0)" title="We intend to purchase this product, would you please send me the quotation and minimum order quantity?" >We intend to purchase this product, would you please send me the quotation and minimum order quantity?</a> </span>
                    </li>
                </ul>
                <input type="hidden" id="selectHidden" value="" />
            </div>
            <span class="tips">No typing, "Quick question" Help you!</span>
        </li>
        <li class="area"><label><i>*</i>Message</label><textarea class="area" name="message" id="area" placeholder="For the best results, we recommend including the following details:
-Self introduction\n
-Required specifications\n
-Inquire about price/MOQ
         "></textarea><span class="erro_alert erro_alert1" id="area_error">Please enter the content for your inquiry.</span></li>
    </ul>
    <div class="slide-menu">
        <div class="title"><span></span><i>Contact & Optional Details</i></div>
        <div class="slide-form">
            <ul>
                <li><label>Name</label>
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
                <li><label>Company</label><input type="text" class="txt1 txt2" name="company" placeholder="" /></li>
                <li><label>Telephone</label><input type="text" class="txt1 txt2" id="tel" name="tel" placeholder="Area - Local Number - Ext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /><label class="label2">Fax</label><input type="text" class="txt1 txt2" name="fax" placeholder="Area - Local Number - Ext" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></li>
                <li><label>Website</label><input type="text" class="txt1 txt3" name="senderwebsite" placeholder="" /></li>
            </ul>
        </div>
    </div>
    <!--slide-menu-->
    <div class="slide-menu">
        <div class="title"><span></span><i>Each file sized 1M max. (Supports jpg, jpeg, png, gif, pdf, doc, docx, xls, xlsx, txt.)</i></div>
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
    <li><input type="checkbox" checked="checked" class="check" name="iscontact" />Please reply me within 24 hours. </li>
    <li><input type="checkbox" class="check English" name="newsletter" />Yes! I would like your verified suppliers matching service! </li>
    </ul>
    <div class="submit"><a href="javascript:void(0);" onclick="submit();">Send Inquiry</a></div>
    </form>
    </div>
    <!--main-form -->    
</div>
<!--content-->
{include file="sets/trade/common/inquiryfooter.tpl"}
{include file="sets/trade/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/send_inquiry.js"></script> 
</body>
</html>