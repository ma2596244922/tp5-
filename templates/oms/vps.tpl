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
{include file="oms/common/mainnav.tpl" page_name="vps"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>VPS管理</h2>
                <a class="btn btn-primary" href="?action=edit_vps">录入新VPS</a>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>别名</th>
                        <th>IP</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $vpss as $i}
                    <tr>
                        <td>{$i.id}</td>
                        <td>{$i.alias|escape}</td>
                        <td>{$i.ip_addr|escape}</td>
                        <td>
                            <a href="?action=edit_vps&vps_id={$i.id}">修改</a>
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