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
{include file="sets/brilly/common/logobar.tpl"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}
<div class="Content Shop noRoute">
  <div class="Page">
    <div class="ConBox Banner">
{foreach $banners as $banner}{if $banner@index>0}{continue}{/if}
      <a href="{$banner.link}" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a>
{/foreach}
    </div>
    <div class="ConBox">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">{$preset_translations.featured_products}</h2>
      <div class="clear"></div>
      <ul class="PicTextList Many">
{foreach $products as $product}
        <li>
          <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$groups[0].products[0].caption:'c'}" alt="{$product.caption}"></a>
          <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></p>
        </li>
{/foreach}
      </ul>
    </div>
{include file="sets/brilly/common/profilepanel.tpl"}
    <!-- Post Sourcing Request Start -->
{include file="sets/brilly/common/inquiryform.tpl"}
    <!-- Post Sourcing Request End -->
  </div>
</div>

<div class="ServiceBox">
  <div class="Page">
{foreach $groups as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index==2&&$main_products|default:[]}{break}{/if}{if $group@index>=3}{break}{/if}
    <dl>
        <dt>{$group.name}</dt>
    {foreach $group.products as $product}
        <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {/foreach}
    </dl>
{/foreach}
{if $main_products|default:[]}
    <dl>
        <dt>{$preset_translations.top_products}</dt>
    {foreach $main_products as $mp}
        <dd><a href="{$mp.url}">{$mp.label}</a></dd>
    {/foreach}
    </dl>
{/if}
    <dl>
        <dt>{$preset_translations.about_us}</dt>
        <dd><a href="/aboutus.html" rel="nofollow">{$preset_translations.company_profile}</a></dd>
        <dd><a href="/contactus.html" rel="nofollow">{$preset_translations.contact_info}</a></dd>
        <dd><a href="/directory.html" rel="nofollow">{$preset_translations.site_map}</a></dd>
    </dl>
  </div>
</div>
{include file="sets/brilly/common/footer.tpl"}

{include file="sets/brilly/common/scripts.tpl"}

<script type="text/javascript">
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