<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
    <p>{$error_msg|default:""}</p>
    <form action="?action=edit_site_mapping&site_mapping_id={$site_mapping_id}" method="POST">
        <p>根域地址*: <input type="text" name="domain" size="45" value="{$site_mapping.domain|default:""|escape}" placeholder="foo.com"></p>
        <p>站点ID: <input type="text" name="site_id" size="30" value="{$site_mapping.site_id|default:$site_id|escape}" readonly></p>
        <p><input type="submit" name="submit" value="Save"></p>
    </form>
</body>
</html>
