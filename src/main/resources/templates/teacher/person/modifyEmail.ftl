<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>账户邮箱</title>
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
        <h3>账户邮箱</h3>
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
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form" action="/student/newMail" method="post">
                        <div class="am-form-group">
                            <input type="email" name="newmail" id="email" placeholder="填写新邮箱" required="required">
                            <input name="id" value="${teacher.getId()}" hidden="hidden"/>
                            <p class="hidden" id="hidemail" style="float: left;font-size: 1rem;color: #be2924 "></p>
                        </div>
                        <div class="am-form-group">
                            <p style="float: left;font-size: 1rem;margin-top: 5%; ">邮箱格式如： user@host.domainnames</p>
                        </div>
                        <button type="submit" class="am-btn am-btn-success" style="width: 100%;margin-top: 1%">确认提交
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <script src="../../../static/js/jquery.min.js"></script>
    <script src="../../../static/js/amazeui.min.js"></script>
    <script src="../../../static/js/app.js"></script>
</body>

</html>