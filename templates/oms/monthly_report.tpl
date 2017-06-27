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
{include file="oms/common/sitenav.tpl"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>月度报告</h2>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>月度报告</th>
                        <th>询盘量</th>
                        <th>邮箱数</th>
                    </tr>
{foreach $report as $r}
                    <tr>
                        <td>{$r.label}</td>
                        <td>{$r.cnt}</td>
                        <td>{$r.email_cnt}</td>
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