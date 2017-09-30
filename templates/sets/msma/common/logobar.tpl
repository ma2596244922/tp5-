<!--********************header********************-->
<div class="ym_header">
  <div class="ym_nav">
        <div class="ym_nav_logo"><a href="/" z-st="ym_nav_logo"><img src="{$corporation.logo|url:'enterprise_url_image'}" width="180" height="62" alt="{$corporation.name|escape}"/></a></div>
        <ul class="ym_nav_menus">
            <li class="ym_nav_menus_ul"><a href="/" >{$preset_translations.home}</a></li>
            <li><a href="/products.html" >{$preset_translations.products}</a></li>
            <li><a href="/aboutus.html" >{$preset_translations.company_profile}</a></li>
            <li><a href="/contactus.html" >{$preset_translations.contact_us}</a></li>
            <li><a href="/contactnow.html" >{$preset_translations.request_a_quote}</a></li>
        </ul>
        
       <div class="ym_nav_right">
           <a onclick="search_yy()" class="ym_nav_right_a"><i class="iconfont icon-fangdajing"></i></a>
           <!--**弹出框**-->
           <div id="divsearch" style="height:44px;width:300px; display:none; z-index:1000; position:absolute; background:#fff;-moz-box-shadow: 0px 2px 2px #dfdfdf;-webkit-box-shadow: 0px 2px 2px #dfdfdf;box-shadow: 0px 2px 2px #dfdfdf; margin-top:41px; margin-left:-126px; ">
           <input  onfocus="if(this.value=='Please enter the content')this.value=''" onblur="if(this.value=='')this.value='Please enter the content'" value="Please enter the content" class="ym_nav_right_input1" >
           <input  onclick="document.getElementById(&quot;search&quot;).submit()" type="button" class="ym_nav_right_input2" value="Search">
           </div>
           <!--**弹出框**-->
           
       </div>
            
  </div>
</div>
<!--********************header********************-->