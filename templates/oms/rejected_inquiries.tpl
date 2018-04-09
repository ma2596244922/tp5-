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
                <h2>询盘回收</h2>
                <nav class="pull-right">
                    <ul class="pagination">
{if $smarty.get.page|default:1 > 1}
                        <li><a href="?{$query_string}&page={$smarty.get.page|default:1-1}">&laquo;</a></li>
{/if}
                        <li><a href="?{$query_string}&page={$smarty.get.page|default:1+1}">&raquo;</a></li>
                    </ul>
                </nav>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>询盘标题</th>
                        <th>询盘内容</th>
                        <th>询盘时间</th>
                        <th>询盘邮箱</th>
                        <th>域名</th>
                    </tr>
{foreach $rejected_inquiries as $i}
                    <tr>
                        <td>{$i.subject}</td>
                        <td>
                            <a href="?action=view_inquiry&pending_inquiry_id={$i.id}" target="_blank">查看</a>
                        </td>
                        <td>{$i.created}</td>
                        <td>{$i.email}</td>
                        <td>{$i.domain}</td>
                    </tr>
{/foreach}
                </table>
                <nav class="pull-right">
                    <ul class="pagination">
{if $smarty.get.page|default:1 > 1}
                        <li><a href="?{$query_string}&page={$smarty.get.page|default:1-1}">&laquo;</a></li>
{/if}
                        <li><a href="?{$query_string}&page={$smarty.get.page|default:1+1}">&raquo;</a></li>
                    </ul>
                </nav>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
{include file="oms/common/filterscripts.tpl"}

</body>
</html>