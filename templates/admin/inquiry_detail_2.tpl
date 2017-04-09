<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

    <meta charset="utf-8" />

    <title>{$inquiry.subject}</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <meta content="" name="description" />

    <meta content="" name="author" />

    <!-- BEGIN GLOBAL MANDATORY STYLES -->

{include file="admin/common/styles.tpl"}

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->

    <link href="media/css/bootstrap-fileupload.css" rel="stylesheet" type="text/css" />

    <link href="media/css/chosen.css" rel="stylesheet" type="text/css" />

    <link href="media/css/profile.css" rel="stylesheet" type="text/css" />

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

                <div class="row-fluid profile">

                    <div class="span12">

                        <!--BEGIN TABS-->

                        <div class="tabbable tabbable-custom tabbable-full-width">

                            <div class="tab-content">

                                <div class="tab-pane profile-classic row-fluid active" id="tab_1_2">

                                    <div class="span2">

                                        <img src="{if $target_product|default:[]}{$target_product.head_image_id|url:'enterprise_url_image'}{else}media/image/no_image.png{/if}" alt="" /> 

                                    </div>

                                    <ul class="unstyled span10">
{if $inquiry_country}
                                        <li><span>国家:</span> {$inquiry_country}</li>
{/if}
{if $inquiry.ip}
                                        <li><span>IP地址:</span> <a href="http://www.ip138.com/ips138.asp?ip={$inquiry.ip|call:'urlencode'}" target="_blank">{$inquiry.ip}</a></li>
{/if}
{if $inquiry.created}
                                        <li><span>发布时间:</span> {$inquiry.created}</li>
{/if}
{if $inquiry.contact}
                                        <li><span>联系人:</span> {$inquiry.courtesy_title|call:'\enterprise\daos\Contact::courtesyTitle2Text'}&nbsp;{$inquiry.contact}</li>
{/if}
{if $inquiry.email}
                                        <li><span>Email:</span> <a href="mailto:{$inquiry.email}">{$inquiry.email}</a></li>
{/if}
{if $inquiry.tel}
                                        <li><span>联系电话:</span> {$inquiry.tel}</li>
{/if}
{if $inquiry.fax}
                                        <li><span>传真:</span> {$inquiry.fax}</li>
{/if}
{if $inquiry.company}
                                        <li><span>公司:</span> {$inquiry.company}</li>
{/if}
{if $inquiry.website}
                                        <li><span>网址:</span> <a href="{$inquiry.website}" target="_blank">{$inquiry.website}</a></li>
{/if}

                                        <li>{$inquiry.message}</li>

                                    </ul>

                                </div>

                                <!--end tab-pane-->

                            </div>

                        </div>

                        <!--END TABS-->

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

    <script type="text/javascript" src="media/js/chosen.jquery.min.js"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->

    <script src="media/js/app.js"></script>      

    <!-- END PAGE LEVEL SCRIPTS -->

    <script>{literal}

        jQuery(document).ready(function() {       

           // initiate layout and plugins

           App.init();

        });

    </script>{/literal}

    <!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>