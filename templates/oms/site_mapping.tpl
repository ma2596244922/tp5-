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
{section name=i loop=$site_mappings}
        <tr>
            <td>{$site_mappings[i].id}</td>
            <td>{$site_mappings[i].site_id}</td>
            <td>{$site_mappings[i].domain}</td>
            <td>{$site_mappings[i].created}</td>
            <td>{$site_mappings[i].updated}</td>
            <td>
                <a href="?action=edit_site_mapping&site_mapping_id={$site_mappings[i].id}">修改</a>
                <a href="?action=delete_site_mapping&site_mapping_id={$site_mappings[i].id}">删除</a>
            </td>
        </tr>
{sectionelse}
        <tr>
            <td colspan="6">暂无站点映射</td>
        </tr>
{/section}
    </table>
</body>
</html>
