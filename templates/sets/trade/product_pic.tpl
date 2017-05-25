
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/shopstyles.tpl"}
{$site.common_head_fragment}
</head>

<body>
<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl" page_name="product_pic"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;<a href="/products.html">Products</a>&gt;<a href="{$product_group|url:'enterprise_url_product_list'}">{$product_group.name}</a>&gt;<span>{$product.caption} image</span></p>
        </div>
        <!--crumb-->
        <div class="product-img fl-clr">
            <div class="img-detail">
                <div class="title">{$product.caption} image</div>
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
                            <ul>
{-foreach $product_images as $image_id}
                                <li{if $image_id@index==0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|escape} #{$image_id@iteration} small image" /></li>
{-/foreach}
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="back-page"><a href="{$product|url:'enterprise_url_product'}"><i></i>Back to product page</a></div>
            </div>
            <div class="img-intro">
                <div class="title">You Might Also Like</div>
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
                    <div class="next-btn">
                        <a href="javascript:void(0)" class="prev"></a>
                        <a href="javascript:void(0)" class="next"></a>
                    </div>
                </div>
            </div> 
        </div>
        <!--product-img-->
{include file="sets/trade/product/specifications.tpl"}
        <!--product-detail-->
{include file="sets/trade/common/contactform.tpl"}
    </div>
    <!--container-->
</div>
<!--content-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/shopscripts.tpl"}
</body>
</html>
