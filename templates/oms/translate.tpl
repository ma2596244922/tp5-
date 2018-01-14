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
{include file="oms/common/mainnav.tpl" page_name="translate"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>翻译工具</h2>
                <form class="form-horizontal" action="?action=translate" method="POST">
                    <div class="form-group">
                        <label for="textareaSourceText" class="col-lg-1 control-label">源文本：</label>
                        <div class="col-lg-6">
                            <textarea class="form-control" id="textareaSourceText" name="source_text" rows="30">{$source_text|default:''}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">目标语言：</label>
                        <div class="col-lg-2">
                            <select class="form-control" name="target_language">
                                <option>（请选择）</option>
{foreach $target_languages as $lang}
                                <option value="{$lang.language}"{if $target_language|default:''==$lang.language} selected{/if}>{$lang.name}</option>
{/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaTargetText" class="col-lg-1 control-label">目标文本：</label>
                        <div class="col-lg-6">
                            <textarea class="form-control" id="textareaTargetText" name="target_text" rows="30">{$target_text|default:''}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">翻译</button>
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