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
</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="homepage.html">
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

            <li><a href="index_message.html" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a>
            </li>
            <li><a href="javascript:doPost('/student/personalInfo', {'id':'${student.getId()}'})"
                   class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a href="javascript:doPost('/student/seminar', {'id':'${student.getId()}'})"
                   class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="/" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>

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
                            <label class="myLabel">${student.getStudentName()}</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">学号：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${student.getAccount()}</label>
                        </div>
                    </div>
                    <#if student.getEmail()?exists>
                        <div>
                        <lable class="mylabel">邮箱：</lable>
                        <div class="myDiv">
                        <label class="myLabel">${student.getEmail()}</label>
                    <br>
                        <div style="margin-top: -1rem;margin-left: 8rem">
                    <a style="font-size: 1rem;color: #1b961b;"
                    href="javascript:doPost('/student/modifyEmail', {'id':'${student.getId()}'})">修改</a>
                        </div>
                        </div>
                        </div>
                    </#if>
                    <div>
                        <lable class="mylabel">账户密码：</lable>
                        <a href="javascript:doPost('/student/modifyPassword', {'id':'${student.getId()}'})">
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
                    <button class="am-btn am-btn-success am-radius am-button" style="margin-top: 3rem" type="submit"
                            onclick="window.open('')">退出登录
                    </button>
                </div>
            </div>


        </div>


        <script src="../../../static/js/jquery.min.js"></script>
        <script src="../../../static/js/amazeui.min.js"></script>
        <script src="../../../static/js/app.js"></script>
</body>

</html>