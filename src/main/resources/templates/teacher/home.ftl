<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../static/i/favicon.png">
    <link rel="stylesheet" href="../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <link rel="stylesheet" href="../../static/css/app.css">
    <script src="../../static/js/echarts.min.js"></script>
    <script>
        window.sessionStorage.setItem("teacherId", "${teacher.getId()}");
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
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>${teacher.getTeacherName()}</h3>
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
                <div class="am-u-sm-12" style="text-align: right">
                    <label>${teacher.getTeacherName()}</label>

                    <div class="am-u-sm-12">
                        <label style="text-align: right">${teacher.getAccount()}</label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="tpl-portlet-components2">
        <li class="tpl-left-nav-item">
            <form id="_form" action="/teacher/courseManage" method="post">
                <a onclick="document.getElementById('_form').submit();" class="nav-link tpl-left-nav-link-list">
                    <i class="am-icon-book"></i>
                    <label style="font-size: 1.8rem;">我的课程</label>
                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                    <input value="${teacher.getId()}" name="id" hidden="hidden">
                </a>
            </form>


            <form id="sform" action="/teacher/personalInfo" method="post">
                <a onclick="document.getElementById('sform').submit();" class="nav-link tpl-left-nav-link-list">
                    <i class="am-icon-unlock-alt"></i>
                    <label style="font-size: 1.8rem;">账户与设置</label>
                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                    <input value="${teacher.getId()}" name="id" hidden="hidden">
                </a>
            </form>

        </li>
    </div>
</div>

<script src="../../static/js/jquery.min.js"></script>
<script src="../../static/js/amazeui.min.js"></script>
<script src="../../static/js/app.js"></script>
</body>

</html>