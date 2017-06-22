            <div class="col-lg-2" id="sidebar-outer-container" style="overflow-y:scroll;">
                <div class="list-group">
                    <a class="list-group-item active" href="?action=dashboard">运营管理</a>
                    <a class="list-group-item">
                        <select class="form-control" name="type">
                            <option value="0">全部网站</option>
                            <option value="10">自营</option>
                            <option value="20">赠送</option>
                        </select>
                    </a>
{foreach $all_site_mappings as $sm}
                    <a class="list-group-item" href="?action=site_dashboard&site_id={$sm.site_id}">(上){$sm.domain}</a>
{/foreach}
                </div>
            </div>