<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>{$title}</title>
<meta name="keywords" content="{$keywords|escape}" />
<meta name="description" content="{$description|escape}" />
{include file="sets/trade/common/definitions.tpl"}
{include file="sets/msma/common/styles.tpl"}
<link href="/media/sets/msma/css/swiper.min.css" rel="stylesheet" type="text/css" />
</head>

<body>
{include file="sets/msma/common/logobar.tpl"}


<!--********************banner********************-->
<div id="banner">
  <a class="arrow-left" href="#"><i class="iconfont icon-arrow-left-circle"></i></a> 
  <a class="arrow-right" href="#"><i class="iconfont icon-xiangyou_jiantou"></i></a> 
  <div class="swiper-container" id="bannerSwiper"> 
<div class="swiper-wrapper">

{foreach $banners as $banner}
   <!--********************banner1********************-->
    <div class="swiper-slide" id="swiper-slide{$banner@iteration}">
        <div class="inner">
            <div id="mainTheme" ><h1 data-swiper-parallax="-1500">{$banner.desc}</h1></div>
            <p data-swiper-parallax="-1500">{$banner.desc}</p>
            <div class="subbtn" data-swiper-parallax="-3000">
                <a class="button1" href="{$banner.link}">shop now</a>  
            </div>

        </div>
    </div>
    <!--********************banner1********************-->
{/foreach}

</div>
</div>
<div id="bannerpagination" class="pagination"></div>
</div>
<!--********************banner********************-->



<!--********************ym_container********************-->
<div class="ym_container">

   <!--****caidan****-->
    <ul class="ym_con_ul"  id="ym_con_ul">
{foreach $groups as $group}{if $group@index>=5}{continue}{/if}
        <li><a href="javascript:;">{$group.name}</a></li>
{/foreach}
    </ul>
    <!--****caidan****-->
    <div class="clear"></div>
    
    <div class="ym_con_pic">
{foreach $groups as $group}{if $group@index>=5}{continue}{/if}
      <!--****切换图片1****-->
      <div class="ym_con_box ym_con_clear"{if $group@index==0} style="display:block;"{/if}>
    {-foreach $group.products as $product}{if $product@index>=8}{continue}{/if}
            <!--**1**-->
            <div class="ym_con_list">
                <div><a href="{$product|url:'enterprise_url_product'}" ><img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" width="228" height="250" alt="{$product.caption}"/></a></div>
                <div class="ym_con_text"><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></div>
            </div>
            <!--**1**-->
    {-/foreach}
        </div>  
        
        <!--****切换图片1****-->
{/foreach}
          
    </div>
    
    
    
</div>
<!--********************ym_container********************-->


<!--********************ym_container********************-->
<div class="ym_mian_list">
    <div class="ym_con_pic">
        <h1>outside Feature</h1>
        <p>There are so many reasons to choose outside, here are a few Features:</p>
        <div class="ym_con_box">
              <ul class="ym_mian_ul">
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Three Home Page Variation</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Creative and Modern Design</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Easy To Customize</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Faster drag and drop page builder</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>7+ Outside addons</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Three Home Page Variation</a></li>
                </ul>
                
        
              <ul class="ym_mian_ul">
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Three Home Page VariationEasy To CustomizeEasy To CustomizeEasy To Customize</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Creative and Modern Design</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Easy To Customize</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Faster drag and drop page builder</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>7+ Outside addons</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Three Home Page Variation</a></li>
                </ul>
                
                
              <ul class="ym_mian_ul">
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Three Home Page Variation</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Creative and Modern Design</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Easy To Customize</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Faster drag and drop page builder</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>7+ Outside addons</a></li>
                    <li><a href=""><i class="iconfont icon-xiangyoujiantou"></i>Three Home Page Variation</a></li>
                </ul>
        </div>
        
    </div>
</div>

<!--********************ym_container********************-->

<!--********************ym_bbs********************-->
<div class="ym_con_pic ym_bbs">

        <img src="/media/sets/msma/images/bbs.svg" alt="" width="110" height="110"/> 
        <h1>contact with us</h1>
        <p>Just contact us and we will get in tonch with you as soon as possible.</p>
        <a href="/contactnow.html" class="ym_bbs_a">contact now</a>
        
</div>
<!--********************ym_bbs********************-->


<!--********************ym_end_menu********************-->
<div class="ym_end_menu">
    <div class="ym_con_pic">
{foreach $groups_in_links_bar as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index==2&&$main_products|default:[]}{break}{/if}{if $group@index>=3}{break}{/if}
        <!--**dl1**-->
        <dl class="ym_end_menu_dl2">
            <dt>{$group.name}</dt>
    {-foreach $group.products as $product}
            <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {-/foreach}
        </dl>
        <!--**dl1**-->
{/foreach}
{if $main_products|default:[]}
        <!--**dl1**-->
        <dl class="ym_end_menu_dl2">
            <dt>{$preset_translations.top_products}</dt>
    {-foreach $main_products as $mp}
            <dd><a href="{$mp.url}">{$mp.label}</a></dd>
    {-/foreach}
        </dl>
        <!--**dl1**-->
{/if}

        <!--**dl1**-->
        <dl class="ym_end_menu_dl3">
            <dt>SIGN UP FOR OUR AWESOME NEWS</dt>
            <dd><input name="EMAIL" placeholder="Email Address" required="" type="email" class="input1"><input value="Subscribe" type="submit" class="input2"></dd>
            <dd class="ym_end_menu_dd"><a href=""><i class="iconfont icon-facebookicon"></i></a><a href=""><i class="iconfont icon-twitter"></i></a></dd>

        </dl>
        <!--**dl1**-->
      
    </div>

</div>
<!--********************ym_end_menu********************-->

{include file="sets/msma/common/copyright.tpl"}


<script src="/media/sets/msma/js/swiper.min.js"></script>
{include file="sets/msma/common/scripts.tpl"}
<script>
    $(function(){
        $('#ym_con_ul li').click(function(){
            $('#ym_con_ul li').removeClass('ym_con_li');
            $(this).addClass('ym_con_li');
            $('.ym_con_clear').hide();
            $('.ym_con_clear:eq('+$(this).index()+')').show();
        });
    });
</script>


<!--********************banner_js********************-->
<script>
    var mySwiper = new Swiper('#bannerSwiper',{
    loop: true,
    autoplay:5000,
    speed:1000,
    pagination: '#bannerpagination',
    paginationClickable: true,
    grabCursor : true,
    nextButton: '.arrow-right',
    prevButton: '.arrow-left',
    parallax:true,
  });  
</script>
<!--********************banner_js********************-->



</body>
</html>
