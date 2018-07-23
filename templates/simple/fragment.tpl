{assign var=page_title value="站长辅助工具"-}<!DOCTYPE html>
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
    <div class="client-msg admin-assist fl-clr">
      <form action="?action=fragment&tpl=simple" method="POST">
      <div class="msg-list">
        <div class="form-group fl-clr">
            <div class="input-group">
                <span>流量统计代码【全站通用】</span>
                <textarea class="area1" id="totalUse" name="common_fragment">{$site.common_fragment|default:''}</textarea>
            </div>
            <div class="input-group">
                <span>流量统计代码【询盘发送页】</span>
                <textarea class="area1" id="inquiryUse" name="contactnow_fragment">{$site.contactnow_fragment|default:''}</textarea>
            </div>
            <div class="input-group">
                <span>流量统计代码【询盘成功页】</span>
                <textarea class="area1" id="successUse" name="contactsave_fragment">{$site.contactsave_fragment|default:''}</textarea>
            </div>
            <div class="input-group">
                <span>全站通用&lt;head&gt;</span>
                <textarea class="area1" id="successUse" name="common_head_fragment">{$site.common_head_fragment|default:''}</textarea>
            </div>
<!--无功能
            <div class="input-group">
                <span>Webmaster验证文件</span>
                <div class="uploadname" id="uploadname">当前已上传：<span></span></div>
                <div class="upload">
                  <input type="file" class="file">
                  <span>选择文件</span>
                </div>
            </div>
-->
        </div>
        <!-- form-group -->
<!--无功能
        <div class="tip-box">
          <dl>
            <dt>提示</dt>
            <dd>网站验证文件只支持以下验证方式及其文件名称格式，示例如下：</dd>
            <dd>1.Google验证： google4dcfd4c7171361.html</dd>
            <dd>2.Bing网站验证：BingSiteAuth.xml</dd>
            <dd>3.yandex验证：yandex_********.html</dd>
            <dd>4.Robots协议：robots.txt</dd>
          </dl>
        </div>
-->
      </div>
      <!-- msg-list -->
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
    $('input[type=file]').on('change',function(){
      var value = $(this).val();
      value = value.split("\\")[2];
      $("#uploadname").css("display","block");
      $("#uploadname span").text(value);
      })
</script>
</body>
</html>