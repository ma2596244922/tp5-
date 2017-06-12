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
                <h2>行业管理</h2>
                <button class="btn btn-default" type="button">录入新行业</button>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>行业名称</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>Foos &amp; Bars</td>
                        <td>
                            <a href="#">修改</a>
                        </td>
                    </tr>
                </table>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>