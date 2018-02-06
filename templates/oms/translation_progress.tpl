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
{include file="oms/common/sitenav.tpl" page_name="translation_progress"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>翻译进度</h2>
                <a class="btn btn-primary" href="javascript:void(0);" data-role="stop-translation" data-redirect-url="?action=stop_translation&site_id={$smarty.get.site_id}">全部停止</a>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>语种</th>
                        <th>进度</th>
                        <th>&nbsp;</th>
                    </tr>
{foreach $translation_progresses as $tp}
                    <tr>
                        <td>{$tp@iteration}</td>
                        <td>{$tp.lang_code}</td>
                        <td>{$tp.status|call:'\oms\daos\TranslationProgress::status2Text'}</td>
                        <td>
                            <a href="javascript:void(0);" data-role="stop-translation" data-redirect-url="?action=stop_translation&site_id={$smarty.get.site_id}&lang_code={$tp.lang_code}">停止翻译</a>
                        </td>
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
        $('[data-role="stop-translation"]').click(function() {
            if (!confirm('确认停止吗？此操作不可逆。'))
                return;

            var redirectUrl = $(this).attr('data-redirect-url');
            location.href = redirectUrl;
        })
    </script>
</body>
</html>