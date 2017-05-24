{assign var=page_title value="后台登录"-}<!DOCTYPE html>

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

    <link href="media/css/login.css" rel="stylesheet" type="text/css"/>

    <!-- END PAGE LEVEL STYLES -->

    <link rel="shortcut icon" href="media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="login">

    <!-- BEGIN LOGO -->

    <div class="logo">

        <img src="media/image/logo.png" alt="logo" width="86" height="14" />

    </div>

    <!-- END LOGO -->

    <!-- BEGIN LOGIN -->

    <div class="content">

        <!-- BEGIN LOGIN FORM -->

        <form class="form-vertical login-form" action="?action=login" method="POST">

            <h3 class="form-title">{$page_title}</h3>

{include file="admin/common/op_alerts.tpl"}

            <div class="control-group">

                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

                <label class="control-label visible-ie8 visible-ie9">登录名</label>

                <div class="controls">

                    <div class="input-icon left">

                        <i class="icon-user"></i>

                        <input class="m-wrap placeholder-no-fix" type="text" placeholder="登录名" name="user"/>

                    </div>

                </div>

            </div>

            <div class="control-group">

                <label class="control-label visible-ie8 visible-ie9">密码</label>

                <div class="controls">

                    <div class="input-icon left">

                        <i class="icon-lock"></i>

                        <input class="m-wrap placeholder-no-fix" type="password" placeholder="密码" name="password"/>

                    </div>

                </div>

            </div>

            <div class="control-group">

                <label class="control-label visible-ie8 visible-ie9">验证码</label>

                <div class="controls">

                    <div class="input-icon left">

                        <i class="icon-key"></i>

                        <input class="m-wrap small" type="text" placeholder="验证码" name="captcha">

                        <a class="help-inline" href="javascript:void(0);" style="margin-top: 0; padding-left: 0;" id="btn-update-captcha">

                            <img src="?action=captcha&t={$smarty.now}">

                        </a>

                    </div>

                </div>

            </div>

            <div class="form-actions">

                <input type="hidden" name="submit" value="login">

                <button type="submit" class="btn green pull-right">

                登录 <i class="m-icon-swapright m-icon-white"></i>

                </button>            

            </div>

        </form>

        <!-- END LOGIN FORM -->        

    </div>

    <!-- END LOGIN -->

    <!-- BEGIN COPYRIGHT -->

    <div class="copyright">

        2016-2017 &copy; M1.0

    </div>

    <!-- END COPYRIGHT -->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

    <!-- BEGIN CORE PLUGINS -->

{include file="admin/common/scripts.tpl"}

    <!-- END CORE PLUGINS -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script src="media/js/jquery.validate.min.js" type="text/javascript"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->

    <script src="media/js/app.js" type="text/javascript"></script>

    <script src="media/js/login.js" type="text/javascript"></script>      

    <!-- END PAGE LEVEL SCRIPTS --> 

    <script>{literal}

        jQuery(document).ready(function() {     

          App.init();

          Login.init();

          $('#btn-update-captcha').click(function() {
                var baseUrl = '?action=captcha';
                var t = Math.round(Math.random() * 10000);
                var url = baseUrl + '&t=' + encodeURIComponent(t);
                $(this).find('img').attr('src', url);
          })

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>