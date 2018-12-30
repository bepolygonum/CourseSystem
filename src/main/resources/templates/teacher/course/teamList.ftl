<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>学生组队</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css" />
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
        <h3>学生组队</h3>
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

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                <#if klassList?exists>
                    <#list klassList as klass>
                        <#if teamList?exists>
                            <#list teamList as team>
                                <#if klass.getId()==team.getKlassId()>
                    <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                            <span>${klass.getKlassSerial()}-${team.getTeamSerial()}</span>
                            <span style="margin-left: 3rem">
                                <#if team.getStatus()==0> invaild
                                <#elseif team.getStatus()==1> vaild
                                <#else> audit
                                </#if>
                            </span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>

                        <ul class="tpl-left-nav-sub-menu">
                            <li>
                                <table class="am-table am-table-striped am-table-hover table-main">
                                    <#if listOfStudents?exists>
                                        <#list listOfStudents as teamlist>
                                            <#if teamlist_index ==team_index>
                                                <#if team.getKlassId()==klass.getId()>

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
                                                </#if>
                                            </#if>
                                        </#list>
                                    </#if>
                                </table>
                            </li>

                        </ul>
                    </li>
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

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>