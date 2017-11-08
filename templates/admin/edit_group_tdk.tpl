{assign var=page_title value="修改分组TDK"}<!DOCTYPE html>

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

    <link rel="stylesheet" type="text/css" href="media/css/select2_metro.css" />

    <link rel="stylesheet" type="text/css" href="media/css/bootstrap-fileupload.css" />

    <link rel="stylesheet" href="media/css/DT_bootstrap.css" />

    <!-- END PAGE LEVEL STYLES -->

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

                            {$page_title} <small>发布、修改分组信息</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=group">分组管理</a></li>

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

                                <div class="caption"><i class="icon-reorder"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body form">

                                <!-- BEGIN FORM-->

                                <form action="?action=edit_group_tdk&group_id={$group_id}" method="POST" class="form-horizontal" id="form-edit-group">

                                    <div class="control-group">

                                        <label class="control-label">HTML Title</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="html_title" value="{$title}" />

                                            <span class="help-inline">网页标题</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Meta Keywords</label>

                                        <div class="controls">

                                            <input type="text" class="span8 m-wrap" id="input-meta-keywords" name="meta_keywords" value="{$keywords}" />

                                            <span class="help-inline">网页关键词</span>

                                            <div class="space10"></div>

                                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[公司名称]" data-target="#input-meta-keywords" type="button">公司名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[分组名称]" data-target="#input-meta-keywords" type="button">分组名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[分页信息]" data-target="#input-meta-keywords" type="button">分页信息</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Meta Description</label>

                                        <div class="controls">

                                            <textarea class="span12 m-wrap" id="textarea-meta-description" name="meta_description" rows="6">{$description}</textarea>

                                            <span class="help-inline">网页描述。多余的回车符号会被自动清除。</span>

                                            <div class="space10"></div>

                                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[公司名称]" data-target="#textarea-meta-description" type="button">公司名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[分组名称]" data-target="#textarea-meta-description" type="button">分组名称</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-control" data-text="[分页信息]" data-target="#textarea-meta-description" type="button">分页信息</button>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="edit_group_tdk">

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

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script type="text/javascript" src="media/js/bootstrap-fileupload.js"></script>

    <script type="text/javascript" src="media/js/select2.min.js"></script>

    <script type="text/javascript" src="media/js/jquery.dataTables.js"></script>

    <script type="text/javascript" src="media/js/DT_bootstrap.js"></script>

    <script src="ckeditor/ckeditor.js" type="text/javascript" ></script>

    <script src="ckeditor/adapters/jquery.js" type="text/javascript" ></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script src="media/js/table-editable.js"></script>    

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

           $('[data-role="btn-insert-to-control"]').click(function() {
                var text = $(this).data('text');
                var target = $(this).data('target');
                $(target).insertAtCaret(text);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>