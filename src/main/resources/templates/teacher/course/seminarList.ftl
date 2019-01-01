<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>讨论课</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
    <style type="text/css">
        .mybutton {
            height: 40px;
            border-radius: 5px;
            width: 100%;
            background-color: #337ab7;
            color: #ffffff;
            margin-top: 2%;
        }
    </style>
</head>

<body>
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
        <#if roundList?exists>
            <#list roundList as round>
                <div class="tpl-block">
                    <div class="am-g">
                        <div class="am-u-sm-12">
                            <li class="tpl-left-nav-item">
                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                                    <span>第${round.getRoundSerial()}轮</span>
                                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                </a>

                                <ul class="tpl-left-nav-sub-menu">
                                    <li>
                                        <form id="sform" action="/teacher/course/roundSet"
                                              class="nav-link tpl-left-nav-link-list" method="post">
                                            <a onclick="document.getElementById('sform').submit();">
                                                <i class="am-icon-gear"></i>
                                                <input value="${id}" name="id" hidden="hidden">
                                                <input value="${course.getId()}" name="courseId" hidden="hidden">
                                                <input value="${round.getId()}" name="roundId" hidden="hidden">
                                                <span>该轮轮次设置</span>
                                                <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                            </a>

                                        </form>
                                    </li>

                <#if seminarList?exists>
                    <#list seminarList as seminar>
                        <#if seminar.getRoundId()==round.getId()>
                            <li class="tpl-left-nav-item">
                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                                    <span>${seminar.getSeminarName()}</span>
                                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                </a>
                                <ul class="tpl-left-nav-sub-menu">
                            <#if klassSeminarList?exists>
                                <#list klassSeminarList as klassSeminar>
                                    <#if klassSeminar.getSeminarId()==seminar.getId()>
                                        <#if klassList?exists>
                                            <#list klassList as klass>
                                                <#if klass.getId()==klassSeminar.getKlassId()>
                                                    <li class="tpl-left-nav-item">
                                                        <a href="/teacher/course/seminar/report?id=${id}&courseId=${course.getId()}&klassSeminarId=${klassSeminar.getId()}">
                                                            <span>${klass.getGrade()}-(${klass.getKlassSerial()})</span>
                                                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                                        </a>
                                                    </li>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </#if>
                                </#list>
                            </#if>
                                </ul>
                            </li>
                        </#if>
                    </#list>
                </#if>


                                </ul>
                            </li>
                        </div>
                    </div>
                </div>
            </#list>
        </#if>
        <a href="/teacher/course/seminar/createSeminar?id=${id}&courseId=${course.getId()}">
            <button class="am-btn am-btn-success" style="width: 100%;margin: 1% 0;" type="submit"><i
                    class="am-icon-plus" style="margin: 0 2%"></i>新建讨论课
            </button>
        </a>
    </div>
</div>

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>