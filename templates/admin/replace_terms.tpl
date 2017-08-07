{assign var=page_title value="批量替换商务条款"}<!DOCTYPE html>

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

                            {$page_title} <small>批量修改产品信息</small>

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

                                <form action="?action=replace_terms" method="POST" class="form-horizontal">

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

                                    <div class="control-group">

                                        <label class="control-label">策略</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="strategy" value="0" checked />数据不为空时替换

                                            </label>

                                            <label class="radio">

                                                <input type="radio" name="strategy" value="1" />数据不为空时跳过

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">品牌</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="brand_name" id="input-brand-name" value="{$product.brand_name|default:''}" />

                                            <span class="help-inline"></span>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-brand-name" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-brand-name" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-brand-name" type="button">公司名称</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">型号</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="model_number" id="input-model-number" value="{$product.model_number|default:''}" />

                                            <span class="help-inline"></span>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-model-number" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-model-number" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-model-number" type="button">公司名称</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">认证证书</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="certification" id="input-certification" value="{$product.certification|default:''}" />

                                            <span class="help-inline"></span>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-certification" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-certification" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-certification" type="button">公司名称</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">原产地</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="place_of_origin" id="input-place-of-origin" value="{$product.place_of_origin|default:''}" />

                                            <span class="help-inline"></span>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-place-of-origin" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-place-of-origin" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-place-of-origin" type="button">公司名称</button>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">最小起订量</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" name="min_order_quantity" id="input-min-order-quantity" value="{$product.min_order_quantity|default:''}" />

                                            <span class="help-inline">请同时填写数值和单位</span>

                                            <div class="space10"></div>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品标题]" data-target="#input-min-order-quantity" type="button">产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[产品分组]" data-target="#input-min-order-quantity" type="button">产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-desc" data-text="[公司名称]" data-target="#input-min-order-quantity" type="button">公司名称</button>

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

                                        <label class="control-label">原关键词</label>

                                        <div class="controls">

                                            <textarea class="span6 m-wrap" name="old_phrase" rows="6"></textarea>

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">新关键词</label>

                                        <div class="controls">

                                            <textarea class="span6 m-wrap" name="new_phrase" rows="6" id="textarea-new-phrase"></textarea>

                                            <button class="btn btn-default" data-role="btn-insert-to-phrase" data-config="[产品标题]" type="button">插入产品标题</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-phrase" data-config="[产品分组]" type="button">插入产品分组</button>

                                            <button class="btn btn-default" data-role="btn-insert-to-phrase" data-config="[公司名称]" type="button">插入公司名称</button>

                                            <label class="checkbox">

                                                <input type="checkbox" name="remove_phrase" value="1" id="input-remove-phrase" />

                                                删除原关键词

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">位置</label>

                                        <div class="controls">

                                            <label class="radio">

                                                <input type="radio" name="location" value="1" />

                                                仅标题

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <div class="controls">

                                            <label class="radio">

                                            <input type="radio" name="location" value="2" />

                                            仅Tag

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <div class="controls">

                                            <label class="radio">

                                            <input type="radio" name="location" value="3" />

                                            仅描述

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <div class="controls">

                                            <label class="radio">

                                            <input type="radio" name="location" value="0" checked />

                                            标题和Tag

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

                                        <input type="hidden" name="submit" value="replace_terms">

                                        <button type="submit" class="btn blue">强势替换</button>

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

           $('[data-role="btn-insert-to-desc"]').click(function() {
                var text = $(this).data('text');
                var target = $(this).data('target');
                $(target).insertAtCaret(text);
           });

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
