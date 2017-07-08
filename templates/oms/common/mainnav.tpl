                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand">运营管理</a>
                        </div>

                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li{if $page_name|default:''=="new_site"} class="active"{/if}><a href="?action=new_site">网站开通</a></li>
                                <li{if $page_name|default:''=="site_stats"} class="active"{/if}><a href="?action=site_stats">网站统计</a></li>
                                <li{if $page_name|default:''=="inquiry_stats"} class="active"{/if}><a href="?action=inquiry_stats">询盘统计</a></li>
                                <li{if $page_name|default:''=="check_inquiry"} class="active"{/if}><a href="?action=check_inquiry">询盘审核</a></li>
                                <li{if $page_name|default:''=="industry"} class="active"{/if}><a href="?action=industry">行业管理</a></li>
                                <li{if $page_name|default:''=="vps"} class="active"{/if}><a href="?action=vps">VPS管理</a></li>
                                <li{if $page_name|default:''=="operator"} class="active"{/if}><a href="?action=operator">帐号设置</a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="?action=dashboard1">旧主面板</a></li>
                                <li><a href="?action=password">修改密码</a></li>
                                <li><a href="?action=logout">退出登录</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>