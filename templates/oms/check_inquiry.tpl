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
                <h2>询盘审核</h2>
{include file="oms/common/inquiry_panel.tpl"}
                <form class="form-horizontal" action="?action=check_inquiry" method="POST" id="formCheck">
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="pending_inquiry_id" value="{$pending_inquiry_id}">
                            <input type="hidden" name="submitted" value="1" id="inputSubmit">
                            <button type="button" class="btn btn-primary" id="btnProve">通过</button>
                            <button type="button" class="btn btn-default" id="btnReject">拒绝</button>
                            <a class="btn btn-default" href="?action=reject_pending_inquiries_with&pending_inquiry_id={$pending_inquiry_id}&with=1">按邮箱批量删除</a>
                            <a class="btn btn-default" href="?action=reject_pending_inquiries_with&pending_inquiry_id={$pending_inquiry_id}&with=2">按IP批量删除</a>
                        </div>
                    </div>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
    <script type="text/javascript">{literal}
        $('#btnProve').click(function() {
            $('#inputSubmit').val(1);
            $('#formCheck').submit();
        });
        $('#btnReject').click(function() {
            $('#inputSubmit').val(2);
            $('#formCheck').submit();
        });
    {/literal}</script>
</body>
</html>