                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand">{$site_mappings[0].domain}</a>
                        </div>

                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li><a href="http://{$site_mappings[0].domain}/" target="_blank">打开网站</a></li>
                                <li><a href="?action=super_login&site_id={$smarty.get.site_id}" target="_blank">超进后台</a></li>
                                <li{if $page_name|default:''=="client_info"} class="active"{/if}><a href="?action=client_info&site_id={$smarty.get.site_id}">客户资料</a></li>
                                <li{if $page_name|default:''=="monthly_report"} class="active"{/if}><a href="?action=monthly_report&site_id={$smarty.get.site_id}">月度报告</a></li>
                                <li><a href="?action=super_login&site_id={$smarty.get.site_id}&redirect_to=/admin/?action=task" target="_blank">超进任务</a></li>
                                <li{if $page_name|default:''=="input_inquiry"} class="active"{/if}><a href="?action=input_inquiry&site_id={$smarty.get.site_id}">匹配询盘</a></li>
                                <li{if $page_name|default:''=="user"} class="active"{/if}><a href="?action=user&site_id={$smarty.get.site_id}">用户管理</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>