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
    <script>
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
        <h3>${course.getCourseName()}-${klass.getKlassSerial()}</h3>
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
                                                <i class="am-icon-table"></i>
                                                <label style="display: inline-block;width: 3rem">${team.getKlassSerial()}-${team.getTeamSerial()}</label>
                                                <label style="display: inline-block;width: 5rem;margin-left: 2rem">
                                                <#if team.getStatus()==0>不合法
                                                <#else>合法</#if>
                                                </label>
                                                <label style="margin-left: 2rem;">${team.getTeamName()}</label>
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
                       href="javascript:doPost('/student/teamList', {'id':'${student.getId()}','course_id':'${course.getId()}','klass_id':'${klass.getId()}'})">我的小组</a>
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