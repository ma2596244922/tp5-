    <div class="header navbar navbar-inverse navbar-fixed-top">

        <!-- BEGIN TOP NAVIGATION BAR -->

        <div class="navbar-inner">

            <div class="container{if $tpl_style|default:'default'=='default'}-fluid{/if}">

                <!-- BEGIN LOGO -->

                <a class="brand" href="/">

                <img src="media/image/logo.png" alt="logo" width="86" height="14" />

                </a>

                <!-- END LOGO -->

                <!-- BEGIN RESPONSIVE MENU TOGGLER -->

                <a href="javascript:;" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">

                <img src="media/image/menu-toggler.png" alt="" />

                </a>          

                <!-- END RESPONSIVE MENU TOGGLER -->

                <!-- BEGIN TOP NAVIGATION MENU -->

                <ul class="nav pull-right">
{if $user.advanced && !$oms_site.enable_translator}
                    <!-- BEGIN LANG DROPDOWN -->

                    <li class="dropdown">

                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">

                        {if $cur_lang_code=='en'}英语{else}{$supported_lang_codes.$cur_lang_code.label}{/if}

                        <i class="icon-angle-down"></i>

                        </a>

                        <ul class="dropdown-menu">

                            <li><a href="//{if $default_lang_code=='en'}www{else}en{/if}.{$site_root_domain}/admin/"><i class="icon-globe"></i> 英语</a></li>
    {-foreach $supported_lang_codes as $lang_code => $def}
                            <li><a href="//{if $default_lang_code==$lang_code}www{else}{$lang_code}{/if}.{$site_root_domain}/admin/"><i class="icon-globe"></i> {$def.label}</a></li>
    {-/foreach}
                        </ul>

                    </li>

                    <!-- END LANG DROPDOWN -->
{/if}
                    <!-- BEGIN USER LOGIN DROPDOWN -->

                    <li class="dropdown user">

                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">

                        <img alt="" src="media/image/avatar.png" />

                        <span class="username">{$user.name}</span>

                        <i class="icon-angle-down"></i>

                        </a>

                        <ul class="dropdown-menu">
{if $tpl_style == 'default'}
                            <li><a href="?action=profile"><i class="icon-cog"></i> 帐号配置</a></li>

                            <li><a href="?action=logo"><i class="icon-picture"></i> 公司LOGO</a></li>

                            <li><a href="?action=favicon"><i class="icon-star"></i> 收藏夹小图标</a></li>
{/if}
                            <li><a href="?action=password"><i class="icon-user"></i> 修改密码</a></li>

                            <li class="divider"></li>

                            <li><a href="?action=logout"><i class="icon-key"></i> 退出</a></li>

                        </ul>

                    </li>

                    <!-- END USER LOGIN DROPDOWN -->
{if $page_name|default:''=='edit_product'}
    {-include file="admin/edit_product_floating_widget.tpl"}
{/if}
                </ul>

                <!-- END TOP NAVIGATION MENU --> 

            </div>

        </div>

        <!-- END TOP NAVIGATION BAR -->

    </div>