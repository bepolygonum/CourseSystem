<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>${course.getCourseName()}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../statici/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>

    <script>
        function conf() {
            var flag = confirm("确认取消与"+"\n"+"软件工程 （林老师）"+"\n"+"的分组共享？");
            if (flag == true) {
                return true;
            } else {
                return false;
            }
        }
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
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>共享设置</h3>
    </div>
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
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">
            <#if seminarMainCourse?exists>
                <#if teacherList1?exists>
                    <#list teacherList1 as teacher>
                        <#if teacher.getId()==seminarMainCourse.getTeacherId()>

                <div class="am-u-sm-12" >
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list" style="width: 100%;">
                            <label class="courseName">${seminarMainCourse.getCourseName()}(${teacher.getTeacherName()}老师)</label>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right" style="margin-top: 0.1rem"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">
                            <li class="tpl-left-nav-item">
                                <table class="am-table am-table-striped am-table-hover table-main"  style="padding-right: 2%">
                                    <tbody>
                                    <tr>
                                        <td>共享类型:</td><td>共享讨论课</td>
                                    </tr>
                                    <tr>
                                        <td>共享情况:</td><td>从课程</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <form  action="/teacher/course/share/delete" method="post" onsubmit="return conf();">
                                    <input value="${id}" name="id" hidden="hidden">
                                    <input value="${course.getId()}" name="courseId" hidden="hidden">
                                    <input value="${seminarMainCourse.getId()}" name="shareCourseId" hidden="hidden">
                                    <input value="subSeminar" name="flag" hidden="hidden">
                                    <button type="submit" class="am-btn am-btn-danger am-radius" style="margin-left: 60%;margin-top: 1rem">取消共享</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </div>
                        </#if>
                    </#list>
                </#if>
            </#if>

    <#if teamMainCourse?exists>
        <#if teacherList2?exists>
            <#list teacherList2 as teacher>
                <#if teacher.getId()==teamMainCourse.getTeacherId()>
                <div class="am-u-sm-12" >
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list" style="width: 100%;">
                            <label class="courseName">${teamMainCourse.getCourseName()}(${teacher.getTeacherName()}老师)</label>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right" style="margin-top: 0.1rem"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">
                            <li class="tpl-left-nav-item">
                                <table class="am-table am-table-striped am-table-hover table-main"  style="padding-right: 2%">
                                    <tbody>
                                    <tr>
                                        <td>共享类型:</td><td>共享分组</td>
                                    </tr>
                                    <tr>
                                        <td>共享情况:</td><td>从课程</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <form  action="/teacher/course/share/delete" method="post" onsubmit="return conf();">
                                    <input value="${id}" name="id" hidden="hidden">
                                    <input value="${course.getId()}" name="courseId" hidden="hidden">
                                    <input value="${teamMainCourse.getId()}" name="shareCourseId" hidden="hidden">
                                    <input value="subTeam" name="flag" hidden="hidden">
                                    <button type="submit" class="am-btn am-btn-danger am-radius" style="margin-left: 60%;margin-top: 1rem">取消共享</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </div>
                </#if>
            </#list>
        </#if>
    </#if>

<#if seminarCourseList?exists>
    <#list seminarCourseList as seminarCourse>
        <#if seminarCourse.getId()!=course.getId()>
            <#if teacherList1?exists>
                <#list teacherList1 as teacher>
                    <#if teacher.getId()==seminarCourse.getTeacherId()>

                <div class="am-u-sm-12" >
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list" style="width: 100%;">
                            <label class="courseName">${seminarCourse.getCourseName()}(${teacher.getTeacherName()}老师)</label>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right" style="margin-top: 0.1rem"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">
                            <li class="tpl-left-nav-item">
                                <table class="am-table am-table-striped am-table-hover table-main"  style="padding-right: 2%">
                                    <tbody>
                                    <tr>
                                        <td>共享类型:</td><td>共享讨论课</td>
                                    </tr>
                                    <tr>
                                        <td>共享情况:</td><td>主课程</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <form  action="/teacher/course/share/delete" method="post" onsubmit="return conf();">
                                    <input value="${id}" name="id" hidden="hidden">
                                    <input value="${course.getId()}" name="courseId" hidden="hidden">
                                    <input value="${seminarCourse.getId()}" name="shareCourseId" hidden="hidden">
                                    <input value="mainSeminar" name="flag" hidden="hidden">
                                    <button type="submit" class="am-btn am-btn-danger am-radius" style="margin-left: 60%;margin-top: 1rem">取消共享</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </div>
                    </#if>
                </#list>
            </#if>
        </#if>
    </#list>
</#if>

    <#if teamCourseList?exists>
        <#list teamCourseList as teamCourse>
            <#if teamCourse.getId()!=course.getId()>
                <#if teacherList2?exists>
                    <#list teacherList2 as teacher>
                        <#if teacher.getId()==teamCourse.getTeacherId()>

                <div class="am-u-sm-12" >
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list" style="width: 100%;">
                            <label class="courseName">${teamCourse.getCourseName()}(${teacher.getTeacherName()}老师)</label>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right" style="margin-top: 0.1rem"></i>
                        </a>
                        <ul class="tpl-left-nav-sub-menu">
                            <li class="tpl-left-nav-item">
                                <table class="am-table am-table-striped am-table-hover table-main"  style="padding-right: 2%">
                                    <tbody>
                                    <tr>
                                        <td>共享类型:</td><td>共享分组</td>
                                    </tr>
                                    <tr>
                                        <td>共享情况:</td><td>主课程</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <form  action="/teacher/course/share/delete" method="post" onsubmit="return conf();">
                                    <input value="${id}" name="id" hidden="hidden">
                                    <input value="${course.getId()}" name="courseId" hidden="hidden">
                                    <input value="${teamCourse.getId()}" name="shareCourseId" hidden="hidden">
                                    <input value="mainTeam" name="flag" hidden="hidden">
                                    <button type="submit" class="am-btn am-btn-danger am-radius" style="margin-left: 60%;margin-top: 1rem">取消共享</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </div>
                        </#if>
                    </#list>
                </#if>
            </#if>
        </#list>
    </#if>



            </div>
        </div>

        <a href="/teacher/course/createShare?id=${id}&courseId=${course.getId()}">
            <button class="am-btn am-btn-success am-radius am-button" style="margin-top: 3rem">新增共享</button>
        </a>

    </div>

</div>

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>
