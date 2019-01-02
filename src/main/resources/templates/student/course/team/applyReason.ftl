<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>激活账号</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../static/i/favicon.png">
    <link rel="stylesheet" href="../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <link rel="stylesheet" href="../../static/css/app.css">
    <script src="../../static/js/echarts.min.js"></script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand" style="width:75%;text-align: center">
        <h3>申请理由</h3>
    </div>
</header>

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form" action="/student/application" method="post">
                        <div class="am-form-group" style="margin-bottom: 1rem">
                            <input type="text" placeholder="申请理由" name="reason">
                            <input name="id" value="${student.getId()}" hidden="hidden"/>
                            <input name="course_id" value="${course.getId()}" hidden="hidden"/>
                            <a class="am-btn am-btn-danger" value="取消" style="width:40%; float: left;" href="javascript:doPost('/student/courseManage', {'id':'${student.getId()}'})">
                            <input class="am-btn am-btn-success" type="submit" value="确认" style="width:40%; float: right;">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../../static/js/jquery.min.js"></script>
<script src="../../static/js/amazeui.min.js"></script>
<script src="../../static/js/app.js"></script>
</body>

</html>