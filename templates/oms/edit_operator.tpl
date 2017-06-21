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
{include file="oms/common/mainnav.tpl" page_name="operator"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>{if $operator|default:[]}修改{else}录入新{/if}新帐号</h2>
                <form class="form-horizontal" action="?action=edit_operator&operator_id={$operator_id}" method="POST">
                    <div class="form-group">
                        <label for="inputUser" class="col-lg-1 control-label">用户名：</label>
                        <div class="col-lg-4">
{if $operator.name|default:''}
                            <p class="form-control-static">{$operator.name}</p>
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
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=operator';">返回</button>
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