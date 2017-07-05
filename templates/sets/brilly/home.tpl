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
      <h2 class="Til">Recommended Products</h2>
      <div class="clear"></div>
      <ul class="PicTextList Many">
        <li>
          <a href=""><img src="/media/sets/brilly/pic1.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic2.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic3.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic4.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic5.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic6.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic7.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic8.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic9.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
        <li>
          <a href=""><img src="/media/sets/brilly/pic10.jpg" alt="" title=""></a>
          <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
        </li>
      </ul>
    </div>
    <div class="CompanyProfile">
      <div class="ConBox Left">
        <div class="clear">&nbsp;</div>
        <h2 class="Til">Company Profile</h2>
        <div class="clear"></div>
        <img src="/media/sets/brilly/pic7.jpg" class="fl"  alt="" title="">
        <div class="info">
          <h1>Top Biology Pharmacy Co.,LtdGuangZhou[China]</h1>
          <table>
            <tr>
              <th>Location</th>
              <td>Guangdong, China (Mainland) </td>
            </tr>
            <tr>
              <th>Total Employees</th>
              <td>301 - 500 People</td>
            </tr>
            <tr>
              <th>Total Annual Revenue</th>
              <td>US$5 Million - US$10 Million</td>
            </tr>
            <tr>
              <th>Membership</th>
              <td>North America, South America, Eastern Europe, South-eastPP Bag out Side Standard Exporting Package</td>
            </tr>
          </table>
        </div>
      </div>
      <div class="Right">
        <img src="/media/sets/brilly/pic8.jpg"  alt="" title="">
        <table>
          <tr>
            <th>Contact </th>
            <td>Jim Green</td>
          </tr>
          <tr>
            <th>Phone</th>
            <td>+8601232333</td>
          </tr>
          <tr>
            <th>Cell Phone</th>
            <td>1880110099</td>
          </tr>
        </table>
        <a href="" class="btn" rel="nofollow">Send Inquiry</a>
      </div>
    </div>
    <!-- Post Sourcing Request Start -->
    <div class="ConBox Request">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">Post Sourcing Request</h2>
      <div class="clear"></div>
      <div class="noPic">
        <table>
          <tr>
            <th><span>*</span>Email</th>
            <td>
              <div class="typeIn">
                <p class="msg">Please Enter your Email Address</p>
                <input type="text" id="request_email" autocomplete="off">
              </div>
            </td>
          </tr>
          <tr>
            <th>Subject</th>
            <td>
              <div class="typeIn">
                <p class="msg"> I would like to know more about your product [ CE Certification and Refrigerant Type refrigerant rec</p>
                <input type="text" id="Subject" autocomplete="off">
              </div>
            </td>
          </tr>
          <tr>
            <th>Quick question</th>
            <td>
              <dl class="quickSelect" id="quickSelect">
                <dt>Quick questions<i class="icon arrow_down2"></i></dt>
                <dd>
                  <p>I would like to know more about the product and prices.</p>
                  <p>Can you please send me the updated price and moq?</p>
                  <p>I would like to purchase this item.Please contact me.</p>
                  <p>Please quote me your price and order payment terms and delivery time.</p>
                  <i class="icon arrow_down2"></i>
                </dd>
              </dl>
            </td>
          </tr>
          <tr>
            <th><span>*</span>Content</th>
            <td>
              <div class="typeIn typeIn2">
                <div class="msg">
                  <p>For the best results, we recommend including the following details:</p>
                  <p>-Self introduction</p>
                  <p>-Required specifications</p>
                  <p>-Inquire about price/MOQ</p>
                </div>
                <textarea id="request_con" maxlength="500" autocomplete="off"></textarea>
              </div>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><button>Send Now</button></td>
          </tr>
        </table>
      </div>
      <div class="clear"></div>
    </div>
    <!-- Post Sourcing Request End -->
    <div class="ConBox">
      <dl class="links">
        <dt>Friendly Link:</dt>
        <dd>
          <a href="" target="_blank">China.cn</a>
          <span>|</span>
          <a href="" target="_blank">China Suppliers</a>
          <span>|</span>
          <a href="" target="_blank">51cto.com</a>
        </dd>
      </dl>
    </div>
  </div>
</div>

<div class="ServiceBox">
  <div class="Page">
    <dl>
      <dt>Buy on china.cn</dt>
      <dd><a href="">How to buy</a></dd>
      <dd><a href="">Browse by catagories</a></dd>
      <dd><a href="">Browse by Hot regoins</a></dd>
      <dd><a href="">Private Sourcing Events</a></dd>
    </dl>
    <dl>
      <dt>Belling on china.cn</dt>
      <dd><a href="">How to sell</a></dd>
      <dd><a href="">Premium Member</a></dd>
      <dd><a href="">Post Products</a></dd>
      <dd><a href="">Manage Products</a></dd>
    </dl>
    <dl>
      <dt>Services</dt>
      <dd><a href="">Post buying lead</a></dd>
      <dd><a href="">Product Alert</a></dd>
    </dl>
    <dl>
      <dt>About</dt>
      <dd><a href="">Dispute and Complaint Assistance</a></dd>
      <dd><a href="">About us</a></dd>
      <dd><a href="">Link to us</a></dd>
      <dd><a href="">Contact us</a></dd>
    </dl>
  </div>
</div>
<div class="Footer">
  <div class="Page">
    <p class="fl">
      <a href="">About Us</a>
      <span>|</span>
      <a href="">Contact Us</a>
      <span>|</span>
      <a href="">Intellectual Property Policy</a>
      <span>|</span>
      <a href="">Privacy Policy</a>
      <span>|</span>
      <a href="">Terms of Use</a>
      <span>|</span>
      <a href="">Advertise</a>
      <span>|</span>
      <a href="">Partners</a>
    </p>
    <p class="fr">Copyright &copy; China Internet Information Center. All Rights Reserved</p>
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