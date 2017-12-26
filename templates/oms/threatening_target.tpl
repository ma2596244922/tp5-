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
                <h2>询盘黑名单</h2>
                <a class="btn btn-primary" href="?action=edit_threatening_target">录入新目标</a>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>Email</th>
                        <th>IP</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $threatening_targets as $i}
                    <tr>
                        <td>{$i.id}</td>
                        <td>{$i.email|escape}</td>
                        <td>{$i.ip_addr|escape}</td>
                        <td>
                            <a href="?action=edit_threatening_target&threatening_target_id={$i.id}">修改</a>
                            <a href="?action=remove_threatening_target&threatening_target_id={$i.id}">删除</a>
                        </td>
                    </tr>
{/foreach}
                </table>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>