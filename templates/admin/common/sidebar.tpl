
        <div class="page-sidebar nav-collapse collapse">

            <!-- BEGIN SIDEBAR MENU -->        

            <ul class="page-sidebar-menu">

                <li>

                    <!-- BEGIN SIDEBAR TOGGLER BUTTON -->

                    <div class="sidebar-toggler hidden-phone"></div>

                    <!-- BEGIN SIDEBAR TOGGLER BUTTON -->

                </li>

                <li class="start{if $page_name=='dashboard'} active{/if}">

                    <a href="/admin/">

                    <i class="icon-dashboard"></i> 

                    <span class="title">主面板</span>

                    </a>

                </li>

                <li class="start{if $page_name=='inquiry'} active{/if}">

                    <a href="?action=inquiry">

                    <i class="icon-envelope"></i> 

                    <span class="title">我的询盘</span>

                    </a>

                </li>

                <li class="start{if $page_name=='group'} active{/if}">

                    <a href="?action=group">

                    <i class="icon-briefcase"></i> 

                    <span class="title">产品分组</span>

                    </a>

                </li>

                <li class="start{if $page_name=='product'} active{/if}">

                    <a href="?action=product">

                    <i class="icon-file"></i> 

                    <span class="title">产品管理</span>

                    </a>

                </li>

                <li class="start{if $page_name=='photo'} active{/if}">

                    <a href="?action=photo">

                    <i class="icon-picture"></i> 

                    <span class="title">公司图片</span>

                    </a>

                </li>

                <li class="start{if $page_name=='certification'} active{/if}">

                    <a href="?action=certification">

                    <i class="icon-legal"></i> 

                    <span class="title">我的证书</span>

                    </a>

                </li>

                <li class="start{if $page_name=='contact'} active{/if}">

                    <a href="?action=contact">

                    <i class="icon-headphones"></i> 

                    <span class="title">管理联系人</span>

                    </a>

                </li>

                <li class="start{if $page_name=='info'} active{/if}">

                    <a href="?action=info">

                    <i class="icon-cogs"></i> 

                    <span class="title">公司信息</span>

                    </a>

                </li>

                <li class="start{if $page_name=='logo'} active{/if}">

                    <a href="?action=logo">

                    <i class="icon-picture"></i> 

                    <span class="title">公司LOGO</span>

                    </a>

                </li>

                <li class="start{if $page_name=='banner'} active{/if}">

                    <a href="?action=banner">

                    <i class="icon-money"></i> 

                    <span class="title">Banner 管理</span>

                    </a>

                </li>

                <li class="start{if $page_name=='custom_page'} active{/if}">

                    <a href="?action=custom_page">

                    <i class="icon-file"></i> 

                    <span class="title">Webmasters 验证</span>

                    </a>

                </li>

                <li class="start{if $page_name=='fragment'} active{/if}">

                    <a href="?action=fragment">

                    <i class="icon-cog"></i> 

                    <span class="title">页面镶嵌代码</span>

                    </a>

                </li>

                <li class="start{if $page_name=='email_template'} active{/if}">

                    <a href="?action=email_template">

                    <i class="icon-envelope"></i> 

                    <span class="title">EDM邮件模板</span>

                    </a>

                </li>
{if $user.advanced}
                <li class="start{if $page_name=='task'} active{/if}">

                    <a href="?action=task">

                    <i class="icon-tasks"></i> 

                    <span class="title">我的任务</span>

                    </a>

                </li>
{/if}
                <li class="start{if $page_name=='index_products'} active{/if}">

                    <a href="?action=index_products">

                    <i class="icon-sun"></i> 

                    <span class="title">首页产品设置</span>

                    </a>

                </li>

                <li class="start{if $page_name=='user_voices'} active{/if}">

                    <a href="?action=user_voices">

                    <i class="icon-user"></i> 

                    <span class="title">首页用户赠言</span>

                    </a>

                </li>

            </ul>

            <!-- END SIDEBAR MENU -->

        </div>