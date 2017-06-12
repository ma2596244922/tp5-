<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title></title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">

    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Begin SideBar -->
            <div class="col-lg-2">
                <div class="list-group">
                    <a class="list-group-item active" href="#">运营管理</a>
                    <a class="list-group-item">
                        <select class="form-control" name="type">
                            <option value="0">全部网站</option>
                            <option value="10">自营</option>
                            <option value="20">赠送</option>
                        </select>
                    </a>
                    <a class="list-group-item" href="#">(上)foo.com</a>
                    <a class="list-group-item" href="#">(上)foo.com</a>
                    <a class="list-group-item" href="#">(上)foo.com</a>
                    <a class="list-group-item" href="#">(上)foo.com</a>
                </div>
            </div>
            <!-- End SideBar -->

            <!-- Begin Page -->
            <div class="col-lg-10">
                <!-- Begin Nav -->
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand">运营管理</a>
                        </div>

                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li class="active"><a href="#">网站开通</a></li>
                                <li><a href="#">网站统计</a></li>
                                <li><a href="#">询盘统计</a></li>
                                <li><a href="#">询盘审核</a></li>
                                <li><a href="#">行业管理</a></li>
                                <li><a href="#">VPS管理</a></li>
                                <li><a href="#">帐号设置</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>网站开通</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputDomain" class="col-lg-1 control-label">根域*：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputDomain" placeholder="foo.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputMemo" class="col-lg-1 control-label">备注：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputMemo" placeholder="某某公司">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="button" class="btn btn-primary">开通</button>
                        </div>
                    </div>
                </form>

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

                <h2>询盘审核</h2>
                <div class="media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object" src="http://www.mocfaoff.org/admin/media/image/no_image.png" alt="...">
                        </a>
                    </div>
                    <div class="media-body">
                        <h3 class="media-heading">Inquiry About Internal wall insulation work good quality prefab house designs for kenya</h3>
                        <ul>
                            <li>国家：美国 阿拉巴马州</li>
                            <li>IP：12.34.56.78</li>
                            <li>发布时间：2017-06-12 08:51:49</li>
                            <li>Email：timands@gmail.com</li>
                        </ul>
                        We intend to purchase this product, would you please send me quotation and minimum order quanlity?
                    </div>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-offset-1  col-lg-4">
                            <button type="button" class="btn btn-primary">通过</button>
                            <button type="button" class="btn btn-default">拒绝</button>
                        </div>
                    </div>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>