{assign var=page_title value="批量插入产品描述"}<!DOCTYPE html>

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

    <link rel="stylesheet" type="text/css" href="media/css/select2_metro.css" />

    <link rel="stylesheet" type="text/css" href="media/css/bootstrap-fileupload.css" />

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

                                <form action="?action=insert_desc" method="POST" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">插入内容</label>

                                        <div class="controls">

                                            <textarea class="span4 m-wrap" name="desc" id="textarea-desc" rows="16"></textarea>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-config="[产品标题]" type="button">插入产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-config="[产品分组]" type="button">插入产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-config="[公司名称]" type="button">插入公司名称</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">位置</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="location" value="1" checked />

                                                插入描述前部

                                            </label>

                                        </div>

                                    </div>


                                    <div class="control-group">

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="location" value="2" />

                                                插入描述后部

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">分组</label>

                                        <div class="controls">

                                            <select class="span6 m-wrap" multiple="multiple" name="group_id" data-placeholder="请选择产品分组" tabindex="1">
{section name=i loop=$groups}
                                                <option value="{$groups[i].id}">{$groups[i].name}</option>
{/section}
                                            </select>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="insert_desc">

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

    <!-- END PAGE LEVEL PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script src="media/js/table-editable.js"></script>    

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

$(function() {  
 /* 在textarea处插入文本--Start */  
 (function($) {  
 $.fn.extend({  
   insertAtCaret : function(myValue, t) {  
   var $t = $(this)[0];  
   if (document.selection) { // ie  
    this.focus();  
    var sel = document.selection.createRange();  
    sel.text = myValue;  
    this.focus();  
    sel.moveStart('character', -l);  
    var wee = sel.text.length;  
    if (arguments.length == 2) {  
    var l = $t.value.length;  
    sel.moveEnd("character", wee + t);  
    t <= 0 ? sel.moveStart("character", wee - 2 * t - myValue.length) : sel.moveStart( "character", wee - t - myValue.length);  
    sel.select();  
    }  
   } else if ($t.selectionStart  
    || $t.selectionStart == '0') {  
    var startPos = $t.selectionStart;  
    var endPos = $t.selectionEnd;  
    var scrollTop = $t.scrollTop;  
    $t.value = $t.value.substring(0, startPos)  
     + myValue  
     + $t.value.substring(endPos,$t.value.length);  
    this.focus();  
    $t.selectionStart = startPos + myValue.length;  
    $t.selectionEnd = startPos + myValue.length;  
    $t.scrollTop = scrollTop;  
    if (arguments.length == 2) {  
    $t.setSelectionRange(startPos - t,  
     $t.selectionEnd + t);  
    this.focus();  
    }  
   } else {  
    this.value += myValue;  
    this.focus();  
   }  
   }  
  })  
 })(jQuery);  
 /* 在textarea处插入文本--Ending */  
});  

           $('[data-role="btn-insert-to-desc"]').click(function() {
                var string = $(this).attr('data-config');
                $('#textarea-desc').insertAtCaret(string);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>