<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>新增共享</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>

    <script type="text/javascript">
        function addtablerow() {
            var Table = document.getElementById("tab"); //取得自定义的表对象
            NewRow = Table.insertRow(); //添加行
            NewCell = NewRow.insertCell(); //添加列
            NewCell.innerHTML = "<select name='conflict' id=''><option value='1'>.Net(**老师)</option> </select>";
        }
    </script>
    <script>
        function conf() {
            var flag = confirm("确认发送共享请求？");
            if (flag == true) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <form id="_form" action="/teacher/course/share" method="get">
            <a onclick="document.getElementById('_form').submit();">
                <input value="${id}" name="id" hidden="hidden">
                <input value="${courseId}" name="courseId" hidden="hidden">
                <div class="am-icon-times" style="color: darkgray"></div>
            </a>
        </form>
    </div>
    <div class="am-topbar-brand">
        <h3>新增共享</h3>
    </div>
</header>


<div class="tpl-page-container1 tpl-page-header-fixed">

    <div class="tpl-portlet-components2">
        <form action="/teacher/course/createShare" method="post" onsubmit="return conf();">
            <div class="Top">
                <input value="${id}" name="id" hidden="hidden">
                <input value="${courseId}" name="courseId" hidden="hidden">
                <p style="margin-left: 1rem;float: left;width: 30%">共享类型:</p>
                <select data-am-selected="{btnWidth: '60%',}" name="shareType" id="shareType">
                    <option value="1">共享分组</option>
                    <option value="2">共享讨论课</option>
                </select>
            </div>
            <hr>
            <div class="Top">
                <p style="margin-left: 1rem;float: left;width: 30%">共享对象:</p>
                <select data-am-selected="{btnWidth: '60%',}" name="shareCourse" id="shareCourse">
                    <#if courseList?exists>
                        <#list courseList as course>
                            <#if course.getId()!=courseId>
                                <#if teacherList?exists>
                                    <#list teacherList as teacher>
                                        <#if teacher.getId()==course.getTeacherId()>
                                            <option value="${course.getId()}">${course.getCourseName()}（${teacher.getTeacherName()}老师）</option>
                                        </#if>
                                    </#list>
                                </#if>
                            </#if>
                        </#list>
                    </#if>
                </select>
            </div>

            <button type="submit" class="am-btn am-btn-success am-radius am-button"
                    style="margin-top: 3rem;margin-bottom: 3rem">确认共享
            </button>
        </form>
    </div>

</div>


</div>

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>