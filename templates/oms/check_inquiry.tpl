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
{include file="oms/common/mainnav.tpl"}
                <!-- End Nav -->

                <!-- Begin Content -->
                <h2>询盘审核</h2>
                <div class="media">
                    <div class="media-left">
{if $target_product|default:[]}
                        <a href="{$target_product|url:'enterprise_url_product'}" target="_blank">
                            <img class="media-object" src="{$target_product.head_image_id|url:'enterprise_url_image'}" alt="...">
                        </a>
{else}
                        <img class="media-object" src="/media/image/no_image.png" alt="...">
{/if}
                    </div>
                    <div class="media-body">
                        <h3 class="media-heading">{$inquiry.subject}</h3>
                        <ul>
{if $inquiry_country}
                            <li>国家: {$inquiry_country}</li>
{/if}
{if $inquiry.ip}
                            <li>IP: <a href="http://www.ip138.com/ips138.asp?ip={$inquiry.ip|call:'urlencode'}" target="_blank">{$inquiry.ip}</a></li>
{/if}
{if $inquiry.created}
                            <li>发布时间: {$inquiry.created}</li>
{/if}
{if $inquiry.contact}
                            <li>联系人: {$inquiry.courtesy_title|call:'\enterprise\daos\Contact::courtesyTitle2Text'}&nbsp;{$inquiry.contact}</li>
{/if}
{if $inquiry.email}
                            <li>Email: <a href="mailto:{$inquiry.email}">{$inquiry.email}</a></li>
{/if}
{if $inquiry.tel}
                            <li>联系电话: {$inquiry.tel}</li>
{/if}
{if $inquiry.fax}
                            <li>传真: {$inquiry.fax}</li>
{/if}
{if $inquiry.company}
                            <li>公司: {$inquiry.company}</li>
{/if}
{if $inquiry.website}
                            <li>网址: <a href="{$inquiry.website}" target="_blank">{$inquiry.website}</a></li>
{/if}
{if $inquiry_attachments}
                            <li>
                                附件:
    {-foreach $inquiry_attachments as $guid}
                                <a href="/attachments/{$guid}" target="_blank">附件{$guid@iteration}</a>
    {-/foreach}
                            </li>
{/if}
                        </ul>
                        {$inquiry.message}
                    </div>
                </div>
                <form class="form-horizontal" action="?action=check_inquiry" method="POST" id="formCheck">
                    <div class="form-group">
                        <div class="col-lg-offset-1 col-lg-4">
                            <input type="hidden" name="pending_inquiry_id" value="{$pending_inquiry_id}">
                            <input type="hidden" name="submitted" value="1" id="inputSubmit">
                            <button type="button" class="btn btn-primary" id="btnProve">通过</button>
                            <button type="button" class="btn btn-default" id="btnReject">拒绝</button>
                        </div>
                    </div>
                </form>
                <!-- End Content -->
            </div>
            <!-- End Page -->
        </div>
    </div>

{include file="oms/common/scripts.tpl"}
    <script type="text/javascript">{literal}
        $('#btnProve').click(function() {
            $('#inputSubmit').val(1);
            $('#formCheck').submit();
        });
        $('#btnReject').click(function() {
            $('#inputSubmit').val(2);
            $('#formCheck').submit();
        });
    {/literal}</script>
</body>
</html>