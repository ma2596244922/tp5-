<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" rel="stylesheet" href="style/style.css" media="all" />
    <link type="text/css" rel="stylesheet" href="style/index.css" media="all" />
    <script>{literal}
        function open_img(a,event){
            var div=a.parentNode;
            function get_pos(div){
                var pos={'left':0,'top':0}
                while(1){
                    if(!div){
                        break;
                    }
                    pos['left']+=div.offsetLeft;
                    pos['top']+=div.offsetTop;
                    div=div.offsetParent;

                }
                return pos;
            }
            var pos=get_pos(div);

            var img=a.firstChild;
            var show=document.getElementById("p_l");
             if(a.className=='col'){
            a.className='ope'
                    show.style.width=121+'px';
                    show.style.height='auto';
                    show.style.visibility='visible';
                    show.style.left=pos['left']+"px";
                    show.style.top=pos['top']+17+"px";


                }else{
                    a.className='col'
                    show.style.visibility='hidden';
                }
        }{/literal}
    </script>
    </head>
    <body>
<div class="header">
      <div class="h_head">
    <div class="logo"><a href="#"><img src="images/logo_1.gif"></a></div>
    <table cellspacing="0" cellpadding="0" border="0" style="width: 400px;" class="slogans">
          <tbody>
        <tr align="left;" valign="middle">
              <td height="80"><b>Best  Car Wash Machine In China</b><br>
            Beijing Autobase Wash Systems CO.,LTD.</td>
            </tr>
      </tbody>
        </table>
    <div class="lge"><b>Sales & support(480) 505-8877</b><br />
          <b>Requst a Quote - Email</b><br />
          <div class="sel"><span>Select Language</span><a href="#" class="col" onclick="open_img(this,event)"></a></div>
        </div>
  </div>
      <dl class="h_menu textf">
    <dd class="bl fleft"></dd>
    <dt><a href="#">Home</a></dt>
    <dt><a href="#" >Products</a></dt>
    <dt><a href="#">About Us</a></dt>
    <dt><a href="#">Factory tour</a></dt>
    <dt><a href="#">Quality Control</a></dt>
    <dt><a href="#">Contact Us</a></dt>
    <dt><a href="#">Request a Quote</a></dt>
    <dd class="br fright"></dd>
  </dl>
    </div>
<dl id="p_l" class="text8" style="width: 121px;">
{section name=i loop=$translations}
  <dt class="{$translations[i].abbr}"><a href="{$translations[i].url}">{$translations[i].text}</a></dt>
{/section}
</dl>
<div class="guide text8"><a href="#">Home</a>
      <h1>Conveyors</h1>
    </div>
<div class="main">
      <div class="left">
    <div class="l_menu text8">
          <div class="tit">All Products</div>
          <div><a href="#"><strong>Autos</strong></a></div>
          <div><a href="#"><strong>Autos</strong></a></div>
          <div><a href="#"><strong>Autos</strong></a></div>
          <div><a href="#"><strong>Autos</strong></a></div>
          <div><a href="#"><strong>Autos</strong></a></div>
          <div><a href="#"><strong>Autos</strong></a></div>
        </div>
    <div class="l_certif"><img src="images/a.gif"></div>
    <div class="l_famous">"The Google suite of products has been as critical to our success as any other part of our business."
          <p>——   Richard Sexton</p>
        </div>
    <div class="clear10"></div>
    <div class="l_famous">"The Google suite of products has been as critical to our success as any other part of our business."
          <p>——   Richard Sexton</p>
        </div>
    <div class="clear10"></div>
    <dl class="l_msy">
          <dd>I am Online Chat Now</dd>
          <dt>
        <div class="one"><a href="#"></a></div>
        <div class="two"><a href="#"></a></div>
        <div class="three"><a href="#"></a></div>
        <div class="four"><a href="#"></a></div>
        <div class="five"><a href="#"></a></div>
      </dt>
        </dl>
    <div class="l_but text4">
          <input type="submit" value="" class="submit_1">
        </div>
    <div class="clear10"></div>
  </div>
      <div class="right">
    <div class="r_flash">
          <div class="r_f_i textf"> <a href="#"id="indexhref"><img src="http://www.carwash.cn/photo/pf3264-Look_Chinese_Development_from_World_Economy.jpg" id="indexpic" ></a>
        <div> <b id="indexb"><a  href="#">car washes</a> <a  href="#">china car wash machine</a> </b> <span id="indexspan">2010 year China after 30 year open and reform become the sparkling big developing country from poor and as the world</span> </div>
      </div>
          <ul class="r_f_l " >
        <li  id="li0" class="" ><a href="#" id="a0" class="b">Autobase enterinto Chinese largest passenger gro...</a><img src="http://www.carwash.cn/photo/pf3269-Autobase_enterinto_Chinese_largest_passenger_gro.jpg" ></li>
        <li  id="li1" class="" ><a class="b" href="#" id="a1">TEPO-AUTO New Car Wash Machine Occupy...</a><img src="http://www.carwash.cn/photo/pf3268-TEPO_AUTO_New_Car_Wash_Machine_Occupy.jpg"></li>
        <li  id="li2" class="" ><a class="b" href="#" id="a2">tunnel car wash machine tepo-auto-tp901...</a><img src="http://www.carwash.cn/photo/pf3266-tunnel_car_wash_machine_tepo_auto_tp901.jpg" ></li>
        <li  id="li3" class="" ><a class="b" href="#" id="a3">TEPO-AUTO New Car Wash Machine Occupy...</a><img src="http://www.carwash.cn/photo/pf3265-TEPO_AUTO_New_Car_Wash_Machine_Occupy.jpg" ></li>
        <li  id="li4" class="cur textf" ><a class="" href="#" id="a4">Look Chinese Development from World Economy...</a><img src="http://www.carwash.cn/photo/pf3264-Look_Chinese_Development_from_World_Economy.jpg" ></li>
      </ul>
        </div>
    <div class="r_pro">
          <div class="sog"> <strong>Top Products</strong>
        <div class="sear text4">
              <form>
            <input type="text" class="te"/>
            <input type="submit" value="" class="submit_2">
          </form>
            </div>
      </div>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <dl class="text8">
        <dd><img src="images/index_30.gif"></dd>
        <dt>
              <div><a href="#">
                <h2>Chongqing Kington Liyang</h2>
                </a></div>
              venture with share holders from both motorcycle industry <a href="#" class="pho">View</a></dt>
      </dl>
          <div class="clear"></div>
        </div>
    <div class="r_com">
          <div class="flpho"><img src="images/index_49.gif" /></div>
          <strong class="text8"><a href="#">Wuyi Xiaobeige Industry & Trade Co., Ltd.</a></strong>
          <div class="con text8" style="height:55px;">Chongqing Kington Liyang Motorcycle Co., Ltd. is a joint venture with share holders from both motorcycle e holder 
        of our company is  MThe major share holder of our company Manufanufactory, one latory, one largest...</div>
          <table class="fleft text8"  cellpadding="0" cellspacing="0" style=" width:414px; margin-top:10px; margin-left:10px;">
        <tr >
              <td width="327"  height="22" align="left" style=" font-weight:bold;font-family:Verdana;border-bottom:#dcdcdc solid 1px; ">News</td>
              <td width="85"  style=" border-bottom:#dcdcdc solid 1px;" align="left"><a href="#">Read More>></a></td>
            </tr>
      </table>
          <ul class="text4 fleft" style=" width:414px; margin-left:10px; padding-top:5px; line-height:20px; text-align:left; ">
        <li><a href="#" style=" text-decoration:underline">Both motorcycle e holder of our company</a></li>
        <li><a href="#" style=" text-decoration:underline">venture with share holders from both</a></li>
      </ul>
          <table class="fleft text3" style="width: 390px; margin-top:10px; margin-left:10px;">
        <tr>
              <td width="149" align="left"><input type="submit" value="" class="submit_3"></td>
              <td width="102" align="left"><a href="#"><b>Factory Tour</b></a></td>
              <td width="123" align="left"><a href="#"><b>Quality Control</b></a></td>
            </tr>
      </table>
          <div class="clear"></div>
        </div>
  </div>
      <div class="clear"></div>
      <div class="bot"></div>
    </div>
<div class="footer">
      <div class="foot">
    <div class="top"></div>
    <div class="text8 men" style=" margin-left:25px; "><b>About Us</b>
          <div><a href="#">Company Profile</a></div>
          <div><a href="#">Factory Tour</a></div>
          <div><a href="#">Quality Control</a></div>
        </div>
    <div class="text8 men" style=" width: 200px;"><b>Facilities</b>
          <div><a href="#"><strong>Factory Tour</strong></a></div>
          <div><a href="#"><strong>Quality Control</strong></a></div>
        </div>
    <div class="text8 men" style=" width: 200px;"><b>Typical Products</b>
          <div><a href="#"><strong>Company Profile</strong></a></div>
          <div><a href="#"><strong>Factory Tour</strong></a></div>
        </div>
    <div class="text8 men" style=" width: 200px;"><b>Processes</b>
          <div><a href="#"><strong>Company Profile</strong></a></div>
        </div>
    <div class="text8 men" style=" background:  none;"><b>Contact Us</b>
          <div><a href="#">Contact Information</a></div>
          <div><a href="#">FRequest a Quote</a></div>
          <div><a href="#">E-Mail</a></div>
        </div>
    <div class="bott"></div>
    <div class="clear"></div>
  </div>
      <div class="reserved">2002-2009 Frbiz.com . All Rights Reserved. </div>
    </div>
</body>
</html>
