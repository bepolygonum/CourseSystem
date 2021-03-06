<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
    <script>
        console.log(new Date() + "window.sessionStorage.getItem(): " + window.sessionStorage.getItem("studentId"));
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
        <h3>${course.getCourseName()}</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">
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

<div class="tpl-page-container tpl-page-header-fixed">
    <div class="tpl-portlet-components">
        <div class="tpl-block">
            <div class="am-g">
                <#list roundList as round>
                    <div class="am-u-sm-12">
                    <li class="tpl-left-nav-item">
                    <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                    <span>第${round.getRoundSerial()}轮</span>
                <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                    </a>
                    <ul class="tpl-left-nav-sub-menu">
                    <li class="tpl-left-nav-item">

                    <#list seminarList?sort_by("roundId") as seminar>
                        <#if seminar.getRoundId()==round.getId()>
                            <a href="/student/seminar-detail?id=${student.getId()}&seminarid=${seminar.getId()}">
                            <span>${seminar.getSeminarName()}</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                            </a>
                        </#if>
                    </#list>

                    </li>
                    </ul>
                    </li>
                    </div>
                </#list>

            </div>
        </div>
    </div>


    <script src="../../../static/js/jquery.min.js"></script>
    <script src="../../../static/js/amazeui.min.js"></script>
    <script src="../../../static/js/app.js"></script>
</body>

</html>