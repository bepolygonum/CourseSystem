<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Log In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="../static/i/favicon.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../static/css/admin.css">
    <link rel="stylesheet" href="../static/css/app.css">
</head>

<body data-type="login">

<div class="am-g myapp-login">
    <div class="am-u-sm-10 login-am-center">
        <div class="myapp-login-logo-text">
            讨论课系统登录
        </div>
        <form class="am-form" action="/index" method="post">
            <div class="am-form-group">
                <input type="text" name="account"  id="doc-ipt-email-1" placeholder="教工号/学号">
            </div>
            <div class="am-form-group">
                <input type="password" name="password" class="" id="doc-ipt-pwd-1" placeholder="密码">
            </div>
            <div class="login-font">
                <a href="forget.html">忘记密码 </a>
            </div>
            <p><button type="submit" class="am-btn am-btn-default">登录</button></p>
        </form>
        <div class="login-down">
            <i>初次登录默认密码为123456</i>
        </div>
    </div>
</div>

<script src="../static/js/jquery.min.js"></script>
<script src="../static/js/amazeui.min.js"></script>
<script src="../static/js/app.js"></script>
</body>

</html>