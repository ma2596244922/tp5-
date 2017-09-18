            <div class="col-lg-2" id="sidebar-outer-container" style="overflow-y:scroll;">
                <div class="list-group" id="sidebar">
                    <a class="list-group-item active" href="?action=dashboard">运营管理</a>
                    <a class="list-group-item">
                        <select class="form-control" id="select-site-type">
                            <option value="0">全部网站</option>
{foreach $site_types as $type => $label}
                            <option value="{$type}">{$label}</option>
{/foreach}
                            <option value="lang_sites">小语种</option>
                        </select>
                    </a>
{foreach $all_site_mappings as $sm}
                    <a class="list-group-item" href="?action=site_dashboard&site_id={$sm.site_id}" data-role="site-entry" data-type="{$sm.type|escape}" data-other-lang-enabled="{if $sm.lang_codes|default:''}1{else}0{/if}">({if $sm.offline}下{else}上{/if}{if $sm.lang_codes|default:''},语{/if}){$sm.domain}</a>
{/foreach}
                </div>
            </div>