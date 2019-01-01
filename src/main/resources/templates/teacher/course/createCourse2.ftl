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
    <script src="../../../static/js/art.js"></script>
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
        <h3>组队要求设置</h3>
    </div>
</header>
<form action="/teacher/course/createCourse2" method="post" >
    <div class="tpl-page-container1 tpl-page-header-fixed">
        <div class="tpl-portlet-components2">
            <input value="${id}" name="id" hidden="hidden">
            <input value="${courseId}" name="courseId" hidden="hidden">
            <p style="margin-left: 6%">组员基本要求</p>
            <hr>
            <p style="margin-left: 6%">小组总人数（含组长）</p>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">上限:</p>
                <input style="width: 30%;margin-left: 10%;" class="border"  type="number" name="max" id="max"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">下限:</p>
                <input style="width: 30%;margin-left: 10%;" class="border"  type="number" name="min" id="min"/>
            </div>
            <p style="margin-left: 6%">组内选修课程人数:</p>
            <div id="ddd">
                <div id="cou">
                    <div class="top" style="margin-left: 6%" >
                        <select style="width: 40%"  id="elective" name="elective">
                            <option value="0">无</option>
                        <#if courseList?exists><#list courseList as course><#if teacherList?exists><#list teacherList as teacher><#if course.getTeacherId()==teacher.getId()>
                            <option value="${course.getId()}">${course.getCourseName()}(${teacher.getTeacherName()}老师)</option>
                        </#if></#list></#if></#list></#if>
                        </select>
                        <div class="top">
                            <p style="width: 30%;float: left;margin-left: 6%" >上限:</p>
                            <input style="width: 30%;margin-left: 10%;" name="smax" id="smax" class="border"  type="number"/>
                        </div>
                        <div class="top">
                            <p style="width: 30%;float: left;margin-left: 6%">下限:</p>
                            <input style="width: 30%;margin-left: 10%;" name="smin" id="smin" class="border"  type="number"/>
                        </div>
                    </div>
                </div>

            </div>
            <button type="button" class="am-btn am-btn-success am-radius" style="margin-left:59%;margin-top: 1rem" onclick="Check()">新增</button><br>
            <hr>

            <div class="top">
                <p style="width: 40%;margin-left: 6%">冲突课程:</p>
                <hr>
                <div id="ddd2">
                    <div class="top" style="margin-left: 6%;float: left">
                        <select  style="width: 40%" id="conflict" name="conflict" >
                            <option value="0">无</option>
                        <#if courseList?exists><#list courseList as course><#if teacherList?exists><#list teacherList as teacher><#if course.getTeacherId()==teacher.getId()>
                            <option value="${course.getId()}">${course.getCourseName()}(${teacher.getTeacherName()}老师)</option>
                        </#if></#list></#if></#list></#if>
                        </select>

                    </div>
                </div>
                <button type="button" class="am-btn am-btn-success am-radius" style="margin-left: 60%;margin-top: -4rem" onclick="Check1()" >新增</button><br>

                <button type="submit" class="am-btn am-btn-success" style="width: 80%;margin-left: 10%;margin-top: 3rem;margin-bottom: 3rem">保存</button>
            </div>
        </div>
    </div>


</form>
<script id="myTr" type="text/html">
    <div class="top" style="margin-left: 6%">
        <select data-am-selected="{btnWidth: '40%',}" style="width: 40%" id="elective" name="elective" >
            <option value="0">无</option>
        <#if courseList?exists><#list courseList as course><#if teacherList?exists><#list teacherList as teacher><#if course.getTeacherId()==teacher.getId()>
            <option value="${course.getId()}">${course.getCourseName()}(${teacher.getTeacherName()}老师)</option>
        </#if></#list></#if></#list></#if>
        </select>
        <div class="top">
            <p style="width: 30%;float: left;margin-left: 6%">上限:</p>
            <input style="width: 30%;margin-left: 10%;" class="border"  type="number" name="smax" id="smax"/>
        </div>
        <div class="top">
            <p style="width: 30%;float: left;margin-left: 6%">下限:</p>
            <input style="width: 30%;margin-left: 10%;" class="border"  type="number" name="smin" id="smin"/>
        </div>
    </div>

</script>
<script id="myTr1" type="text/html">
    <br>
    <div class="top" style="margin-left: 6%;float: left;margin-top: 1rem">
        <select data-am-selected="{btnWidth: '40%',}" style="width: 40%"  id="conflict" name="conflict">
            <option value=\"0\">无</option>
        <#if courseList?exists><#list courseList as course><#if teacherList?exists><#list teacherList as teacher><#if course.getTeacherId()==teacher.getId()>
            <option value="${course.getId()}">${course.getCourseName()}(${teacher.getTeacherName()}老师)</option>
        </#if></#list></#if></#list></#if>
        </select>

    </div>

</script>
<script id="div1" type="text/html">
    <div style="margin-top: 1rem">
        <p style="margin-left: 6%;float: left">选课人数要求:</p>
        <select style="margin-left: 20%" id="request" name="request">
            <option value="0">均满足</option>
            <option value="1">满足其一</option>
        </select>
    </div>
</script>
<script>
    var MyBuilder = function(container,conId,model){
        this.container=container;
        this.model=model;
        this.conId=conId;
        this.render();
    }
    {
        MyBuilder.prototype={
            render:function(){
                var conId=this.conId;
                var myBuilder= template.compile(conId.html());
                var container=this.container;
                var model=this.model;
                var result=myBuilder(model);
                container.append(result);
            },
        }
    }

    function Check() {

        var title=new MyBuilder($("#cou"),$("#myTr"));
        var aa = document.getElementById("cou").getElementsByTagName("div").length;
        if (aa==6)
            var aaa=new MyBuilder($("#ddd"),$("#div1"));
    }
    function Check1() {

        var title=new MyBuilder($("#ddd2"),$("#myTr1"));
    }
</script>
</script>
<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>