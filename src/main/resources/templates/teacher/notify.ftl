<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>代办及通知</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../static/i/favicon.png">
    <link rel="stylesheet" href="../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <link rel="stylesheet" href="../../static/css/app.css">
    <script src="../../static/js/echarts.min.js"></script>

    <script>
        function setStatus(teamid,status) {
            $.ajax({
                //接口地址
                url: '/teacher/notify-team',
                type: 'GET',
                data: 'teamid='+teamid+'&status='+status,
                success:function () {
                    window.location.reload();
                },
                error:function () {
                    console.log('error');
                },
            });
        }

        function setTeamGroup(maincourseid,subcourseid,status) {
            $.ajax({
                url:'/teacher/notify-share-group',
                type: 'GET',
                data: 'maincourseid='+maincourseid+'&subcourseid='+subcourseid+'&status='+status,
                success:function () {
                    window.location.reload();
                },
                error:function () {
                    console.log('error');
                },
            });
        }
    </script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="homepage.html">
            <div class="am-icon-times" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>代办及通知</h3>
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


    <#if teamValidApplicationList?exists>
    <#list teamValidApplicationList as teamApplication>
        <#if teamList?exists>
            <#list teamList as team>
                <#if team.getId()==teamApplication.getTeamId()>
                    <#if courseList?exists>
                        <#list courseList as course>
                            <#if course.getId()==team.getCourseId()>
                                <#if klassList?exists>
                                    <#list klassList as klass>
                                        <#if klass.getId()==team.getKlassId()>
                                            <#if leaderList?exists>
                                                <#list leaderList as leader>
                                                    <#if leader.getId()==team.getLeaderId()>
                                                    <div class="tpl-block">
                                                        <div class="am-g">
                                                            <div class="am-u-sm-12">
                                                                <li class="tpl-left-nav-item">
                                                                    <a href="javascript:;"
                                                                       class="nav-link tpl-left-nav-link-list">

                                                                        <span>${course.getCourseName()}${klass.getGrade()}(${klass.getKlassSerial()}) ${leader.getStudentName()}的特殊组队申请</span>

                                                                        <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                                                    </a>

                                                                    <ul class="tpl-left-nav-sub-menu">
                                                                        <li>
                                                                            <div class="nav-link tpl-left-nav-link-list">
                                                                                <div>
                                                                                    <lable style="width:100%;text-align:center;">${klass.getGrade()}
                                                                                        (${klass.getKlassSerial()})
                                                                                        ${leader.getStudentName()}提出
                                                                                    </lable>
                                                                                </div>
                                                                                <div>
                                                                                    <span>${teamApplication.getReason()}</span>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                        <li>
                                                                            <a class="am-icon-times"
                                                                               style="color: #e93c4d;float: left;margin-left: 2rem;" onclick="setStatus('${teamApplication.getTeamId()}',0)"></a>
                                                                            <a class="am-icon-check"
                                                                               style="color: #5fc9da;float: left;margin-left: 11rem;" onclick="setStatus('${teamApplication.getTeamId()}',1)"></a>
                                                                        </li>
                                                                    </ul>
                                                                </li>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    </#if>
                                                </#list>
                                            </#if>
                                        </#if>
                                    </#list>
                                </#if>
                            </#if>
                        </#list>
                    </#if>
                </#if>
            </#list>
        </#if>
    </#list>
    </#if>

    <#if shareTeamApplicationList?exists>
    <#list shareTeamApplicationList as shareTeam>
        <#if teamCourseList?exists>
        <#list teamCourseList as teamCourse>
        <#if teamCourse.getId()==shareTeam.getMainCourseId()>
            <#if teamTeacherList?exists>
            <#list teamTeacherList as teacher>
            <#if teamCourse.getTeacherId()==teacher.getId()>
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;"
                           class="nav-link tpl-left-nav-link-list">

                            <span>${teamCourse.getCourseName()}${teacher.getTeacherName()}的共享分组申请</span>

                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>

                        <ul class="tpl-left-nav-sub-menu">
                            <li>
                                <div class="nav-link tpl-left-nav-link-list">
                                    <div>
                                        <lable style="width:100%;text-align:center;">${teacher.getTeacherName()}提出
                                        </lable>
                                    </div>
                                    <div>
                                        <span>共享分组申请</span>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <a class="am-icon-times"
                                   style="color: #e93c4d;float: left;margin-left: 2rem;" onclick="javascript:setTeamGroup('${shareTeam.getMainCourseId()}','${shareTeam.getSubCourseId()}',0)"></a>
                                <a class="am-icon-check"
                                   style="color: #5fc9da;float: left;margin-left: 11rem;" onclick="javascript:setTeamGroup('${shareTeam.getMainCourseId()}','${shareTeam.getSubCourseId()}',1)"></a>
                            </li>
                        </ul>
                    </li>
                </div>

            </div>
        </div>
            </#if>
            </#list>
            </#if>
        </#if>
        </#list>
        </#if>
    </#list>
    </#if>

        <#if shareSeminarApplicationList?exists>
            <#list shareSeminarApplicationList as shareSeminar>
                <#if seminarCourseList?exists>
                    <#list seminarCourseList as seminarCourse>
                        <#if seminarCourse.getId()==shareSeminar.getMainCourseId()>
                            <#if seminarTeacherList?exists>
                                <#list seminarTeacherList as teacher>
                                    <#if seminarCourse.getTeacherId()==teacher.getId()>
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;"
                           class="nav-link tpl-left-nav-link-list">

                            <span>${seminarCourse.getCourseName()}${teacher.getTeacherName()}的共享讨论课申请</span>

                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>

                        <ul class="tpl-left-nav-sub-menu">
                            <li>
                                <div class="nav-link tpl-left-nav-link-list">
                                    <div>
                                        <lable style="width:100%;text-align:center;">${teacher.getTeacherName()}提出
                                        </lable>
                                    </div>
                                    <div>
                                        <span>共享讨论课申请</span>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <i class="am-icon-times"
                                   style="color: #e93c4d;float: left;margin-left: 7rem;"></i>
                                <i class="am-icon-check"
                                   style="color: #5fc9da;float: left;margin-left: 11rem;"></i>
                            </li>
                        </ul>
                    </li>
                </div>

            </div>
        </div>
                                    </#if>
                                </#list>
                            </#if>
                        </#if>
                    </#list>
                </#if>
            </#list>
        </#if>

    </div>

</div>
<script src="../../static/js/jquery.min.js"></script>
<script src="../../static/js/amazeui.min.js"></script>
<script src="../../static/js/app.js"></script>
</body>

</html>