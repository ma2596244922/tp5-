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
{include file="sets/peony/common/logobar.tpl" h1_element_type=2}
{include file="sets/peony/common/navbar.tpl" page_name="product_list"}
        <div class="crumb">
            <p >
                <a href="/" data-scode="32001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;
{-if $group|default:[]}
                <a href="/products.html">{$preset_translations.products}</a>&gt;<strong>{$group.name}</strong>
{-elseif $phrase|default:''}
                <a href="/products.html">{$preset_translations.products}</a>&gt;<strong>{$phrase}</strong>
{-else}
                <strong>{$preset_translations.products}</strong>
{-/if}
            </p>
        </div>
        <!--crumb-->

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
        <div class="product-box">
            <div class="title">
                <i></i>
{-if $group|default:[]}
                <h1>{$group.name}</h1>
{-elseif $phrase|default:''}
                <h1>{$phrase}</h1>
{-else}
                {$preset_translations.all_products}
{-/if}
                <a href="/contactnow.html" data-scode="" rel="nofollow" target="_blank" title="{$preset_translations.contact_now}">{$preset_translations.contact_now}</a>
            </div>
            <ul class="fl-clr product-img">
{foreach $products as $product}
                <li>
                    <span class="img-box">
                        <a href="{$product|url:'enterprise_url_product'}" data-scode="32005" title="{$product.caption}">
                            <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption}">
                        </a>
                        <a href="{$product|url:'enterprise_url_product'}" data-scode="32005" title="{$product.caption}">
                            <h2><i>{$product.caption}</i></h2>
                        </a>
                    </span>
                    <dl style="display: none;">
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=4}{break}{/if}
        {-if $product.$k|default:$meta.default}
                        <dd>{$meta.label}: {$product.$k|default:$meta.default}</dd>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
                    </dl>
                </li>
{foreachelse}
                <li><p><i></i>Sorry! No matches were found{if $phrase|default:''} for "{$phrase}"{/if}.</p></li>
{/foreach}
            </ul>
        </div>
        <!--product-box-->
{include file="sets/trade/product/pager.tpl"}

<!--view-page-->        <!--view-page-->
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
