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
{include file="oms/common/mainnav.tpl" page_name="threatening_target"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>{if $threatening_target|default:[]}修改{else}录入新{/if}目标</h2>
                <form class="form-horizontal" action="?action=edit_threatening_target&threatening_target_id={$threatening_target_id}" method="POST">
                    <div class="form-group">
                        <label for="inputEmail" class="col-lg-1 control-label">Email：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputEmail" name="email" value="{$threatening_target.email|default:''}" placeholder="aa@bb.cc">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddr" class="col-lg-1 control-label">IP：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputAddr" name="ip_addr" value="{$threatening_target.ip_addr|default:''}" placeholder="12.34.56.78">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=threatening_target';">返回</button>
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