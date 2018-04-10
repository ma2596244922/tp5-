{assign var=page_title value="编辑分组"-}<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

{include file="admin/common/definitions.tpl"}

    <!-- BEGIN GLOBAL MANDATORY STYLES -->

{include file="admin/common/styles.tpl"}

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->

    <link rel="stylesheet" href="media/css/DT_bootstrap.css" />

    <!-- END PAGE LEVEL STYLES -->

    <link rel="stylesheet" type="text/css" href="media/css/bootstrap-fileupload.css" />

    <link rel="shortcut icon" href="media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

    <!-- BEGIN HEADER -->

{include file="admin/common/header.tpl"}

    <!-- END HEADER -->

    <!-- BEGIN CONTAINER -->

    <div class="page-container row-fluid">

        <!-- BEGIN SIDEBAR -->

{include file="admin/common/sidebar.tpl" page_name="group"}

        <!-- END SIDEBAR -->

        <!-- BEGIN PAGE -->

        <div class="page-content">

            <!-- BEGIN PAGE CONTAINER-->        

            <div class="container-fluid">

                <!-- BEGIN PAGE HEADER-->

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN PAGE TITLE & BREADCRUMB-->

                        <h3 class="page-title">

                            {$page_title} <small>创建、修改分组信息</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=group">产品分组</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

{include file="admin/common/op_alerts.tpl"}

                        <!-- BEGIN SAMPLE FORM PORTLET-->   

                        <div class="portlet box blue">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-briefcase"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body form">

                                <!-- BEGIN FORM-->

                                <form action="?action=edit_group&group_id={$group_id}" method="POST" enctype="multipart/form-data" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">名称</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="name" value="{$group.name|default:''}" />

                                            <span class="help-inline">请输入英文分组名称</span>

                                        </div>

                                    </div>
{if $user.advanced}
                                    <div class="control-group">

                                        <label class="control-label">页面路径</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="path" value="{$group.path|default:''}" placeholder="/high-speed-doritos-corn-chips-cutting" />

                                            <span class="help-inline">请输入以/开头的页面路径（如：/high-speed-doritos-corn-chips-cutting）</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品URL前缀</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="purl_prefix" value="{$group.purl_prefix|default:''}" placeholder="sell" />

                                            <span class="help-inline">仅可以输入a-z英文字母</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页HTML Title</label>

                                        <div class="controls">

                                            <input type="text" name="html_title" class="m-wrap span6" value="{$group.product_html_title|default:''}" id="input-html-title" />

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-html-title" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-html-title" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-html-title" type="button">公司名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag1]" data-target="#input-html-title" type="button">Tag1</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag2]" data-target="#input-html-title" type="button">Tag2</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag3]" data-target="#input-html-title" type="button">Tag3</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页Meta Keywords</label>

                                        <div class="controls">

                                            <textarea class="span6 m-wrap" name="meta_keywords" id="textarea-meta-keywords" rows="6">{$group.product_meta_keywords|default:''}</textarea>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题], " data-target="#textarea-meta-keywords" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组], " data-target="#textarea-meta-keywords" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称], " data-target="#textarea-meta-keywords" type="button">公司名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag1], " data-target="#textarea-meta-keywords" type="button">Tag1</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag2], " data-target="#textarea-meta-keywords" type="button">Tag2</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag3], " data-target="#textarea-meta-keywords" type="button">Tag3</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页Meta Description</label>

                                        <div class="controls">

                                            <textarea class="span6 m-wrap" name="meta_description" id="textarea-meta-description" rows="6">{$group.product_meta_description|default:''}</textarea>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#textarea-meta-description" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#textarea-meta-description" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#textarea-meta-description" type="button">公司名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag1]" data-target="#textarea-meta-description" type="button">Tag1</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag2]" data-target="#textarea-meta-description" type="button">Tag2</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag3]" data-target="#textarea-meta-description" type="button">Tag3</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页H1：</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="product_give_h1_to" value="0"{if $group.product_give_h1_to|default:'0'=='0'} checked="checked"{/if} />标题

                                            </label>

                                            <label class="radio">

                                                <input type="radio" name="product_give_h1_to" value="1"{if $group.product_give_h1_to|default:'0'=='1'} checked="checked"{/if} />型号

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页视频封面图</label>

                                        <div class="controls">

                                            <div class="fileupload fileupload-{if $group.product_video_cover_uri|default:''}exists{else}new{/if}" data-provides="fileupload">

                                                <input type="hidden" name="product_video_cover_uri" value="{$group.product_video_cover_uri|default:''}">

                                                <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

                                                    <img src="media/image/no_image.png" alt="" />

                                                </div>

                                                <div class="fileupload-preview fileupload-exists thumbnail" style="width: 200px; height: 150px; padding: 4px;">

                                                    <img src="{$group.product_video_cover_uri|default:''|url:'enterprise_url_photo'}" alt="" style="max-height: 150px;" />

                                                </div>

                                                <div>

                                                    <span class="btn btn-file">
                                                        <span class="fileupload-new">选择图片</span>

                                                        <span class="fileupload-exists">更换</span>

                                                        <input type="file" class="default" name="product_video_cover_uri" />
                                                    </span>

                                                    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>

                                                </div>

                                            </div>

                                            <span class="help-block">推荐图片尺寸177x67。</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页视频时长</label>

                                        <div class="controls">

                                            <input type="text" class="span1 m-wrap" name="product_video_duration" value="{$group.product_video_duration|default:''}" />

                                            <span class="help-inline">如：00:13</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">产品页视频地址</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="product_video_uri" value="{$group.product_video_uri|default:''}" />

                                            <span class="help-inline">如：https://www.youtube.com/watch?v=EOIvnRUa3ik</span>

                                        </div>

                                    </div>
{/if}
                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="edit_group">

                                        <button type="submit" class="btn blue">保存</button>

                                        <a href="?action=group" class="btn">取消</a>

                                    </div>

                                </form>

                                <!-- END FORM-->

                            </div>

                        </div>

                        <!-- END SAMPLE FORM PORTLET-->

                    </div>

                </div>

                <!-- END PAGE CONTENT-->

            </div>

            <!-- END PAGE CONTAINER-->

        </div>

        <!-- END PAGE -->

    </div>

    <!-- END CONTAINER -->

    <!-- BEGIN FOOTER -->

{include file="admin/common/footer.tpl"}

    <!-- END FOOTER -->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

    <!-- BEGIN CORE PLUGINS -->

{include file="admin/common/scripts.tpl"}

    <!-- END CORE PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script type="text/javascript" src="media/js/bootstrap-fileupload.js"></script>

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

           $('[data-role="btn-insert-to-desc"]').click(function() {
                var text = $(this).data('text');
                var target = $(this).data('target');
                $(target).insertAtCaret(text);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
