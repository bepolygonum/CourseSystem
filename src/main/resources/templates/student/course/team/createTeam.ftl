<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>学生组队</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>

</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="seminar1.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>${course.getCourseName()}-${klass.getKlassSerial()}</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">

        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">

            <li><a href="index_message.html" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a>
            </li>
            <li><a href="javascript:doPost('/student/personalInfo', {'id':'${student.getId()}'})"
                   class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a href="javascript:doPost('/student/seminar', {'id':'${student.getId()}'})"
                   class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="/" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>

        </ul>
    </div>
</header>

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <#list klasses as klass>
                        <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                        <label class="courseName">${klass.getGrade()}-${klass.getKlassSerial()}</label>
                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">
                        <#if teamList ?exists>
                            <#list teamList as team>
                                <#if listOfStudents?exists>
                                    <#list listOfStudents as teamlist>
                                        <#if teamlist_index ==team_index>
                                            <#if team.getKlassId()==klass.getId()>
                                                <li class="tpl-left-nav-item">
                                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                                                <span >${team.getKlassSerial()}-${team.getTeamSerial()}</span>
                                                <span style="margin-left: 3rem">
                                                <#if team.getStatus()==0>不合法
                                                <#else>合法</#if>
                                                </span>
                                                <span style="margin-left: 3rem">${team.getTeamName()}</span>
                                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                                </a>
                                                <ul class="tpl-left-nav-sub-menu">
                                                <li>
                                                <table class="am-table am-table-striped am-table-hover table-main">
                                                <#list teamlist as teammember>
                                                    <#if teammember.getId()==team.getLeaderId()>
                                                        <tr>
                                                        <td>组长</td>
                                                        <td>${teammember.getAccount()}</td>
                                                        <td>${teammember.getStudentName()}</td>
                                                        </tr>
                                                    </#if>
                                                </#list>
                                                <#list teamlist as teammember>
                                                    <#if teammember.getId()!=team.getLeaderId()>
                                                        <tr>
                                                        <td>组员</td>
                                                        <td>${teammember.getAccount()}</td>
                                                        <td>${teammember.getStudentName()}</td>
                                                        </tr>
                                                    </#if>
                                                </#list>
                                                </table>
                                                </li>

                                                </ul>
                                                </li>
                                            </#if>
                                        </#if>
                                    </#list>
                                </#if>
                            </#list>
                        </#if>

                        </ul>

                        </li>
                    </#list>


                    <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                            <label class="courseName">未组队学生</label>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">

                            <li>
                                <table class="am-table am-table-striped am-table-hover table-main">
                                    <#list noTeams as noteam>
                                        <tr>
                                        <td>${noteam.getAccount()}</td>
                                        <td>${noteam.getStudentName()}</td>
                                        </tr>
                                    </#list>
                                </table>
                            </li>
                        </ul>
                    </li>

                    <a class="am-btn am-btn-success" style="width: 100%;margin: 1% 0;"
                       href="javascript:doPost('/student/submitTeam',  {'id':'${student.getId()}','course_id':'${course.getId()}','klass_id':'${klass.getId()}'})">创建小组</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>