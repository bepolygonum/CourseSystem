<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>新建讨论课</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <form id="_form" action="/teacher/course/seminar" method="get">
            <a onclick="document.getElementById('_form').submit();">
                <input value="${id}" name="id" hidden="hidden">
                <input value="${course.getId()}" name="courseId" hidden="hidden">
                <div class="am-icon-times" style="color: darkgray"></div>
            </a>
        </form>
    </div>
    <div class="am-topbar-brand">
        <h3>${course.getCourseName()}</h3>
    </div>
</header>
<form action="/teacher/course/seminar/createSeminar" method="post" onsubmit="return test();">
    <div class="tpl-page-container1 tpl-page-header-fixed">
        <div class="tpl-portlet-components2">
            <hr>
            <input value="${id}" name="id" hidden="hidden">
            <input value="${course.getId()}" name="courseId" hidden="hidden">
            <div style="text-align: center">
                <h3 style="margin-top: 1rem">新建讨论课</h3>
            </div>
            <hr>
            <div style="text-align: center"><input type="text" placeholder="讨论课主题" name="seminarName" id="seminarName" style="width: 90%;"></div>
            <hr>
            <div style="text-align: center">
                <textarea   placeholder="讨论课主要内容" style="border: none;width: 90%;" name="mainContent" id="mainContent"></textarea>
            </div>
            <hr>
            <div style="margin-top: 1rem">

                <p style="margin-left: 1rem;float: left;width: 40%" >讨论课次序号</p>

                <select data-am-selected="{btnWidth: '40%',}" style="width: 60%"  id="serial" name="serial">
                    <option value="1">1</option>
                    <#if seminarList?exists>
                    <#list seminarList as seminar>
                    <option value="${seminar.getSeminarSerial()+1}">${seminar.getSeminarSerial()+1}</option>
                    </#list>
                    </#if>
                </select>
            </div>
            <hr>
            <div style="margin-top: 1rem">

                <p style="margin-left: 1rem;float: left;width: 40%" >讨论课可见</p>
                <label class="am-radio" style="margin-left: 50%">
                    <input type="checkbox" name="isVisible" id="isVisible" value="1" data-am-ucheck style="margin-top: 0.4rem">
                    可见
                </label>
            </div>
            <hr>

            <p style="margin-left: 6%">展示报名</p>
            <div>
                <p style="width: 30%;float: left;margin-left: 6%">开始时间:</p>
                <input style="width: 55%;" class="border"  type="datetime-local" id="startDate" name="startDate"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">结束时间:</p>
                <input style="width: 55%;" class="border"  type="datetime-local" name="endDate" id="endDate"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">报名小组数:</p>
                <input style="width: 30%;margin-left: 10%" class="border"  type="number" name="number" id="number"/>
            </div>
            <div class="top">
                <p style="width: 40%;float: left;margin-left: 6%">所属Round:</p>
                <select data-am-selected="{btnWidth: '40%',}" name="round" id="round" >
                    <option value="0">新建</option>
                    <#if roundList?exists>
                        <#list roundList as round>
                        <option value="${round.getId()}">${round.getRoundSerial()}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <button type="submit" class="am-btn am-btn-success" style="width: 80%;margin-left: 10%;margin-top: 3rem;margin-bottom: 3rem">发布</button>

        </div>

    </div>

</form>
<script>
    function test() {
        var seminarName = document.getElementById('seminarName');
        var mainContent = document.getElementById('mainContent');
        var serial = document.getElementById('serial');
        var startDate = document.getElementById('startDate');
        var endDate = document.getElementById('endDate');
        var number = document.getElementById('number');
        var round = document.getElementById('round');
        if (seminarName.value == ''|mainContent.value == ''|serial.value == ''|startDate.value==''|endDate.value==''|number.value==''|round.value=='')
        {
            alert("These items cannot be empty!");
            return false;
        }
        return true;
    }
</script>
<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>

