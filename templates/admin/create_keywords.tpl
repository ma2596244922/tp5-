{assign var=page_title value="批量录入关键词"}<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="keyword"}

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

                            {$page_title} <small>向关键词列表批量插入新关键词</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li><a href="?action=keyword">关键词列表</a></li>

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

                                <form action="?action=create_keywords" method="POST" enctype="multipart/form-data" class="form-horizontal" id="form-edit-keyword">

                                    <div class="control-group">

                                        <label class="control-label">关键词</label>

                                        <div class="controls">

                                            <textarea class="span12 m-wrap" name="keyword_lines" id="textarea-keyword-lines" rows="6"></textarea>

                                            <button class="btn btn-default" id="btn-generate-urllist" type="button">生成链接</button>

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">URL</label>

                                        <div class="controls">
{literal}
                                            <table class="table table-striped table-bordered table-hover" id="tbl-keyword-urls">

                                                <thead>

                                                    <tr>

                                                        <th>#</th>

                                                        <th>关键词</th>

                                                        <th>URL</th>

                                                    </tr>

                                                </thead>

                                                <tbody v-if="keywordUrlPairs.length > 0">

                                                    <tr v-for="(pair, idx) in keywordUrlPairs">

                                                        <td>{{ idx }}</td>

                                                        <td>{{ pair.keyword }}</td>

                                                        <td>

                                                            <a v-bind:href="pair.url" target="_blank">{{ pair.url }}</a>

                                                        </td>

                                                    </tr>

                                                </tbody>

                                                <tbody v-else>

                                                    <tr>

                                                        <td colspan="3">暂未生成任何关键词</td>

                                                    </tr>

                                                </tbody>

                                            </table>
{/literal}
                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">关键词说明</label>

                                        <div class="controls">

                                            <textarea class="span12 m-wrap" id="textarea-desc-template" name="desc_template" rows="6"></textarea>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc-template" data-config="[关键词]" type="button">插入关键词</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc-template" data-config="[公司名称]" type="button">插入公司名称</button>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="create_keywords">

                                        <button type="submit" class="btn blue">保存</button>

                                        <a href="?action=keyword" class="btn">取消</a>

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

            var additionalConfig = {
                filebrowserUploadUrl: '?action=upload_image',
                extraPlugins: 'videoembed',
                extraAllowedContent: 'iframe[*]'
            };
           $('#textarea-desc-template').ckeditor(additionalConfig);

           $('[data-role="btn-insert-to-desc-template"]').click(function() {
                var string = $(this).attr('data-config');
                CKEDITOR.instances['textarea-desc-template'].insertText(string);
           });

            var tblKeywordUrls = new Vue({
                'el': '#tbl-keyword-urls',
                'data': {
                    'keywordUrlPairs': [],
                }
            })

            $('#btn-generate-urllist').click(function() {
                $(this).prop('disabled', true);

                var url = 'fei.php?action=get_url_of_keyword';
                var me = this;
                var postData = 'keyword_lines=' + encodeURIComponent($('#textarea-keyword-lines').val());
                $.ajax({
                    'url': url,
                    'method': 'POST',
                    'dataType': 'json',
                    'data': postData,
                    'success': function(data) {
                        if ('code' in data)
                            alert('发生错误：' + data.message);
                        else
                            tblKeywordUrls.$data.keywordUrlPairs = data;
                    },
                    'error': function(jqXHR, testStatus, errorThrown) {
                        alert(errorThrown);
                    },
                    'complete': function() {
                        $(me).prop('disabled', false);
                    }
                });
            });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
