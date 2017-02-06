Inquiries
<table border="1">
    <tr>
        <th>ID</th>
        <th>标题</th>
        <th>国家</th>
        <th>发布时间(+8)</th>
    </tr>
{section name=i loop=$inquiries}
    <tr>
        <td>{$inquiries[i].id}</td>
        <td>
            <a href="?action=inquiry_detail&inquiry_id={$inquiries[i].id}">{$inquiries[i].subject}</a>
        </td>
        <td>{$inquiries[i].country}</td>
        <td>{$inquiries[i].created}</td>
    </tr>
{sectionelse}
    <tr>
        <td colspan="4">暂无任何询盘</td>
    </tr>
{/section}
</table>