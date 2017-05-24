{assign var=page_title value="用户赠言"}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="user_voice"}

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

                            {$page_title} <small>管理首页用户赠言</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=user_voice">{$page_title}</a>

                                <i class="icon-angle-right"></i>

                            </li>

                            <li>用户赠言</li>

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

                                <div class="caption"><i class="icon-comments"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_user_voice" class="btn red">

                                            录入赠言 <i class="icon-plus"></i>

                                        </a>

                                    </div>

                                </div>

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>称谓</th>

                                            <th>创建时间(+8)</th>

                                            <th>最后修改时间(+8)</th>

                                            <th>&nbsp;</th>

                                        </tr>

                                    </thead>

                                    <tbody>
{section name=i loop=$user_voices}
                                        <tr>

                                            <td>{$user_voices[i].id}</td>

                                            <td>

                                                {$user_voices[i].title}

                                            </td>

                                            <td>{$user_voices[i].created}</td>

                                            <td>{$user_voices[i].updated}</td>

                                            <td>

                                                <a href="?action=edit_user_voice&user_voice_id={$user_voices[i].id}">修改</a>

                                                <a href="javascript:void(0);" data-role="btn-delete" data-href="?action=delete_user_voice&user_voice_id={$user_voices[i].id}">删除</a>

                                            </td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="5">暂无任何用户赠言</td>

                                        </tr>
{/section}
                                    </tbody>

                                </table>

                                <div class="row-fluid">

                                    <div class="span6">

                                        <div class="dataTables_info" id="sample_1_info">共有{$total_user_voice}条赠言。当前展示{$page_no}/{$pager_info['pages']}页</div>

                                    </div>

                                    <div class="span6">

                                        <div class="dataTables_paginate paging_bootstrap pagination">

                                            <ul>
{-if isset($pager_info['prev_page'])}
                                                <li class="prev"><a href="?action=user_voice&page={$pager_info['prev_page']}">← <span class="hidden-480">Prev</span></a></li>
{-/if}
{-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                                                <li{if $i==$page_no} class="active"{/if}><a href="?action=user_voice&page={$i}">{$i}</a></li>
{-/for}
{-if isset($pager_info['next_page'])}
                                                <li class="next"><a href="?action=user_voice&page={$pager_info['next_page']}"><span class="hidden-480">Next</span> → </a></li>
{-/if}
                                            </ul>

                                        </div>

                                    </div>

                                </div>

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

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script type="text/javascript" src="media/js/chosen.jquery.min.js"></script>

    <!-- END PAGE LEVEL PLUGINS -->

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
