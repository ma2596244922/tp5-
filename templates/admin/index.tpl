{assign var=page_title value="主面板"-}<!DOCTYPE html>

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

    <link rel="shortcut icon" href="media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed page-boxed">

    <!-- BEGIN HEADER -->

{include file="admin/common/header.tpl"}

    <!-- END HEADER -->
{if $tpl_style|default:'default'=='tight'}
    <div class="container">
{/if}
    <!-- BEGIN CONTAINER -->

    <div class="page-container row-fluid">

        <!-- BEGIN SIDEBAR -->

{include file="admin/common/sidebar.tpl" page_name="dashboard"}

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

                            {$page_title} <small>信息汇总</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="/admin/">{$page_title}</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                    <!-- BEGIN DASHBOARD STATS -->

                    <div class="row-fluid">

                        <div class="span3 responsive" data-tablet="span6" data-desktop="span3">

                            <div class="dashboard-stat blue">

                                <div class="visual">

                                    <i class="icon-signin"></i>

                                </div>

                                <div class="details">

                                    <div class="number">{$pv}</div>

                                    <div class="desc">昨日PV</div>

                                </div>

                            </div>

                        </div>

                        <div class="span3 responsive" data-tablet="span6" data-desktop="span3">

                            <div class="dashboard-stat green">

                                <div class="visual">

                                    <i class="icon-user"></i>

                                </div>

                                <div class="details">

                                    <div class="number">{$uv}</div>

                                    <div class="desc">昨日UV</div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- END DASHBOARD STATS -->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN CONDENSED TABLE PORTLET-->

                        <div class="portlet box green">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-envelope"></i>近期询盘</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <table class="table table-condensed table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>标题</th>

                                            <th>邮箱</th>

                                            <th>国家</th>

                                            <th>发布时间(+8)</th>

                                        </tr>

                                    </thead>

                                    <tbody>

{section name=i loop=$inquiries}
                                        <tr>

                                            <td>{$inquiries[i].id}</td>

                                            <td>

                                                <a href="?action=inquiry_detail&inquiry_id={$inquiries[i].id}">{$inquiries[i].subject}</a>

                                            </td>

                                            <td>{$inquiries[i].email}</td>

                                            <td>{$inquiries[i].country}</td>

                                            <td>{$inquiries[i].created}</td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="4">暂无任何询盘</td>

                                        </tr>
{/section}

                                    </tbody>

                                </table>

                            </div>

                        </div>

                        <!-- END CONDENSED TABLE PORTLET-->

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