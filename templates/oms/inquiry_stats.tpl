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
                            <a href="#" target="_blank">查看</a>
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
    <script type="text/javascript">{literal}
        var submitToDate = function(from, to) {
            $('#inputFrom').val(from);
            $('#inputTo').val(to);
            $('#formFilter').submit();
        };
        var getDaysOfMonth = function(dt) {
            var m = dt.getMonth() + 1;
            switch (m) {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    return 31;
                case 4:
                case 6:
                case 9:
                case 11:
                    return 30;
            }

            var y = dt.getFullYear();
            if ((y % 4 == 0
                    && y % 100 != 0)
                    || y % 400 == 0)
                return 29;
            else
                return 28;
        };
        $('#btnToday').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            submitToDate(now, now);
        });
        $('#btnYesterday').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            var ts = Date.parse(now);
            ts -= 1000 * 86400;

            var yesterday = $.format.date(new Date(ts), 'yyyy-MM-dd');
            submitToDate(yesterday, yesterday);
        });
        $('#btnRecent7Days').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            var tsTo = Date.parse(now);
            var tsFrom = tsTo - 1000 * 86400 * 7;

            var to = $.format.date(new Date(tsTo), 'yyyy-MM-dd');
            var from = $.format.date(new Date(tsFrom), 'yyyy-MM-dd');
            submitToDate(from, to);
        });
        $('#btnRecent30Days').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            var tsTo = Date.parse(now);
            var tsFrom = tsTo - 1000 * 86400 * 30;

            var to = $.format.date(new Date(tsTo), 'yyyy-MM-dd');
            var from = $.format.date(new Date(tsFrom), 'yyyy-MM-dd');
            submitToDate(from, to);
        });
        $('#btnThisMonth').click(function() {
            var dt = new Date();
            var from = $.format.date(dt, 'yyyy-MM-01');
            var ts = Date.parse(from);
            ts += (getDaysOfMonth(dt) - 1) * 86400 * 1000;

            var dtLastDayOfThisMonth = new Date(ts);
            var to = $.format.date(dtLastDayOfThisMonth, 'yyyy-MM-dd');
            submitToDate(from, to);
        });
        $('#btnLastMonth').click(function() {
            var dt = new Date();
            var firstDay = $.format.date(dt, 'yyyy-MM-01');
            var ts = Date.parse(firstDay);
            ts -= 1000 * 86400;

            var dtLastDayOfLastMonth = new Date(ts);
            var from = $.format.date(dtLastDayOfLastMonth, 'yyyy-MM-01');
            var to = $.format.date(dtLastDayOfLastMonth, 'yyyy-MM-dd');
            submitToDate(from, to);
        });
    {/literal}</script>
</body>
</html>