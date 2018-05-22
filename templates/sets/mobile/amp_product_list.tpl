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
<script async custom-element="amp-sidebar" src="https://cdn.ampproject.org/v0/amp-sidebar-0.1.js"></script>

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
  background: url(/media/sets/mobile/search.png) no-repeat 0 0;
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
  background: url(/media/sets/mobile/back.png) no-repeat 0 0;
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
/*店铺首页样式*/
body {
  background: #fff;
  position: relative;
  width: 6.4rem;
  overflow-x: hidden;
}
.bh_81 {
  height: 0.81rem;
}
.logo-bar {
  padding: 0.4rem 0.2rem 0.4rem 2.3rem;
  position: relative;
  background: url(/media/sets/mobile/top_bj.jpg) no-repeat center 0;
  background-size: cover;
}
.logo-img {
  width: 2rem;
  height: 0.54rem;
  position: absolute;
  left: 0.2rem;
  top: 50%;
  margin-top: -0.27rem;
}
.logo-name {
  color: #fff;
  font-size: 0.28rem;
  line-height: 0.36rem;
  font-weight: normal;
}
.top-nav {
  height: 0.7rem;
  line-height: 0.7rem;
  border-top: 0.02rem solid #b9becb;
  text-align: center;
  font-size: 0.25rem;
}
.top-nav li {
  float: left;
  height: 0.7rem;
  width: 25%;
}
.top-nav li a {
  display: block;
  height: 0.7rem;
  color: #8b91aa;
}
.top-nav li.hover a {
  border-top: 0.04rem solid #576086;
  margin-top: -0.02rem;
  height: 0.68rem;
  color: #576086;
  font-weight: bold;
}
.shop-info {
  overflow: hidden;
  padding: 0 0.2rem 0.2rem 0.2rem;
}
.shop-info li {
  min-height: 0.28rem;
  padding-left: 0.28rem;
  position: relative;
  font-size: 0.22rem;
  color: #666666;
  padding-bottom: 0.12rem;
}
.shop-info li i {
  width: 0.22rem;
  height: 0.22rem;
  display: block;
  position: absolute;
  left: 0;
  top: 0.03rem;
}
.shop-info li .i1 {
  background: url(/media/sets/mobile/pic1.png) no-repeat;
  background-size: 100%;
}
.shop-info li .i2 {
  background: url(/media/sets/mobile/pic2.png) no-repeat;
  background-size: 100%;
}
.shop-info li .i3 {
  background: url(/media/sets/mobile/pic3.png) no-repeat;
  background-size: 100%;
}
.shop-info li .i4 {
  background: url(/media/sets/mobile/pic4.png) no-repeat;
  background-size: 100%;
}
.hot-products {
  background: #f9f9f9;
  border-top: 0.01rem solid #eee;
  border-bottom: 0.01rem solid #eee;
  padding-bottom: 0.2rem;
}
.title-t {
  height: 0.8rem;
  line-height: 0.8rem;
  padding: 0 0.2rem;
  font-size: 0.3rem;
  color: #333333;
  font-weight: normal;
}
.hot-ul {
  overflow: hidden;
}
.hot-ul li {
  width: 3.15rem;
  height: 3.95rem;
  float: left;
  background: #fff;
  margin: 0 0 0.1rem 0;
}
.hot-ul li img {
  width: 2.95rem;
  height: 2.95rem;
  margin: 0.1rem;
}
.hot-ul li .pro-title {
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
.hot-ul li .pro-title a {
  color: #333333;
}
.hot-ul li:nth-child(even) {
  float: right;
}
.pop-button {
  height: 0.8rem;
  border-top: 0.01rem solid #eee;
  background: #fff;
  text-align: center;
  line-height: 0.8rem;
  font-size: 0.28rem;
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: 999;
  width: 100%;
}
.pop-button a {
  display: block;
  height: 0.8rem;
  float: left;
  width: 50%;
}
.pop-button .all {
  color: #333333;
}
.pop-button .now {
  color: #fff;
  background: #d41313;
}
/*联系我们*/
.contact-info {
  overflow: hidden;
  border-top: 0.01rem solid #eee;
}
.contact-info li {
  border-bottom: 0.01rem solid #eee;
  position: relative;
  padding: 0.2rem 0.2rem 0.2rem 1.72rem;
  line-height: 0.35rem;
  font-size: 0.28rem;
  min-height: 0.25rem;
}
.contact-info li .img {
  width: 1rem;
  height: 1rem;
  border: 0.01rem solid #eee;
  display: block;
}
.contact-info li .t {
  position: absolute;
  left: 0.2rem;
  top: 0.2rem;
  color: #999999;
}
.contact-info li.photo .t {
  top: 0.525rem;
}
.contact-info li:nth-child(even) {
  background: #f9f9f9;
}
.about-info {
  overflow: hidden;
  border-top: 0.01rem solid #eee;
}
.about-info li {
  border-bottom: 0.01rem solid #eee;
  position: relative;
  padding: 0.2rem 0.2rem 0.2rem 2.5rem;
  line-height: 0.35rem;
  font-size: 0.28rem;
  min-height: 0.25rem;
  overflow: hidden;
}
.about-info li .img {
  width: 1rem;
  height: 1rem;
  border: 0.01rem solid #eee;
  display: block;
}
.about-info li .t {
  position: absolute;
  left: 0.2rem;
  top: 0.2rem;
  color: #999999;
}
.about-info li.photo .t {
  top: 0.525rem;
}
.about-info li:nth-child(odd) {
  background: #f9f9f9;
}
.about-info .text-txt {
  padding: 0.2rem;
}
.about-info li .see {
  padding-right: 0.25rem;
  position: relative;
  color: #8b91aa;
  float: right;
}
.about-info li .see i {
  width: 0.1rem;
  height: 0.19rem;
  display: block;
  background: url(/media/sets/mobile/dot3.png) no-repeat;
  background-size: 100%;
  position: absolute;
  right: 0;
  top: 50%;
  margin-top: -0.1rem;
}
.about-info li .tt {
  color: #000000;
}
.about-info li .txt {
  height: 1.05rem;
  overflow: hidden;
  margin-bottom: 0.05rem;
}
.about-info li .txt.auto {
  height: auto;
}
.about-info .text-txt .text-a {
  padding-right: 0.35rem;
  position: relative;
  color: #8b91aa;
  display: inline-block;
  height: 0.4rem;
  line-height: 0.4rem;
}
.about-info .text-txt .text-a i {
  width: 0.2rem;
  height: 0.11rem;
  position: absolute;
  right: 0;
  top: 50%;
  margin-top: -0.02rem;
  background: url(/media/sets/mobile/dot1.png) no-repeat;
  background-size: 100%;
}
.about-info .text-txt .text-a.x i {
  background: url(/media/sets/mobile/dot2.png) no-repeat;
  background-size: 100%;
}
.swiper-wrapper {
  width: 100%;
  height: 100%;
  position: relative;
  z-index: 1;
  display: -webkit-box;
  display: -moz-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
  -webkit-transition-property: -webkit-transform;
  -moz-transition-property: -moz-transform;
  -o-transition-property: -o-transform;
  -ms-transition-property: -ms-transform;
  transition-property: transform;
  -webkit-box-sizing: content-box;
  -moz-box-sizing: content-box;
  box-sizing: content-box;
}
.swiper-wrapper {
  -webkit-transform: translate3d(0px, 0, 0);
  -moz-transform: translate3d(0px, 0, 0);
  -o-transform: translate(0px, 0px);
  -ms-transform: translate3d(0px, 0, 0);
  transform: translate3d(0px, 0, 0);
}
.swiper-slide {
  width: 100%;
  height: 100%;
  -webkit-flex-shrink: 0;
  -ms-flex: 0 0 auto;
  flex-shrink: 0;
  position: relative;
}
.banner {
  padding: 0 1.95rem 0.2rem 1.95rem;
  height: 2.6rem;
  background: #f9f9f9;
  border-top: 0.01rem solid #eee;
  border-bottom: 0.01rem solid #eee;
  position: relative;
}
.banner .swiper-container .swiper-pagination {
  text-align: center;
  left: 0;
  bottom: 0.2rem;
  width: 100%;
  position: absolute;
  z-index: 111;
}
.banner .swiper-container .swiper-pagination .swiper-pagination-bullet {
  width: 0.1rem;
  height: 0.1rem;
  display: inline-block;
  border-radius: 100%;
  background: #ddd;
  opacity: 1;
  margin-left: 0.07rem;
}
.banner .swiper-container .swiper-pagination .swiper-pagination-bullet.swiper-pagination-bullet-active {
  background: #576086;
}
.swiper-container {
  width: 100%;
  height: 100%;
  overflow: hidden;
}
.swiper-container .swiper-wrapper .swiper-slide {
  text-align: left;
  font-size: 0.12rem;
  background: #f9f9f9;
  display: -webkit-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  -webkit-justify-content: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  -webkit-align-items: center;
  align-items: center;
}
.title {
  width: 6rem;
  height: 0.8rem;
  border-top: 1px solid #eeeeee;
  border-bottom: 1px solid #eeeeee;
  padding: 0 0.2rem;
  background: #f9f9f9;
}
.title em {
  color: #333333;
  line-height: 0.8rem;
}
.title em h1 {
  font-size: 0.3rem;
  font-weight: normal;
  display: inline;
}


 .ampstart-btn{ width: 0.34rem; height: 0.29rem; border: none; display: block; background: url(/media/sets/mobile/classify.png) left top no-repeat; background-size: 100%; float: right; margin: 0.25rem 0 0 0; cursor: pointer; }
.classify-detail {
  width: 100%;
  height: 2rem;
  background: #fff;
  border-bottom: 1px solid #eeeeee;
}
.classify-detail .detail-img { margin: 0.2rem 0 0.2rem 0.2rem; width: 1.6rem; height: 1.6rem; display: block; float: left; }

.classify-detail img {
  margin: 0.2rem 0 0.2rem 0.2rem;
  width: 1.6rem;
  height: 1.6rem;
  float: left;
}
.classify-detail dl {
  float: left;
  margin: 0.3rem 0.2rem 0 0.1rem;
  width: 4.29rem;
}
.classify-detail dl dt {
  font-size: 0.28rem;
  line-height: 0.32rem;
  margin: 0 0 0.1rem 0;
  height: 0.64rem;
  display: block;
  word-wrap: break-word;
  text-overflow: -o-ellipsis-lastline;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.classify-detail dl dt a {
  color: #333333;
}
.classify-detail dl dt a i {
  font-weight: bold;
}
.classify-detail dl dd {
  font-size: 0.22rem;
  color: #333333;
  line-height: 0.28rem;
}
.classify-detail dl dd label {
  color: #999999;
}
.click-more {
  width: 100%;
  height: 0.72rem;
  background: #fff;
}
.click-more p {
  text-align: center;
  line-height: 0.72rem;
  color: #666666;
  cursor: pointer;
}
.click-more p i {
  width: 0.22rem;
  height: 0.12rem;
  display: inline-block;
  margin: 0 0 0 0.19rem;
  background: url(/media/sets/mobile/slide.png) left top no-repeat;
  background-size: 100%;
  cursor: pointer;
}
.categories {
  position: absolute;
  left: 6.4rem;
  top: 0;
  background: #f9f9f9;
  z-index: 1100;
  opacity: 0;
  width: 0;
  display: none;
}
.categories.show {
  animation: move 0.3s;
  -moz-animation: move 0.3s;
  -webkit-animation: move 0.3s;
  -o-animation: move 0.3s;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  -moz-animation-fill-mode: forwards;
  display: block;
}
.categories.show1 {
  animation: move1 0.3s;
  -moz-animation: move1 0.3s;
  -webkit-animation: move1 0.3s;
  -o-animation: move1 0.3s;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  -moz-animation-fill-mode: forwards;
  display: none;
}
.categories dl > dt {
  height: 0.8rem;
  padding: 0 0 0 0.2rem;
  line-height: 0.8rem;
  font-size: 0.3rem;
  color: #333;
  background: #fff;
  border-bottom: 1px solid #eeeeee;
}
.categories dl > dt span.close {
  width: 0.8rem;
  height: 0.8rem;
  display: block;
  float: right;
  cursor: pointer;
}
.categories dl > dt span.close i {
  width: 0.4rem;
  height: 0.4rem;
  display: block;
  background: url(/media/sets/mobile/close.jpg) left top no-repeat;
  background-size: 100%;
  float: right;
  margin: 0.2rem 0.2rem 0 0;
}
.categories dl > dd {
  height: 0.7rem;
  line-height: 0.7rem;
  font-size: 0.28rem;
  border-bottom: 1px solid #eeeeee;
}
.categories dl > dd a {
  color: #333;
  width: 5rem;
  height: 0.7rem;
  padding: 0 0 0 0.2rem;
  overflow: hidden;
  display: block;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.categories dl > dd a.current {
  color: #d41313;
}
.categories dl > dd a.current:after {
  width: 0.35rem;
  height: 0.22rem;
  display: block;
  content: "";
  background: url(/media/sets/mobile/select.png) left top no-repeat;
  background-size: 100%;
  float: right;
  margin: 0.25rem 0.2rem 0 0;
}
@keyframes move {
  from {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
  to {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
}
@-moz-keyframes move {
  from {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
  to {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
}
@-webkit-keyframes move {
  from {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
  to {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
}
@-o-keyframes move {
  from {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
  to {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
}
@keyframes move1 {
  from {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
  to {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
}
@-moz-keyframes move1 {
  from {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
  to {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
}
@-webkit-keyframes move1 {
  from {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
  to {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
}
@-o-keyframes move1 {
  from {
    left: 1rem;
    opacity: 1;
    width: 5.4rem;
    display: block;
  }
  to {
    left: 6.4rem;
    opacity: 0;
    width: 0;
    display: none;
  }
}
#opacity-layer {
  width: 100%;
  height: 100%;
  background: #000;
  opacity: 0.8;
  display: none;
  position: fixed;
  left: 0;
  top: 0;
  z-index: 1002;
}
.spinner {
  margin: 0 auto;
  width: 1.5rem;
  height: 0.72rem;
  text-align: center;
  display: none;
}
.spinner div {
  width: 0.12rem;
  height: 0.12rem;
  display: inline-block;
  margin: 0.33rem 0 0 0;
  background-color: #bbbbbb;
  border-radius: 100%;
  -webkit-animation: bouncedelay 1.4s infinite ease-in-out;
  animation: bouncedelay 1.4s infinite ease-in-out;
  /* Prevent first frame from flickering when animation starts */
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
}
.spinner div.bounce1 {
  -webkit-animation-delay: -0.32s;
  animation-delay: -0.32s;
}
.spinner div.bounce2 {
  -webkit-animation-delay: -0.16s;
  animation-delay: -0.16s;
}
@-webkit-keyframes bouncedelay {
  0%,
  80%,
  100% {
    -webkit-transform: scale(0);
    background-color: #dddddd;
  }
  40% {
    -webkit-transform: scale(1);
    background-color: #bbbbbb;
  }
}
@keyframes bouncedelay {
  0%,
  80%,
  100% {
    transform: scale(0);
    -webkit-transform: scale(0);
    background-color: #dddddd;
  }
  40% {
    transform: scale(1);
    -webkit-transform: scale(1);
    background-color: #bbbbbb;
  }
}

amp-sidebar {background: #f9f9f9;width: 5rem;}
        amp-sidebar li:first-child { height: 0.8rem; line-height: 0.8rem; font-size: 0.3rem; color: #333; background: #fff; border-bottom: 1px solid #eeeeee; }
        amp-sidebar amp-img.amp-close-image{cursor: pointer;position: absolute;right: 0.2rem;top: 0.24rem; }
        amp-sidebar li:first-child span.close i { width: 0.4rem; height: 0.4rem; display: block; background: url(/media/sets/mobile/close.jpg) left top no-repeat; background-size: 100%; float: right; margin: 0.2rem 0.2rem 0 0; }
        amp-sidebar li { height: 0.7rem; line-height: 0.7rem; font-size: 0.28rem; border-bottom: 1px solid #eeeeee; }
        amp-sidebar li a { color: #333; width: 5rem; height: 0.7rem; padding: 0 0 0 0.2rem; overflow: hidden; display: block; white-space: nowrap; text-overflow: ellipsis; }
        amp-sidebar li a.current { color: #d41313; }
        amp-sidebar li a.current:after { width: 0.35rem; height: 0.22rem; display: block; content: ""; background: url(/media/sets/mobile/select.png) left top no-repeat; background-size: 100%; float: right; margin: 0.25rem 0.2rem 0 0; }

.amp_page {text-align: right; height: 0.72rem; line-height: 0.72rem;}
</style>
{/literal} 
{$amp_style}
    </head>
<body>
<div class="content">
 <div class="logo-bar">
    <a href="/">
        
        <amp-img src="{$corporation.logo|url:'enterprise_url_image'}" class="logo-img" width="117" height="31" ></amp-img>
    </a>
    <h1 class="logo-name">{$corporation.name}</h1>
</div>
{include file="sets/mobile/common/navbar.tpl" page_name="product_list"}
    <div class="title">
        <em><h1>{if $group|default:[]}{$group.name}{else}{$preset_translations.all_products}{/if}</h1></em>
        <!--<span class="ampstart-btn caps m2" on="tap:sidebar.toggle"></span>-->
        <button on="tap:sidebar.toggle" class="ampstart-btn caps m2"></button>

    </div>
    <section class="pro-list">
{foreach $products as $product}
        <div class="classify-detail">
             <a href="{$product|url:'enterprise_url_product'}" class="detail-img"  title="{$product.caption|escape}">

             <amp-img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'d'}" layout="responsive"  alt="{$product.caption|escape}" width="94" height="94" ></amp-img>
            </a>
            <dl>
                <dt><a href="{$product|url:'enterprise_url_product'}" title="{$product.caption|escape}">{$product.caption}</a></dt>
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=2}{break}{/if}
        {-if $product.$k|default:$meta.default}
                <dd><label>{$preset_translations.$k} : </label>{$product.$k|default:$meta.default}</dd>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
            </dl>
        </div>
        <!--classify-detail-->
{/foreach}
    </section>
</div>
{if $total_products > $page_size}
<div class="amp_page">
    {if $page_no > 1}
    <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}">Prev</a>
    {/if}
    {if $page_no < $total_pages}
    <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}">Next</a>
    {/if}
</div>
{/if}
<!--content-->
{include file="sets/mobile/common/floatingbar.tpl"}
<div class="categories">
    <dl>
        <dt>{$preset_translations.product_categories}</dt>
{foreach $groups as $g}
        <dd><a href="{$g|url:'enterprise_url_product_list'}"{if $g.id==$group.id|default:'0'} class="current"{/if} title="{$g.name}">{$g.name}</a></dd>
{/foreach}
    </dl>
</div>
<!--categories-->
<div id="opacity-layer"></div>


<amp-sidebar id="sidebar"
  layout="nodisplay"
  side="right">
  <amp-img class="amp-close-image"
    src="/media/sets/mobile/close.jpg"
    width="20"
    height="20"
    alt="close sidebar"
    on="tap:sidebar.close"
    role="button"
    tabindex="0"></amp-img>



  <ul>
    <li><a href="/">{$preset_translations.product_categories}</a></li>
    {foreach $groups as $g}
        <li><a href="{$g|url:'enterprise_url_product_list'}"{if $g.id==$group.id|default:'0'} class="current"{/if} title="{$g.name}">{$g.name}</a></li>
   {/foreach}
   
  </ul>

</amp-sidebar>
</body>
</html>