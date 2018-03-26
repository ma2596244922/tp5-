<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
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
{include file="sets/peony/common/navbar.tpl" page_name="aboutus"}

        <div class="crumb">
            <p ><a href="/" data-scode="33001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<strong>{$corporation.name}</strong></p>
        </div>
        <!--crumb-->

<!--crumb-->
<div class="main-content fl-clr">
    <div class="left-content">
{include file="sets/peony/common/left_menu.tpl" page_name="aboutus"}
<!--menu-list-->
{include file="sets/peony/common/contact_panel.tpl"}
</div>
<!--contact-msg-->
    <!--left-content-->
    <div class="right-content">
        <div class="product-box news-box">
            <div class="title"><i></i>
                <h1>{$preset_translations.company_profile}</h1>
            </div>
            <div class="news-detail">
                <div class="news-art intro-art">
                    <div class="scrollArea" id="scrollArea">
{foreach $photos as $photo}
                        <a class="c1"><span><img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" alt="{$corporation.name}" /></span></a>
{/foreach}
                        <ul class="small-list" id="small-list">
{foreach $photos as $photo}
                            <li{if $photo@index==0} class="current"{/if}></li>
{/foreach}
                        </ul>
                    </div>
                    <div class="intro-txt intro-art">
                        {$corporation.introduction}
                    </div>
                    <div class="intro-txt">
                        <div class="title"><i></i><h2>{$preset_translations.company_details}</h2></div>
                        <ul class="fl-clr">
                            <li><label>{$preset_translations.business_type}</label><span>{$corporation.business_type}</span></li>
                            <li><label>{$preset_translations.main_market}</label><span>{$corporation.main_market}</span></li>
                            <li><label>{$preset_translations.brands}</label><span>{$corporation.brands}</span></li>
                            <li><label>{$preset_translations.no_of_employees}</label><span>{$corporation.no_of_employees}</span></li>
                            <li><label>{$preset_translations.annual_sales}</label><span>{$corporation.annual_sales}</span></li>
                            <li><label>{$preset_translations.year_established}</label><span>{$corporation.year_established}</span></li>
                            <li><label>{$preset_translations.export_p_c}</label><span>{$corporation.export_p_c}</span></li>
                        </ul>
                    </div>
                    <div class="intro-txt intro-market">
                        <div class="title"><i></i><h2>{$preset_translations.history}</h2></div>
                        {$corporation.history}
                    </div>
                    <div class="intro-txt intro-market">
                        <div class="title"><i></i><h2>{$preset_translations.service}</h2></div>
                        {$corporation.service}
                    </div>
                    <div class="intro-txt intro-market">
                        <div class="title"><i></i><h2>{$preset_translations.our_team}</h2></div>
                        {$corporation.our_team}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--right-content--> 
</div>
<!--main-content-->
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
