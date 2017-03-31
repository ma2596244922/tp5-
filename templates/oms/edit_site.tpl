<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
    <p>{$error_msg|default:""}</p>
    <form action="?action=edit_site&site_id={$site_id}" method="POST">
        <input type="hidden" name="site_id" value="{$site_id}">
{-if !$site_id}
        <p>根域地址*: <input type="text" name="domain" size="45" value="{$site.domain|default:""|escape}" placeholder="foo.com"></p>
{-/if}
        <p>备注: <input type="text" name="desc" size="30" value="{$site.desc|default:""|escape}" placeholder="Foo"></p>
        <p><input type="submit" name="submit" value="Save"></p>
    </form>
</body>
</html>
