{if $smarty.get.product_id|default:''}{assign var=page_title value="修改产品信息"}{else}{assign var=page_title value="发布新产品"}{/if}<!DOCTYPE html>

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

            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <div id="portlet-config" class="modal hide">

                <div class="modal-header">

                    <button data-dismiss="modal" class="close" type="button"></button>

                    <h3>portlet Settings</h3>

                </div>

                <div class="modal-body">

                    <p>Here will be a configuration form</p>

                </div>

            </div>

            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

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

                                <form action="?action=edit_product&product_id={$product_id}" method="POST" enctype="multipart/form-data" class="form-horizontal" id="form-edit-product">

                                    <div class="control-group">

                                        <label class="control-label">标题</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="caption" value="{$product.caption|default:''}" />

                                            <span class="help-inline">请输入英文产品标题</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">描述</label>

                                        <div class="controls">

                                            <textarea class="span12 m-wrap" name="description" id="textarea-description" rows="6">{$product.description|default:''}</textarea>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">分组</label>

                                        <div class="controls">

                                            <select class="span6 m-wrap" multiple="multiple" name="group_id" data-placeholder="请选择产品分组" tabindex="1">
{section name=i loop=$groups}
                                                <option value="{$groups[i].id}"{if isset($product.group_id) && $product.group_id==$groups[i].id} selected="selected"{/if}>{$groups[i].name}</option>
{/section}
                                            </select>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">图片</label>

                                        <div class="controls">
{for $i=0 to 4}
                                            <div class="fileupload fileupload-{if isset($product_images[$i])}exists{else}new{/if} span2" data-provides="fileupload">

                                                <input type="hidden" name="file{$i}" value="{$product_images[$i]|default:''}">

                                                <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

                                                    <img src="media/image/no_image.png" alt="" />

                                                </div>

                                                <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;">

                                                    <img src="{$product_images[$i]|default:''|url:'enterprise_url_image':{$product.caption|default:''}:'c'}" alt="" style="max-height: 150px;" />

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
{/for}
                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">关键词</label>

                                        <div class="controls">

                                            <input type="hidden" id="select2_sample5" class="span6 select2" name="tags" value="{$product.tags|default:''}">

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">品牌</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="brand_name" value="{$product.brand_name|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">型号</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="model_number" value="{$product.model_number|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">认证证书</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="certification" value="{$product.certification|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">原产地</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="place_of_origin" value="{$product.place_of_origin|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">最小起订量</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="min_order_quantity" value="{$product.min_order_quantity|default:''}" />

                                            <span class="help-inline">请同时填写数值和单位</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">价格</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="price" value="{$product.price|default:''}" placeholder="货币类型 + 价格区间 + 计量单位" />

                                            <span class="help-inline">请同时填写数值和单位。建议填写方式为：货币类型 + 价格区间 + 计量单位</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">付款方式</label>

                                        <div class="controls">

                                            <input type="hidden" id="input-payment-terms" class="span6 select2" name="payment_terms" value="{$product.payment_terms|default:''}">

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">供货能力</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="supply_ability" value="{$product.supply_ability|default:''}" placeholder="数量 + 计量单位 + per时间单位" />

                                            <span class="help-inline">请同时填写数值和单位。建议填写方式为：数量 + 计量单位 + per时间单位</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">发货期限</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="delivery_time" value="{$product.delivery_time|default:''}" />

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">常规包装</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="packaging_details" value="{$product.packaging_details|default:''}" />

                                            <span class="help-inline">建议填写包装形式、尺寸，各类集装箱能装载的产品件数等信息，便于买家了解。</span>

                                        </div>

                                    </div>


                                    <div class="control-group">

                                        <label class="control-label">自定义属性</label>

                                        <div class="controls">

                                            <input type="hidden" name="specifications">

                                            <div class="btn-group">

                                                <button id="sample_editable_1_new" class="btn green">

                                                新增属性 <i class="icon-plus"></i>

                                                </button>

                                            </div>

                                            <table class="table table-striped table-hover table-bordered" id="sample_editable_1">

                                                <thead>

                                                    <tr>

                                                        <th>属性名</th>

                                                        <th>属性值</th>

                                                        <th>修改</th>

                                                        <th>删除</th>

                                                    </tr>

                                                </thead>

                                                <tbody>
{if isset($product_specifications)}{foreach $product_specifications as $s}
                                                    <tr class="">

                                                        <td>{$s@key}</td>

                                                        <td>{$s}</td>

                                                        <td><a class="edit" href="javascript:;">修改</a></td>

                                                        <td><a class="delete" href="javascript:;">删除</a></td>

                                                    </tr>
{/foreach}{/if}
                                                </tbody>

                                            </table>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <input type="hidden" name="submit" value="edit_product">

                                        <button type="submit" class="btn blue">保存</button>

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

    <script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

    <script src="media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

    <script src="media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

    <script src="media/js/bootstrap.min.js" type="text/javascript"></script>

    <!--[if lt IE 9]>

    <script src="media/js/excanvas.min.js"></script>

    <script src="media/js/respond.min.js"></script>  

    <![endif]-->   

    <script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>  

    <script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.uniform.min.js" type="text/javascript" ></script>

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script type="text/javascript" src="media/js/bootstrap-fileupload.js"></script>

    <script type="text/javascript" src="media/js/select2.min.js"></script>

    <script type="text/javascript" src="media/js/jquery.dataTables.js"></script>

    <script type="text/javascript" src="media/js/DT_bootstrap.js"></script>

    <script src="ckeditor/ckeditor.js" type="text/javascript" ></script>

    <script src="ckeditor/adapters/jquery.js" type="text/javascript" ></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- END CORE PLUGINS -->

    <script src="media/js/app.js"></script>      

    <script src="media/js/table-editable.js"></script>    

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

            var dataTable = TableEditable.init();

            $('#form-edit-product').on('submit', function(e) {
                var specifications = [];
                var nodes = dataTable.fnGetNodes();
                for(var node in nodes) {
                    var data = dataTable.fnGetData(node);
                    if (data.length <= 0)
                        continue;
                    var pair = data[0] + '=' + encodeURIComponent(data[1]);
                    specifications.push(pair);
                }
                var val = specifications.join('&');
                $(this).find('[name="specifications"]').val(val);
            });

            $('#textarea-description').ckeditor({
                filebrowserUploadUrl: '?action=upload_image'
            });

            $("#select2_sample5").select2({
                tags: []
            });

            $("#input-payment-terms").select2({
                tags: ['L/C', 'D/A', 'D/P', 'T/T', 'Western Union', 'MoneyGram']
            });
        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
