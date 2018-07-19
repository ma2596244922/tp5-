{if $smarty.get.user_voice_id|default:''}{assign var=page_title value="修改用户赠言"}{else}{assign var=page_title value="录入用户赠言"}{/if}<!DOCTYPE html>
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
    </div>
    <form action="?action=edit_user_voice&user_voice_id={$user_voice_id}" method="POST" enctype="multipart/form-data" class="form-horizontal" id="form-edit-user_voice">

    <div class="client-msg fl-clr">
      <div class="msg-list">
          <div class="form-group fl-clr">
            <span class="client-img"><img src="simple/images/client.png" /></span>
            <div class="input-group">
                <em>客户姓名：</em>
                <input type="text" class="txt" id="clientname0" name="title" value="{$user_voice.title|default:''}"/>
            </div>
            <div class="input-group">
                <em>客户赠言：</em>
                <textarea class="area1" id="clientmsg0" name="voice">{$user_voice.voice|default:''}</textarea>
            </div>
          </div>
          <!-- form-group -->
      </div>
      <!-- msg-list -->
<!-- 无批量功能
      <div class="Btn add" id="appendGroup">新增客户赠言</div>
-->
      <input type="hidden" name="submit" value="edit_user_voice">
      <button class="submit">提交</button>
    </div>
    </form>
    <!-- client-msg -->
  </div>
  <!-- MaxMain -->
  <div class="clear"></div>
</div>
<!-- content -->
{include file="simple/common/footer.tpl"}
<script type="text/javascript">
$("#appendGroup").click(function(){
  var i=$(".form-group").length;
  var addClient='<div class="form-group fl-clr">'
    +'<span class="client-img"><img src="simple/images/client.png" /></span>'
    +'<div class="input-group"><em>客户姓名：</em><input type="text" class="txt" id="clientname'+i+'" ></div>'
    +'<div class="input-group"><em>客户赠言：</em><textarea class="area1" id="clientmsg'+i+'"></textarea></div>'
    +'</div>';
  $('.msg-list').append(addClient);
})
</script>
</body>
</html>