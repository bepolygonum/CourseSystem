<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="../../static/i/favicon.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <link rel="stylesheet" href="../../static/css/app.css">
    <script src="../../static/js/echarts.min.js"></script>
    <script>
        console.log(new Date() + "window.sessionStorage.getItem('teacherId'): " + window.sessionStorage.getItem("teacherId"));
        function standardPost(to){
            var form = $("<form method='post'></form>");
            form.attr( {"action": "/teacher/topnavigation"});
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
        <#--<form id="_form" action="/teacher/home" method="post">-->
            <#--<a onclick="document.getElementById('_form').submit();">-->
                <#--<input value="${id}" name="id" hidden="hidden">-->
                <#--<div class="am-icon-chevron-left" style="color: darkgray"></div>-->
            <#--</a>-->
        <#--</form>-->
    <#--</div>-->
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>课程管理</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li><a onclick="standardPost('message')" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a onclick="standardPost('personalInfo')" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a onclick="standardPost('seminar')" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>

</header>

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">
                <#if courseList?exists>
                    <#list  courseList as item>
                        <div class="am-u-sm-12">
                        <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                        <label class="courseName">${item.getCourseName()}</label>
                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">
                        <li class="tpl-left-nav-item">
                    <a href="/teacher/course/grade?id=${id}&courseId=${item.getId()}">
                            <span>学生成绩</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                    <a href="/teacher/course/teamList?id=${id}&courseId=${item.getId()}">
                            <span>学生组队</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                    <a href="/teacher/course/info?id=${id}&courseId=${item.getId()}">
                            <span>课程信息</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                    <a href="/teacher/course/klassList?id=${id}&courseId=${item.getId()}">
                            <span>班级信息</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                    <a href="/teacher/course/seminar?id=${id}&courseId=${item.getId()}">
                            <span>讨论课设置</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                    <a href="/teacher/course/share?id=${id}&courseId=${item.getId()}">
                        <span>共享设置</span>
                        <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        </li>
                        </ul>
                        </li>
                        </form>
                        </div>
                    </#list>
                </#if>
            </div>
        </div>

    </div>

    <div class="tpl-portlet-components" style="margin-bottom: 0px; padding: 1rem 1rem;">
        <a class="am-btn am-btn-success" style="width: 100%;" href="/teacher/course/createCourse?id=${id}"><i class="am-icon-plus" style="margin: 0 2%"></i>新建课程</a>
    </div>
</div>

<script src="../../static/js/jquery.min.js"></script>
<script src="../../static/js/amazeui.min.js"></script>
<script src="../../static/js/app.js"></script>
</body>

</html>