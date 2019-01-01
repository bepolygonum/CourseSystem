<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>讨论课</title>
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

<body >
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>课程名</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li><a onclick="standardPost('message')" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a onclick="standardPost('personalInfo')" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>
<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
    <#list courseList as course>
        <div class="am-g">
            <div class="am-u-sm-12">
                <li class="tpl-left-nav-item">
                    <a href="/teacher/course/seminar?id=${course.getTeacherId()}&courseId=${course.getId()}" class="nav-link tpl-left-nav-link-list">
                        <i class="am-icon-book"></i>
                        <span>${course.getCourseName()}</span>
                    </a>
                </li>
            </div>
        </div>
    </#list>
        </div>
    </div>
    <button type="submit" class="am-btn am-btn-default" style="float:right;margin-top:5%;background-color: red;color: #ffffff;">正在进行讨论课</button>
    <#list courseKlassList as courseKlass>
        <#list  klassList as klass>
            <#list  seminarList as seminar>
                <#if klass_index==courseKlass_index&&seminar_index==klass_index>
                    <a href="/teacher/seminarRunning?klassid=${klass.getId()}&seminarid=${seminar.getId()}">${courseKlass.getCourseName()}-${klass.getGrade()}级${klass.getKlassSerial()}班-${seminar.getSeminarName()}</a>
                </#if>
            </#list>
        </#list>
    </#list>
</div>
<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>