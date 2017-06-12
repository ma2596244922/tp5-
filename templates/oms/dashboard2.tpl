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

                <h2>录入新行业</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputName" class="col-lg-1 control-label">名称：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputName" placeholder="Foos &amp; Bars">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default">返回</button>
                        </div>
                    </div>
                </form>

                <h2>VPS管理</h2>
                <button class="btn btn-default" type="button">录入新VPS</button>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>别名</th>
                        <th>IP</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>web2</td>
                        <td>12.34.56.78</td>
                        <td>
                            <a href="#">修改</a>
                        </td>
                    </tr>
                </table>

                <h2>录入新VPS</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputAlias" class="col-lg-1 control-label">别名：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputAlias" placeholder="web2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddr" class="col-lg-1 control-label">IP：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputAddr" placeholder="12.34.56.78">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default">返回</button>
                        </div>
                    </div>
                </form>

                <h2>帐号管理</h2>
                <button class="btn btn-default" type="button">录入新帐号</button>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>用户名</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>foo</td>
                        <td>
                            <a href="#">修改</a>
                        </td>
                    </tr>
                </table>

                <h2>录入新帐号</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputUser" class="col-lg-1 control-label">用户名：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputUser" placeholder="foo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputUser" class="col-lg-1 control-label">用户名：</label>
                        <div class="col-lg-4">
                           <p class="form-control-static">foo</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-lg-1 control-label">密码：</label>
                        <div class="col-lg-4">
                            <input type="password" class="form-control" id="inputPassword" placeholder="为空则不作修改">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default">返回</button>
                        </div>
                    </div>
                </form>

                <h2>客户资料</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-1 control-label">域名：</label>
                        <div class="col-lg-4">
                           <p class="form-control-static">popost.com</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputMemo" class="col-lg-1 control-label">备注：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputMemo" placeholder="某某公司">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputQQ" class="col-lg-1 control-label">QQ：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputQQ" placeholder="123456">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputWechat" class="col-lg-1 control-label">微信：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputWechat" placeholder="foo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-lg-1 control-label">姓名：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputName" placeholder="张三">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTelephone" class="col-lg-1 control-label">电话：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputTelephone" placeholder="13800138000">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">性别：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" value="0" checked>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" value="1">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">询盘审核：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" value="0" checked>关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" value="1">开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">VPS：</label>
                        <div class="col-lg-4">
                            <select class="form-control">
                                <option>（待分配）</option>
                                <option>web2（12.34.56.78）</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">移动版：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" value="0">关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" value="1" checked>开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">上/下线：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" value="0">下线
                            </label>
                            <label class="radio-inline">
                                <input type="radio" value="1" checked>上线
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaCSR" class="col-lg-1 control-label">CSR：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textareaCSR" rows="15"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaKey" class="col-lg-1 control-label">Key：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textareaKey" rows="15"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">HTTPS：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" value="0" checked>关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" value="1">开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default">返回</button>
                        </div>
                    </div>
                </form>

                <h2>月度报告</h2>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>月度报告</th>
                        <th>询盘量</th>
                        <th>邮箱数</th>
                    </tr>
                    <tr>
                        <td>2017年4月月报</td>
                        <td>123</td>
                        <td>11</td>
                    </tr>
                </table>

                <h2>匹配询盘</h2>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-1 control-label">域名：</label>
                        <div class="col-lg-4">
                           <p class="form-control-static">popost.com</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCaption" class="col-lg-1 control-label">标题：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputCaption" placeholder="Inquiry about ...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaContent" class="col-lg-1 control-label">正文：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textareaContent" rows="15"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-lg-1 control-label">Email：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputEmail" placeholder="foo@bar.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddr" class="col-lg-1 control-label">IP：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputAddr" placeholder="12.34.56.78">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputDateTime" class="col-lg-1 control-label">时间：</label>
                        <div class="col-lg-4">
                            <input type="datetime-local" class="form-control" id="inputDateTime" placeholder="2017-06-12 17:24:59">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputUrl" class="col-lg-1 control-label">相关URL：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputUrl" placeholder="http://">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">附件：</label>
                        <div class="col-lg-4">
                            <input type="file">
                            <input type="file">
                            <input type="file">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <button type="submit" class="btn btn-primary">匹配</button>
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