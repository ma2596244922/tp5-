
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>产品发布</title>

  <link rel="stylesheet" type="text/css" href="simple/style.css">
  <script type="text/javascript" src="simple/js/jquery.min.js"></script>
  <script type="text/javascript" src="simple/js/prototype_create.js"></script>
  <script type="text/javascript" src="simple/js/jquery.nicescroll.min.js"></script>
  <script type="text/javascript" src="simple/js/plugins.js"></script>
</head>
<body>

<div class="Top">
  <div class="Page">
    <h1 class="logo fl"><a href="">　　　　　　　　　　　</a></h1>
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
      <h2 class="BoxTil fl">分组管理</h2>
      <div class="clear"></div>
      <div class="MainBox retrieval retrieval2">
        <p class="checkALL fl">全选</p>
        <p class="cancelALL fl">取消</p>
        <button class="del fl">删除分组</button>
        <button class="edit fl" id="appendGroup">新建分组</button>
        <div class="clear"></div>
      </div>
    </div>

    <table class="GoodsListTb GroupListTb">
      <thead>
        <tr>
          <td class="gName">分组名称</td>
          <td class="nums">产品数量</td>
          <td class="sortTD"><p>分组排序</p></td>
          <td>创建时间</td>
          <td>更新时间</td>
          <td class="acts">操作</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          {section name=i loop=$groups}{assign var="gid" value={$groups[i].id|default:$groups[i].group_id}}
          <td class="gName">
            {if $groups[i].cnt > 0}
            <a href="{$groups[i]|url:'enterprise_url_product_list'}" target="_blank">{$groups[i].name}</a>
            {else}
                                                {$groups[i].name}
            {/if}
            <i class="icon check"></i>
          </td>

          <td>{$groups[i].cnt}</td>
          <td class="sortTD">
            <input type="text" value="{$groups[i].ranking}">
            <span>{$groups[i].ranking}</span>
          </td>
          <td class="time">{$groups[i].created}</td>
          <td class="time2">{$groups[i].updated}</td>
          <td class="acts">
            <a href="" class="edit btn">修改</a>
            <a href="javascript:void(0);" class="edit_sort" onclick="edit_sort(this,{$groups[i].id},{$groups[i].ranking},'{$groups[i].name}')">修改产品排序</a>
            <a href="javascript:void(0);" class="clean">清空分组</a>
          </td>
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
      <input type="text" name="name" id="group_name">
      <p class="error">请输入3-60字符</p>
    </div>
    <div class="Tr font6">
      <p class="ph">输入分组排序：</p>
      <input type="text" name="ranking" id="group_ranking">
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
//
$(".sortTD p").click(function(){
  $('.sortTD').toggleClass('edit')
})

$(".checkboxList li").click(function(){
  $(this).toggleClass('ed')
})

$("#addAttr").click(function(){
  var item = $("#itemAttr").clone().removeAttr('id')
  $(this).parent().before(item)
  item.find('button').click(function(){item.remove()})
})
$("#itemAttr").find('button').click(function(){alert('默认属性不能删除')})

$("#appendGroup").click(function(){
  $("#appendGroupDiv").fadeIn(500)
})
$("#appendGroupDiv").find('.submit').click(function(){
 console.log($('#group_name').val())
  if($('#group_name').val()){
      $.ajax({
          url: "?action=edit_group_ajax&group_id=0",
          dataType: 'json',
          type: 'POST',
          data: {"name":$('#group_name').val(),"submit":"edit_group_ajax","ranking":$('#group_ranking').val()},
          success:function(result){
            if(result.code==1)
            {
              alert(result.msg);
              window.location.href = '/admin/?action=group';
        
            }else{
              alert(result.msg);
            }
           
          }
      })

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
        window.location.href = "/admin/?action=group&page="+val;

    }else{
        return false;
    }
})

function edit_sort (obj,id,ranking,name) {
 var new_ranking = $(obj).parent().parent().find('input').val();
 if(new_ranking==ranking)
 {
  return false;
 }else{
   $.ajax({
          url: "?action=edit_group_ajax&group_id="+id,
          dataType: 'json',
          type: 'POST',
          data: {"name":name,"submit":"edit_group_ajax","ranking":new_ranking},
          success:function(result){
            if(result.code==1)
            {
              alert(result.msg);
            
            }else{
              alert(result.msg);
            }
           
          }
      })
 }

}



{/literal}
</script>
</body>
</html>