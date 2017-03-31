<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
    <p>{$error_msg|default:""}</p>
    <form action="?action=edit_site&site_id={$site_id}" method="POST">
        <input type="hidden" name="site_id" value="{$site_id}">
        <p>备注: <input type="text" name="desc" size="30" value="{$site.desc|default:""|escape}"></p>
        <p><input type="submit" name="submit" value="Save"></p>
    </form>
</body>
</html>
