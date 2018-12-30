<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>班级信息</title>
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
                <div class="am-icon-chevron-left" style="color: darkgray"></div>
            </a>
        </form>

    </div>
    <div class="am-topbar-brand">
        <h3>班级信息</h3>
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
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <#if klassList?exists>
        <#list klassList as klass>
            <div class="tpl-portlet-components1">
                <div class="tpl-block">
                    <div class="am-g tpl-amazeui-form">
                        <div class="">
                            <div style="text-align: center">
                                <h3 style="color:#337ab7">${klass.getGrade()}-${klass.getKlassSerial()}</h3>
                            </div>
                            <div>
                                <lable class="mylabel">讨论课时间：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">${klass.getKlassTime()}</label>
                                </div>
                            </div>
                            <div>
                                <lable class="mylabel">讨论课地点：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">${klass.getKlassLocation()}</label>
                                </div>
                            </div>
                            <div>
                                <lable class="mylabel">学生名单：</lable>
                                <div class="myDiv">
                                    <input type="file" style="width: 80%;margin-left: 10%;">
                                </div>
                            </div>
                            <div>
                                <button type="submit" class="am-btn am-btn-default" style="color: #337ab7;float: left;margin-top: 5%">
                                    修改
                                </button>

                                <form id="_form" action="/teacher/course/klass/delete" method="post">
                                    <input value="${id}" name="id" hidden="hidden">
                                    <input value="${courseId}" name="courseId" hidden="hidden">
                                    <input value="${klass.getId()}" name="klassId" hidden="hidden">
                                    <button type="submit" class="am-btn am-btn-default" style="float:right;margin-top:5%">删除班级</button>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </#list>
    </#if>

    <button class="am-btn am-btn-success" style="width: 100%;margin-bottom: 4%" type="submit"
            onclick="window.location.href='/teacher/course/klass/createKlass?id=${id}&courseId=${courseId}'"><i class="am-icon-plus" style="margin: 0 2%"></i>新增班级
    </button>
</div>


<script src="../../../staticjs/jquery.min.js"></script>
<script src="../../../staticjs/amazeui.min.js"></script>
<script src="../../../staticjs/app.js"></script>
</body>

</html>