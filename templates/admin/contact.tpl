{assign var=page_title value="管理联系人"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="contact"}

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

                            {$page_title} <small>管理网站内的联系人信息</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=contact">{$page_title}</a></li>

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

                                <div class="caption"><i class="icon-headphones"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body">

                                <div class="clearfix">

                                    <div class="btn-group">

                                        <a href="?action=edit_contact" class="btn red">

                                        创建联系人 <i class="icon-plus"></i>

                                        </a>

                                    </div>

                                </div>

                                <table class="table table-striped table-condensed table-hover">

                                    <thead>

                                        <tr>

                                            <th>#</th>

                                            <th>姓名</th>

                                            <th>职务</th>

                                            <th>创建时间(+8)</th>

                                            <th>最后修改时间(+8)</th>

                                            <th>联系方式</th>

                                            <th>&nbsp;</th>

                                        </tr>

                                    </thead>

                                    <tbody>
{section name=i loop=$contacts}
                                        <tr>

                                            <td>{$contacts[i].id}</td>

                                            <td>{$contacts[i].name}</td>

                                            <td>{$contacts[i].title}</td>

                                            <td>{$contacts[i].created}</td>

                                            <td>{$contacts[i].updated}</td>

                                            <td>

                                                {if $contacts[i].tel}<p>Tel: {$contacts[i].tel}</p>{/if}
                                                {if $contacts[i].skype}<p>Skype: {$contacts[i].skype}</p>{/if}
                                                {if $contacts[i].email}<p>Email: {$contacts[i].email}</p>{/if}
                                                {if $contacts[i].yahoo}<p>Yahoo: {$contacts[i].yahoo}</p>{/if}
                                                {if $contacts[i].icq}<p>ICQ: {$contacts[i].icq}</p>{/if}
                                                {if $contacts[i].viber}<p>Viber: {$contacts[i].viber}</p>{/if}
                                                {if $contacts[i].whatsapp}<p>WhatsApp: {$contacts[i].whatsapp}</p>{/if}

                                            </td>

                                            <td>

                                                <a href="?action=edit_contact&contact_id={$contacts[i].id}">修改</a>

                                                <a href="javascript:void(0);" data-role="btn-delete" data-href="?action=delete_contact&contact_id={$contacts[i].id}">删除</a>

                                            </td>

                                        </tr>
{sectionelse}
                                        <tr>

                                            <td colspan="7">暂无任何联系人</td>

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
