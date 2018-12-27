<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
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
        <h3>${seminar.getSeminarName()}</h3>
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
                        <lable class="mylabel">轮次：</lable>
                        <div class="myDiv">
                            <label class="myLabel" style="color:#23c0c0">第${seminar.getRoundId()}轮</label>
                        </div>
                    </div>

                    <div style="margin-bottom:0.5rem">
                        <lable class="mylabel">主题：</lable>
                        <div class="myDiv">
                            <label class="myLabel">${seminar.getSeminarName()}</label>
                        </div>
                    </div>
                    <div>
                        <lable class="mylabel">课次序号：</lable>
                        <div class="myDiv">
                            <label class="myLabel">第${seminar.getSeminarSerial()}次</label>
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
                            <label class="myLabel">
                                <#if status=0>
                                    未开始
                                <#elseif status=1>
                                    正在进行
                                <#elseif status=2>
                                    已结束
                                <#elseif status=3>
                                    暂停
                                </#if>
                            </label>
                            <a href="" style="color: #23c0c0;font-size: 1.5rem">报名情况</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <#if status=1>
            <div style="margin-top:3rem">
            <lable class="mylabel" style="width: 40%">报名开始时间：</lable>
            <div class="myDiv" style="width: 60%">
            <label class="myLabel" style="color: #df7e7e">${seminar.getEnrollStartTime()}</label>
            </div>
            </div>
            <div>
            <lable class="mylabel" style="width: 40%">报名结束时间：</lable>
            <div class="myDiv" style="width: 60%">
            <label class="myLabel" style="color: #df7e7e">${seminar.getEnrollEndTime()}</label>
            </div>
            </div>
            <a href="/student/enroll-detail?id=${student.getId()}&seminarid=${seminar.getId()}">
            <button class="am-btn am-btn-success  am-radius"
                    style="width: 80%;margin-left: 10%;background-color: #23c0c0;border: none;margin-top: 3rem">报名
            </button>
            </a>
        </#if>
    </div>


    <script src="../../../static/js/jquery.min.js"></script>
    <script src="../../../static/js/amazeui.min.js"></script>
    <script src="../../../static/js/app.js"></script>
</body>

</html>