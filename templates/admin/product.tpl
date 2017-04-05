{assign var=page_title value="产品管理"}<!DOCTYPE html>

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

    <link href="media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/style-metro.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/style.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

    <link href="media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

    <link href="media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

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

{include file="admin/common/sidebar.tpl" page_name="product"}

        <!-- END SIDEBAR -->

        <!-- BEGIN PAGE -->

        <div class="page-content">

            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <div id="portlet-config" class="modal hide">

                <div class="modal-header">

                    <button data-dismiss="modal" class="close" type="button"></button>

                    <h3>portlet Settings</h3>

                </div>

                <div class="modal-body">

                    <p>Here will be a configuration form</p>

                </div>

            </div>

            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <!-- BEGIN PAGE CONTAINER-->        

            <div class="container-fluid">

                <!-- BEGIN PAGE HEADER-->

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN PAGE TITLE & BREADCRUMB-->

                        <h3 class="page-title">

                            {$page_title} <small>产品汇总</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=product">{$page_title}</a>

                                <i class="icon-angle-right"></i>

                            </li>
{if $group|default:[]}
                            <li>分组：{$group.name}</li>
{/if}
                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

                        <div class="alert alert-error{if !$smarty.get.error_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.error_msg}</span>

                        </div>

                        <div class="alert alert-success{if !$smarty.get.success_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.success_msg}</span>

                        </div>

                        <!-- BEGIN CONDENSED TABLE PORTLET-->

                        <div class="portlet box green">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-file"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="row-fluid">

                                    <div class="span4">

                                        <a href="?action=edit_product" class="btn red">

                                            发布新产品 <i class="icon-plus"></i>

                                        </a>

                                        <a href="?action=insert_keywords" class="btn normal">批量插入关键词</a>

                                    </div>

                                    <div class="span8">

                                        <div class="pull-right">

                                            <select data-placeholder="选择分组" class="chosen" tabindex="-1" id="select-group">

                                                <option value="0"></option>

                                                <option value="0">全部</option>
{foreach $groups as $group}
                                                <option value="{$group.id}"{if $group.id==$smarty.get.group_id} selected{/if}>{$group.name}</option>
{/foreach}
                                            </select>

                                        </div>

                                    </div>

                                </div>

                                <hr class="clearfix">

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>标题</th>

                                            <th>创建时间(+8)</th>

                                            <th>最后修改时间(+8)</th>

                                            <th>所属分组</th>

                                            <th>&nbsp;</th>

                                        </tr>

                                    </thead>

                                    <tbody>
{section name=i loop=$products}
                                        <tr>

                                            <td>{$products[i].id}</td>

                                            <td>

                                                <a href="{$products[i]|url:'enterprise_url_product'}" target="_blank">{$products[i].caption}</a>
    {-if $products[i].source_url}
                                                <!--<br>

                                                <span style="color: #7f7f7f">源站地址：</span>

                                                <a href="{$products[i].source_url}" title="{$products[i].source_url}" target="_blank">{$products[i].source_url|truncate:100}</a>-->
    {-/if}
                                            </td>

                                            <td>{$products[i].created}</td>

                                            <td>{$products[i].updated}</td>

                                            <td><a href="?action=product&group_id={$products[i].group_id}">{$products[i].group_name}</a></td>

                                            <td>

                                                <a href="?action=comment&product_id={$products[i].id}">查看留言</a>

                                                <a href="?action=edit_product_tdk&product_id={$products[i].id}">TDK</a>

                                                <a href="?action=edit_product&source_product_id={$products[i].id}">复制</a>

                                                <a href="?action=edit_product&product_id={$products[i].id}">修改</a>

                                                <a href="?action=delete_product&product_id={$products[i].id}">删除</a>

                                            </td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="6">暂无任何产品</td>

                                        </tr>
{/section}
                                    </tbody>

                                </table>

                                <div class="row-fluid">

                                    <div class="span6">

                                        <div class="dataTables_info" id="sample_1_info">共有{$total_products}条产品。当前展示{$page_no}/{$pager_info['pages']}页</div>

                                    </div>

                                    <div class="span6">

                                        <div class="dataTables_paginate paging_bootstrap pagination">

                                            <ul>
{-if isset($pager_info['prev_page'])}
                                                <li class="prev"><a href="?action=product&page={$pager_info['prev_page']}">← <span class="hidden-480">Prev</span></a></li>
{-/if}
{-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                                                <li{if $i==$page_no} class="active"{/if}><a href="?action=product&page={$i}">{$i}</a></li>
{-/for}
{-if isset($pager_info['next_page'])}
                                                <li class="next"><a href="?action=product&page={$pager_info['next_page']}"><span class="hidden-480">Next</span> → </a></li>
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

    <script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

    <script src="media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

    <script src="media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

    <script src="media/js/bootstrap.min.js" type="text/javascript"></script>

    <!--[if lt IE 9]>

    <script src="media/js/excanvas.min.js"></script>

    <script src="media/js/respond.min.js"></script>  

    <![endif]-->   

    <script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>  

    <script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.uniform.min.js" type="text/javascript" ></script>

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
                location.href = '?action=product&group_id=' + $(this).val();
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
