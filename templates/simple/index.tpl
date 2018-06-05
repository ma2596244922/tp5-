<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>首页</title>
  <link rel="stylesheet" type="text/css" href="simple/common.css">
  <link rel="stylesheet" type="text/css" href="simple/index.css">
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
                      <dt>2</dt>
                      <dd>今日UV</dd>
                  </dl>
              </li>
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
          </ul>
      </div>
      <!-- daily-update -->
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
      <!-- home-chart -->
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
          <!-- msg-calssify -->
      </div>
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
                  <tr>
                      <td>Embroidery Patches</td>
                      <td>l****@flomousa.com</td>
                      <td>2017-05-15 23:32:32</td>
                      <td><a href="#" class="see">查看</a></td>
                  </tr>
                  <tr>
                      <td>Embroidery Patches</td>
                      <td>l****@flomousa.com</td>
                      <td>2017-05-15 23:32:32</td>
                      <td><a href="#" class="see">查看</a></td>
                  </tr>
                  <tr>
                      <td>Embroidery Patches</td>
                      <td>l****@flomousa.com</td>
                      <td>2017-05-15 23:32:32</td>
                      <td><a href="#" class="see">查看</a></td>
                  </tr>
              </tbody>
          </table>
      </div>
      <!-- new-inquiry -->
  </div>
  <!-- right-content -->
</div>
<!-- Content -->
{include file="simple/common/footer.tpl"}
</body>
</html>