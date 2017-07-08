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
{include file="oms/common/mainnav.tpl" page_name="password"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>修改密码</h2>
                <form class="form-horizontal" action="?action=password" method="POST">
                    <div class="form-group">
                        <label for="inputOldPassword" class="col-lg-1 control-label">旧密码：</label>
                        <div class="col-lg-4">
                            <input type="password" class="form-control" id="inputOldPassword" name="old_password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputNewPassword" class="col-lg-1 control-label">新密码：</label>
                        <div class="col-lg-4">
                            <input type="password" class="form-control" id="inputNewPassword" name="new_password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputNewPassword2" class="col-lg-1 control-label">再次输入：</label>
                        <div class="col-lg-4">
                            <input type="password" class="form-control" id="inputNewPassword2" name="new_password_2">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=vps';">返回</button>
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