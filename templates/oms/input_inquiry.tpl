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
                <h2>匹配询盘</h2>
                <form class="form-horizontal" action="?action=input_inquiry&site_id={$smarty.get.site_id}" method="POST">
                    <div class="form-group">
                        <label class="col-lg-1 control-label">域名：</label>
                        <div class="col-lg-4">
                           <p class="form-control-static">{$site_mappings[0].domain}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCaption" class="col-lg-1 control-label">标题：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputCaption" name="subject" placeholder="Inquiry about ...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaContent" class="col-lg-1 control-label">正文：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textareaContent" name="message" rows="15"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-lg-1 control-label">Email：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputEmail" name="email" placeholder="foo@bar.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddr" class="col-lg-1 control-label">IP：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputAddr" name="ip_addr" placeholder="12.34.56.78">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputDateTime" class="col-lg-1 control-label">时间：</label>
                        <div class="col-lg-4">
                            <input type="datetime-local" class="form-control" id="inputDateTime" name="created" placeholder="2017-06-12 17:24:59">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputUrl" class="col-lg-1 control-label">相关URL：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputUrl" name="related_url" placeholder="http://">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">附件：</label>
                        <div class="col-lg-4">
                            <input type="file" name="file1">
                            <input type="file" name="file2">
                            <input type="file" name="file3">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="message_type" value="text/plain" />
                            <button type="submit" class="btn btn-primary">匹配</button>
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