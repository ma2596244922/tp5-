{assign var=page_title value="用户赠言"}<!DOCTYPE html>
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
    <a href="?action=edit_user_voice">录入赠言</a>
    <table class="GoodsListTb home-list">
      <thead>
        <tr>
          <td class="pic" width="15%">图片</td>
          <td width="30%">称谓</td>
          <td width="13%">创建时间(+8)</td>
          <td width="13%">最后修改时间(+8)</td>
          <td width="15%">操作</td>
        </tr>
      </thead>
      <tbody>
{foreach $user_voices as $uv}
        <tr class="{if $uv@index % 2}bgfa{else}on{/if}">
          <td class="pic">
            <img class="gp" src="{$uv.avatar_image_id|default:''|url:'enterprise_url_image':{$uv.title|default:''}:'m'}">
          </td>
          <td class="name">
            {$uv.title}
          </td>
          <td class="time">{$uv.created}</td>
          <td class="time2">{$uv.updated}</td>
          <td class="acts">
            <a href="?action=edit_user_voice&user_voice_id={$uv.id}">修改</a>

            <a href="javascript:void(0);" data-role="btn-delete" data-href="?action=delete_user_voice&user_voice_id={$uv.id}">删除</a>

          </td>
        </tr>
{foreachelse}
        <tr class="on">
          <td colspan="5">暂无任何用户赠言</td>
        </tr>
{/foreach}
      </tbody>
    </table>
  </div>
  <div class="clear"></div>
</div>
<!-- content -->
{include file="simple/common/footer.tpl"}
</body>
</html>