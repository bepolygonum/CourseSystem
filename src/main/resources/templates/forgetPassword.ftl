<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>忘记密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../static/i/favicon.png">
    <link rel="stylesheet" href="../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../static/css/admin.css">
    <link rel="stylesheet" href="../static/css/app.css">
    <script src="../static/js/echarts.min.js"></script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="/login">
            <div class="am-icon-times" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand" style="width:75%;text-align: center">
        <h3>忘记密码</h3>
    </div>
</header>

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form" action="/findPwd" method="post">
                        <div class="am-form-group" style="margin-bottom: 1rem">
                            <input type="text" class="" id="account" name="account" placeholder="学号/教工号">
                        </div>
                        <div class="am-form-group" style="margin-top: 2rem">
                            <p style="font-size: 1.5rem">发送验证码到邮箱</p>
                        </div>
                        <div class="am-form-group" style="margin-top: -2rem">
                            <input type="text" style="width: 50%;float: left" id="captcha" name="code" placeholder="验证码">
                            <input id="btnSendCode" type="button" style="width: 50%;" class="am-btn-success am-btn" value="发送验证码" onclick="sendMessage()" /></p>
                        </div>
                        <button type="submit" class="am-btn am-btn-success" style="width: 100%;">确认提交</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        var InterValObj; // timer变量，控制时间
        var count = 120; // 间隔函数，1秒执行
        var account;
        var curCount;// 当前剩余秒数
        function sendMessage() {
            account= document.getElementById("account").value;
            curCount = count;

            $("#btnSendCode").attr("disabled", "true");
            $("#btnSendCode").val("验证码(" + curCount + "s)");
            InterValObj = window.setInterval(SetRemainTime, 1000); // 启动计时器，1秒执行一次
// 向后台发送处理数据
            $.ajax({
                type : "POST",
                url : "/send",
                data :"account="+account,
                dataType: "json",
                success : function(msg) {
                    alert(msg.msg);
                }
            });
        }
        // timer处理函数
        function SetRemainTime() {
            if (curCount == 0) {
                window.clearInterval(InterValObj);// 停止计时器
                $("#btnSendCode").removeAttr("disabled");// 启用按钮
                $("#btnSendCode").val("重新发送验证码");
                code = ""; // 清除验证码。如果不清除，过时间后，输入收到的验证码依然有效
            } else {
                curCount--;
                $("#btnSendCode").val("验证码(" + curCount + "s)");
            }
        }
    </script>
    <script src="../static/js/jquery.min.js"></script>
    <script src="../static/js/amazeui.min.js"></script>
    <script src="../static/js/app.js"></script>
</body>

</html>