<!DOCTYPE html>
<html lang="{$lang_code}"{$html_attr_dir} amp>
    <head>
        {$site.common_head_fragment}
        <meta charset="utf-8" />
        <title>{$title}</title>
        <meta name="keywords" content="{$keywords|escape}">
        <meta name="description" content="{$description|escape}">
        <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <link rel="canonical" href="{$smarty.server.REQUEST_SCHEME}://{$canonical_host}{$smarty.server.REQUEST_URI}">

{-if in_array($page_name|default:'', ['home', 'product_list', 'aboutus', 'news_list', 'contactus', 'keyword_list', 'product_directory'])}
    {-if $lang_code!=$default_lang_code}
        <link rel="alternate" href="http://{$default_lang_code|call:'enterprise_build_alternate_mobile_host':$site_root_domain}{$smarty.server.REQUEST_URI}" hreflang="{$default_lang_code}" />
    {-/if}
    {-foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}{if $lc==$lang_code}{continue}{/if}
        <link rel="alternate" href="http://{$lc|call:'enterprise_build_alternate_mobile_host':$site_root_domain}{$smarty.server.REQUEST_URI}" hreflang="{$lc}" />
    {-/foreach}
{-/if}
{-if $hide_site.enabled}
        <script type="text/javascript" src="/hide.php"></script>
{-/if}
{literal} 
<script async src="https://cdn.ampproject.org/v0.js"></script>
<script async custom-element="amp-carousel" src="https://cdn.ampproject.org/v0/amp-carousel-0.1.js"></script>
<style amp-custom>
body,
h1,
h2,
h3,
h4,
h5,
h6,
hr,
p,
blockquote,
dl,
dt,
dd,
ul,
ol,
li,
pre,
fieldset,
lengend,
button,
input,
textarea,
form,
th,
td {
  margin: 0;
  padding: 0;
}
body {
  background: #f9f9f9;
  font-size: 0.26rem;
  font-family: 'Tahoma';
  min-width: 320px;
  max-width: 640px;
  margin: 0 auto;
}
address,
cite,
dfn,
em,
var {
  font-style: normal;
}
strong,
b {
  font-weight: normal;
}
ul,
ol {
  list-style: none;
}
a {
  text-decoration: none;
}
.fl-clr {
  zoom: 1;
}
.fl-clr:after {
  display: block;
  content: '';
  clear: both;
  visibility: hidden;
}
i {
  font-style: normal;
}
/*ios form style*/
::-webkit-input-placeholder {
  color: #999;
}
input[type="text"],
input[type="password"] {
  -webkit-appearance: none;
  appearance: none;
  outline: none;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
  border-radius: 0;
}
/*placeholder style*/
::-webkit-input-placeholder {
  /* WebKit browsers */
  color: #ccc;
}
:-moz-placeholder {
  /* Mozilla Firefox 4 to 18 */
  color: #ccc;
}
::-moz-placeholder {
  /* Mozilla Firefox 19+ */
  color: #ccc;
}
:-ms-input-placeholder {
  /* Internet Explorer 10+ */
  color: #ccc;
}
/* 初始化font-size*/
@media screen and (min-width: 640px) {
  html {
    font-size: 100px;
  }
}
@media screen and (min-width: 601px) and (max-width: 639px) {
  html {
    font-size: 93.9063px;
  }
}
@media screen and (min-width: 551px) and (max-width: 600px) {
  html {
    font-size: 86.0938px;
  }
}
@media screen and (min-width: 501px) and (max-width: 550px) {
  html {
    font-size: 78.2813px;
  }
}
@media screen and (min-width: 451px) and (max-width: 500px) {
  html {
    font-size: 70.4688px;
  }
}
@media screen and (min-width: 414px) and (max-width: 450px) {
  html {
    font-size: 64.6875px;
  }
}
@media screen and (min-width: 375px) and (max-width: 413px) {
  html {
    font-size: 58.5938px;
  }
}
@media screen and (min-width: 360px) and (max-width: 374px) {
  html {
    font-size: 56.25px;
  }
}
@media screen and (min-width: 320px) and (max-width: 359px) {
  html {
    font-size: 50px;
  }
}
/*header style*/
header {
  width: 100%;
  height: 0.8rem;
  background: #d41313;
}
header .logo {
  margin: 0.2rem 0 0 0.2rem;
  float: left;
}
header .logo h1 {
  font-size: inherit;
}
header .logo h1 img {
  width: 1.78rem;
  height: 0.4rem;
}
header .logo a img {
  width: 1.78rem;
  height: 0.4rem;
}
header .search {
  float: right;
  margin: 0.13rem 0.2rem 0 0;
  position: relative;
}
header .search .txt {
  width: 3.13rem;
  height: 0.54rem;
  border: none;
  border-radius: 0.03rem;
  font-size: 0.24rem;
  padding: 0 0.7rem 0 0.19rem;
  color: #666666;
}
header .search .search-btn {
  width: 0.7rem;
  height: 0.54rem;
  display: block;
  background: #fff;
  position: absolute;
  right: 0;
  top: 0;
  border-radius: 0 3px 3px 0;
}
header .search .search-btn span {
  width: 0.27rem;
  height: 0.26rem;
  display: block;
  background: url(search.png) no-repeat 0 0;
  background-size: 100%;
  margin: 0.14rem 0 0 0.2rem;
}
header.title-header {
  position: relative;
  text-align: center;
  line-height: 0.8rem;
}
header.title-header .back {
  width: 0.18rem;
  height: 0.34rem;
  display: block;
  background: url(back.png) no-repeat 0 0;
  background-size: 100%;
  position: absolute;
  left: 0.2rem;
  top: 0.22rem;
}
header.title-header span {
  font-size: 0.3rem;
  color: #fff;
}
footer {
  border-top: 1px solid #eeeeee;
  background: #fff;
  padding: 0.22rem 0 0.2rem;
}
footer p {
  text-align: center;
  line-height: 0.36rem;
  font-size: 0.2rem;
  color: #999999;
}
footer p a {
  color: #666666;
  margin: 0 0.26rem;
  font-size: 0.26rem;
}
footer p.links {
  color: #ddd;
}
body {
  background: #f9f9f9;
}
  .banner { width: 4rem; margin:0 auto;padding:0.2rem 0;}
.product-title {
  width: 6rem;
  height: 1.13rem;
  padding: 0 0.2rem;
  background: #fff;
  border-bottom: 1px solid #eeeeee;
}
.product-title span {
  width: 6rem;
  height: 0.8rem;
  display: block;
  word-wrap: break-word;
  text-overflow: -o-ellipsis-lastline;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  line-height: 0.4rem;
  color: #333333;
  font-size: 0.3rem;
  padding: 0.14rem 0 0 0;
}
.product-title span h1 {
  font-size: 0.3rem;
  font-weight: normal;
}
.product-detail {
  margin: 0.1rem 0 0 0;
  border-top: 1px solid #eeeeee;
  border-bottom: 1px solid #eeeeee;
  background: #fff;
}
.product-detail.product-detail1 {
  margin: 0;
  border-bottom: none;
}
.product-detail.product-detail1 .product-title {
  padding: 0.105rem 0.2rem 0 0.2rem;
}
.product-detail .title {
  border-top: none;
}
.product-detail table tr td {
  border-bottom: 1px solid #eeeeee;
  font-size: 0.22rem;
  color: #333333;
}
.product-detail table tr td:first-child {
  padding: 0.2rem 0 0.2rem 0.2rem;
  color: #999999;
  width: 2.12rem;
}
.product-detail table tr td:last-child {
  padding: 0.2rem 0.2rem 0.2rem 0;
  width: 3.89rem;
}
.product-detail table tr td em {
  color: #d41313;
}
.product-detail table.table1 tr td {
  height: 0.59rem;
  line-height: 0.59rem;
}
.product-detail table.table1 tr td:first-child {
  padding: 0 0 0 0.2rem;
}
.product-detail table.table1 tr td:last-child {
  padding: 0 0.2rem 0 0;
  width: 3.89rem;
  height: 0.59rem;
  overflow: hidden;
  display: block;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.product-detail section {
  padding: 0.2rem;
}
.product-detail section a.show-more {
  width: 5.98rem;
  height: 0.58rem;
  display: block;
  border: solid 1px #d41313;
  border-radius: 3px;
  color: #d41313;
  text-align: center;
  line-height: 0.58rem;
  font-size: 0.26rem;
}
.title {
  width: 100%;
  height: 0.8rem;
  background: #fff;
  border-top: 1px solid #eeeeee;
  border-bottom: 1px solid #eeeeee;
}
.title h2 {
  font-size: 0.3rem;
  color: #333333;
  line-height: 0.8rem;
  padding: 0 0 0 0.2rem;
  font-weight: normal;
}
.company-name {
  width: 100%;
  height: 0.69rem;
  background: #fff;
  border-bottom: 1px solid #eeeeee;
}
.company-name a {
  width: 6rem;
  height: 0.69rem;
  font-size: 0.28rem;
  color: #576086;
  line-height: 0.69rem;
  padding: 0 0.2rem;
  font-weight: normal;
  overflow: hidden;
  display: block;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.recom-products {
  margin: 0.1rem 0 0 0;
}
.recom-products ul {
  margin: 0.1rem 0 0 0;
}
.recom-products ul li {
  float: left;
  width: 3.15rem;
  height: 3.95rem;
  background: #fff;
  margin: 0 0 0.1rem 0;
}
.recom-products ul li:nth-child(even) {
  float: right;
}
.recom-products ul li img {
  width: 2.95rem;
  height: 2.95rem;
  margin: 0.1rem;
}
.recom-products ul li span.pro-title {
  width: 2.95rem;
  height: 0.6rem;
  display: block;
  word-wrap: break-word;
  text-overflow: -o-ellipsis-lastline;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  line-height: 0.3rem;
  font-size: 0.26rem;
  margin: 0 auto;
}
.recom-products ul li span.pro-title a {
  color: #333333;
}
.popular-searches {
  margin: 0.1rem 0 0 0;
  background: #fff;
  padding: 0 0 0.2rem 0;
}
.popular-searches .search-box {
  padding: 0.2rem 0 0 0.2rem;
  border-bottom: 1px solid #eeeeee;
  background: #f9f9f9;
}
.popular-searches .search-box a {
  padding: 0.11rem 0.15rem;
  background: #fff;
  border-radius: 3px;
  border: 1px solid #eeeeee;
  float: left;
  margin: 0 0.2rem 0.2rem 0;
  color: #333333;
}
.product-features {
  margin: 0.1rem 0 0 0;
  background: #fff;
  padding: 0 0 0.2rem 0;
}
.product-features article {
  padding: 0.15rem 0.2rem 0.1rem 0.2rem;
  background: #fff;
  border-bottom: 1px solid #eeeeee;
}
.product-features article p {
  font-size: 0.28rem;
  line-height: 0.46rem;
  color: #333333;
}
.product-features article img {
  width: 100%;
}
.bh_81 {
  height: 0.81rem;
}
.bh_81 .pop-button {
  width: 100%;
  height: 0.8rem;
  border-top: 1px solid #eeeeee;
  background: #fff;
  font-size: 0.28rem;
  text-align: center;
  line-height: 0.8rem;
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: 999;
}
.bh_81 .pop-button a {
  color: #333333;
  width: 50%;
  height: 0.8rem;
  display: block;
  float: left;
}
.bh_81 .pop-button a.now {
  color: #fff;
  background: #d41313;
}



</style>

{/literal} 

{$amp_style}
        
    </head>
<body>
<div class="content">
   <div class="banner">
      
          <amp-carousel type="slides" width="300" height="300"
            controls
            loop
            autoplay
            delay="3000"
            data-next-button-aria-label="Go to next slide"
            data-previous-button-aria-label="Go to previous slide" layout="responsive">
            {-if $product_images}
    {-foreach $product_images as $image_id}
              <amp-img src="{$image_id|url:'enterprise_url_image':$product.caption:'c'}" layout="responsive" alt="{$product.caption|default:''|escape}" width="300"  height="300" ></amp-img>
                    {-/foreach}
{-else}
                 <amp-img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" layout="responsive" alt="{$product.caption|default:''|escape}" width="300"  height="300" ></amp-img>
            {-/if}
            </amp-carousel>



        <!--swiper-container-->
   </div>
   <!--banner-->
   <div class="product-title">
       <span><h1 title="">{$product.caption}</h1></span>
   </div>
   <!--product-title-->
   <div class="product-detail">
       <table cellpadding="0" cellspacing="0" class="table1">
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=5}{break}{/if}
        {-if $product.$k|default:$meta.default}
           <tr>
               <td>{$preset_translations.$k}</td>
               <td>{if $meta.default}<em>{/if}{$product.$k|default:$meta.default}{if $meta.default}</em>{/if}</td>
           </tr>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
       </table>
       <section><a href="{$product|url:'enterprise_url_detailed_product'}" class="show-more">{$preset_translations.view_more}</a></section>
   </div>
   <!--product-detail-->
   <div class="product-detail">
       <div class="title"><h2>{$preset_translations.company_profile}</h2></div>
       <div class="company-name"><a href="/aboutus.html">{$corporation.name}</a></div>
       <table cellpadding="0" cellspacing="0">
{-if $corporation.worktime|default:''}
           <tr>
               <td valign="top">{$preset_translations.worktime}</td>
               <td>{$corporation.worktime}</td>
           </tr>
{-/if}
{-if $corporation.tel_wt|default:''}
           <tr>
               <td valign="top">{$preset_translations.business_phone}</td>
               <td>{$corporation.tel_wt}</td>
           </tr>
{-/if}
{-if $corporation.fax|default:''}
           <tr>
               <td valign="top">{$preset_translations.fax}</td>
               <td>{$corporation.fax}</td>
           </tr>
{-/if}
       </table>
       <section><a href="/aboutus.html" class="show-more">{$preset_translations.view_more}</a></section>
   </div>
   <!--product-detail-->
   <section class="recom-products">
        <div class="title"><h2>{$preset_translations.recommended_products}</h2></div>
        <ul class="fl-clr">
{foreach $new_products as $product}{if $product@index>=6}{break}{/if}
            <li>
              <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">
                
                 <amp-img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="{$product.caption|escape}" width="173" layout="responsive"  height="173" ></amp-img>
              </a>
              <span class="pro-title">
              <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}"><strong>{$product.caption}</strong></a></span></li>
{/foreach}
        </ul>
    </section>
    <!--recom-products-->
{include file="sets/mobile/common/main_products.tpl"}
</div>
<!--content-->
{include file="sets/mobile/common/floatingbar.tpl"}


</body>
</html>