{assign var=page_title value="编辑联系人"-}<!DOCTYPE html>

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

    <link href="media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/style-metro.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/style.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

    <link href="media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->

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

{include file="admin/common/sidebar.tpl" page_name="contact"}

        <!-- END SIDEBAR -->

        <!-- BEGIN PAGE -->

        <div class="page-content">

            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <div id="portlet-config" class="modal hide">

                <div class="modal-header">

                    <button data-dismiss="modal" class="close" type="button"></button>

                    <h3>portlet Settings</h3>

                </div>

                <div class="modal-body">

                    <p>Here will be a configuration form</p>

                </div>

            </div>

            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <!-- BEGIN PAGE CONTAINER-->        

            <div class="container-fluid">

                <!-- BEGIN PAGE HEADER-->

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN PAGE TITLE & BREADCRUMB-->

                        <h3 class="page-title">

                            {$page_title} <small>创建、修改联系人信息</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=contact">管理联系人</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

                        <div class="alert alert-error{if !$error_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$error_msg}</span>

                        </div>

                        <div class="alert alert-success{if !$success_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$success_msg}</span>

                        </div>

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

                                <form action="?action=edit_contact&contact_id={$contact_id}" method="POST" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">姓名</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="name" value="{$contact.name|default:''}" />

                                            <span class="help-inline">请输入联系人姓名</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">职务</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="title" value="{$contact.title|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">电话</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="tel" value="{$contact.tel|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Skype</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="skype" value="{$contact.skype|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Email</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="email" value="{$contact.email|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Yahoo</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="yahoo" value="{$contact.yahoo|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">ICQ</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="icq" value="{$contact.icq|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Viber</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="viber" value="{$contact.viber|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">WhatsApp</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="whatsapp" value="{$contact.whatsapp|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="edit_contact">

                                        <button type="submit" class="btn blue">保存</button>

                                        <a href="?action=contact" class="btn">取消</a>

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

    <script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

    <script src="media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

    <script src="media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

    <script src="media/js/bootstrap.min.js" type="text/javascript"></script>

    <!--[if lt IE 9]>

    <script src="media/js/excanvas.min.js"></script>

    <script src="media/js/respond.min.js"></script>  

    <![endif]-->   

    <script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>  

    <script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.uniform.min.js" type="text/javascript" ></script>

    <!-- END CORE PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
