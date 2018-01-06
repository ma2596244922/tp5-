{assign var=page_title value="屏蔽记录"}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="hide_track"}

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

                            {$page_title} <small>站点屏蔽日志。</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li>{$page_title}</li>

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

                                <div class="caption"><i class="icon-book"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="clearfix">

                                    <div class="control-group">

                                        <div class="input-icon inline">

                                            <i class="icon-envelop"></i>

                                            <input class="m-wrap" type="text" id="input-keywords" placeholder="搜索记录" value="{$smarty.get.keywords|default:''|escape}">

                                        </div>

                                    </div>

                                </div>

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>IP</th>

                                            <th>记录时间(+8)</th>

                                            <th>页面</th>

                                            <th>命中策略</th>

                                        </tr>

                                    </thead>

                                    <tbody>
{section name=i loop=$hide_tracks}
                                        <tr>

                                            <td>{$hide_tracks[i].id}</td>

                                            <td>

                                                <a href="http://www.ip138.com/ips138.asp?ip={$hide_tracks[i].ipaddr|long2ip|call:'urlencode'}" target="_blank">{$hide_tracks[i].ipaddr|long2ip}</a>

                                            </td>

                                            <td>{$hide_tracks[i].created}</td>

                                            <td>{$hide_tracks[i].path}</td>

                                            <td>{$hide_tracks[i].hit|call:'\hide\daos\Track::hit2Text'}</td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="5">暂无任何记录</td>

                                        </tr>
{/section}
                                    </tbody>

                                </table>

                                <div class="row-fluid">

                                    <div class="span6">

                                        <div class="dataTables_info" id="sample_1_info">最多展示{$total_hide_tracks}条记录。当前展示{$page_no}/{$pager_info['pages']}页</div>

                                    </div>

                                    <div class="span6">

                                        <div class="dataTables_paginate paging_bootstrap pagination">

                                            <ul>
{-if isset($pager_info['prev_page'])}
                                                <li class="prev"><a href="?action=hide_track&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['prev_page']}">← <span class="hidden-480">Prev</span></a></li>
{-/if}
{-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                                                <li{if $i==$page_no} class="active"{/if}><a href="?action=hide_track&keywords={$smarty.get.keywords|default:''|urlencode}&page={$i}">{$i}</a></li>
{-/for}
{-if isset($pager_info['next_page'])}
                                                <li class="next"><a href="?action=hide_track&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['next_page']}"><span class="hidden-480">Next</span> → </a></li>
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

           $('#select-group').change(function() {
                location.href = '?action=hide_track&group_id=' + $(this).val();
           });

           $('#input-keywords').keypress(function (e) {
                if (e.which != 13)
                    return;

                var keywords = $(this).val();
                location.href = '?action=hide_track&keywords=' + encodeURIComponent(keywords);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
