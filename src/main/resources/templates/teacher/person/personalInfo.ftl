<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>个人信息管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
    <script>
        console.log(new Date() + "window.sessionStorage.getItem(): " + window.sessionStorage.getItem("teacherId"));
        function standardPost(to){
            var form = $("<form method='post'></form>");
            form.attr({"action": "/teacher/topnavigation"});
            var input;
            input = $("<input type='hidden'>");
            input.attr({"name": "to"});
            input.val(to);
            form.append(input);
            input = $("<input type='hidden'>");
            input.attr({"name": "id"});
            input.val(window.sessionStorage.getItem("teacherId"));
            form.append(input);
            $(document.body).append(form);
            form.submit();
        }
    </script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <#--<div class="am-topbar-brand1">-->
        <#--<a href="homepage.html">-->
            <#--<div class="am-icon-chevron-left" style="color: darkgray"></div>-->
        <#--</a>-->
    <#--</div>-->
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>账户与设置</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li><a onclick="standardPost('message')" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a onclick="standardPost('seminar')" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g tpl-amazeui-form">
                <div class="">
                    <div>
                        <lable class="mylabel">姓名：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${teacher.getTeacherName()}</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">学号：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${teacher.getAccount()}</label>
                        </div>
                    </div>
                    <#if teacher.getEmail()?exists>
                        <div>
                            <lable class="mylabel">邮箱：</lable>
                            <div class="myDiv">
                                <label class="myLabel">${teacher.getEmail()}</label><br>
                                <div style="margin-top: -1rem;margin-left: 8rem">
                                    <a style="font-size: 1rem;color: #1b961b;" href="javascript:doPost('/teacher/modifyEmail', {'id':'${teacher.getId()}'})">修改</a>
                                <#--<label class="myLabel">${teacher.getEmail()}</label><br>-->
                                <#--<div style="margin-top: -1rem;margin-left: 8rem">-->
                                    <#--<a style="font-size: 1rem;color: #1b961b;" href="javascript:doPost('/teacher/modifyEmail', {'id':'${teacher.getId()}'})">修改</a>-->
                                <#--</div>-->
                            </div>
                        </div>
                    </#if>
                    <div>
                        <lable class="mylabel">账户密码：</lable>
                        <a href="javascript:doPost('/teacher/modifyPassword', {'id':'${teacher.getId()}'})">
                            <div class="myDiv">
                                <label class="am-icon-angle-right"></label>
                            </div>
                        </a>
                    </div>
                    <div>
                        <lable class="mylabel">管理员邮箱：</lable>
                        <div class="myDiv">
                            <label class="myLabel">654321@163.com</label>
                        </div>
                    </div>
                    <a class="am-btn am-btn-success am-radius am-button" style="margin-top: 3rem; float: right;" type="submit" href="/">退出登录</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>