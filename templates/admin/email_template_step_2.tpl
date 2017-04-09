{assign var=page_title value="EDM邮件模板"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="email_template"}

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

                            {$page_title} <small>创建个性的邮件模板</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=email_template">EDM邮件模板</a></li>

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

                                <form action="?action=email_template&step=3" method="POST" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">模板</label>

                                        <div class="controls">

                                            <textarea class="span12 m-wrap" name="message" id="textarea-content" rows="25">{$content|default:''}</textarea>

                                        </div>

                                    </div>

                                    <div class="form-actions">
{if $user.email}
                                        <button type="submit" class="btn blue">发送邮件到我的邮箱</button>
{else}
                                        未设置邮箱，无法发送
{/if}
                                        <a class="btn" href="javascript:void();" onclick="history.go(-1);">返回</a>

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

    <script src="ckeditor/ckeditor.js" type="text/javascript" ></script>

    <script src="ckeditor/adapters/jquery.js" type="text/javascript" ></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

           $('#textarea-content').ckeditor({
                height: '500px',
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
