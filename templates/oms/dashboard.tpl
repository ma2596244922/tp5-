<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
    <h1>Dashboard</h1>
    <a href="?">主面板</a> | <a href="?action=site_mapping">域名映射</a>
    <hr>
    <a href="?action=edit_site">创建</a>
    <table border="1" width="100%">
        <tr>
            <th>#</th>
            <th>描述</th>
            <th>创建时间(+8)</th>
            <th>最后修改时间(+8)</th>
            <th>&nbsp;</th>
        </tr>
{section name=i loop=$sites}
        <tr>
            <td>{$sites[i].id}</td>
            <td>{$sites[i].desc}</td>
            <td>{$sites[i].created}</td>
            <td>{$sites[i].updated}</td>
            <td>
                <a href="?action=edit_site&site_id={$sites[i].id}">修改</a>
                <a href="?action=site_mapping&site_id={$sites[i].id}">域名映射</a>
            </td>
        </tr>
{sectionelse}
        <tr>
            <td colspan="5">暂无站点</td>
        </tr>
{/section}
    </table>
</body>
</html>
