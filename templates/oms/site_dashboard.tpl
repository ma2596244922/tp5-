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
                <h2>DNS解析</h2>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>语种</th>
                        <th>域名</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                    <tr data-role="lang-site" data-domain="{$lc}.{$site_mappings[0].domain}">
                        <td>{$meta.label}</td>
                        <td>{$lc}.{$site_mappings[0].domain}</td>
                        <td data-role="lang-site-dns-status">Checking ...</td>
                    </tr>
{/foreach}
                </table>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
    <script type="text/javascript">
        $('[data-role="lang-site"]').each(function() {
            var domain = $(this).data('domain');
            var url = '?action=lang_site_dns_check&domain=' + encodeURIComponent(domain);
            var me = this;
            $.get(url, function(response) {
                    $(me).find('[data-role="lang-site-dns-status"]').text(response);
                });
        });
    </script>
</body>
</html>