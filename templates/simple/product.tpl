{assign var=page_title value="产品管理"}<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>{$page_title}</title>
{include file="simple/common/stylesheets.tpl"}
</head>
<body>
{include file="simple/common/top.tpl"}
<div class="Content Page">
  {include file="simple/common/left.tpl"}
  <div class="MaxMain">
    <div class="MaxMainBox">
      <h2 class="BoxTil fl">{$page_title}</h2>
      <div class="fr rightTag">
{if $group|default:[]}
        <span>分组：{$group.name}</span>
{elseif $smarty.get.keywords|default:''}
        <span>关键词：{$smarty.get.keywords}</span>
{else}
        <span>全部产品({$site.product_cnt})</span>
{/if}
<!-- 无功能
        <i class="icon quest"><div>Tips提示信息<strong></strong></div></i>
-->
      </div>
<!-- 无功能
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
-->
    </div>

    <table class="GoodsListTb">
      <thead>
        <tr>
          <td class="pic">产品图片</td>
          <td>产品名称</td>
          <td>创建时间</td>
          <td>更新时间</td>
          <td>操作</td>
<!-- 无功能
          <td class="sortTD"><p>分组排序</p></td>
-->
        </tr>
      </thead>
      <tbody>
{foreach $products as $product}
        <tr class="{if $product@index % 2}bgfa{else}on{/if}">
          <td class="pic">
            <img class="gp" src="{$product.head_image_id|default:''|url:'enterprise_url_image':{$product.caption|default:''}:'m'}">
<!-- 无功能
            <img src="simple/images/s1.png" class="status">
            <i class="icon check"></i>
-->
          </td>
          <td class="name">
            <a href="{$product|url:'enterprise_url_product'}" target="_blank">{$product.caption}</a>
            <p>分组：{$product.group_name}</p>
          </td>
          <td class="time">{$product.created}</td>
          <td class="time2">{$product.updated}</td>
          <td class="acts">
            <a href="?action=edit_product&product_id={$product.id}" class="edit btn">编辑</a>
            <a href="{$product|url:'enterprise_url_product'}" class="fl" target="_blank">查看</a>
<!-- 无功能
            <a href="javascript:void(0);" class="sort fr">排序</a>
-->
          </td>
<!-- 无功能
          <td class="sortTD">
            <input type="text">
          </td>
-->
        </tr>
{foreachelse}
        <tr>
            <td colspan="5">暂无任何产品</td>
        </tr>
{/foreach}  
      </tbody>
    </table>
    
    <table class="gList">
    </table>

    <div class="MaxMainBox">
      <div class="Pager ConBox tr">
<!-- 无功能
        <button class="fr" id="goto">Go</button>
        <input class="fr tc" type="" id="goto_input">
        <span class="fr">Go to Page</span>
-->
        <div class="lists">
{-if isset($pager_info['prev_page'])}
          <a href="?action=product&tpl=simple&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['prev_page']}" class="left">&lt;</a>
{-/if}
{-for $i=$pager_info['min_page'] to $pager_info['max_page']}
          <a href="?action=product&tpl=simple&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$i}"{if $i==$page_no} class="cur"{/if}>{$i}</a>
{-/for}
{-if isset($pager_info['next_page'])}
          <a href="?action=product&tpl=simple&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['next_page']}" class="right">&gt;</a>
{-/if}
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!-- 无功能
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
-->
{include file="simple/common/footer.tpl"}
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