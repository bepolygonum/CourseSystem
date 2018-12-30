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
        <div class="am-form">
            <div class="am-form-group">
                <input type="text" name="account"  id="userName" placeholder="教工号/学号">
            </div>
            <div class="am-form-group">
                <input type="password" name="password" class="" id="userPassword" placeholder="密码">
            </div>
            <div class="am-form-group">
                <div id="tipBar" style="color: #FFF"></div>
            </div>
            <div class="login-font">
                <a href="/forgetPassword">忘记密码 </a>
            </div>
            <p><button type="submit" class="am-btn am-btn-default" onclick="login()">登录</button></p>
        </div>
        <div class="login-down">
            <i>初次登录默认密码为123456</i>
        </div>
    </div>
</div>
<script type="text/javascript">
    function login() {
        var username=document.getElementById("userName").value;
        var password=document.getElementById("userPassword").value;
        if(!username||username=="")
        {
            return false;
        }
        if(!password||password=="")
        {
            return false;
        }
        $.ajax({
            url: "/login",
            data: {
                "account":username,
                "password":password
            },
            type:"POST",
            success:function(JSON,status){
                if(JSON.toString()=="[ROLE_STUDENT]")
                    window.location.href="/student/index";
                if(JSON.toString()=="[ROLE_TEACHER]")
                    window.location.href="/teacher/index";
            },
            error:function (data) {
                document.getElementById("tipBar").innerText="用户名或密码错误";
            }
        });
    }
</script>
<script src="../static/js/jquery.min.js"></script>
<script src="../static/js/amazeui.min.js"></script>
<script src="../static/js/app.js"></script>
</body>

</html>