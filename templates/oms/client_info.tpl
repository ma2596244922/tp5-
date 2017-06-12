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
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>