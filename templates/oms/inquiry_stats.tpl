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
{include file="oms/common/mainnav.tpl" page_name="inquiry_stats"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>询盘统计</h2>
                <form class="form-inline" action="?" method="GET" id="formFilter">
                    <div class="form-group">
                        <select class="form-control" name="type">
                            <option value="-1">所有来源</option>
                            <option value="{$TYPE_NATURAL}"{if $smarty.get.type|default:0==$TYPE_NATURAL} selected{/if}>自然</option>
                            <option value="{$TYPE_INPUT}"{if $smarty.get.type|default:0==$TYPE_INPUT} selected{/if}>匹配</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input class="form-control" type="text" name="email" placeholder="询盘邮箱" value="{$smarty.get.email|default:''}">
                    </div>
                    <div class="form-group">
                        <input class="form-control" type="text" name="domain" placeholder="域名" value="{$smarty.get.domain|default:''}">
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <input type="date" class="form-control" name="from" id="inputFrom" placeholder="2017-06-09" value="{$smarty.get.from|default:''}">
                            <div class="input-group-addon">至</div>
                            <input type="date" class="form-control" name="to" id="inputTo" placeholder="2017-06-09" value="{$smarty.get.to|default:''}">
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="action" value="inquiry_stats"/>
                        <button type="submit" class="btn btn-primary">查询</button>
                        <button type="button" class="btn btn-default" id="btnToday">今天</button>
                        <button type="button" class="btn btn-default" id="btnYesterday">昨天</button>
                        <button type="button" class="btn btn-default" id="btnRecent7Days">最近7天</button>
                        <button type="button" class="btn btn-default" id="btnRecent30Days">最近30天</button>
                        <button type="button" class="btn btn-default" id="btnThisMonth">本月</button>
                        <button type="button" class="btn btn-default" id="btnLastMonth">上月</button>
                    </div>
                </form>
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
{foreach $inquiries as $i}
                    <tr>
                        <td>{$i.subject}</td>
                        <td>
                            <a href="?action=view_inquiry&inquiry_id={$i.id}" target="_blank">查看</a>
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