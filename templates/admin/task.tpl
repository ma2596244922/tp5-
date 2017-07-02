{assign var=page_title value="我的任务"-}<!DOCTYPE html>

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

    <!-- BEGIN CONTAINER -->

    <div class="page-container row-fluid">

        <!-- BEGIN SIDEBAR -->

{include file="admin/common/sidebar.tpl" page_name="task"}

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

                            {$page_title} <small>抓取任务汇总</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=task">{$page_title}</a></li>

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

                                <div class="caption"><i class="icon-tasks"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_task" class="btn red">

                                        创建新任务 <i class="icon-plus"></i>

                                        </a>

                                    </div>

                                </div>

                                <table class="table table-striped table-condensed table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>目标分组</th>

                                            <th>目标URL</th>

                                            <th>创建时间(+8)</th>

                                            <th>最后修改时间(+8)</th>

                                            <th>状态</th>

                                            <th>类型</th>

                                            <th>&nbsp;</th>

                                        </tr>

                                    </thead>

                                    <tbody>
{section name=i loop=$tasks}
                                        <tr>

                                            <td>{$tasks[i].id}</td>

                                            <td>{$tasks[i].group_name}</td>

                                            <td>{$tasks[i].target_url}</td>

                                            <td>{$tasks[i].created}</td>

                                            <td>{$tasks[i].updated}</td>

                                            <td>{$tasks[i].status|call:'\blowjob\daos\Task::status2Text'}</td>

                                            <td>{$tasks[i].type|call:'\blowjob\daos\Task::type2Text'}</td>

                                            <td>
    {if !$tasks[i].type}
                                                <a href="?action=edit_task&task_id={$tasks[i].id}">修改</a>
    {/if}
                                                <a href="javascript:void(0);" data-role="btn-delete" data-href="?action=delete_task&task_id={$tasks[i].id}">删除</a>

                                            </td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="7">暂无任何任务</td>

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
