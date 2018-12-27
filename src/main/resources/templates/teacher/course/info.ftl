<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
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
        <h3>${course.getCourseName()}</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">

            <li><a href="index_message.html" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a>
            </li>
            <li><a href="index_personal.html" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a>
            </li>
            <li><a href="index_personal.html" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a>
            </li>
            <li><a href="login.html" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>

        </ul>
    </div>
</header>

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <hr/>
        <div style="text-align: center">
            <h3 style="color:#337ab7">${course.getIntroduction()}</h3>
        </div>
        <hr/>
        <div class="tpl-content-wrapper" style="margin-top: 5rem">
            <div class="tpl-portlet-components1">
                <div class="tpl-block">
                    <div class="am-g tpl-amazeui-form">
                        <div class="">
                            <div>
                                <lable class="mylabel">课程简介：</lable>
                                <div class="myDiv">
                                    <label class="myLabel"></label>
                                </div>
                            </div>
                            <br><br>
                            <div>
                                <lable class="mylabel">成绩计算规则：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">课堂展示${course.getPresentationPercentage()}%</label><br>
                                    <label class="myLabel">课堂提问${course.getQuestionPercentage()}%</label><br>
                                    <label class="myLabel">书面报告${course.getReportPercentage()}%</label>
                                </div>
                            </div>
                            <#if courseMemberLimitStrategy?exists>
                                <div>
                                    <lable class="mylabel">小组人数：</lable>
                                    <div class="myDiv">
                                        <label class="myLabel">${courseMemberLimitStrategy.getMinMember()}
                                            ~${courseMemberLimitStrategy.getMaxMember()}</label>
                                    </div>
                                </div>
                            </#if>
                            <div>
                                <lable class="mylabel">组队开始时间：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">${course.getTeamStartTime()}</label>
                                </div>
                            </div>
                            <div>
                                <lable class="mylabel">组队截止时间：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">${course.getTeamEndTime()}</label>
                                </div>
                            </div>
                            <div>
                                <lable class="mylabel">冲突课程：</lable>
                                <div class="myDiv">
                            <#if courseList?exists>
                                <#list courseList as conflictCourse>
                                    <#if teacherList?exists>
                                        <#list teacherList as teacher>
                                            <#if teacher.getId()==conflictCourse.getTeacherId()>
                                                        <label class="myLabel">${conflictCourse.getCourseName()}
                                                            (${teacher.getTeacherName()}老师)</label>
                                            </#if>
                                        </#list>
                                    </#if>
                                </#list>
                            </#if>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button type="submit" class="am-btn am-btn-danger" style="float: right">删除此课程</button>
            </div>
        </div>

    </div>
</div>

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>