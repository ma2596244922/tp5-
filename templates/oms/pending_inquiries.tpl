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
{include file="oms/common/mainnav.tpl" page_name="pending_inquiries"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>询盘审核</h2>
                <div class="alert alert-warning" role="alert">未被选中的询盘将自动拒绝。</div>
                <form action="?action=approve_inquiries" method="POST">
                    <table class="table table-striped table-bordered table-hover">
                        <tr>
                            <th>
                                <input type="checkbox" id="check-all"/>
                            </th>
                            <th>询盘标题</th>
                            <th>询盘内容</th>
                            <th>询盘时间</th>
                            <th>询盘邮箱</th>
                            <th>域名</th>
                        </tr>
{foreach $pending_inquiries as $i}
                        <tr>
                            <td>
                                <input type="checkbox" name="selected_pending_inquiries[{$i.id}]" value="1" data-role="tr-checkbox"/>
                                <input type="hidden" name="pending_inquiries[]" value="{$i.id}"/>
                            </td>
                            <td>
                                {foreach $i.verifying_tags as $tag}<span class="label label-danger">{$tag}</span>{/foreach}
                                {$i.subject}
                            </td>
                            <td>
                                <a href="?action=check_inquiry&pending_inquiry_id={$i.id}" target="_blank">查看</a>
                            </td>
                            <td>{$i.created}</td>
                            <td>{$i.email}</td>
                            <td>{$i.domain}</td>
                        </tr>
{/foreach}
                    </table>
                    <button class="btn btn-primary" type="submit">通过选中询盘</button>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
{include file="oms/common/filterscripts.tpl"}
    <script type="text/javascript">
        $('#check-all').click(function() {
            $('[data-role="tr-checkbox"]').prop('checked', $(this).prop('checked'));
        })
    </script>
</body>
</html>