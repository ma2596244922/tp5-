<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title></title>

{include file="oms/common/definitions.tpl"}

{include file="oms/common/styles.tpl"}
</head>
<body>
    <div class="container">
{if $success_msg|default:''}
        <div class="alert alert-success">
            <h4>
                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                成功！
            </h4>
            <p>{$success_msg}</p>
    {-if $forwarding|default:[]}
            <p>
                <a class="btn btn-success" href="{$forwarding.url}" data-role="btn-delay-forwarding">{$forwarding.text}</a>
            </p>
    {-/if}
        </div>
{/if}
{if $error_msg|default:''}
        <div class="alert alert-danger">
            <h4>
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                错误！
            </h4>
            <p>{$error_msg}</p>
            <p>
                <a class="btn btn-primary" href="javascript:void(0);" onclick="history.go(-1);">返回修改</a>
            </p>
        </div>
{/if}
    </div>

{include file="oms/common/scripts.tpl"}
    <script type="text/javascript">
        setTimeout(function() {
            var forwarding = $('[data-role="btn-delay-forwarding"]').attr('href');
            if (typeof(forwarding) != 'undefined')
                location.href = forwarding;
        }, 3000);
    </script>
</body>
</html>