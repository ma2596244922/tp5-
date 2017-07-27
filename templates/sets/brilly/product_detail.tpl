<!DOCTYPE html>
<html{$html_attr_dir}>
<head>
  {$site.common_head_fragment}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  {include file="sets/trade/common/definitions.tpl"}
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl" page_name="product_detail"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}

<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
      <a href="/products.html">{$preset_translations.products}</a>
      <span>&gt;</span>
      <a href="{$product_group|default:[]|url:'enterprise_url_product_list'}">{$product_group.name|default:''}</a>
      <span>&gt;</span>
      {$product.caption}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
{include file="sets/brilly/common/grouppanel.tpl"}
      </div>
      <div class="Right">
        <div class="ConBox ProductInfo">
          <div class="clear">&nbsp;</div>
          <h1 class="Til">{$product.caption}</h1>
          <div class="clear"></div>
          <div class="pics PL">
            <ul class="picsList PL_List">
{-if $product_images}
    {-foreach $product_images as $image_id}
              <li class="PL_item" style="display: none;">
                <a href="{$product|url:'enterprise_url_product_pic'}" title="{$product.caption|default:''|escape} image" target="_blank">
                  <img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}">
                </a>
              </li>
    {-/foreach}
{-else}
              <li class="PL_item" style="display: none;"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|default:''|escape}"></li>
{-/if}
            </ul>
            <button class="PL_prev"><i class="icon arrow_left"></i></button>
            <button class="PL_next"><i class="icon arrow_right"></i></button>
            <div class="PL_dots">
{-if $product_images}
    {-foreach $product_images as $image_id}
              <img src="{$image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" class="PL_dot{if $image_id@index == 0} cur{/if}">
    {-/foreach}
{-else}
              <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption|default:''|escape}" class="PL_dot cur">
{-/if}
            </div>
          </div>
          <div class="main">
            <!-- Product Details -->
            {if $product.place_of_origin|default:''}<dl>
              <dt>{$preset_translations.place_of_origin}:</dt>
              <dd>{$product.place_of_origin}</dd>
            </dl>{/if}
            {if $product.brand_name|default:''}<dl>
              <dt>{$preset_translations.brand_name}:</dt>
              <dd>{$product.brand_name}</dd>
            </dl>{/if}
            {if $product.certification|default:''}<dl>
              <dt>{$preset_translations.certification}:</dt>
              <dd>{$product.certification}</dd>
            </dl>{/if}
            {if $product.model_number|default:''}<dl>
              <dt>{$preset_translations.model_number}:</dt>
              <dd>{$product.model_number}</dd>
            </dl>{/if}

            <!-- Payment & Shipping Terms -->
            <dl>
              <dt>{$preset_translations.minimum_order_quantity}:</dt>
              <dd>{$product.min_order_quantity|default:'Negotiation'}</dd>
            </dl>
            <dl>
              <dt>{$preset_translations.price}:</dt>
              <dd>{$product.price|default:'Negotiation'}</dd>
            </dl>
            {if $product.packaging_details|default:''}<dl>
              <dt>{$preset_translations.packaging_details}:</dt>
              <dd>{$product.packaging_details}</dd>
            </dl>{/if}
            {if $product.delivery_time|default:''}<dl>
              <dt>{$preset_translations.delivery_time}:</dt>
              <dd>{$product.delivery_time}</dd>
            </dl>{/if}
            {if $product.payment_terms|default:''}<dl>
              <dt>{$preset_translations.payment_terms}:</dt>
              <dd>{$product.payment_terms}</dd>
            </dl>{/if}
            {if $product.supply_ability|default:''}<dl>
              <dt>{$preset_translations.supply_ability}:</dt>
              <dd>{$product.supply_ability}</dd>
            </dl>{/if}
            <a href="" class="Btn" rel="nofollow">{$preset_translations.contact_now}</a>
          </div>
          <div class="clear"></div>
        </div>
        <div class="ConBox ProductIntro">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.product_description}</h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
                {$product.description}
              </div>
            </dd>
          </dl>
        </div>
{include file="sets/brilly/common/inquiryform.tpl"}
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.new_products}</h2>
          <div class="clear">&nbsp;</div>
          <ul class="PicTextList Many Type2">
{foreach $new_products as $product}{if $product@index>=5}{break}{/if}
            <li>
              <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}"></a>
              <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption|escape}</a></p>
            </li>
{/foreach}
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

<script type="text/javascript">
new IndexBanner('PL',0); //轮换

(function(){
  $("#quickSelect").mouseenter(function(e){
    $(this).children('dd').show()
  }).click(function(e){
    if(e.target.tagName != 'P') return false;
    var inner = $(e.target).html()
    $("#request_con").val(inner).prev('.msg').hide();
    $(this).children('dd').hide()
    $(this).children('dt').html(inner+'<i class="icon arrow_down2"></i>').addClass('cur')
  }).mouseleave(function(){
    $(this).children('dd').hide()
  })
  $("#request_email,#request_con,#Subject").keyup(function(){
    if(this.value.length > 0){
      $(this).prev('.msg').hide().parent().removeClass('error')
    }
  })
  var rules = []
  var email = new rule('request_email');
  email.add(['isEmpty:Please Enter Your Email Address','isEmail:false:Please Enter A valid Email Address'])
  var con = new rule('request_con');
  con.add(['isEmpty:Please Enter The content for your inquiry','min:20:Please enter at least 20 characters','max:500:Please enter up to 500 characters'])
  rules.push(email)
  rules.push(con)
  $("#request_email,#request_con").each(function(i,e){
    $(e).blur(function(){
      var s = rules[i].start()
      if(s!==true){
        $(this).prev('.msg').html(s).show().parent().addClass('error')
      }
    })
  })
})()
$("#productsSearch").keyup(function(){
  console.log(this.value.length)
  if(this.value.length > 0){
    $(this).next('i').addClass('focus')
    return false;
  }
  $(this).next('i').removeClass('focus')
});
</script>
</body>
</html>