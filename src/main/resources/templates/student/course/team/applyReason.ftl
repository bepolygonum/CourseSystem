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


<div class="tpl-page-container1 tpl-page-header-fixed" style="margin:18rem 0rem;">
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form" action="/student/application" method="post">
                        <div class="am-form-group" style="margin: 5rem，0">
                            <input type="text" class="" name="reason" placeholder="申请理由">
                            <input name="id" value="${student.getId()}" hidden="hidden"/>
                            <input name="course_id" value="${course.getId()}" hidden="hidden"/>
                        </div>
                        <button type="submit" class="am-btn am-btn-success" style="width: 100%;">确认提交</button>
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