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
                <form class="form-inline">
                    <div class="form-group">
                        <select class="form-control">
                            <option>全部网站</option>
                            <option>自营</option>
                            <option>赠送</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control">
                            <option>全部行业</option>
                            <option>Foos & Bars</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control">
                            <option>（待分配）</option>
                            <option>web2 (12.34.56.78)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <input type="date" class="form-control" placeholder="2017-06-09">
                            <div class="input-group-addon">至</div>
                            <input type="date" class="form-control" placeholder="2017-06-09">
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-primary">查询</button>
                        <button type="button" class="btn btn-default">今天</button>
                        <button type="button" class="btn btn-default">昨天</button>
                        <button type="button" class="btn btn-default">最近7天</button>
                        <button type="button" class="btn btn-default">最近30天</button>
                        <button type="button" class="btn btn-default">本月</button>
                        <button type="button" class="btn btn-default">上月</button>
                    </div>
                </form>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>域名</th>
                        <th>开通时间</th>
                        <th>产品数</th>
                        <th>询盘量</th>
                        <th>已删除询盘</th>
                        <th>邮箱数</th>
                    </tr>
                    <tr>
                        <td>popost.com</td>
                        <td>2017-05-04</td>
                        <td>1234</td>
                        <td>12</td>
                        <td>123</td>
                        <td>11</td>
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