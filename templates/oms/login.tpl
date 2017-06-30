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
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">OMS</div>
                    <div class="panel-body">
{if isset($error_msg)}
                        <div class="alert alert-warning">{$error_msg}</div>
{/if}
                        <form class="form-horizontal" action="?action=login" method="POST">
                            <div class="form-group">
                                <label class="control-label col-lg-2">用户名:</label>
                                <div class="col-lg-10">
                                    <input class="form-control" type="text" name="user">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-lg-2 control-label">密码:</label>
                                <div class="col-lg-10">
                                    <input class="form-control" type="password" name="password">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-10 col-lg-offset-2">
                                    <input class="btn btn-primary" type="submit" name="submit" value="Login">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>