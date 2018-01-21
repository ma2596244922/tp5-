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
                <h2>VPS状态</h2>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>别名</th>
                        <th>IP</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $vpss as $i}
                    <tr data-role="vps" data-config="{$i.ip_addr|escape}">
                        <td>{$i.id}</td>
                        <td>{$i.alias|escape}</td>
                        <td>{$i.ip_addr|escape}</td>
                        <td data-role="vps-status-text">
                            Checking ...
                        </td>
                    </tr>
{/foreach}
                </table>

                <h2>磁盘空间</h2>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>总空间</th>
                        <th>剩余空间</th>
                    </tr>
                    <tr>
                        <td>{$disk_total_space|size_format}</td>
                        <td>{$disk_free_space|size_format}</td>
                    </tr>
                </table>

                <h2>环境监测</h2>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>jpeg</th>
                        <td>{$imagecreatefromjpeg}</td>
                    </tr>
                </table>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
    <script type="text/javascript">
        $('[data-role="vps"]').each(function() {
            var addr = $(this).data('config');
            var url = '?action=vps_health&addr=' + encodeURIComponent(addr);
            var me = this;
            $.get(url, function(response) {
                    $(me).find('[data-role="vps-status-text"]').text(response);
                });
        });
    </script>
</body>
</html>