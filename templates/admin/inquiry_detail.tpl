
<!DOCTYPE html>

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

{include file="admin/common/sidebar.tpl" page_name="inquiry"}

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

                            我的询盘 <small>询盘的详细内容</small>

                        </h3>

                        <ul class="breadcrumb">

                            <li>

                                <i class="icon-home"></i>

                                <a href="/">网站</a> 

                                <i class="icon-angle-right"></i>

                            </li>

                            <li>

                                <a href="?action=inquiry">我的询盘</a>

                                <i class="icon-angle-right"></i>

                            </li>


                            <li>{$inquiry.subject}</li>

                        </ul>

                        <!-- END PAGE TITLE & BREADCRUMB-->

                    </div>

                </div>

                <!-- END PAGE HEADER-->

                <!-- BEGIN PAGE CONTENT-->          

                <div class="row-fluid">

                    <div class="span12 news-page blog-page">

                        <div class="row-fluid">

                            <div class="span8 blog-tag-data">

                                <h1>{$inquiry.subject}</h1>

                                <div class="row-fluid">

                                    <div class="span12 blog-tag-data-inner">

                                        <ul class="unstyled inline">
{if $inquiry.country}
                                            <li><i class="icon-globe"></i> {$inquiry.country}</li>
{/if}
{if $inquiry.ip}
                                            <li><i class="icon-globe"></i>

                                                <a href="http://www.ip138.com/ips138.asp?ip={$inquiry.ip|call:'urlencode'}" target="_blank">{$inquiry.ip}</a>

                                            </li>
{/if}
                                            <li><i class="icon-calendar"></i> {$inquiry.created}</li>
{if $inquiry.contact}
                                            <li><i class="icon-user"></i> {$inquiry.courtesy_title|call:'\enterprise\daos\Contact::courtesyTitle2Text'}&nbsp;{$inquiry.contact}</li>
{/if}
                                            <li><i class="icon-envelope"></i> <a href="mailto:{$inquiry.email}">{$inquiry.email}</a></li>
{if $inquiry.tel}
                                            <li><i class="icon-headphones"></i> {$inquiry.tel}</li>
{/if}
{if $inquiry.fax}
                                            <li><i class="icon-print"></i> {$inquiry.fax}</li>
{/if}
{if $inquiry.company}
                                            <li><i class="icon-group"></i> {$inquiry.company}</li>
{/if}
{if $inquiry.website}
                                            <li><i class="icon-external-link"></i> <a href="{$inquiry.website}" target="_blank">{$inquiry.website}</a></li>
{/if}
                                        </ul>

                                    </div>

                                </div>

                                <div class="news-item-page">{$inquiry.message}</div>

                            </div>

                            <div class="span4">

                            </div>

                        </div>

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

    <script src="media/js/app.js"></script>      

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

        });

    </script>{/literal}

</body>

<!-- END BODY -->

</html>
