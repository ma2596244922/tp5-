<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title></title>

{include file="oms/common/definitions.tpl"}

{include file="oms/common/styles.tpl"}
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Begin SideBar -->
{include file="oms/common/sidebar.tpl"}
            <!-- End SideBar -->

            <!-- Begin Page -->
            <div class="col-lg-10">
                <!-- Begin Nav -->
{include file="oms/common/sitenav.tpl" page_name="user"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>{if $user|default:[]}修改{else}录入新{/if}用户</h2>
                <form class="form-horizontal" action="?action=edit_user&site_id={$smarty.get.site_id}&user_id={$user_id}" method="POST">
                    <div class="form-group">
                        <label for="inputUser" class="col-lg-1 control-label">用户名：</label>
                        <div class="col-lg-4">
{if $user.name|default:''}
                            <p class="form-control-static">{$user.name}</p>
{else}
                            <input type="text" class="form-control" id="inputUser" name="name" placeholder="foo">
{/if}
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-lg-1 control-label">密码：</label>
                        <div class="col-lg-4">
                            <input type="password" class="form-control" id="inputPassword" name="password" placeholder="为空则不作修改">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-lg-1 control-label">Email：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputEmail" name="email" value="{$user.email|default:''|escape}" placeholder="foo@bar.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">高级用户：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="advanced" value="0"{if $user.advanced|default:'0'=='0'} checked{/if}>否
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="advanced" value="1"{if $user.advanced|default:'0'=='1'} checked{/if}>是
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=user&site_id={$smarty.get.site_id}';">返回</button>
                        </div>
                    </div>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>