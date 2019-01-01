<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>讨论课信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>
</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="courselist.html">
            <div class="am-icon-times" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>${course.getCourseName()}-讨论课</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">

            <li><a href="index_message.html" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a href="index_personal.html" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a href="index_personal.html" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="login.html" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>

        </ul>
    </div>
</header>
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g tpl-amazeui-form">
                <div class="">
                    <div>
                        <lable class="mylabel">轮次：</lable>
                        <div class="myDiv">
                            <label class="myLabel">第${round.getRoundSerial()}轮</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">主题：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${seminar.getSeminarName()}</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">课次序号：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${seminar.getSeminarSerial()}</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">要求：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${seminar.getIntroduction()}</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">课程情况：</lable>
                        <div class="myDiv">
                            <label class="myLabel">正在进行<a href="editseminar.html" style=" word-break: keep-all; white-space: nowrap;margin-left:1%; text-decoration:underline; ">查看信息</a></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button class="am-btn am-btn-success" style="width: 100%;margin: 1% 0;" type="submit" onclick="window.location.href='startseminar.html'">开始讨论课</button>
    </div>
</div>

<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>