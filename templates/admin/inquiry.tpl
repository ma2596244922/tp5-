{assign var=page_title value="我的询盘"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="inquiry"}

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

                            {$page_title} <small>询盘汇总</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=inquiry">{$page_title}</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

{include file="admin/common/op_alerts.tpl"}

                        <!-- BEGIN CONDENSED TABLE PORTLET-->

                        <div class="portlet box green">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-envelope"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>标题</th>

                                            <th>Email</th>

                                            <th>发布时间(+8)</th>

                                            <th>&nbsp;</th>

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

                                            <td>{$inquiries[i].created}</td>

                                            <td>
    {-if $inquiries[i].target_product_id}
                                                <a href="?action=edit_comment&source_inquiry_id={$inquiries[i].id}">转留言</a>
    {-/if}
                                                <a href="javascript:void(0);" data-role="btn-delete" data-href="?action=delete_inquiry&inquiry_id={$inquiries[i].id}">删除</a>

                                            </td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="5">暂无任何询盘</td>

                                        </tr>
{/section}
                                    </tbody>

                                </table>
{if $total_inquiries > $page_size}
                                <div class="row-fluid">

                                    <div class="span12">

                                        <div class="dataTables_paginate pagination">

                                            <ul>
    {if $page_no > 1}
                                                <li><a href="?action=inquiry&page={$page_no-1}">«</a></li>
    {/if}
    {for $i=1 to $total_pages}
                                                <li><a href="?action=inquiry&page={$i}">{$i}</a></li>
    {/for}
    {if $page_no < $total_pages}
                                                <li><a href="?action=inquiry&page={$page_no+1}">»</a></li>
    {/if}
                                            </ul>

                                        </div>

                                    </div>

                                </div>
{/if}
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
