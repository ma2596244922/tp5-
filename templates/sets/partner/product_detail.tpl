
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
</head>
<body>
{include file="sets/partner/common/header.tpl"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
{include file="sets/partner/common/banner.tpl"}
<!-- banner -->
<div class="content fl-clr">
    <div class="left-content">
        <div class="pro-detail fl-clr">
            <h1 class="pro-title" id="proName">{$product.caption}</h1>
            <div class="left-show">
                <ul class="big-show">
                    {-if $product_images}
                    {-foreach $product_images as $image_id}
                    <li{if $image_id@index==0} style="display:block;"{/if}><a href="{$product|url:'enterprise_url_product_pic'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" title="{$product.caption|default:''|escape}"  alt="{$product.caption|default:''|escape}"/></a></li>
                    {-/foreach}
                    {-else}
                    <li><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" title="{$product.caption|default:''|escape}" alt="{$product.caption|default:''|escape}"/></li>
                    {-/if}
                </ul>
                <ul class="small-list">
                    {-if $product_images}
                    {-foreach $product_images as $image_id}
                    <li{if $image_id@index==0} class="current"{/if}><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" title="{$product.caption|default:''|escape}" alt="{$product.caption|default:''|escape}" /></li>
                    {-/foreach}
                    {-else}
                    <li><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" title="{$product.caption|default:''|escape}" alt="{$product.caption|default:''|escape}" /></li>
                    {-/if}
                </ul>
            </div>
            <div class="right-intro">
                <ul>
                    {if $product.place_of_origin|default:''}<li><label>{$preset_translations.place_of_origin}:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.brand_name|default:''}<li><label>{$preset_translations.brand_name}:</label><span>{$product.brand_name}</span></li>{/if}
                    {if $product.certification|default:''}<li><label>{$preset_translations.certification}:</label><span>{$product.certification}</span></li>{/if}
                    {if $product.model_number|default:''}<li><label>{$preset_translations.model_number}:</label><{$model_number_html_element}>{$product.model_number}</{$model_number_html_element}></li>{/if}

                    <li><label>{$preset_translations.minimum_order_quantity}:</label><span>{$product.min_order_quantity|default:'Negotiation'}</span></li>
                    <li><label>{$preset_translations.price}:</label><span>{$product.price|default:'Negotiation'}</span></li>

                    {if $product.packaging_details|default:''}<li><label>{$preset_translations.packaging_details}:</label><span>{$product.packaging_details}</span></li>{/if}
                    {if $product.delivery_time|default:''}<li><label>{$preset_translations.delivery_time}:</label><span>{$product.delivery_time}</span></li>{/if}
                    {if $product.payment_terms|default:''}<li><label>{$preset_translations.payment_terms}:</label><span>{$product.payment_terms}</span></li>{/if}
                    {if $product.supply_ability|default:''}<li><label>{$preset_translations.supply_ability}:</label><span>{$product.supply_ability}</span></li>{/if}
                </ul>
                <a href="#" class="send">Send Message</a>
            </div>
        </div>
        <!-- pro-detail -->
        <div class="detail-intro">
            <span>More Product Details</span>
            <p>{$preset_translations.contact_now}</p>
        </div>
        <!-- intro-box -->
        {include file="sets/partner/common/send_msg.tpl" send_style="1"}
        <!-- send-msg -->
        {include file="sets/partner/common/latest_product.tpl"}
        <!-- intro-pro -->
    </div>
    <!-- left-content -->
    {include file="sets/partner/common/right_list.tpl"}
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
</body>
</html>