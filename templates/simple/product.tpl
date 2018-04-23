<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>产品管理</title>
    <link rel="stylesheet" type="text/css" href="simple/style.css">
  <script type="text/javascript" src="simple/js/jquery.min.js"></script>
  <script type="text/javascript" src="simple/js/prototype_create.js"></script>
  <script type="text/javascript" src="simple/js/jquery.nicescroll.min.js"></script>
  <script type="text/javascript" src="simple/js/plugins.js"></script>
</head>
<body>

<div class="Top">
  <div class="Page">
    <h1 class="logo fl"><a href=""></a></h1>
    <div class="userInfo fr">
      <img src="./images/tmp/head1.jpg">
      <span>Hello,David</span>
    </div>
  </div>
</div>
<div class="Content Page">
  <div class="Left">
    <a href="" class="s1"><i></i>首页</a>
    <a href="" class="s2"><i></i>询盘中心</a>
    <a href="" class="s3 cur"><i></i>产品管理<i class="more"></i></a>
    <a href="" class="s4"><i></i>公司管理</a>
    <a href="" class="s5"><i></i>新闻中心</a>
    <a href="" class="s6"><i></i>图片中心</a>
    <a href="" class="s7"><i></i>Banner管理</a>
    <div class="line"></div>
    <a href="" class="s8"><i></i>Webmaster验证</a>
    <a href="" class="s9"><i></i>页面代码</a>
    <a href="" class="s10"><i></i>SEO设置</a>
    <div class="qrcode tc">
      <p>创业不易·我要打赏</p>
      <img src="./images/qrcode.png">
    </div>
  </div>
  <div class="MaxMain">
    <div class="MaxMainBox">
      <h2 class="BoxTil fl">产品管理</h2>
      <div class="fr rightTag">
        <span>当前显示产品：{$total_products}</span>
        <i class="icon quest"><div>Tips提示信息<strong></strong></div></i>
      </div>
      <div class="clear"></div>
      <div class="MainBox retrieval">
        <dl class="SelectDL fl">
          <dt><p>筛选状态</p><input type="hidden"></dt>
          <dd tabindex="0" style="overflow: hidden; outline: none;">
            <ul>
              <li val="0">全部</li>
             
             
            </ul>
          </dd>
        </dl>
        <dl class="SelectDL fl">
          <dt><p>
            {if !empty($smarty.get.group_id)}
               {foreach $groups as $group}
                  {if $group.id==$smarty.get.group_id}
                    {$group.name}
                  {/if}
                {/foreach}
            {else}
            选择分组
            {/if}
          </p><input type="hidden" id="select-group" ></dt>
          <dd tabindex="0" style="overflow: hidden; outline: none;">
            <ul>
              <li val="0">全部</li>
               {foreach $groups as $group}

                  <li val="{$group.id}">{$group.name}</li>
              {/foreach}
            </ul>
          </dd>
        </dl>
        <input type="text" class="searchName fl" placeholder="请输入产品名称"  value="{$smarty.get.keywords|default:''|escape}"  id="input-keywords">
        <button class="searchNameBtn fl"></button>
        <a class="addOne fl" href="?action=edit_product">发布新产品</a>
        <div class="clear"></div>
      </div>
      <div class="MainBox retrieval retrieval2">
        <p class="checkALL fl">全选</p>
        <p class="cancelALL fl">取消</p>
        
        <div class="clear"></div>
      </div>
    </div>

    <table class="GoodsListTb">
      <thead>
        <tr>
          <td class="pic">产品图片</td>
          <td>产品名称</td>
          <td>创建时间</td>
          <td>更新时间</td>
          <td>操作</td>
          <td class="sortTD"><p>分组排序</p></td>
        </tr>
      </thead>
      <tbody>
{section name=i loop=$products}

        <tr class="bgfa">
          <td class="pic">
            <img class="gp" src="{$products[i].head_image_id|default:''|url:'enterprise_url_image':{$product.caption|default:''}:'c'}">
            <img src="simple/images/s1.png" class="status">
            <i class="icon check"></i>
          </td>
          <td class="name">
            <a href="{$products[i]|url:'enterprise_url_product'}">{$products[i].caption}</a>
            <p>分组：{$products[i].group_name}</p>
          </td>
          <td class="time">{$products[i].created}</td>
          <td class="time2">{$products[i].updated}</td>
          <td class="acts">
            <a href="?action=edit_product&product_id={$products[i].id}" class="edit btn">编辑</a>
            <a href="{$products[i]|url:'enterprise_url_product'}" class="fl">查看</a>
            <a href="javascript:void(0);" class="sort fr">排序</a>
          </td>
          <td class="sortTD">
            <input type="text">
          </td>
        </tr>

{sectionelse}
        <tr>

            <td colspan="6">暂无任何产品</td>

        </tr>
{/section}  
      </tbody>
    </table>
    
    <table class="gList">
    </table>

    <div class="MaxMainBox">
      <div class="Pager ConBox tr">
        <button class="fr" id="goto">Go</button>
        <input class="fr tc" type="" id="goto_input">
        <span class="fr">Go to Page</span>
        {$page_str}
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>

<div class="mask" id="appendGroupDiv">
  <div class="main">
    <p class="tit fl">添加分组</p>
    <button class="close fr closeBtn">x</button>
    <div class="clear"></div>
    <div class="Tr font6">
      <p class="ph">输入分组名称：</p>
      <input type="text">
      <p class="error">请输入3-60字符</p>
    </div>
    <div class="btns">
      <button class="submit">提交</button>
      <button class="cancel closeBtn">取消</button>
    </div>
  </div>
</div>

<script type="text/javascript" src="simple/js/nice_select.js"></script>
<script type="text/javascript">
{literal} 
$(".checkALL").click(function(){
  $(this).toggleClass('on')
  if($(this).hasClass('on')){
    $("i.check").closest('tr').addClass('on')
  }else{
    $("i.check").closest('tr').removeClass('on')
  }
})

$("i.check").click(function(){
  $(this).closest('tr').toggleClass('on')
  tjCheck()
})

function tjCheck(){
  if($("i.check").length == $("tr.on").length){
    $(".checkALL").addClass('on')
  }else{
    $(".checkALL").removeClass('on')
  }
}

//排序
$(".sort").click(function(){ //显示
  $('.GoodsListTb').addClass('sort')
})
$(".sortTD p").click(function(){ //隐藏||保存
  $('.GoodsListTb').removeClass('sort')
})

$("#appendGroup").click(function(){
  $("#appendGroupDiv").fadeIn(500)
})
$("#appendGroupDiv").find('.submit').click(function(){
  var v = $("#appendGroupDiv").find('input').val()
  if(v!=''){
    //will ajax
    //success:
    $("#group").prepend('<li val="'+v+'">'+v+'</li>')
    $("#appendGroupDiv").fadeOut(500).find('input').val('')
  }else{
    alert('请输入分组名称')
  }
}).end().find('.closeBtn').click(function(){
  $("#appendGroupDiv").fadeOut(500).find('input').val('')
})

$('#goto').on('click',function(){
  var val = $('#goto_input').val();
  if(val === "" || val ==null){
        return false;
    }
    if(!isNaN(val)){
        window.location.href = "/admin/?action=product&page="+val;

    }else{
        return false;
    }
})


$('#select-group').change(function() {
                console.log(222);
                location.href = '?action=product&group_id=' + $(this).val();
           });

 $('#input-keywords').keypress(function (e) {
                if (e.which != 13)
                    return;

                var keywords = $(this).val();
                location.href = '?action=product&keywords=' + encodeURIComponent(keywords);
           });

{/literal} 
</script>
</body>
</html>