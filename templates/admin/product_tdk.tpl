{assign var=page_title value="公司信息"-}<!DOCTYPE html>

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

{include file="admin/common/styles.tpl"}

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->

    <link href="media/css/bootstrap-fileupload.css" rel="stylesheet" type="text/css" />

    <link href="media/css/chosen.css" rel="stylesheet" type="text/css" />

    <link href="media/css/profile.css" rel="stylesheet" type="text/css" />

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

{include file="admin/common/sidebar.tpl" page_name="product_tdk"}

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

                            用户资料 <small>管理我的资料</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=profile">用户资料</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid profile">

                    <div class="span12">

{include file="admin/common/op_alerts.tpl"}

                        <!--BEGIN TABS-->

                        <div class="tabbable tabbable-custom tabbable-full-width">

                            <ul class="nav nav-tabs">

                                <li class="active"><a href="#tab_1_3" data-toggle="tab">用户帐户</a></li>

                            </ul>

                            <div class="tab-content">

                                <div class="tab-pane row-fluid profile-account active" id="tab_1_3">

                                    <div class="row-fluid">

                                        <div class="span12">

                                            <div class="span3">

{include file="admin/common/profile_l2menu.tpl" profile_page_name="product_tdk"}

                                            </div>

                                            <div class="span9">

                                                <div class="tab-content">

                                                    <div id="tab_1-1" class="tab-pane active">

                                                        <div style="height: auto;" id="accordion1-1" class="accordion collapse">

                                                            <form action="?action=product_tdk" method="POST">

                                                                <label class="control-label">HTML Title</label>

                                                                <input type="text" name="html_title" class="m-wrap span8" value="{$site.product_html_title|default:''}" id="input-html-title" />

                                                                <div class="space10"></div>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-html-title" type="button">产品标题</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-html-title" type="button">产品分组</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-html-title" type="button">公司名称</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag1]" data-target="#input-html-title" type="button">Tag1</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag2]" data-target="#input-html-title" type="button">Tag2</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag3]" data-target="#input-html-title" type="button">Tag3</button>

                                                                <label class="control-label">Meta Keywords</label>

                                                                <textarea class="span8 m-wrap" name="meta_keywords" id="textarea-meta-keywords" rows="6">{$site.product_meta_keywords|default:''}</textarea>

                                                                <div class="space10"></div>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题], " data-target="#textarea-meta-keywords" type="button">产品标题</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组], " data-target="#textarea-meta-keywords" type="button">产品分组</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称], " data-target="#textarea-meta-keywords" type="button">公司名称</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag1], " data-target="#textarea-meta-keywords" type="button">Tag1</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag2], " data-target="#textarea-meta-keywords" type="button">Tag2</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag3], " data-target="#textarea-meta-keywords" type="button">Tag3</button>

                                                                <label class="control-label">Meta Description</label>

                                                                <textarea class="span8 m-wrap" name="meta_description" id="textarea-meta-description" rows="6">{$site.product_meta_description|default:''}</textarea>

                                                                <div class="space10"></div>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#textarea-meta-description" type="button">产品标题</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#textarea-meta-description" type="button">产品分组</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#textarea-meta-description" type="button">公司名称</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag1]" data-target="#textarea-meta-description" type="button">Tag1</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag2]" data-target="#textarea-meta-description" type="button">Tag2</button>

                                                                <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[Tag3]" data-target="#textarea-meta-description" type="button">Tag3</button>

                                                                <label class="radio"><input type="radio" name="tdk_scope" value="0"{if $site.product_tdk_scope==0} checked{/if} />全站</label>

                                                                <label class="radio"><input type="radio" name="tdk_scope" value="-1"{if $site.product_tdk_scope>0} checked{/if} />指定分组</label>

                                                                <select class="span6 m-wrap" multiple="multiple" name="group_id" data-placeholder="请选择产品分组" tabindex="1">
{section name=i loop=$groups}
                                                                    <option value="{$groups[i].id}"{if $groups[i].id==$site.product_tdk_scope} selected{/if}>{$groups[i].name}</option>
{/section}
                                                                </select>

                                                                <div class="submit-btn">

                                                                    <input type="hidden" name="submit" value="update">

                                                                    <button class="btn green" type="submit">更新</button>

                                                                </div>

                                                            </form>

                                                        </div>

                                                    </div>

                                                </div>

                                            </div>

                                            <!--end span9-->

                                        </div>

                                    </div>

                                </div>

                                <!--end tab-pane-->

                            </div>

                        </div>

                        <!--END TABS-->

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

    <script type="text/javascript" src="media/js/bootstrap-fileupload.js"></script>

    <script type="text/javascript" src="media/js/chosen.jquery.min.js"></script>

    <script src="ckeditor/ckeditor.js" type="text/javascript" ></script>

    <script src="ckeditor/adapters/jquery.js" type="text/javascript" ></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->

    <script src="media/js/app.js"></script>      

    <!-- END PAGE LEVEL SCRIPTS -->

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

           $('[data-role="btn-insert-to-desc"]').click(function() {
                var text = $(this).data('text');
                var target = $(this).data('target');
                $(target).insertAtCaret(text);
           });

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>