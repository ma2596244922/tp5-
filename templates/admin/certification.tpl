{assign var=page_title value="我的证书"-}<!DOCTYPE html>

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

    <link href="media/css/jquery.fancybox.css" rel="stylesheet" />

    <link href="media/css/chosen.css" rel="stylesheet" type="text/css"/>

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

{include file="admin/common/sidebar.tpl" page_name="certification"}

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

                            {$page_title} <small>上传、管理证书</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=certification">{$page_title}</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">

                    <div class="span12">

                        <div class="alert alert-error{if !$smarty.get.error_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.error_msg}</span>

                        </div>

                        <div class="alert alert-success{if !$smarty.get.success_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.success_msg}</span>

                        </div>

                        <!-- BEGIN GALLERY MANAGER PORTLET-->

                        <div class="portlet box green">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-legal"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <!-- BEGIN GALLERY MANAGER PANEL-->

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_certification" class="btn red">

                                        上传证书 <i class="icon-plus"></i>

                                        </a>

                                    </div>

                                </div>

                                <!-- END GALLERY MANAGER PANEL-->

                                <hr class="clearfix" />

                                <!-- BEGIN GALLERY MANAGER LISTING-->

                                <div class="row-fluid">
{foreach $certifications as $certification}
                                    <div class="span3">

                                        <div class="item">

                                            <a class="fancybox-button" data-rel="fancybox-button" title="{$certification.standard}" href="{$certification.uri|url:'enterprise_url_photo'}">

                                                <div class="zoom">

                                                    <img src="{$certification.uri|url:'enterprise_url_photo':'':'t'}" alt="{$certification.standard}" />

                                                    <div class="zoom-icon"></div>

                                                </div>

                                            </a>

                                            <div class="details">

                                                <a href="?action=edit_certification&certification_id={$certification.id}" class="icon"><i class="icon-pencil"></i></a>

                                                <a href="?action=delete_certification&certification_id={$certification.id}" class="icon"><i class="icon-remove"></i></a>

                                            </div>

                                        </div>

                                    </div>
{foreachelse}
                                    <div class="span12">

                                        <div>尚未上传证书</div>

                                    </div>
{/foreach}
                                </div>

                                <!-- END GALLERY MANAGER LISTING-->

                            </div>

                        </div>

                        <!-- END GALLERY MANAGER PORTLET-->

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

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script src="media/js/jquery.fancybox.pack.js"></script>   

    <script type="text/javascript" src="media/js/chosen.jquery.min.js"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->

    <script src="media/js/app.js"></script>   

    <script src="media/js/gallery.js"></script>  

    <!-- END PAGE LEVEL SCRIPTS -->

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

           Gallery.init();

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>