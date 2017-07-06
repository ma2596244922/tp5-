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
{include file="sets/brilly/common/logobar.tpl" page_name="product_list"}
<!-- Plub Header End -->
{include file="sets/brilly/common/navbar.tpl"}
<div class="Content Shop">
  <div class="Page">
    <div class="Route">
      <a href="/">{$preset_translations.home}</a>
      <span>&gt;</span>
{-if $group|default:[]}
      <a href="/products.html">{$preset_translations.products}</a>
      <span>&gt;</span>
      {$group.name}
{-elseif $phrase|default:''}
      <a href="/products.html">{$preset_translations.products}</a>
      <span>&gt;</span>
      {$phrase}
{-else}
      {$preset_translations.products}
{-/if}
    </div>
    <!-- Route End -->
    <div class="Main">
      <div class="Left">
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
{-if $group|default:[]}
          <h1 class="Til">{$group.name}</h1>
{-elseif $phrase|default:''}
          <h1 class="Til">{$phrase}</h1>
{-else}
          <h2 class="Til">{$preset_translations.all_products}</h2>
{-/if}
          <div class="clear">&nbsp;</div>
          <ul class="TextList">
            <li><a href="" title=""><strong>LED downlight</strong></a></li>
            <li><a href="" title=""><strong>LED downlight show</strong></a></li>
            <li><a href="" title=""><strong>LED bulbs</strong></a></li>
            <li><a href="" title=""><strong>LED light screen</strong></a></li>
            <li><a href="" title=""><strong>LED downlight</strong></a></li>
            <li><a href="" title=""><strong>LED T8 move</strong></a></li>
            <li><a href="" title=""><strong>LED PL Light</strong></a></li>
            <li><a href="" title=""><strong>LED light screen</strong></a></li>
          </ul>
        </div>
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">Related Products</h2>
          <ul class="PicTextList Type2">
            <li>
              <a href=""><img src="./images/pic1.jpg" alt="" title=""></a>
              <p><a href="" title="">Matt White / Black 24W LED Track Lights ...</a></p>
            </li>
            <li>
              <a href=""><img src="./images/pic2.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
            </li>
            <li>
              <a href=""><img src="./images/pic3.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
            </li>
            <li>
              <a href=""><img src="./images/pic4.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
            </li>
            <li>
              <a href=""><img src="./images/pic5.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
            </li>
          </ul>
        </div>
      </div>
      <div class="Right">
        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h1 class="Til">Surface Mounted LED Downlight</h1>
          <div class="clear">&nbsp;</div>
          <ul class="PicTextList Many">
            <li>
              <a href=""><img src="./images/pic1.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic2.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic3.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic4.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic5.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic6.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic7.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic8.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic9.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic10.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic9.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic10.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic1.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic2.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic3.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic4.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic5.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic6.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic7.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
            <li>
              <a href=""><img src="./images/pic8.jpg" alt="" title=""></a>
              <p><a href="" title="">Hot Sale Promotional Customized Logo Gift 2600</a></p>
              <a href="" class="btn" rel="nofollow">Contact Now</a>
            </li>
          </ul>
          <div class="Pager ConBox tc">
            <div class="lists">
              <a href="" class="disabled left"><i class="icon arrow_left"></i> Prev</a>
              <a href="" class="cur">1</a>
              <a href="">2</a>
              <a href="">3</a>
              <span>…</span>
              <a href="">5</a>
              <a href="">6</a>
              <a href="" class="right">Next <i class="icon arrow_right"></i></a>
            </div>
          </div>
        </div>
      </div>
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

{include file="sets/brilly/common/scripts.tpl"}

<script type="text/javascript">

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