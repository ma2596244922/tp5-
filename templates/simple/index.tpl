<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>首页</title>
{include file="simple/common/stylesheets.tpl"}
</head>
<body>
{include file="simple/common/top.tpl"}
<!-- Top -->
<div class="Content Page fl-clr">
  {include file="simple/common/left.tpl"}
  <!-- Left -->
  <div class="right-content">
      <div class="daily-update">
          <ul class="fl-clr">
            <li>
                <span class="icon1"></span>
                <dl>
                    <dt>{$uv}</dt>
                    <dd>昨日UV</dd>
                </dl>
            </li>
<!-- 无数据
            <li>
                <span class="icon2"></span>
                <dl>
                    <dt>55</dt>
                    <dd>今日询盘</dd>
                </dl>
            </li>
            <li>
                <span class="icon3"></span>
                <dl>
                    <dt>487</dt>
                    <dd>今日更新产品</dd>
                </dl>
            </li>
            <li>
                <span class="icon4"></span>
                <dl>
                    <dt>1893</dt>
                    <dd>今日发布产品</dd>
                </dl>
            </li>
-->
          </ul>
      </div>
      <!-- daily-update -->
<!-- 无数据
      <div class="home-chart">
          <div class="tab-title">
              <ul class="fl-clr">
                  <li class="cur">周询盘<i>|</i></li>
                  <li>周PV</li>
              </ul>
          </div>
          <div class="tab-content">
              <div class="tab-detail">
                  <img src="images/chart.png" />
              </div>
              <div class="tab-detail">
                1
              </div>
          </div>
      </div>
-->
      <!-- home-chart -->
<!-- 无数据
      <div class="msg-collect">
          <div class="title">信息汇总</div>
          <div class="msg-classify fl-clr">
              <div class="msg-box">
                  <dl class="fl-clr">
                      <dt>询盘信息</dt>
                      <dd><span>5120</span>共接收询盘</dd>
                      <dd><span>621</span>未读询盘</dd>
                  </dl>
                  <a href="#">查看详情</a>
              </div>
              <div class="msg-box">
                <dl class="fl-clr">
                    <dt>询盘信息</dt>
                    <dd><span>362</span>发布产品</dd>
                    <dd class="green"><span>94</span>更新产品</dd>
                </dl>
                <a href="#">查看详情</a>
            </div>
            <div class="msg-box">
                <dl class="fl-clr">
                    <dt>询盘信息</dt>
                    <dd class="center"><span>76</span>发布分组</dd>
                </dl>
                <a href="#">查看详情</a>
            </div>
          </div>
      </div>
-->
      <!-- msg-collect -->
      <div class="new-inquiry">
          <div class="title">最新询盘</div>
          <table cellspacing="0" cellpadding="0">
              <thead>
                  <tr>
                     <th width="30%">询盘名称</th>
                     <th width="25%">买家邮箱</th>
                     <th width="25%">接收时间</th>
                     <th width="20%">操作</th> 
                  </tr>
              </thead>
              <tbody>
{section name=i loop=$inquiries}
                  <tr>
                      <td>
                        {$inquiries[i].subject}
                      </td>
                      <td>{$inquiries[i].email}</td>
                      <td>{$inquiries[i].created}</td>
                      <td><a href="?action=inquiry_detail&inquiry_id={$inquiries[i].id}" class="see">查看</a></td>
                  </tr>
{/section}
              </tbody>
          </table>
      </div>
      <!-- new-inquiry -->
  </div>
  <!-- right-content -->
</div>
<!-- Content -->
{include file="simple/common/footer.tpl"}
<script type="text/javascript">
$(function(){
    var c
    $(".tab-content .tab-detail:first").show();
    $(".tab-title li").click(function(){
        $(this).addClass("cur");
        $(this).siblings().removeClass("cur");
        c =  $(this).index();
        $($(".tab-content .tab-detail")[c]).siblings().hide();
        $($(".tab-content .tab-detail")[c]).show();
    })  
})
</script>
</body>
</html>