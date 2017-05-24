{assign var=page_title value="{$error_msg|default:''}{$success_msg|default:''}"-}<!DOCTYPE html>

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

    <link href="media/css/error.css" rel="stylesheet" type="text/css"/>

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

        <div class="page-sidebar nav-collapse collapse">

            <!-- BEGIN SIDEBAR MENU -->        

{include file="admin/common/sidebar.tpl" page_name=""}

            <!-- END SIDEBAR MENU -->

        </div>

        <!-- END SIDEBAR -->

        <!-- BEGIN PAGE -->

        <div class="page-content">

            <div class="container-fluid">

                <!-- BEGIN PAGE HEADER-->

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN PAGE TITLE & BREADCRUMB-->

                        <h3 class="page-title">

                            信息提示 <small>信息提示</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>


                            <li>信息提示</li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN INLINE NOTIFICATIONS PORTLET-->

                        <div class="portlet box blue">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-cogs"></i>信息提示</div>

                            </div>

                            <div class="portlet-body">
{if $error_msg|default:''}
                                <div class="alert alert-block alert-error fade in">

                                    <button type="button" class="close" data-dismiss="alert"></button>

                                    <h4 class="alert-heading">错误!</h4>

                                    <p>

                                        {$error_msg}

                                    </p>

                                    <p>

                                        <a class="btn red" href="javascript:void(0);" onclick="history.go(-1);">返回修改</a>

                                    </p>

                                </div>
{/if}
{if $success_msg|default:''}
                                <div class="alert alert-block alert-success fade in">

                                    <button type="button" class="close" data-dismiss="alert"></button>

                                    <h4 class="alert-heading">成功!</h4>

                                    <p>

                                        {$success_msg}

                                    </p>
    {-if $forward|default:[]}
                                    <p>

                                        <a class="btn green" href="{$forward.url}" data-role="btn-delay-forward">{$forward.text}</a>

                                    </p>
    {-/if}
                                </div>
{/if}
                            </div>

                        </div>

                        <!-- END INLINE NOTIFICATIONS PORTLET-->

                    </div>

                </div>

                <!-- END PAGE CONTENT-->

            </div>

            <!-- END PAGE CONTAINER-->       

        </div>

        <!-- BEGIN PAGE -->     

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

    <script>{literal}

        jQuery(document).ready(function() {    

           App.init();

           setTimeout(function() {
                var forward = $('[data-role="btn-delay-forward"]').attr('href');
                if (typeof(forward) != 'undefined')
                    location.href = forward;
           }, 3000);

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>