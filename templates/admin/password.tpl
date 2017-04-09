{assign var=page_title value="修改密码"-}<!DOCTYPE html>

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

    <link href="media/css/bootstrap-fileupload.css" rel="stylesheet" type="text/css" />

    <link href="media/css/chosen.css" rel="stylesheet" type="text/css" />

    <link href="media/css/profile.css" rel="stylesheet" type="text/css" />

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

{include file="admin/common/sidebar.tpl"}

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

                            用户资料 <small>管理我的资料</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=profile">用户资料</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid profile">

                    <div class="span12">

{include file="admin/common/op_alerts.tpl"}

                        <!--BEGIN TABS-->

                        <div class="tabbable tabbable-custom tabbable-full-width">

                            <ul class="nav nav-tabs">

                                <li class="active"><a href="#tab_1_3" data-toggle="tab">用户帐户</a></li>

                            </ul>

                            <div class="tab-content">

                                <div class="tab-pane row-fluid profile-account active" id="tab_1_3">

                                    <div class="row-fluid">

                                        <div class="span12">

                                            <div class="span3">

{include file="admin/common/profile_l2menu.tpl" profile_page_name="password"}

                                            </div>

                                            <div class="span9">

                                                <div class="tab-content">

                                                    <div id="tab_3-3" class="tab-pane active">

                                                        <div style="height: auto;" id="accordion3-3" class="accordion collapse">

                                                            <form action="?action=password" method="POST">

                                                                <label class="control-label">当前密码</label>

                                                                <input type="password" name="old_password" class="m-wrap span8" />

                                                                <label class="control-label">新密码</label>

                                                                <input type="password" name="new_password" class="m-wrap span8" />

                                                                <label class="control-label">再次输入</label>

                                                                <input type="password" name="new_password_2" class="m-wrap span8" />

                                                                <div class="submit-btn">

                                                                    <input type="hidden" name="submit" value="update">

                                                                    <button class="btn green" type="submit">更新</button>

                                                                </div>

                                                            </form>

                                                        </div>

                                                    </div>

                                                </div>

                                            </div>

                                            <!--end span9-->                                   

                                        </div>

                                    </div>

                                </div>

                                <!--end tab-pane-->

                            </div>

                        </div>

                        <!--END TABS-->

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

    <script type="text/javascript" src="media/js/chosen.jquery.min.js"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->

    <script src="media/js/app.js"></script>      

    <!-- END PAGE LEVEL SCRIPTS -->

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>