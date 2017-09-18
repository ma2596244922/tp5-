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
{include file="oms/common/mainnav.tpl" page_name="task"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>{if $task|default:[]}修改{else}录入新{/if}任务</h2>
                <form class="form-horizontal" action="?action=edit_task&task_id={$task_id}" method="POST">
                    <div class="form-group">
                        <label for="inputSourceGroupID" class="col-lg-1 control-label">源分组ID：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputSourceGroupID" name="source_group_id" value="{$task_details.source_group_id|default:''}" placeholder="123">
                        </div>
                        <span class="help-inline">可以使用英文半角逗号“,”分隔多个ID。</span>
                    </div>
                    <div class="form-group">
                        <label for="selectSourceLangCode" class="col-lg-1 control-label">源分组语种：</label>
                        <div class="col-lg-4">
                            <select class="form-control" name="source_lang_code" id="selectSourceLangCode">
                                <option value="">（请选择）</option>
                                <option value="en"{if $task_details.source_lang_code|default:''=='en'} selected{/if}>英语</option>
{foreach $supported_lang_codes as $lc => $meta}
                                <option value="{$lc}"{if $task_details.source_lang_code|default:''==$lc} selected{/if}>{$meta.label}</option>
{/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">目标：</label>
                        <div class="col-lg-4">
                            <label class="radio">
                                <input type="radio" name="target_type" value="10"{if $task_details.target_type|default:'10'=='10'} checked{/if} data-role="target-type">目标分组ID
                                <input type="text" class="form-control" id="inputTargetGroupID" name="target_group_id" value="{$task_details.target_group_id|default:''}" placeholder="123">
                            </label>
                            <label class="radio">
                                <input type="radio" name="target_type" value="20"{if $task_details.target_type|default:'10'=='20'} checked{/if} data-role="target-type">目标站ID
                                <input type="text" class="form-control" id="inputTargetSiteID" name="target_site_id" value="{$task_details.target_site_id|default:''}" placeholder="123{if !$task|default:[]},456,...{/if}">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="selectTargetLangCode" class="col-lg-1 control-label">目标分组语种：</label>
                        <div class="col-lg-4">
                            <select class="form-control" name="target_lang_code" id="selectTargetLangCode">
                                <option value="">（请选择）</option>
                                <option value="en"{if $task_details.target_lang_code|default:''=='en'} selected{/if}>英语</option>
{foreach $supported_lang_codes as $lc => $meta}
                                <option value="{$lc}"{if $task_details.target_lang_code|default:''==$lc} selected{/if}>{$meta.label}</option>
{/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputDelayUntil" class="col-lg-1 control-label">定时：</label>
                        <div class="col-lg-4">
                            <input type="datetime-local" class="form-control" id="inputDelayUntil" name="delay_until" placeholder="2017-06-12 17:24:59">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">变更产品URL：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="update_purl_prefix" value="1"{if $task_details.update_purl_prefix|default:'1'=='1'} checked{/if}>变更为happy-*
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="update_purl_prefix" value="0"{if $task_details.update_purl_prefix|default:'1'=='0'} checked{/if}>保持不变
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=task';">返回</button>
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
        var renderTargetControls = function(targetType) {
            switch (targetType) {
                case '10':
                    $('#inputTargetGroupID').prop('disabled', false);
                    $('#inputTargetSiteID').prop('disabled', true);
                    break;
                case '20':
                    $('#inputTargetGroupID').prop('disabled', true);
                    $('#inputTargetSiteID').prop('disabled', false);
                    break;
            }
        };
        $('[data-role="target-type"]').click(function() {
            renderTargetControls($(this).val());
        });
        $(function() {
            $('[name="target_type"]').each(function() {
                if ($(this).prop('checked'))
                    renderTargetControls($(this).val());
            });
        });
    </script>{/literal}
</body>
</html>