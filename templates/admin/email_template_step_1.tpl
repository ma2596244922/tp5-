{assign var=page_title value="EDM邮件模板"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="email_template"}

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

                            {$page_title} <small>创建个性的邮件模板</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=email_template">EDM邮件模板</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

                        <div class="alert alert-error{if !$error_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$error_msg}</span>

                        </div>

                        <div class="alert alert-success{if !$success_msg} hide{/if}">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$success_msg}</span>

                        </div>

                        <!-- BEGIN SAMPLE FORM PORTLET-->   

                        <div class="portlet box blue">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-reorder"></i>{$page_title}</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                </div>

                            </div>

                            <div class="portlet-body form">

                                <!-- BEGIN FORM-->

                                <form action="?action=email_template&step=2" method="POST" class="form-horizontal">
{for $i=1 to 2}
                                    <div class="control-group">

                                        <label class="control-label">产品分组{$i}</label>

                                        <div class="controls">

                                            <select class="span6 m-wrap" multiple="multiple" name="group_id_array[{$i}]" data-placeholder="请选择产品分组" tabindex="1">
    {-section name=i loop=$groups}
                                                <option value="{$groups[i].id}"{if $email_template|default:[] && $email_template.group_id_array[$i]==$groups[i].id} selected="selected"{/if}>{$groups[i].name}</option>
    {-/section}
                                            </select>

                                        </div>

                                    </div>
    {-for $j=1 to 3}
                                    <div class="control-group">

                                        <label class="control-label">产品{$i}-{$j}</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="product_url_array[{$i}][{$j}]" value="{$email_template.product_url_array[$i][$j]|default:''}" />

                                            <span class="help-inline">请输入对应产品分组内产品链接</span>

                                        </div>
    {-/for}
                                    </div>
{/for}

                                    <div class="form-actions">

                                        <button type="submit" class="btn blue">下一步</button>

                                        <a href="?action=email_template" class="btn">取消</a>

                                    </div>

                                </form>

                                <!-- END FORM-->

                            </div>

                        </div>

                        <!-- END SAMPLE FORM PORTLET-->

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
