<!DOCTYPE html>
<html>
<head>
  {$site.common_head_fragment}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  {include file="sets/trade/common/definitions.tpl"}
  <link rel="stylesheet" type="text/css" href="/media/sets/brilly/style.css">
  <script type="text/javascript" src="/media/sets/brilly/jquery.min.js"></script>
  <script type="text/javascript" src="/media/sets/brilly/prototype_create.js"></script>
  <script type="text/javascript" src="/media/sets/brilly/plugins.js"></script>
</head>
<body>
<!-- Plub Header -->
<div class="topBar">
  <div class="Page">
    <p class="fr">
      <span>{$corporation.tel_wt}</span>
      <span>|</span>
      <a href="/contactnow.html" rel="nofollow">{$preset_translations.request_a_quote}</a>
    </p>
  </div>
</div>
<div class="Page Top Shop">
  <div class="fl Logo"><a href="/" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name|escape}"></a></div>
  <p class="fl">{$corporation.name}</p>
  <div class="clear"></div>
</div>
<!-- Plub Header End -->
<div class="Product Navigate Shop">
  <div class="Page">
    <ul class="Navs fl tc">
      <li class="fb"><a href="/">{$preset_translations.home}</a></li>
      <li class="subList">
        <a href="/products.html">{$preset_translations.products}</a><i class="icon arrow_down3"></i>
        <div class="subNav">
{foreach $groups as $group}
          <a href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a>
{/foreach}
        </div>
      </li>
      <li><a href="/aboutus.html">{$preset_translations.company_profile}</a></li>
      <li><a href="/contactus.html">{$preset_translations.contact_us}</a></li>
      <li><a href="/news">{$preset_translations.company_news}</a></li>
      <li><a href="/contactnow.html">{$preset_translations.request_a_quote}</a></li>
    </ul>
    <div class="clear"></div>
  </div>
</div>
<div class="Content Shop noRoute">
  <div class="Page">
    <div class="ConBox Banner">
{foreach $banners as $banner}{if $banner@index>0}{continue}{/if}
      <a href="{$banner.link}" title="{$banner.desc}" target="_blank"><img src="{$banner.uri|url:'enterprise_url_photo'}" alt="{$banner.desc}"></a>
{/foreach}
    </div>
    <div class="ConBox">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">{$preset_translations.recommended_products}</h2>
      <div class="clear"></div>
      <ul class="PicTextList Many">
{foreach $products as $product}
        <li>
          <a href="{$product|url:'enterprise_url_product'}"><img src="{$product.head_image_id|url:'enterprise_url_image':$group.products[0].caption:'c'}" alt="{$product.caption}"></a>
          <p><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption}</a></p>
        </li>
{/foreach}
      </ul>
    </div>
    <div class="CompanyProfile">
      <div class="ConBox Left">
        <div class="clear">&nbsp;</div>
        <h2 class="Til">{$preset_translations.company_profile}</h2>
        <div class="clear"></div>
        <img src="{$corporation.logo|url:'enterprise_url_image'}" class="fl"  alt="{$corporation.name}">
        <div class="info">
          <h1>{$corporation.name}</h1>
          <table>
{if $contacts[0]|default:[]}
            <tr>
              <th>Email</th>
              <td>{$contacts[0].email}</td>
            </tr>
{/if}
            <tr>
              <th>{$preset_translations.address}</th>
              <td>{$corporation.address}</td>
            </tr>
            <tr>
              <th>{$preset_translations.business_phone}({$preset_translations.working_time})</th>
              <td>{$corporation.tel_wt}</td>
            </tr>
            <tr>
              <th>{$preset_translations.fax}</th>
              <td>{$corporation.fax}</td>
            </tr>
          </table>
        </div>
      </div>
{if $contacts[0]|default:[]}
      <div class="Right">
        <img src="/media/sets/trade/default_photo.jpg"  alt="" title="">
        <table>
        {-foreach $contacts[0] as $f => $v}
            {-if isset($contact_desc.$f) && $contacts[0].$f}
                    <li><label></label></li>
          <tr>
            <th>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</th>
            <td>{$v}</td>
          </tr>
            {-/if}
        {-/foreach}
        </table>
        <a href="/contactnow.html" class="btn" rel="nofollow">{$preset_translations.send_inquiry}</a>
      </div>
{/if}
    </div>
    <!-- Post Sourcing Request Start -->
    <div class="ConBox Request">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">{$preset_translations.send_inquiry}</h2>
      <div class="clear"></div>
      <div class="noPic">
        <form action="/contactsave.html" method="POST">
        <table>
          <tr>
            <th><span>*</span>Email</th>
            <td>
              <div class="typeIn">
                <p class="msg">{$preset_translations.please_enter_your_email_address}</p>
                <input type="text" id="request_email" name="email" autocomplete="off">
              </div>
            </td>
          </tr>
          <tr>
            <th>{$preset_translations.subject}</th>
            <td>
              <div class="typeIn">
                <p class="msg"> I would like to know more about your product [ CE Certification and Refrigerant Type refrigerant rec</p>
                <input type="text" id="Subject" name="subject" autocomplete="off">
              </div>
            </td>
          </tr>
          <tr>
            <th>{$preset_translations.quick_question}</th>
            <td>
              <dl class="quickSelect" id="quickSelect">
                <dt>{$preset_translations.please_select_faq}<i class="icon arrow_down2"></i></dt>
                <dd>
                  <p>{$preset_translations.quick_question_1}</p>
                  <p>{$preset_translations.quick_question_2}</p>
                  <p>{$preset_translations.quick_question_3}</p>
                  <p>{$preset_translations.quick_question_4}</p>
                  <i class="icon arrow_down2"></i>
                </dd>
              </dl>
            </td>
          </tr>
          <tr>
            <th><span>*</span>{$preset_translations.message}</th>
            <td>
              <div class="typeIn typeIn2">
                <div class="msg"></div>
                <textarea id="request_con" maxlength="500" autocomplete="off" name="message" placeholder="{$preset_translations.placeholder_of_inquiry_message}"></textarea>
              </div>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><button>{$preset_translations.send_now}</button></td>
          </tr>
        </table>
        </form>
      </div>
      <div class="clear"></div>
    </div>
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
<div class="Footer">
  <div class="Page">
    <p class="fl">
      <a href="/aboutus.html" rel="nofollow">{$preset_translations.about_us}</a>
      <span>|</span>
      <a href="/contactus.html" rel="nofollow">{$preset_translations.contact_us}</a>
      <span>|</span>
      <a href="/directory.html">{$preset_translations.site_map}</a>
    </p>
    <p class="fr">{$corporation.name}. {$preset_translations.copyright} © {$site.start_year} - {$smarty.now|date_format:'%Y'} {$preset_translations.all_rights_reserved}.</p>
    <div class="clear"></div>
  </div>
</div>

<script type="text/javascript" src="./js/header.js"></script>
<script type="text/javascript" src="./js/index.js"></script>

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