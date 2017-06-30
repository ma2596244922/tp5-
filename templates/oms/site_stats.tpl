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
                <h2>网站统计</h2>
                <form class="form-inline" action="?" method="GET" id="formFilter">
                    <div class="form-group">
                        <select class="form-control" name="type">
                            <option value="0">全部网站</option>
{foreach $types as $type => $label}
                            <option value="{$type}"{if $type==$smarty.get.type|default:'0'} selected{/if}>{$label}</option>
{/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="industry_id">
                            <option value="0">全部行业</option>
{foreach $industries as $i}
                            <option value="{$i.id}"{if $i.id==$smarty.get.industry_id|default:'0'} selected{/if}>{$i.name|escape}</option>
{/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="vps_id">
                            <option value="0">（待分配）</option>
{foreach $vpss as $v}
                            <option value="{$v.id}"{if $v.id==$smarty.get.vps_id|default:'0'} selected{/if}>{$v.alias} ({$v.ip_addr})</option>
{/foreach}
                        </select>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <input type="date" class="form-control" name="from" id="inputFrom" placeholder="2017-06-09" value="{$smarty.get.from|default:''}">
                            <div class="input-group-addon">至</div>
                            <input type="date" class="form-control" name="to" id="inputTo" placeholder="2017-06-09" value="{$smarty.get.to|default:''}">
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="action" value="site_stats"/>
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
                        <th>域名</th>
                        <th>开通时间</th>
                        <th>产品数</th>
                        <th>询盘量</th>
                        <th>已删除询盘</th>
                        <th>邮箱数</th>
                    </tr>
{foreach $sites as $s}
                    <tr>
                        <td>
                            <a href="?action=site_dashboard&site_id={$s.id}" target="_blank">{$s.domain}</a>
                        </td>
                        <td>{$s.created}</td>
                        <td>{$s.products}</td>
                        <td>{$s.inquiries}</td>
                        <td>{$s.deleted_inquiries}</td>
                        <td>{$s.inquiry_emails}</td>
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