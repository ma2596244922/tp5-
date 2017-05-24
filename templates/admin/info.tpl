{assign var=page_title value="公司信息"-}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="info"}

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

{include file="admin/common/profile_l2menu.tpl" profile_page_name="info"}

                                            </div>

                                            <div class="span9">

                                                <div class="tab-content">

                                                    <div id="tab_1-1" class="tab-pane active">

                                                        <div style="height: auto;" id="accordion1-1" class="accordion collapse">

                                                            <form action="?action=info" method="POST">

                                                                <label class="control-label">公司名称</label>

                                                                <input type="text" name="name" placeholder="Beijing JB-Online Co., Ltd." class="m-wrap span8" value="{$corporation.name}" />

                                                                <label class="control-label">地址</label>

                                                                <input type="text" name="address" placeholder="Zhichun road, Haidian, Beijing, China" class="m-wrap span8" value="{$corporation.address}" />

                                                                <label class="control-label">厂址</label>

                                                                <input type="text" name="factory_address" placeholder="Zhichun road, Haidian, Beijing, China" class="m-wrap span8" value="{$corporation.factory_address}" />

                                                                <label class="control-label">工作时间</label>

                                                                <input type="text" name="worktime" placeholder="9:00-18:00(Beijing time)" class="m-wrap span8" value="{$corporation.worktime}" />

                                                                <label class="control-label">电话（工作时间内）</label>

                                                                <input type="text" name="tel_wt" placeholder="86-xx-xxxxxxx" class="m-wrap span8" value="{$corporation.tel_wt}" />

                                                                <label class="control-label">电话（非工作时间内）</label>

                                                                <input type="text" name="tel_nwt" placeholder="86-1xxxxxxxxxx" class="m-wrap span8" value="{$corporation.tel_nwt}" />

                                                                <label class="control-label">传真</label>

                                                                <input type="text" name="fax" placeholder="86-xx-xxxxxxx" class="m-wrap span8" value="{$corporation.fax}" />
<!--
                                                                <label class="control-label">Skype</label>

                                                                <input type="text" name="skype" class="m-wrap span8" value="{$corporation.skype}" />

                                                                <label class="control-label">Email</label>

                                                                <input type="text" name="email" class="m-wrap span8" value="{$corporation.email}" />

                                                                <label class="control-label">Yahoo</label>

                                                                <input type="text" name="yahoo" class="m-wrap span8" value="{$corporation.yahoo}" />
-->

                                                                <label class="control-label">Business Type</label>

                                                                <input type="text" name="business_type" class="m-wrap span8" value="{$corporation.business_type}" />

                                                                <label class="control-label">Main Market</label>

                                                                <input type="text" name="main_market" class="m-wrap span8" value="{$corporation.main_market}" />

                                                                <label class="control-label">Brands</label>

                                                                <input type="text" name="brands" class="m-wrap span8" value="{$corporation.brands}" />

                                                                <label class="control-label">No. of Employees</label>

                                                                <input type="text" name="no_of_employees" class="m-wrap span8" value="{$corporation.no_of_employees}" />

                                                                <label class="control-label">Annual Sales</label>

                                                                <input type="text" name="annual_sales" class="m-wrap span8" value="{$corporation.annual_sales}" />

                                                                <label class="control-label">Year Established</label>

                                                                <input type="text" name="year_established" class="m-wrap span8" value="{$corporation.year_established}" />

                                                                <label class="control-label">Export p.c</label>

                                                                <input type="text" name="export_p_c" class="m-wrap span8" value="{$corporation.export_p_c}" />

                                                                <label class="control-label">Introduction</label>

                                                                <textarea class="span8 m-wrap" name="introduction" id="textarea-introduction" rows="6">{$corporation.introduction|default:''}</textarea>

                                                                <label class="control-label">History</label>

                                                                <textarea class="span8 m-wrap" name="history" id="textarea-history" rows="6">{$corporation.history|default:''}</textarea>

                                                                <label class="control-label">Service</label>

                                                                <textarea class="span8 m-wrap" name="service" id="textarea-service" rows="6">{$corporation.service|default:''}</textarea>

                                                                <label class="control-label">Our Team</label>

                                                                <textarea class="span8 m-wrap" name="our_team" id="textarea-our_team" rows="6">{$corporation.our_team|default:''}</textarea>

                                                                <label class="control-label">QC Profile</label>

                                                                <textarea class="span8 m-wrap" name="qc_profile" id="textarea-qc_profile" rows="6">{$corporation.qc_profile|default:''}</textarea>

                                                                <label class="control-label">口号</label>

                                                                <textarea class="span8 m-wrap" name="slogan" rows="6">{$corporation.slogan|default:''}</textarea>

                                                                <label class="control-label">信息说明</label>

                                                                <textarea class="span8 m-wrap" name="desc_4_inquiry_sender" id="textarea-desc_4_inquiry_sender" rows="6">{$site.desc_4_inquiry_sender|default:''}</textarea>

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

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>