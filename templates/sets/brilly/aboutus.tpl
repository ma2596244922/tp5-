<!DOCTYPE html>
<html>
<head>
  {$site.common_head_fragment}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=1200, initial-scale=device-width/1200, user-scalable=no, minimal-ui">
  <title>{$title}</title>
  <meta name="keywords" content="{$keywords|escape}" />
  <meta name="description" content="{$description|escape}" />
  <link rel="stylesheet" type="text/css" href="style.css">
  {include file="sets/trade/common/definitions.tpl"}
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl" page_name="aboutus"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}

<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
      {$corporation.name}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.about_us}</h2>
          <div class="clear">&nbsp;</div>
          <ul class="TextList">
            <li><a href="/aboutus.html">{$preset_translations.company_profile}</a></li>
            <li><a href="/contactus.html">{$preset_translations.contact_us}</a></li>
            <li><a href="/news">{$preset_translations.company_news}</a></li>
          </ul>
        </div>
{include file="sets/brilly/common/grouppanel.tpl"}
      </div>
      <div class="Right">
{include file="sets/brilly/common/profilepanel.tpl"}
        <div class="ConBox ProductIntro">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.company_details}</h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
                <ul>
                    <li><label>{$preset_translations.business_type}</label><span>{$corporation.business_type}</span></li>
                    <li><label>{$preset_translations.main_market}</label><span>{$corporation.main_market}</span></li>
                    <li><label>{$preset_translations.brands}</label><span>{$corporation.brands}</span></li>
                    <li><label>{$preset_translations.no_of_employees}</label><span>{$corporation.no_of_employees}</span></li>
                    <li><label>{$preset_translations.annual_sales}</label><span>{$corporation.annual_sales}</span></li>
                    <li><label>{$preset_translations.year_established}</label><span>{$corporation.year_established}</span></li>
                    <li><label>{$preset_translations.export_p_c}</label><span>{$corporation.export_p_c}</span></li>
                </ul>
              </div>
            </dd>
          </dl>
        </div>
        <div class="ConBox ProductIntro">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.history}</h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
                {$corporation.history}
              </div>
            </dd>
          </dl>
        </div>
        <div class="ConBox ProductIntro">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.service}</h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
                {$corporation.service}
              </div>
            </dd>
          </dl>
        </div>
        <div class="ConBox ProductIntro">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.our_team}</h2>
          <div class="clear"></div>
          <dl>
            <dd>
              <div class="content cur">
                {$corporation.our_team}
              </div>
            </dd>
          </dl>
        </div>
{include file="sets/brilly/common/inquiryform.tpl"}
      </div>
    </div>
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