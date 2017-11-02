{assign var=page_title value="产品分组"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="group"}

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

                            {$page_title} <small>产品分组汇总</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=group">{$page_title}</a></li>

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

                                <div class="caption"><i class="icon-briefcase"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_group" class="btn red">

                                        创建新分组 <i class="icon-plus"></i>

                                        </a>

                                    </div>

                                    <div class="control-group">

                                        <div class="input-icon inline">

                                            <i class="icon-envelop"></i>

                                            <input class="m-wrap" type="text" id="input-keywords" placeholder="搜索关键词" value="{$smarty.get.keywords|default:''|escape}">

                                        </div>

                                    </div>

                                </div>

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>名称</th>

                                            <th>创建时间(+8)</th>

                                            <th>最后修改时间(+8)</th>

                                            <th>产品数量</th>

                                            <th>&nbsp;</th>

                                        </tr>

                                    </thead>

                                    <tbody>
{section name=i loop=$groups}{assign var="gid" value={$groups[i].id|default:$groups[i].group_id}}
                                        <tr>

                                            <td>{$gid}</td>

                                            <td>
    {if $groups[i].cnt > 0}
                                                <a href="{$groups[i]|url:'enterprise_url_product_list'}" target="_blank">{$groups[i].name}</a>
    {else}
                                                {$groups[i].name}
    {/if}
    {-if $groups[i].purl_prefix}
                                                <br>

                                                <span style="color: #7f7f7f">产品页前缀：</span>

                                                {$groups[i].purl_prefix|truncate:100}
    {-/if}
                                            </td>

                                            <td>{$groups[i].created}</td>

                                            <td>{$groups[i].updated}</td>

                                            <td>{$groups[i].cnt}</td>

                                            <td>

                                                <a href="?action=count_products&group_id={$gid}">重算产品数</a>

                                                <a href="?action=edit_group&group_id={$gid}">修改</a>

                                                <a href="?action=edit_group_tdk&group_id={$gid}">TDK</a>

                                                <a href="javascript:void(0);" data-role="btn-delete-group" data-group-id="{$gid}" data-group-cnt="{$groups[i].cnt}">删除</a>

                                            </td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="6">暂无任何分组</td>

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

           $('[data-role="btn-delete-group"]').click(function() {
                var groupId = $(this).data('group-id');
                var groupCnt = $(this).data('group-cnt');
                var confirmMsg = '确认删除该分组？' + ((groupCnt>0)?'（同时删除该分组下所有产品）':'（空分组）');
                if (!confirm(confirmMsg))
                    return;

                var forceDeleteString = '';
                if (groupCnt > 0)
                    forceDeleteString = '&force=1';

                var url = '?action=delete_group&group_id=' + encodeURIComponent(groupId) + forceDeleteString;
                location.href = url;
           });

           $('#input-keywords').keypress(function (e) {
                if (e.which != 13)
                    return;

                var keywords = $(this).val();
                location.href = '?action=group&keywords=' + encodeURIComponent(keywords);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
