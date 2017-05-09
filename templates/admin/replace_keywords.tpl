{assign var=page_title value="批量替换关键词"}<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

    <meta charset="utf-8" />

    <title>{$page_title}</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <meta content="" name="description" />

    <meta content="" name="author" />

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

{include file="admin/common/sidebar.tpl" page_name="product"}

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

                            {$page_title} <small>发布、修改产品信息</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=product">产品管理</a></li>

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

                                <form action="?action=replace_keywords" method="POST" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">原关键词</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="old_phrase" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">新关键词</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="new_phrase" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">分组</label>

                                        <div class="controls">

                                            <select class="span6 m-wrap" multiple="multiple" name="group_id" data-placeholder="请选择产品分组" tabindex="1">
{section name=i loop=$groups}
                                                <option value="{$groups[i].id}">{$groups[i].name}</option>
{/section}
                                            </select>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="replace_keywords">

                                        <button type="submit" class="btn blue">强势替换</button>

                                        <a href="?action=product" class="btn">取消</a>

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

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
