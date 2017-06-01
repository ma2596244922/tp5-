{assign var=page_title value="产品默认图片"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="product_default_image"}

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

{include file="admin/common/profile_l2menu.tpl" profile_page_name="product_default_image"}

                                            </div>

                                            <div class="span9">

                                                <div class="tab-content">

                                                    <div id="tab_2-2" class="tab-pane active">

                                                        <div style="height: auto;" id="accordion2-2" class="accordion collapse">

                                                            <form action="?action=product_default_image" method="POST" enctype="multipart/form-data">

                                                                <p>上传、修改产品默认图片。</p>

                                                                <br />

                                                                <div class="controls">

                                                                    <div class="thumbnail" style="width: 600px; height: 600px;">

                                                                        <img src="{$site.product_default_image|default:''|url:'enterprise_url_image'}" alt="" width="220" height="60" style="width: 600px; height: 600px;" />

                                                                    </div>

                                                                </div>

                                                                <div class="space10"></div>

                                                                <div class="fileupload fileupload-{if $site.product_default_image|default:''}exists{else}new{/if}" data-provides="fileupload">

                                                                    <input type="hidden" name="product_default_image" value="{$site.product_default_image|default:''}">

                                                                    <div class="input-append">

                                                                        <div class="uneditable-input">

                                                                            <i class="icon-file fileupload-exists"></i> 

                                                                            <span class="fileupload-preview">{if $site.product_default_image|default:''}{$site.product_default_image}.jpg{/if}</span>

                                                                        </div>

                                                                        <span class="btn btn-file">

                                                                        <span class="fileupload-new">Select file</span>

                                                                        <span class="fileupload-exists">Change</span>

                                                                        <input type="file" class="default" name="product_default_image" />

                                                                        </span>

                                                                        <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">Remove</a>

                                                                    </div>

                                                                </div>

                                                                <div class="clearfix"></div>

                                                                <div class="controls">

                                                                    <span class="label label-important">注意!</span>

                                                                    <span>推荐尺寸图片大小600x600。</span>

                                                                </div>

                                                                <div class="space10"></div>

                                                                <div class="submit-btn">

                                                                    <input type="hidden" name="submit" value="product_default_image">

                                                                    <button type="submit" class="btn green">保存</button>

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

    <script>

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

        });

    </script>

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>