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
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>