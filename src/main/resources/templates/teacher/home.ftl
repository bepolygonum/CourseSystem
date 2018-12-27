<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../static/i/favicon.png">
    <link rel="stylesheet" href="../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../static/css/admin.css">
    <link rel="stylesheet" href="../../static/css/app.css">
    <script src="../../static/js/echarts.min.js"></script>
    <script>
        function doPost(to) { // to:提交动作（action）,p:参数
            var myForm = document.createElement("form");
            myForm.method = "post";
            myForm.action = to;

            var myInput = document.createElement("input");
            myInput.setAttribute("name", "id"); // 为input对象设置name

            myInput.setAttribute("value", "${teacher.getId()}"); // 为input对象设置value
            myForm.appendChild(myInput);

            document.body.appendChild(myForm);
            myForm.submit();
            document.body.removeChild(myForm); // 提交后移除创建的form
        }
    </script>
</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="seminar.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>${teacher.getTeacherName()}</h3>
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

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12"  style="text-align: right">
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
         <!--   <a href="javascript:doPost('teacher/courseManage')" class="nav-link tpl-left-nav-link-list">-->
                <a onclick="document.getElementById('_form').submit();" class="nav-link tpl-left-nav-link-list">
                    <i class="am-icon-book"></i>
                    <label style="font-size: 1.8rem;">我的课程</label>
                <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                    <input value="${teacher.getId()}" name="id" hidden="hidden">
          <!--  </a> -->
                </a>
            </form>

            <a class="nav-link tpl-left-nav-link-list">
                <i class="am-icon-unlock-alt"></i>
                <label style="font-size: 1.8rem;">账户与设置</label>
                <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
            </a>
        </li>
    </div>
</div>

<script src="../../static/js/jquery.min.js"></script>
<script src="../../static/js/amazeui.min.js"></script>
<script src="../../static/js/app.js"></script>
</body>

</html>