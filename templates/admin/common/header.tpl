    <div class="header navbar navbar-inverse navbar-fixed-top">

        <!-- BEGIN TOP NAVIGATION BAR -->

        <div class="navbar-inner">

            <div class="container-fluid">

                <!-- BEGIN LOGO -->

                <a class="brand" href="/">

                <img src="media/image/logo.png" alt="logo" />

                </a>

                <!-- END LOGO -->

                <!-- BEGIN RESPONSIVE MENU TOGGLER -->

                <a href="javascript:;" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">

                <img src="media/image/menu-toggler.png" alt="" />

                </a>          

                <!-- END RESPONSIVE MENU TOGGLER -->            

                <!-- BEGIN TOP NAVIGATION MENU -->              

                <ul class="nav pull-right">

                    <!-- BEGIN USER LOGIN DROPDOWN -->

                    <li class="dropdown user">

                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">

                        <img alt="" src="media/image/avatar.png" />

                        <span class="username">{$user.name}</span>

                        <i class="icon-angle-down"></i>

                        </a>

                        <ul class="dropdown-menu">

                            <li><a href="?action=profile"><i class="icon-user"></i>修改密码</a></li>

                            <li class="divider"></li>

                            <li><a href="?action=logout"><i class="icon-key"></i>退出</a></li>

                        </ul>

                    </li>

                    <!-- END USER LOGIN DROPDOWN -->

                </ul>

                <!-- END TOP NAVIGATION MENU --> 

            </div>

        </div>

        <!-- END TOP NAVIGATION BAR -->

    </div>