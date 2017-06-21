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
                <h2>帐号管理</h2>
                <a class="btn btn-primary" href="?action=edit_operator">录入新帐号</a>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>用户名</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $operators as $i}
                    <tr>
                        <td>{$i.id}</td>
                        <td>{$i.name|escape}</td>
                        <td>
                            <a href="?action=edit_operator&operator_id={$i.id}">修改</a>
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