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
{include file="oms/common/mainnav.tpl" page_name="task"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>任务管理</h2>
                <a class="btn btn-primary" href="?action=edit_task">录入新任务</a>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>摘要</th>
                        <th>定时</th>
                        <th>状态</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $tasks as $i}
                    <tr>
                        <td>{$i.id}</td>
                        <td>{$i.details}</td>
                        <td>{$i.delay_until}</td>
                        <td>{$i.status|call:'\oms\daos\Task::status2Text'}</td>
                        <td>
    {-if $i.status==\oms\daos\Task::STATUS_PENDING}
                            <a href="?action=edit_task&task_id={$i.id}">修改</a>
    {-/if}
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