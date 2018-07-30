{assign var=page_title value="Banner 管理"-}<!DOCTYPE html>

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
{if $tpl_style|default:'default'=='tight'}
    <div class="container">
{/if}
    <!-- BEGIN CONTAINER -->

    <div class="page-container row-fluid">

        <!-- BEGIN SIDEBAR -->

{include file="admin/common/sidebar.tpl" page_name="banner"}

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

                            {$page_title} <small>上传、管理横幅</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=banner">{$page_title}</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">

                    <div class="span12">

{include file="admin/common/op_alerts.tpl"}

                        <!-- BEGIN GALLERY MANAGER PORTLET-->

                        <div class="portlet box green">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-money"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <!-- BEGIN GALLERY MANAGER PANEL-->

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_banner" class="btn red">

                                        上传Banner <i class="icon-plus"></i>

                                        </a>

                                    </div>

                                </div>

                                <!-- END GALLERY MANAGER PANEL-->

                                <hr class="clearfix" />

                                <!-- BEGIN GALLERY MANAGER LISTING-->

                                <div class="row-fluid">
{foreach $banners as $banner}
                                    <div class="span3">

                                        <div class="item">

                                            <a class="fancybox-button" data-rel="fancybox-button" title="{$banner.desc}" href="{$banner.uri|url:'enterprise_url_photo'}">

                                                <div class="zoom">

                                                    <img src="{$banner.uri|url:'enterprise_url_photo':'':'t'}" alt="{$banner.desc}" />

                                                    <div class="zoom-icon"></div>

                                                </div>

                                            </a>

                                            <div class="details">

                                                <a href="?action=edit_banner&banner_id={$banner.id}" class="icon"><i class="icon-pencil"></i></a>

                                                <a href="?action=delete_banner&banner_id={$banner.id}" class="icon"><i class="icon-remove"></i></a>

                                            </div>

                                        </div>

                                    </div>
{foreachelse}
                                    <div class="span12">

                                        <div>尚未上传Banner</div>

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
{if $tpl_style|default:'default'=='tight'}
    </div>
{/if}
    <!-- BEGIN FOOTER -->

{include file="admin/common/footer.tpl"}

    <!-- END FOOTER -->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

    <!-- BEGIN CORE PLUGINS -->

{include file="admin/common/scripts.tpl"}

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