<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>新建讨论课</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <form id="_form" action="/teacher/courseManage" method="post">
            <a onclick="document.getElementById('_form').submit();">
                <input value="${id}" name="id" hidden="hidden">
                <div class="am-icon-times" style="color: darkgray"></div>
            </a>
        </form>
    </div>
    <div class="am-topbar-brand">
        <h3>新建课程</h3>
    </div>
</header>
<form action="/teacher/course/createCourse" method="post" onsubmit="return test();">
    <div class="tpl-page-container1 tpl-page-header-fixed">
        <div class="tpl-portlet-components2">
            <hr>
                <input value="${id}" name="id" hidden="hidden">
            <div style="text-align: center" class="top"><input type="text" placeholder="课程名称" id="courseName" name="courseName" style="width: 90%;"></div>
            <hr>
            <div style="text-align: center">
                <textarea   placeholder="课程要求" id="courseRequest"
                            name="courseRequest" style="border: none;width: 90%;"></textarea>
            </div>
            <hr>
            <p style="margin-left: 6%">成绩计算规则</p>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">课堂展示:</p>
                <input id="presentation" name="presentation" style="width: 30%;margin-left: 10%;float: left" class="border"  type="number"/><p>%</p>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">课堂提问:</p>
                <input id="question" name="question" style="width: 30%;margin-left: 10%;float: left" class="border"  type="number"/><p>%</p>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">书面报告:</p>
                <input id="report" name="report" style="width: 30%;margin-left: 10%;float: left" class="border"  type="number"/><p>%</p>
            </div>
            <hr>
            <p style="margin-left: 6%">组队时间限制</p>
            <div>
                <p style="width: 30%;float: left;margin-left: 6%">开始时间:</p>
                <input id="startDateTime" name="startDateTime" style="width: 55%;" class="border"  type="datetime-local"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">结束时间:</p>
                <input id="endDateTime" name="endDateTime" style="width: 55%;" class="border"  type="datetime-local"/>
            </div>
            <button type="submit" class="am-btn am-btn-success" style="width: 80%;margin-left: 10%;margin-top: 3rem;margin-bottom: 3rem">保存</button>
        </div>

    </div>

</form>
<script>
    function test() {
        var courseName = document.getElementById('courseName');
        var courseRequest = document.getElementById('courseRequest')
        var presentation = document.getElementById('presentation');
        var question = document.getElementById('question');
        var report = document.getElementById('report');
        var startDateTime = document.getElementById('startDateTime');
        var endDateTime = document.getElementById('endDateTime');
        if (courseName.value == '' | courseRequest.value == '' |presentation.value==''| question.value == '' |
                report.value == '' | startDateTime.value == '' | endDateTime.value == '') {
            alert("These items cannot be empty!");
            return false;
        }
        return true;
    }
</script>
<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>