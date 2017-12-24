<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}" />
    <meta name="description" content="{$description|escape}" />
{include file="sets/peony/common/styles.tpl"}
<link type="text/css" rel="stylesheet" href="/media/quick-inquiry/inquiry-fast.css" />
</head>
<body>

{include file="sets/peony/common/topbar.tpl"}
<div class="container">
{include file="sets/peony/common/logobar.tpl"}
        <!--header-->
{include file="sets/peony/common/navbar.tpl" page_name="product_detail"}

            <div class="crumb">
                <p ><a href="/" data-scode="38001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<a href="/product.html" data-scode="38001" title="{$preset_translations.products}" rel="nofollow">{$preset_translations.products}</a>&gt;<a href="{$product_group|default:[]|url:'enterprise_url_product_list'}" data-scode="38001" rel="nofollow">{$product_group.name|default:''}</a>&gt;<strong>{$product.caption}</strong></p>
            </div>
        <!--crumb-->

<!--crumb-->
<div class="produce-show fl-clr">
    <div class="img-show">
        <div class="tabContent">

                <div class="big-img">
                    <ul>
{-if $product_images}
    {-foreach $product_images as $image_id}
                        <li>
                            <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank">
                                <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" />
                            </a>
                        </li>
    {-/foreach}
{-else}
                        <li><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}" /></li>
{-/if}
                    </ul>
                </div>
                <div class="small-img">
                        <div class="scroll">
                            <ul style="width: 395px;">
{-if $product_images}
    {-foreach $product_images as $image_id}
                                <li{if $image_id@index == 0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" /></li>
    {-/foreach}
{-else}
                                <li class="current"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" /></li>
{-/if}
                            </ul>
                        </div>
                        <div class="prev-next"> <a href="javascript:void(0);" class="prev default current"></a> <a href="javascript:void(0);" class="next"></a> </div>
                </div>
        </div>
    </div>
{-if $product_group.product_give_h1_to|default:'0'=='1'}
    {-assign var="caption_html_element" value="h2"}
    {-assign var="model_number_html_element" value="h1"}
{-else}
    {-assign var="caption_html_element" value="h1"}
    {-assign var="model_number_html_element" value="h2"}
{-/if}
             <div class="simple-intro">
            <div class="title">
                <{$caption_html_element}>{$product.caption}</{$caption_html_element}>
            </div>
            <ul>
                <!-- Product Details -->
                {if $product.place_of_origin|default:''}<li><label>{$preset_translations.place_of_origin}:</label><span>{$product.place_of_origin}</span></li>{/if}
                {if $product.brand_name|default:''}<li><label>{$preset_translations.brand_name}:</label><span>{$product.brand_name}</span></li>{/if}
                {if $product.certification|default:''}<li><label>{$preset_translations.certification}:</label><span>{$product.certification}</span></li>{/if}
                {if $product.model_number|default:''}<li><label>{$preset_translations.model_number}:</label><{$model_number_html_element}>{$product.model_number}</{$model_number_html_element}></li>{/if}

                <!-- Payment & Shipping Terms -->
                <li><label>{$preset_translations.minimum_order_quantity}:</label><span>{$product.min_order_quantity|default:'Negotiation'}</span></li>
                <li><label>{$preset_translations.price}:</label><span>{$product.price|default:'Negotiation'}</span></li>
                {if $product.packaging_details|default:''}<li><label>{$preset_translations.packaging_details}:</label><span>{$product.packaging_details}</span></li>{/if}
                {if $product.delivery_time|default:''}<li><label>{$preset_translations.delivery_time}:</label><span>{$product.delivery_time}</span></li>{/if}
                {if $product.payment_terms|default:''}<li><label>{$preset_translations.payment_terms}:</label><span>{$product.payment_terms}</span></li>{/if}
                {if $product.supply_ability|default:''}<li><label>{$preset_translations.supply_ability}:</label><span>{$product.supply_ability}</span></li>{/if}
            </ul>
            <div class="contact-btn fl-clr"> 
                <a href="/contactnow.html" data-scode="38004" rel="nofollow" >{$preset_translations.contact_now}</a>
            </div>
             
            </div>
        </div>

</div>
<!--produce-show--> 
<div class="main-content fl-clr">
    <div class="left-content">
{include file="sets/peony/common/group_panel.tpl"}
        <!--menu-list-->
{include file="sets/peony/common/contact_panel.tpl"}
    </div>
    <!--left-msg-->

        
    <div class="right-msg">
        <!--produce-show-->
{include file="sets/trade/product/specifications.tpl"}
        <!--product-detail-->
        <div class="product-description">
            <div class="title"><i></i><h2>{$preset_translations.product_description}</h2></div>
            {$product.description}
        </div>
        <!--tab-product-->
                <!--contact-us-->
        <!--new-products-->
<div class="new-products">
    <div class="title"><i></i>{$preset_translations.new_products}</div>
    <div class="tab-content">
                        <div class="tabs-new" id="tabs-new">
            
                <a href="javascript:void(0)" class="current"></a>
            
                <a href="javascript:void(0)" ></a>
                        </ul>
        </div>
        <div class="tabs-list" id="tabs-list">
            <ul class="fl-clr">
{foreach $new_products as $product}{if $product@index>=5}{break}{/if}
                <li><a href="{$product|url:'enterprise_url_product'}" data-scode="38008" title="{$product.caption|escape}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}" /><i>{$product.caption|escape}</i></a></li>
{/foreach}
            </ul>
        </div>
    </div>
</div>
<!--new-products-->        <!--new-products-->
       
    </div>
    <!--right-msg--> 
</div>
<script>

function update()
{
    $.post("?t=ajax",{},function(data){
        var str = '';
        $(data).each(function(x,y)
        {
            str +=' <li><img src="'+y.pic+'" alt="'+y.caption+'" />';
            str +='<span><a href="'+y.url+'"title="'+y.caption+'">'+y.caption+'</a></span></li>';
        });
        $('.fl-clr .pro-list').html(str);
    },'json');
}
</script>
{include file="sets/peony/common/footer.tpl"}
<!--footer-->
<!--footer-->

{include file="sets/peony/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/quick-inquiry/quick-inquiry.js"></script>

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
