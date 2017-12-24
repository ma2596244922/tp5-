<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}" />
    <meta name="description" content="{$description|escape}" />
{include file="sets/peony/common/styles.tpl"}
    <link type="text/css" rel="stylesheet" href="/media/lightbox/2.8.1/css/lightbox.min.css" />
</head>
<body>

{include file="sets/peony/common/topbar.tpl"}
{include file="sets/peony/common/logobar.tpl"}
{include file="sets/peony/common/navbar.tpl" page_name="quality"}
        <div class="crumb">
            <p ><a href="/" data-scode="36001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<strong>{$corporation.name} {$preset_translations.quality_control}</strong></p>
        </div>
        <!--crumb-->

<div class="main-content fl-clr">
    <div class="left-content">
{include file="sets/peony/common/group_panel.tpl"}
<!--menu-list-->
{include file="sets/peony/common/contact_panel.tpl"}
</div>
<!--contact-msg-->
    <!--left-content-->
    <div class="right-content">
        <div class="product-box quality-box quality-none">
            <div class="title"><i></i><h1>{$preset_translations.quality_control}</h1></div>
            <div class="quality-list">
                {$corporation.qc_profile}
            </div>
        </div>
        <!--products-box-->
        <div class="product-box certification-box certification-none">
            <div class="title"><i></i><h2>{$preset_translations.certifications}</h2></div>
            <div class="certification-list fl-clr">
{foreach $certifications as $cert}
                <div class="certification-detail">
                    <div class="left-img">
                        <a href="{$cert.uri|url:'enterprise_url_photo'}" title="{$cert.standard|default:''}" data-lightbox="certificate-set">
                            <img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="120" height="168" style="margin: 10px auto;" />
                        </a>
                    </div>
                    <ul>
    {if $cert.standard|default:''}
                        <li><label>Standard</label><span>{$cert.standard}</span></li>
    {/if}
    {if $cert.number|default:''}
                        <li><label>Number</label><span>{$cert.number}</span></li>
    {/if}
    {if $cert.issue_date|default:''}
                        <li><label>Issue Date</label><span>{$cert.issue_date}</span></li>
    {/if}
    {if $cert.expiry_date|default:''}
                        <li><label>Expiry Date</label><span>{$cert.expiry_date}</span></li>
    {/if}
    {if $cert.scope_n_range|default:''}
                        <li><label>Scope/Range</label><span>{$cert.scope_n_range}</span></li>
    {/if}
    {if $cert.issued_by|default:''}
                        <li><label>Issued By</label><span>{$cert.issued_by}</span></li>
    {/if}
                    </ul>
                </div>
{foreachelse}
                <p><i></i>The user has not provide such information.</p>
{/foreach}
            </div>
        </div>
        <!--products-box-->
    </div>
</div>
<!--main-content-->
    <!--contact-us-->
{include file="sets/peony/common/footer.tpl"}
<!--footer-->
<!--footer-->

{include file="sets/peony/common/scripts.tpl"}
<script charset="utf-8" type="text/javascript" src="/media/lightbox/2.8.1/js/lightbox.min.js"></script>  

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
