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
                            <p ><a href="https://user.china.cn/test/hizo.com/" data-scode="37001" title="Qingdao Hizo Bearing Co., Ltd.">Home</a>&gt;<strong>Contacts</strong></p>                    </div>
        <!--crumb-->

<div class="contact-allinfo fl-clr">
        <div class="contact-communication fl-clr">
            <div class="left-intro">
                                    <img src="//timg.china.cn/1/1_424_40460_100_100.jpg" />
                                <span>Mr. HIZO YOUNG</span>
            </div>
            <div class="right-intro">
                <ul>
                                            <li><label>Job Title</label>Manager</li>
                                            <li><label>Telephone</label><h2>86-0532-67766030</h2></li>
                                            <li><label>Mobile</label><h1>13906426296</h1></li>
                                            <li><label>Fax</label>86-0532-67766031</li>
                                            <li><label>Address</label>No. 192, Zhengyang Road, Chengyang Dist.</li>
                                        <li><label>Showroom</label>http://user.china.cn/test/hizo.com/</li>
                                            <li><label>Website</label><a href="http://http://www.hizobearing.com" target="_blank" data-scode="37002" rel="nofollow">Click Here</a></li>
                                    </ul>
            </div>
        </div>
                <!--contact-communication-->
    </div>
<!--contact-allinfo-->
<div class="contact-us">
    <div class="title">
        <h2>Contact Us</h2>
    </div>
    <div class="contact-info fl-clr">
        <div class="left-list">
                                    <img src="//timg.china.cn/2/1_424_40460_100_100.jpg" alt="Qingdao Hizo Bearing Co., Ltd." />
                                <dl>
                    <dt>Qingdao Hizo Bearing Co., Ltd.</dt>
                                            <dd><span>Contact</span>HIZO YOUNG</dd>
                                                                <dd><span>Phone</span>86-0532-67766030</dd>
                                                                <dd><span>Address</span>No. 192, Zhengyang Road, Chengyang Dist.</dd>
                                    </dl>
            </div>
        <div class="right-list">
            <div class="title"><h2>Contact Us</h2></div>
            <form action="/successfully.html" method="POST">
                <input type="hidden"  name="corpindustry" value="3407">
                <input type="hidden" name ="cid" value="100058201">
                <input type="hidden" name ="entitytype" value="1">
                <ul class="form-list fl-clr">
                    <li><label><i>*</i>Email</label><input type="text" class="txt1" id="email" name="email" placeholder="Enter your email address" />
                    <span class="email-error" id="email-error">Please enter your valid email address.</span>
                    </li>
                    <li><label><i></i>To</label><em class="company-name">Qingdao Hizo Bearing Co., Ltd.</em></li>
                    <li><label><i>*</i>Subject</label><input type="text" class="txt1 txt-val" id="subject" name="subject" value="Inquiry About Qingdao Hizo Bearing Co., Ltd." /><span class="subject-error" id="subject-error">Please enter a subject for your inquiry</span></li>
                    <li class="fl-clr">
                        <label><i></i>Quick question</label>
                        <div class="select fl-clr">
                            <ul class="fl-clr">
                                <li class="select">
                                    <a class="select-box" id="slt2" onclick="boxOut(2)" >
                                        <span class="selectTxt" id="selectTxt2">Quick question</span>
                                        <i class="select-btn"><a href="javascript:void(0)" class="search-btn"></a></i>
                                    </a>
                                    <span class="selectMenu" id="selectMenu2" style="display:none;">
                                        <a href="javascript:void(0)" title="Quick question" >Quick question</a>
                                                                                <a href="javascript:void(0)" title="I would send you order.Please send me e-mail address for our order." >I would send you order.Please send me e-mail address for our order.</a>
                                                                                <a href="javascript:void(0)" title="I would like to purchase your products. Please contact me" >I would like to purchase your products. Please contact me</a>
                                                                                <a href="javascript:void(0)" title="I would need some samples.I will pay for them.Please contact me." >I would need some samples.I will pay for them.Please contact me.</a>
                                                                            </span>   
                                </li>
                            </ul>
                        </div>
                        <div class="tips">What is this?<em>This feature is Quick question function, select the corresponding question types, automatically enter the corresponding problem, remove your trouble of typing<i></i></em></div>
                        <input data-role="isquick" type="hidden" name="isquick" value=""/>
                    </li>
                    <li class="area-li"><label><i>*</i>Message</label>
                        <textarea class="area" id="area" name="message" placeholder="For the best results, we recommend including the following details:
    -Self introduction  
    -Required specifications 
    -Inquire about price/MOQ
                                "></textarea>
                     <span class="area-error" id="area-error">Your inquiry content must be between 20 to 5000 characters.</span>           
                     </li>
                </ul>
                <div class="send-btn"><button type="submit">Send Now</button></div>
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
