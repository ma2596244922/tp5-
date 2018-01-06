
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

                <li{if $page_name=='group' || $page_name=='product'} class="active"{/if}>

                    <a href="javascript:;">

                    <i class="icon-file"></i> 

                    <span class="title">产品管理</span>

                    <span class="selected"></span>

                    <span class="arrow open"></span>

                    </a>

                    <ul class="sub-menu">

                        <li{if $page_name=='group'} class="active"{/if}>

                            <a href="?action=group">

                                <i class="icon-briefcase"></i>

                                 <span class="title">产品分组</span>

                            </a>

                        </li>

                        <li{if $page_name=='product'} class="active"{/if}>

                            <a href="?action=product">

                                <i class="icon-file"></i>

                                <span class="title">产品管理</span>

                            </a>

                        </li>

                    </ul>

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

                <li class="start{if $page_name=='favicon'} active{/if}">

                    <a href="?action=favicon">

                    <i class="icon-star"></i> 

                    <span class="title">收藏夹小图标</span>

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
                <li{if $page_name=='fragment' || $page_name=='index_products' || $page_name=='user_voice' || $page_name=='index_tdk' || $page_name=='product_tdk' || $page_name=='picture' || $page_name=='index_keyword' || $page_name=='hide'} class="active"{/if}>

                    <a href="javascript:;">

                    <i class="icon-sun"></i> 

                    <span class="title">站点设置</span>

                    <span class="selected"></span>

                    <span class="arrow open"></span>

                    </a>

                    <ul class="sub-menu">
{if $user.advanced}
                        <li class="start{if $page_name=='picture'} active{/if}">

                            <a href="?action=picture">

                            <i class="icon-picture"></i> 

                            <span class="title">图片银行</span>

                            </a>

                        </li>
{/if}
                        <li class="start{if $page_name=='fragment'} active{/if}">

                            <a href="?action=fragment">

                            <i class="icon-cog"></i> 

                            <span class="title">页面镶嵌代码</span>

                            </a>

                        </li>

                        <li class="start{if $page_name=='index_products'} active{/if}">

                            <a href="?action=index_products">

                            <i class="icon-sun"></i> 

                            <span class="title">首页产品设置</span>

                            </a>

                        </li>
{if $user.advanced}
                        <li class="start{if $page_name=='index_tdk'} active{/if}">

                            <a href="?action=index_tdk">

                            <i class="icon-edit"></i> 

                            <span class="title">首页TDK</span>

                            </a>

                        </li>
{/if}
                        <li class="start{if $page_name=='user_voice'} active{/if}">

                            <a href="?action=user_voice">

                            <i class="icon-comments"></i> 

                            <span class="title">用户赠言</span>

                            </a>

                        </li>
{if $user.advanced}
                        <li class="start{if $page_name=='product_tdk'} active{/if}">

                            <a href="?action=product_tdk">

                            <i class="icon-edit"></i> 

                            <span class="title">TDK自行设计</span>

                            </a>

                        </li>
{/if}
                        <li class="start{if $page_name=='product_default_image'} active{/if}">

                            <a href="?action=product_default_image">

                            <i class="icon-picture"></i> 

                            <span class="title">产品默认图片</span>

                            </a>

                        </li>
{if $user.advanced}
                        <li class="start{if $page_name=='main_product'} active{/if}">

                            <a href="?action=main_product">

                            <i class="icon-file"></i> 

                            <span class="title">全局主推产品</span>

                            </a>

                        </li>
{/if}
                        <li class="start{if $page_name=='common_bg_image'} active{/if}">

                            <a href="?action=common_bg_image">

                            <i class="icon-picture"></i> 

                            <span class="title">全站背景图片</span>

                            </a>

                        </li>
{if $user.advanced}
                        <li class="start{if $page_name=='index_keyword'} active{/if}">

                            <a href="?action=index_keyword">

                            <i class="icon-key"></i> 

                            <span class="title">首页关键词</span>

                            </a>

                        </li>

                        <li class="start{if $page_name=='hide'} active{/if}">

                            <a href="?action=hide">

                            <i class="icon-ban-circle"></i> 

                            <span class="title">屏蔽配置</span>

                            </a>

                        </li>
{/if}
                    </ul>

                </li>

                <li class="start{if $page_name=='news'} active{/if}">

                    <a href="?action=news">

                    <i class="icon-coffee"></i> 

                    <span class="title">新闻管理</span>

                    </a>

                </li>
{if $user.advanced}
                <li class="start{if $page_name=='hide_track'} active{/if}">

                    <a href="?action=hide_track">

                    <i class="icon-book"></i> 

                    <span class="title">屏蔽记录</span>

                    </a>

                </li>
{/if}
            </ul>

            <!-- END SIDEBAR MENU -->

        </div>