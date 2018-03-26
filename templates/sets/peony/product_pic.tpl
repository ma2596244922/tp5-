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
{include file="sets/peony/common/navbar.tpl" page_name="product_pic"}
        <div class="crumb">
            <p ><a href="/" data-scode="39001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<a href="/product.html" data-scode="39001" title="{$preset_translations.products}" rel="nofollow">{$preset_translations.products}</a>&gt;<a href="{$product_group|default:[]|url:'enterprise_url_product_list'}" data-scode="39001" rel="nofollow">{$product_group.name|default:''}</a>&gt;<strong>{$product.caption} image</strong></p>
        </div>
        <!--crumb-->

<!--crumb-->
<div class="product-img fl-clr">
    <div class="img-detail">
        <div class="title">
            <h1>{$product.caption} image</h1>
        </div>
        <div class="photo-show fl-clr">
            <div class="img-tab">
                <div class="big-box">
                    <ul>
{-foreach $product_images as $image_id}
                        <li{if $image_id@index==0} class="current"{/if}><span><img src="{$image_id|url:'enterprise_url_image':$product.caption:'t'}" alt="{$product.caption|escape} #{$image_id@iteration} image" /></span></li>
{-/foreach}
                    </ul>
                </div>
                <div class="small-box">
                    <ul style="width: 160px;">
{-foreach $product_images as $image_id}
                                <li{if $image_id@index==0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|escape} #{$image_id@iteration} small image" /></li>
{-/foreach}
                    </ul>
                </div>
            </div>
        </div>
        <div class="back-page"><a href="{$product|url:'enterprise_url_product'}" title="{$preset_translations.back_to_product_page}" data-scode=""> <i></i>{$preset_translations.back_to_product_page}</a></div>
    </div>
            <div class="img-intro">
            <div class="title">{$preset_translations.you_might_also_like}</div>
            <div class="photo-list photo-big">
                <div class="scrollArea">
                    <div class="img-list">
                        <ul>
{foreach $new_products as $product}
                            <li><a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'d'}" alt="{$product.caption|escape}" /><i>{$product.caption}</i></a></li>
{/foreach}
                        </ul>
                    </div>
                </div>
                <div class="next-btn"> <a href="javascript:void(0)" class="prev"></a> <a href="javascript:void(0)" class="next"></a> </div>
            </div>
        </div>
    </div>
<!--product-img-->
<!--contact-us-->
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
