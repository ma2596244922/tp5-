{assign var=page_title value="首页TDK设置"-}<!DOCTYPE html>
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
    <div class="client-msg tdk-words fl-clr">
      <form action="?action=index_tdk&tpl=simple" method="POST">
      <div class="msg-list">
        <div class="form-group fl-clr">
            <div class="input-group">
                <em>Title:</em>
                <input type="text" class="txt" id="title" name="html_title" value="{$title|default:''}" />
            </div>
<!--无功能
            <div class="input-group">
                <span>Keywords</span>
                <input type="text" class="txt txt3" id="key1" >
                <input type="text" class="txt txt3" id="key2" >
                <input type="text" class="txt txt3" id="key3" >
                <input type="text" class="txt txt3" id="key4" >
                <input type="text" class="txt txt3" id="key5" >
                <input type="text" class="txt txt3" id="key6" >
            </div>
-->
            <div class="input-group">
                <em>Keywords:</em>
                <textarea class="area1" id="descrimsg" name="meta_keywords">{$keywords|default:''}</textarea>
            </div>
            <div class="input-group">
                <em>Description:</em>
                <textarea class="area1" id="descrimsg" name="meta_description">{$description|default:''}</textarea>
            </div>
        </div>
        <!-- form-group -->
      </div>
      <!-- msg-list -->
<!--无功能
      <span class="recover" id="recoverform">恢复默认值</span>
-->
      <input type="hidden" name="submit" value="update">
      <button class="submit">提交</button>
      </form>
    </div>
    <!-- client-msg -->
  </div>
  <!-- MaxMain -->
  <div class="clear"></div>
</div>
<!-- content -->
{include file="simple/common/footer.tpl"}
<!-- footer -->
<script type="text/javascript">
    $("#recoverform").click(function(){
      $(".txt").val("");
      $("#descrimsg").val("");
    })
</script>
</body>
</html>