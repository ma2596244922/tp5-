<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title></title>

{include file="oms/common/definitions.tpl"}

{include file="oms/common/styles.tpl"}
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Begin SideBar -->
{include file="oms/common/sidebar.tpl"}
            <!-- End SideBar -->

            <!-- Begin Page -->
            <div class="col-lg-10">
                <!-- Begin Nav -->
{include file="oms/common/sitenav.tpl" page_name="client_info"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>客户资料</h2>
                <form class="form-horizontal" action="?action=client_info&site_id={$smarty.get.site_id}" method="POST">
                    <div class="form-group">
                        <label class="col-lg-1 control-label">域名：</label>
                        <div class="col-lg-4">
                           <p class="form-control-static">{$site_mappings[0].domain}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputMemo" class="col-lg-1 control-label">备注：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputMemo" name="desc" value="{$site.desc|default:''}" placeholder="某某公司">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputQQ" class="col-lg-1 control-label">QQ：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputQQ" name="qq" value="{$site.qq|default:''}" placeholder="123456">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputWechat" class="col-lg-1 control-label">微信：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputWechat" name="wechat" value="{$site.wechat|default:''}" placeholder="foo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-lg-1 control-label">姓名：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputName" name="name" value="{$site.name|default:''}" placeholder="张三">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTelephone" class="col-lg-1 control-label">电话：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputTelephone" name="tel" value="{$site.tel|default:''}" placeholder="13800138000">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">性别：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="0"{if $site.sex|default:'0'=='0'} checked{/if}>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="1"{if $site.sex|default:'0'=='1'} checked{/if}>女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">询盘审核：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="enable_inquiry_checking" value="0"{if $site.enable_inquiry_checking|default:'0'=='0'} checked{/if}>关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="enable_inquiry_checking" value="1"{if $site.enable_inquiry_checking|default:'0'=='1'} checked{/if}>开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">VPS：</label>
                        <div class="col-lg-4">
                            <select class="form-control" name="vps_id">
                                <option>（待分配）</option>
{foreach $vpss as $vps}
                                <option value="{$vps.id}"{if $site.vps_id|default:'0'==$vps.id} selected{/if}>{$vps.alias}（{$vps.ip_addr}）</option>
{/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">行业：</label>
                        <div class="col-lg-4">
                            <select class="form-control" name="industry_id">
                                <option>（请选择）</option>
{foreach $industries as $industry}
                                <option value="{$industry.id}"{if $site.industry_id|default:'0'==$industry.id} selected{/if}>{$industry.name}</option>
{/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">类型：</label>
                        <div class="col-lg-4">
                            <select class="form-control" name="type">
                                <option>（请选择）</option>
{foreach $types as $type => $label}
                                <option value="{$type}"{if $type==$site.type} selected{/if}>{$label}</option>
{/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">移动版：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="enable_mobile_sites" value="0"{if $site.enable_mobile_sites|default:'1'=='0'} checked{/if}>关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="enable_mobile_sites" value="1"{if $site.enable_mobile_sites|default:'1'=='1'} checked{/if}>开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">上/下线：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="offline" value="1"{if $site.offline|default:'0'=='1'} checked{/if}>下线
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="offline" value="0"{if $site.offline|default:'0'=='0'} checked{/if}>上线
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaCSR" class="col-lg-1 control-label">CSR：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textareaCSR" name="csr" rows="15">{$site.csr}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="textareaKey" class="col-lg-1 control-label">Key：</label>
                        <div class="col-lg-4">
                            <textarea class="form-control" id="textareaKey" name="key" rows="15">{$site.key}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">HTTPS：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="enable_https" value="0"{if $site.enable_https|default:'0'=='0'} checked{/if}>关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="enable_https" value="1"{if $site.enable_https|default:'0'=='1'} checked{/if}>开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">漂浮框：</label>
                        <div class="col-lg-4">
                            <label class="radio-inline">
                                <input type="radio" name="enable_floating_widget" value="0"{if $site.enable_floating_widget|default:'0'=='0'} checked{/if}>关闭
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="enable_floating_widget" value="1"{if $site.enable_floating_widget|default:'0'=='1'} checked{/if}>开启
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputFloatingWidgetUrl" class="col-lg-1 control-label">漂浮框链接：</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" id="inputFloatingWidgetUrl" name="floating_widget_url" value="{$site.floating_widget_url|default:''}" placeholder="http://">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">模板：</label>
                        <div class="col-lg-4">
                            <select class="form-control" name="template">
                                <option value="">（待分配）</option>
                                <option value="trade"{if $site.template=='trade'} selected{/if}>M1</option>
                                <option value="brilly"{if $site.template=='brilly'} selected{/if}>M2</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-1 control-label">语种：</label>
                        <div class="col-lg-4">
{foreach $supported_lang_codes as $lc => $meta}
                            <label class="checkbox-inline">
                                <input type="checkbox" name="lang_codes[{$lc}]" value="1"{if $site_lang_codes.$lc|default:'0'=='1'} checked{/if}>{$meta.label}
                            </label>
{/foreach}
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="submit" value="1">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="location.href='?action=industry';">返回</button>
                        </div>
                    </div>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
</body>
</html>