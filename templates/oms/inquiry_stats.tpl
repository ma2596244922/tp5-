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
                <form class="form-inline">
                    <div class="form-group">
                        <select class="form-control">
                            <option>所有来源</option>
                            <option>自然</option>
                            <option>匹配</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input class="form-control" type="text" placeholder="询盘邮箱">
                    </div>
                    <div class="form-group">
                        <input class="form-control" type="text" placeholder="域名">
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
                <nav class="pull-right">
                    <ul class="pagination">
                        <li><a href="#">&laquo;</a></li>
                        <li class="active"><span>1</span></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">&raquo;</a></li>
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
                    <tr>
                        <td>Inquiry About Internal wall insulation work good quality prefab house designs for kenya</td>
                        <td>
                            <a href="#" target="_blank">查看</a>
                        </td>
                        <td>2017-05-04 19:11:05</td>
                        <td>timands@gmail.com</td>
                        <td>popost.com</td>
                    </tr>
                </table>
                <nav class="pull-right">
                    <ul class="pagination">
                        <li><a href="#">&laquo;</a></li>
                        <li class="active"><span>1</span></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </nav>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>