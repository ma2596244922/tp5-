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
  {include file="sets/brilly/common/styles.tpl"}
</head>
<body>
<!-- Plub Header -->
{include file="sets/brilly/common/topbar.tpl"}
{include file="sets/brilly/common/logobar.tpl" page_name="news_list"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}
<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
      {$preset_translations.news}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
{include file="sets/brilly/common/grouppanel.tpl"}
      </div>
      <div class="Right News">
        <div class="ListTitle ConBox">
          <h1>{$preset_translations.company_news}</h1>
          <p>Show all the company news and by the news you'll find more details about our company.</p>
        </div>
        <ul class="ItemList">
{foreach $news as $n}
          <li class="NewsItem">
  {-if $n.head_image_id}
            <div class="pic">
              <a href="{$n|url:'enterprise_url_news'}"><img src="{$n.head_image_id|url:'enterprise_url_image':$n.caption:''}" alt="{$n.caption}"></a>
            </div>
  {-/if}
            <div class="main">
              <p class="til"><a href="{$n|url:'enterprise_url_news'}"><strong title="{$n.caption}">{$n.caption}</strong></a></p>
              <span class="time">{$n.created}</span>
              <div class="clear"></div>
              <p class="con">{$n.content|strip_tags|truncate:260}</p>
            </div>
          </li>
{foreachelse}
          <li><p>{$preset_translations.the_user_has_not_provide_such_information}.</p></li>
{/foreach}
        </ul>
{if $total_news > $page_size}
        <div class="Pager ConBox tc">
          <div class="lists">
    {-if isset($pager_info['prev_page'])}
            <a href="{$pager_info['prev_page']|url:'enterprise_url_news_list'}" class="disabled left"><i class='icon arrow_left'></i> Prev</a>
    {-/if}
    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
            <a href="{$i|url:'enterprise_url_news_list'}"{if $i==$page_no} class="cur"{/if}>{$i}</a>
    {-/for}
    {-if isset($pager_info['next_page'])}
            <a href="{$pager_info['next_page']|url:'enterprise_url_news_list'}" class="right">Next <i class='icon arrow_right'></i></a>
    {-/if}
          </div>
        </div>
{/if}
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