<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}" />
    <meta name="description" content="{$description|escape}" />
{include file="sets/peony/common/styles.tpl"}
</head>
<body>

{include file="sets/peony/common/topbar.tpl"}
{include file="sets/peony/common/logobar.tpl"}
{include file="sets/peony/common/navbar.tpl" page_name="contactus"}

        <div class="crumb">
            <p ><a href="/" data-scode="37001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<strong>{$corporation.name} Contact Info</strong></p>
        </div>
        <!--crumb-->
{if $site.contact_content|default:''}
    <div class="intro-txt intro-art">
        {$site.contact_content}
    </div>
{else}
    {-foreach $contacts as $contact}
    <div class="contact-allinfo fl-clr">
        <div class="contact-communication fl-clr">
            <div class="left-intro">
                <img src="/media/sets/trade/default_photo.jpg" />
                <span>{$contact.name}</span>
            </div>
            <div class="right-intro">
                <ul>
        {-foreach $contact as $f => $v}{if $f=='name'}{continue}{/if}
            {-if isset($contact_desc.$f) && $contact.$f}
                {-if $f=='email'}
                    <li>
                        <label>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</label>
                        <a href="mailto:{$v}">{$v}</a>
                    </li>
                {-else}
                    <li><label>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</label>{$v}</li>
                {-/if}
            {-/if}
        {-/foreach}
                </ul>
            </div>
        </div>
        <!--contact-communication-->
    </div>
    {-/foreach}
{/if}
<!--contact-allinfo-->
<div class="contact-us">
    <div class="title">
        <h2>Contact Us</h2>
    </div>
    <div class="contact-info fl-clr">
        <div class="left-list">
            <img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name}" />
            <dl>
                <dt>{$corporation.name}</dt>
{-if $corporation.address|default:''}
                <dd><span>{$preset_translations.address}</span>{$corporation.address}</dd>
{-/if}
{-if $corporation.factory_address|default:''}
                <dd><span>{$preset_translations.factory_address}</span>{$corporation.factory_address}</dd>
{-/if}
{-if $corporation.worktime|default:''}
                <dd><span>{$preset_translations.worktime}</span>{$corporation.worktime}</dd>
{-/if}
{-if $corporation.tel_wt|default:''}
                <dd><span>{$preset_translations.business_phone}({$preset_translations.working_time})</span>{$corporation.tel_wt}</dd>
{-/if}
{-if $corporation.tel_nwt|default:''}
                <dd><span>{$preset_translations.business_phone}({$preset_translations.nonworking_time})</span>{$corporation.tel_nwt}</dd>
{-/if}
{-if $corporation.fax|default:''}
                <dd><span>{$preset_translations.fax}</span>{$corporation.fax}</dd>
{/if}
            </dl>
            </div>
        <div class="right-list">
            <div class="title"><h2>Contact Us</h2></div>
            <form action="/contactsave.html" method="POST">
                <ul class="form-list fl-clr">
                    <li><label><i>*</i>Email</label><input type="text" class="txt1" id="email" name="email" placeholder="{$preset_translations.please_enter_your_email_address}" />
                    <span class="email-error" id="email-error">Please enter your valid email address.</span>
                    </li>
                    <li><label><i></i>{$preset_translations.to}</label><em class="company-name">{$corporation.name}</em></li>
                    <li><label><i>*</i>{$preset_translations.subject}</label><input type="text" class="txt1 txt-val" id="subject" name="subject" value="Inquiry About {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if}" /><span class="subject-error" id="subject-error">Please enter a subject for your inquiry</span></li>
                    <li class="fl-clr">
                        <label><i></i>{$preset_translations.quick_question}</label>
                        <div class="select fl-clr">
                            <ul class="fl-clr">
                                <li class="select">
                                    <a class="select-box" id="slt2" onclick="boxOut(2)" >
                                        <span class="selectTxt" id="selectTxt2">{$preset_translations.quick_question}</span>
                                        <i class="select-btn"><a href="javascript:void(0)" class="search-btn"></a></i>
                                    </a>
                                    <span class="selectMenu" id="selectMenu2" style="display:none;">
                                        <a href="javascript:void(0)" title="{$preset_translations.quick_question}" >{$preset_translations.quick_question}</a>
{foreach $quick_questions as $q}
                                        <a href="javascript:void(0)" title="{$q|escape}" >{$q|escape}</a>
{/foreach}
                                    </span>
                                </li>
                            </ul>
                        </div>
                        <div class="tips">{$preset_translations.what_is_this}<em>{$preset_translations.what_is_this_1}<i></i></em></div>
                        <input data-role="isquick" type="hidden" name="isquick" value=""/>
                    </li>
                    <li class="area-li"><label><i>*</i>{$preset_translations.message}</label>
                        <textarea class="area" id="area" name="message" placeholder="{$preset_translations.placeholder_of_inquiry_message}"></textarea>
                     <span class="area-error" id="area-error">Your inquiry content must be between 20 to 5000 characters.</span>           
                     </li>
                </ul>
                <div class="send-btn"><button type="submit">{$preset_translations.send_now}</button></div>
            </form>
        </div>
    </div>
</div>

<!--contact-us-->
{include file="sets/peony/common/footer.tpl"}
<!--footer-->
<!--footer-->

{include file="sets/peony/common/scripts.tpl"}

<script>
        
            var inputTxt = $("#search-text");
            /*searchBtn.on('click',function(){
                 
                    // 验证关键词 
                    validate(inputTxt);
            });*/
                
            // 按下enter键，跳转到该搜索页面
            inputTxt.keyup(function(event){
              
                    if(event.keyCode == 13){
                        
                        self.validate(inputTxt);
                     }
            });

            function validate(inputTxt){
                    var _key = $.trim(inputTxt.val());
                    // 英文站校验规则 
                    // 特殊字符过滤
                    _key = _key.replace(/[&\|\\\*^%$#@;:~\'\"\"\!￥\(\)]/g,' ');

                    // 非空校验、非中文校验
                    if(_key == ''){
                        alert("Please enter a keyword!");
                        inputTxt.focus();
                        return false;
                    }else if(!valideChinese(_key)){
                        alert("Please input information in english only!");
                        inputTxt.focus();
                        return false;
                    }

                    // 调用搜索方法
                    var url = 'http://user.china.cn/test/hizo.com/products.html';
                     
                    window.location.href = url+"?keyword="+encodeURIComponent(_key)+"";
                
                    
                
            }

            function valideChinese(key){
                    var reg = /[\u4e00-\u9fa5]+/;
                    if(reg.test(key)){
                        return false;
                    }else{
                        return true;
                    }
            }

</script>
</body>
</html>
