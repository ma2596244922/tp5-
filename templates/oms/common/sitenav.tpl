                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand">popost.com</a>
                        </div>

                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li><a href="#" target="_blank">打开网站</a></li>
                                <li><a href="#">超进后台</a></li>
                                <li{if $page_name|default:''=="client_info"} class="active"{/if}><a href="?action=client_info">客户资料</a></li>
                                <li{if $page_name|default:''=="monthly_report"} class="active"{/if}><a href="?action=monthly_report">月度报告</a></li>
                                <li><a href="#">超进任务</a></li>
                                <li{if $page_name|default:''=="input_inquiry"} class="active"{/if}><a href="?action=input_inquiry">匹配询盘</a></li>
                                <li><a href="#">用户管理</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>