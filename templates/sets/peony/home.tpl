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
{include file="sets/peony/common/logobar.tpl" h1_element_type=1}
<!--header-->
{include file="sets/peony/common/navbar.tpl" page_name="home"}
    <!--nav-->
<!--nav-->
<div class="banner-block fl-clr">
    <div class="banner" id="banner"> 
        <div class="inner">
{foreach $banners as $banner}
            <a href="{$banner.link}" class="d1" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a>
{/foreach}
        </div>
         
        <ul class="number" id="banner_id">
{foreach $banners as $banner}
            <li{if $banner@index==0}  class="nuw current"{/if}></li>
{/foreach}
        </ul>
    </div>
    <!--banner-->
    <div class="banner-right">
        <span class="title"><img src="/media/sets/peony/banner-right.png" /></span>
        <p>{$corporation.introduction|strip_tags}</p>
        <a href="/aboutus.html" class="see-detail">See Detail</a>
    </div>
    <!--banner-right-->
</div>
<!--banner-block-->
<div class="high-quality">
    <div class="title"><span>Our High Quality Products</span><a href="/products.html" class="more-btn">More</a></div>
    <ul>
{foreach $groups as $group}{if $group@index>=4}{continue}{/if}
        <li>
            <a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">
                <img src="{$group.products[0].head_image_id|url:'enterprise_url_image':$group.products[0].caption:'c'}" width="160" height="160" alt="{$group.products[0].caption}"/></a>
            <div class="right-intro">
                <span><a href="{$group.products[0]|url:'enterprise_url_product'}" title="{$group.products[0].caption}">
                    {$group.products[0].caption|truncate:80}</a>
                </span>
                <a href="{$group|url:'enterprise_url_product_list'}" class="see-detail">See Detail</a>
            </div>
        </li>
{/foreach}
    </ul>
</div>
<!--high-quality-->
<div class="group-item">
    <ul>
        <li class="item1">
            <span></span>
            <dl>
                <dt>{$preset_translations.all_about_us}</dt>
                <dd>{$preset_translations.all_about_us_desc}</dd>
            </dl>
        </li>
        <li class="item2">
            <span></span>
            <dl>
                <dt>{$preset_translations.contact_details}</dt>
                <dd>{$preset_translations.contact_details_desc}</dd>
            </dl>
        </li>
        <li class="item3">
            <span></span>
            <dl>
                <dt>{$preset_translations.quality_control}</dt>
                <dd>{$preset_translations.quality_control_desc}</dd>
            </dl>
        </li>
    </ul>
</div>
<!--group-item-->
<div class="new-update">

     <div class="title">
        <ul data-role="update-title">
            <li class="cur">New Updates<span>|</span></li>
            <!--<li class="">Especially Recommended</li>-->
        </ul>
    </div>
    <div class="update-list" data-role="update-list">
        <ul class="fl-clr" style="display: block;">
            <!--update   pro-->
{foreach $products as $product}
            <li>
                <a href="{$product|url:'enterprise_url_product'}" class="product-img" title="{$product.caption}">
                    <img src="{$product.head_image_id|url:'enterprise_url_image':$groups[0].products[0].caption:'c'}" width="160" height="160" alt="{$product.caption}"/>
                </a>
                <span class="pro-name">
                    <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a>
                </span>
                <div class="star"><span class="star-5"></span></div>
                <a href="{$product|url:'enterprise_url_product'}" class="contact-btn"  rel="nofollow">Contacts</a>
                <span class="new-icon"></span>
            </li>
{/foreach}
        </ul>
        <!--<ul class="fl-clr" style="display: none;">
        </ul>-->
    </div>
</div>
<!--new-update-->
<div class="company-intro">
    <div class="company-inner">
        <div class="intro">
            <span><a href="/aboutus.html">{$preset_translations.company_introduction}</a></span>
            <p><a href="/aboutus.html">{$corporation.introduction|strip_tags|truncate:300}</a></p>
        </div>
        <div class="leave-email">
            <span>Leave Your Intention</span>
            <form action="/contactsave.html" method="POST">
                <p>
                    <label>Email:</label><input type="text" name="email" class="email" data-role="email" placeholder="Enter a keyword to search products" />
                    <span class="erro_alert" data-role="email_error"></span>
                </p>
                <input type="hidden" name="subject" value="Inquiry About {$corporation.name}">
                <input type="hidden" name="message" value="Please contact me as soon as possible and I want to know more about your products.">
                <a href="javascript:void(0)" class="send-now" data-role="send-now">Send Now</a>
            </form>
        </div>
       
    </div>
</div>


<!--company-intro-->
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