<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
    <h1>Dashboard</h1>
    <a href="?">主面板</a> | <a href="?action=site_mapping">域名映射</a>
    <hr>
{-if $site_id}
    <a href="?action=edit_site_mapping&site_id={$site_id}">创建</a>
{-/if}
    <table border="1" width="100%">
        <tr>
            <th>#</th>
            <th>站点ID</th>
            <th>根域地址</th>
            <th>创建时间(+8)</th>
            <th>最后修改时间(+8)</th>
            <th>&nbsp;</th>
        </tr>
{foreach $site_mappings as $sm}
        <tr>
            <td>{$sm.id}</td>
            <td>{$sm.site_id}</td>
            <td>{$sm.domain}</td>
            <td>{$sm.created}</td>
            <td>{$sm.updated}</td>
            <td>
                <a href="?action=edit_site_mapping&site_mapping_id={$sm.id}">修改</a>
                <a href="?action=delete_site_mapping&site_mapping_id={$sm.id}">删除</a>
            </td>
        </tr>
{foreachelse}
        <tr>
            <td colspan="6">暂无站点映射</td>
        </tr>
{/foreach}
    </table>
</body>
</html>
