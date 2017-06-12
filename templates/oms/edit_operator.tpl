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
{include file="oms/common/mainnav.tpl"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>录入新帐号</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputUser" class="col-lg-1 control-label">用户名：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputUser" placeholder="foo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputUser" class="col-lg-1 control-label">用户名：</label>
                        <div class="col-lg-4">
                           <p class="form-control-static">foo</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-lg-1 control-label">密码：</label>
                        <div class="col-lg-4">
                            <input type="password" class="form-control" id="inputPassword" placeholder="为空则不作修改">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default">返回</button>
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