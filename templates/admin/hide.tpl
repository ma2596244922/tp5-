{assign var=page_title value="屏蔽配置"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="hide"}

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

{include file="admin/common/profile_l2menu.tpl" profile_page_name="hide"}

                                            </div>

                                            <div class="span9">

                                                <div class="tab-content">

                                                    <div id="tab_1-1" class="tab-pane active">

                                                        <div style="height: auto;" id="accordion1-1" class="accordion collapse">

                                                            <form action="?action=hide" method="POST" enctype="multipart/form-data">

                                                                <label class="control-label">启用屏蔽</label>

                                                                <div class="controls">

                                                                    <label class="radio">

                                                                        <input type="radio" name="enabled" value="0"{if $hide_site.enabled|default:"0"=="0"} checked{/if} />关闭

                                                                    </label>

                                                                    <label class="radio">

                                                                        <input type="radio" name="enabled" value="1"{if $hide_site.enabled|default:"0"=="1"} checked{/if} />启用

                                                                    </label>

                                                                </div>

                                                                <label class="control-label">屏蔽方式</label>

                                                                <div class="controls">

                                                                    <label class="checkbox">

                                                                        <input type="checkbox" name="hide_by_ipaddr" value="1"{if $hide_site.hide_by_ipaddr|default:"0"=="1"} checked{/if} />IP地址

                                                                    </label>

                                                                    <label class="checkbox">

                                                                        <input type="checkbox" name="hide_by_browser" value="1"{if $hide_site.hide_by_browser|default:"0"=="1"} checked{/if} />浏览器

                                                                    </label>

                                                                    <label class="checkbox">

                                                                        <input type="checkbox" name="hide_by_os" value="1"{if $hide_site.hide_by_os|default:"0"=="1"} checked{/if} />操作系统

                                                                    </label>

                                                                </div>

                                                                <label class="control-label">IP黑名单</label>

                                                                <textarea class="span8 m-wrap" name="ipaddr_black_list" rows="6">{$hide_site.ipaddr_black_list|default:''}</textarea>

                                                                <label class="control-label">IP白名单</label>

                                                                <textarea class="span8 m-wrap" name="ipaddr_white_list" rows="6">{$hide_site.ipaddr_white_list|default:''}</textarea>

                                                                <label class="control-label">目标页</label>

                                                                <div class="controls">

                                                                    <label class="radio">

                                                                        <input type="radio" name="target_page" value="0"{if $hide_site.target_page|default:"0"=="0"} checked{/if} />默认页

                                                                    </label>

                                                                    <label class="radio">

                                                                        <input type="radio" name="target_page" value="10"{if $hide_site.target_page|default:"0"=="10"} checked{/if} />自定义

                                                                    </label>

                                                                    <input type="text" name="target_page_url" class="m-wrap span6" value="{$hide_site.target_page_url}" />

                                                                </div>

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

            var additionalConfig = {
                filebrowserUploadUrl: '?action=upload_image'
            };

           $('#textarea-introduction').ckeditor(additionalConfig);
           $('#textarea-history').ckeditor(additionalConfig);
           $('#textarea-service').ckeditor(additionalConfig);
           $('#textarea-our_team').ckeditor(additionalConfig);
           $('#textarea-qc_profile').ckeditor(additionalConfig);
           $('#textarea-desc_4_inquiry_sender').ckeditor(additionalConfig);
           $('#textarea-contact_content').ckeditor(additionalConfig);

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>