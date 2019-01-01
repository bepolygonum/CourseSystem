<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>

</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="homepage.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <#if course?exists>
            <h3>${course.getCourseName()}-书面报告</h3>
        </#if>
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
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <div class="tpl-portlet-components">


        <div class="tpl-block">
        <form action="/teacher/course/seminar/makereportScore" method="post">
            <div class="am-g tpl-amazeui-form">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <input value="${id}" name="id" hidden="hidden">
                    <input value="${course.getId()}" name="courseId" hidden="hidden">
                    <input value="${klassSeminarId}" name="klassSeminarId" hidden="hidden">
                    <tr>
                        <th style="width: 27%">小组序号</th>
                        <th style="width: 43%;padding-left: 12%">书面报告</th>
                        <th style="width:25%">打分</th>
                    </tr>
                    </thead>
                    <tbody>

                    <#if attendanceList?exists>
                        <#list attendanceList as attendance>
                        <#if seminarScoreList?exists>
                        <#list seminarScoreList as seminarScore>
                        <#if seminarScore.getTeamId()==attendance.getTeamId()>
                        <tr>
                            <td>
                                第${attendance.getTeamOrder()}组:
                            </td>
                            <td><#if attendance.getReportName()?exists>${attendance.getReportName()}</#if></td>
                            <td><input class="border" type="number" name="reportScore" value="${seminarScore.getReportScore()}"></td>
                            <input value="${attendance.getTeamId()}" name="teamId" hidden="hidden">
                        </tr>
                        </#if>
                        </#list>
                        </#if>
                        </#list>
                    </#if>
                    </tbody>
                </table>

                <button class="am-btn am-btn-default" style="width: 100%;margin-top: 3rem">批量下载</button>
                <button type="submit" class="am-btn am-btn-success" style="width: 100%;margin-top: 1rem">确认</button>
            </div>
        </form>
        </div>
    </div>
</div>


<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>