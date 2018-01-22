{assign var=page_title value="批量插入产品图"}<!DOCTYPE html>

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

    <link rel="stylesheet" type="text/css" href="media/css/select2_metro.css" />

    <link rel="stylesheet" type="text/css" href="media/css/bootstrap-fileupload.css" />

    <link rel="stylesheet" href="media/css/DT_bootstrap.css" />

    <link rel="stylesheet" type="text/css" href="media/css/multi-select-metro.css" />

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

                            {$page_title} <small>发布、修改产品信息</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=product">产品管理</a></li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12">

{include file="admin/common/op_alerts.tpl"}

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

                                <form action="?action=insert_images" method="POST" enctype="multipart/form-data" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">图片</label>

                                        <div class="controls">
    {-for $i=0 to 9}
                                            <div class="fileupload fileupload-new pull-left" data-provides="fileupload" style="margin-left: 5px;">

                                                <input type="hidden" name="file{$i}" value="">

                                                <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

                                                    <img src="media/image/no_image.png" alt="" />

                                                </div>

                                                <div class="fileupload-preview fileupload-exists thumbnail" style="width: 200px; height: 150px; padding: 4px;">

                                                    <img src="/media/sets/trade/no_image.png" alt="" style="max-height: 150px;" />

                                                </div>

                                                <div>

                                                    <span class="btn btn-file">
                                                        <span class="fileupload-new">选择图片</span>

                                                        <span class="fileupload-exists">更换</span>

                                                        <input type="file" class="default" name="file{$i}" />
                                                    </span>

                                                    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>

                                                </div>

                                            </div>
    {-/for}
                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">位置</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="location" value="1" checked />

                                                从前往后

                                            </label>

                                            单个产品插入

                                            <input type="text" class="span1 m-wrap" name="location_1_cnt" value="5" />

                                            张产品图

                                            <label class="checkbox">

                                                <input type="checkbox" name="location_1_overwrite" value="1" />

                                                覆盖原产品图

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label"></label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="location" value="2" />

                                                插入描述前部

                                            </label>

                                            单个产品插入

                                            <input type="text" class="span1 m-wrap" name="location_2_cnt" value="5" />

                                            张产品图

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label"></label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="location" value="3" />

                                                插入描述后部

                                            </label>

                                            单个产品插入

                                            <input type="text" class="span1 m-wrap" name="location_3_cnt" value="5" />

                                            张产品图

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">全站</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="type" value="1" />

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">分组</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="type" value="3" checked />

                                            </label>

                                            <select class="span6 m-wrap" multiple="multiple" name="group_id_array[]" id="multi-select-group-id" data-placeholder="请选择产品分组" tabindex="1">
{section name=i loop=$groups}
                                                <option value="{$groups[i].id}">{$groups[i].name}</option>
{/section}
                                            </select>

                                        </div>

                                    </div>
{if $user.advanced}
                                    <div class="control-group">

                                        <label class="control-label">后台处理：</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="background" value="0" />否

                                            </label>

                                            <label class="radio">

                                                <input type="radio" name="background" value="1" checked />是

                                            </label>

                                        </div>

                                    </div>
{/if}
                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="insert_images">

                                        <button type="submit" class="btn blue">强势插入</button>

                                        <a href="?action=product" class="btn">取消</a>

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

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script type="text/javascript" src="media/js/bootstrap-fileupload.js"></script>

    <script type="text/javascript" src="media/js/select2.min.js"></script>

    <script type="text/javascript" src="media/js/jquery.dataTables.js"></script>

    <script type="text/javascript" src="media/js/DT_bootstrap.js"></script>

    <script src="ckeditor/ckeditor.js" type="text/javascript" ></script>

    <script src="ckeditor/adapters/jquery.js" type="text/javascript" ></script>

    <script type="text/javascript" src="media/js/jquery.multi-select.js"></script>  

    <!-- END PAGE LEVEL PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script src="media/js/table-editable.js"></script>    

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

           var options = {
                'afterInit': function() {
                    this.$selectableUl.height(500);
                    this.$selectionUl.height(500);
                }
           }
           $('#multi-select-group-id').multiSelect(options);
        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
