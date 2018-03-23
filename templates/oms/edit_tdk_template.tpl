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
{include file="oms/common/mainnav.tpl" page_name="tdk_template"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>{if $tdk_template|default:[]}修改{else}录入新{/if}模板</h2>
                <form class="form-horizontal" action="?action=edit_tdk_template&tdk_template_id={$tdk_template_id}" method="POST">
                    <div class="form-group">
                        <label for="input-html-title" class="col-lg-1 control-label">HTML Title：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="input-html-title" name="html_title" value="{$tdk_template.html_title|default:''}">
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[产品标题]" data-target="#input-html-title" type="button">产品标题</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[产品分组]" data-target="#input-html-title" type="button">产品分组</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[公司名称]" data-target="#input-html-title" type="button">公司名称</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag1]" data-target="#input-html-title" type="button">Tag1</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag2]" data-target="#input-html-title" type="button">Tag2</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag3]" data-target="#input-html-title" type="button">Tag3</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input-meta-keywords" class="col-lg-1 control-label">Meta Keywords：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textarea-meta-keywords" name="meta_keywords" rows="15">{$tdk_template.meta_description|default:''}</textarea>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[产品标题], " data-target="#textarea-meta-keywords" type="button">产品标题</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[产品分组], " data-target="#textarea-meta-keywords" type="button">产品分组</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[公司名称], " data-target="#textarea-meta-keywords" type="button">公司名称</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag1], " data-target="#textarea-meta-keywords" type="button">Tag1</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag2], " data-target="#textarea-meta-keywords" type="button">Tag2</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag3], " data-target="#textarea-meta-keywords" type="button">Tag3</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textarea-meta-description" class="col-lg-1 control-label">Meta Description：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textarea-meta-description" name="meta_description" rows="15">{$tdk_template.meta_description|default:''}</textarea>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[产品标题]" data-target="#textarea-meta-description" type="button">产品标题</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[产品分组]" data-target="#textarea-meta-description" type="button">产品分组</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[公司名称]" data-target="#textarea-meta-description" type="button">公司名称</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag1]" data-target="#textarea-meta-description" type="button">Tag1</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag2]" data-target="#textarea-meta-description" type="button">Tag2</button>
                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[Tag3]" data-target="#textarea-meta-description" type="button">Tag3</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=tdk_template';">返回</button>
                        </div>
                    </div>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
    <script type="text/javascript" src="/media/js/jquery-insertAtCaret.js"></script>
    <script type="text/javascript">
        $('[data-role="btn-insert-to-control"]').click(function() {
            var text = $(this).data('text');
            var target = $(this).data('target');
            $(target).insertAtCaret(text);
        });
    </script>
</body>
</html>