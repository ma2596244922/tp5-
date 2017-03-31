<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
{if isset($error_msg)}
    <p>{$error_msg}</p>
{/if}
    <form action="?action=login" method="POST">
        <p>User: <input type="text" name="user"></p>
        <p>Password: <input type="password" name="password"></p>
        <p><input type="submit" name="submit" value="Login"></p>
    </form>
</body>
</html>
