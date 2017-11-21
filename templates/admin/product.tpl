{assign var=page_title value="产品管理"}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="product"}

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
{elseif $smarty.get.keywords|default:''}
                            <li>关键词：{$smarty.get.keywords}</li>
{else}
                            <li>全部产品({$site.product_cnt})</li>
{/if}
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

                                <div class="caption"><i class="icon-file"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_product" class="btn red">

                                            发布新产品 <i class="icon-plus"></i>

                                        </a>
{-if $user.advanced}
                                        <a href="?action=insert_images" class="btn normal">批量插入产品图</a>

                                        <a href="?action=insert_desc" class="btn normal">批量插入产品描述</a>

                                        <a href="?action=insert_keywords" class="btn normal">批量插入关键词</a>

                                        <a href="?action=replace_keywords" class="btn normal">批量替换关键词</a>

                                        <a href="?action=replace_terms" class="btn normal">批量设置商务条款</a>

                                        <a href="?action=remove_empty_caption_products" class="btn normal">删除空标题产品</a>
{-/if}
                                        <a href="?action=count_products" class="btn normal">重算产品总数</a>

                                    </div>

                                    <div class="control-group">

                                        <select data-placeholder="选择分组" class="chosen" tabindex="-1" id="select-group">

                                            <option value="0"></option>

                                            <option value="0">全部</option>
{foreach $groups as $group}
                                            <option value="{$group.id}"{if $group.id==$smarty.get.group_id|default:''} selected{/if}>{$group.name}</option>
{/foreach}
                                        </select>
                        
                                        <div class="input-icon inline">

                                            <i class="icon-envelop"></i>

                                            <input class="m-wrap" type="text" id="input-keywords" placeholder="搜索标题" value="{$smarty.get.keywords|default:''|escape}">

                                        </div>

                                    </div>

                                </div>

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
    {-if $products[i].path}
                                                <br>

                                                <span style="color: #7f7f7f">自定义路径：</span>

                                                {$products[i].path|truncate:100}
    {-/if}
                                            </td>

                                            <td>{$products[i].created}</td>

                                            <td>{$products[i].updated}</td>

                                            <td><a href="?action=product&group_id={$products[i].group_id}">{$products[i].group_name}</a></td>

                                            <td>

                                                <a href="?action=comment&product_id={$products[i].id}">查看留言</a>
    {-if $user.advanced}
                                                <a href="?action=edit_product_tdk&product_id={$products[i].id}">TDK</a>

                                                <a href="?action=edit_product_url&product_id={$products[i].id}">URL</a>
    {-/if}
                                                <a href="?action=edit_product&source_product_id={$products[i].id}">复制</a>

                                                <a href="?action=edit_product&product_id={$products[i].id}">修改</a>

                                                <a href="javascript:void(0);" data-role="btn-delete" data-href="?action=delete_product&product_id={$products[i].id}">删除</a>
    {-if $smarty.get.group_id|default:'' && $user.advanced}
                                                <a href="?action=duplicate_products&product_id={$products[i].id}">批量复制产品</a>
    {-/if}
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
                                                <li class="prev"><a href="?action=product&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['prev_page']}">← <span class="hidden-480">Prev</span></a></li>
{-/if}
{-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                                                <li{if $i==$page_no} class="active"{/if}><a href="?action=product&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$i}">{$i}</a></li>
{-/for}
{-if isset($pager_info['next_page'])}
                                                <li class="next"><a href="?action=product&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['next_page']}"><span class="hidden-480">Next</span> → </a></li>
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
                location.href = '?action=product&group_id=' + $(this).val();
           });

           $('#input-keywords').keypress(function (e) {
                if (e.which != 13)
                    return;

                var keywords = $(this).val();
                location.href = '?action=product&keywords=' + encodeURIComponent(keywords);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
