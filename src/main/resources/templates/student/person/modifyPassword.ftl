<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
    <script>
        function standardPost(to){
            var form = $("<form method='post'></form>");
            form.attr({"action": "/student/topnavigation"});
            var input;
            input = $("<input type='hidden'>");
            input.attr({"name": "to"});
            input.val(to);
            form.append(input);
            input = $("<input type='hidden'>");
            input.attr({"name": "id"});
            input.val(window.sessionStorage.getItem("studentId"));
            form.append(input);
            $(document.body).append(form);
            form.submit();
        }

        var bt1 = document.getElementById('bt1');
        $(function () {
            $("#pwd").blur(function () {
                var va = $("#pwd").val();
                if (va.length > 0) {
                    if (va != ${student.getPassword()}) {
                        alert("密码错误")
                        $("#bt1").attr("disabled", true);
                        bt1.style.backgroundColor = "red";
                    } else {
                        bt1.style.backgroundColor = "#23c0c0";
                        $("#bt1").attr("disabled", false);
                    }
                }

            })
            $("#pwd1").blur(function () {
                var val = $("#pwd1").val();
                var val2 = $("#pwd2").val();

                if (val.length > 0) {

                    if (!/^(((?=.*[0-9])(?=.*[a-zA-Z])|(?=.*[0-9])(?=.*[^\s0-9a-zA-Z])|(?=.*[a-zA-Z])(?=.*[^\s0-9a-zA-Z]))[^\s]{8,32})$/.test(val)) {
                        alert("密码格式错误")
                        $("#bt1").attr("disabled", true);
                        bt1.style.backgroundColor = "red";

                    } else if (val != val2) {
                        alert("两次密码输入不一致")
                        $("#bt1").attr("disabled", true);
                        bt1.style.backgroundColor = "red";
                    } else {
                        bt1.style.backgroundColor = "#23c0c0";
                        $("#bt1").attr("disabled", false);
                    }
                }
            })


            $("#pwd2").blur(function () {
                var val = $("#pwd1").val();
                var val2 = $("#pwd2").val();
                if (val2.length > 0) {
                    if (val != val2) {
                        alert("两次密码输入不一致")
                        $("#bt1").attr("disabled", true);
                    } else {
                        bt1.style.backgroundColor = "#23c0c0";
                        $("#bt1").attr("disabled", false);
                    }
                }
            })
        })

    </script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <#--<div class="am-topbar-brand1">-->
        <#--<a href="homepage.html">-->
            <#--<div class="am-icon-chevron-left" style="color: darkgray"></div>-->
        <#--</a>-->
    <#--</div>-->
    <div class="am-topbar-brand">
        <h3>修改密码</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li><a onclick="standardPost('personalInfo')" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a onclick="standardPost('seminar')" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>


<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form" action="/student/newPass" method="post">
                        <div class="am-form-group" style="margin-bottom: 1rem">
                            <input type="password" class="" id="pwd" placeholder="原密码" required="required">
                        </div>
                        <div class="am-form-group" style="margin-bottom: 1rem">
                            <input type="password" class="" id="pwd1" name="newpass" placeholder="填写密码"
                                   required="required">
                            <input name="id" value="${student.getId()}" hidden="hidden"/>
                        </div>
                        <div class="am-form-group">
                            <input type="password" class="" id="pwd2" placeholder="确认密码" required="required">
                        </div>
                        <div class="am-form-group">
                            <p style="font-size: 1rem;margin-top: 5%;">密码长度8-32位，须包含数字、字母、符号至少两种或两种以上元素</p>
                        </div>
                        <input class="am-btn am-btn-success" type="submit" id="bt1" value="确认提交" style="width:100%;">
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="../../../static/js/jquery.min.js"></script>
    <script src="../../../static/js/amazeui.min.js"></script>
    <script src="../../../static/js/app.js"></script>
    <script src="../../../static/js/jquery.min.js"></script>

</body>

</html>