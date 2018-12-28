<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程管理</title>
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
        <a href="seminar1.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>${course.getCourseName()}-${klass.getKlassSerial()} </h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li><a href="index_message.html"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
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
                <#if roundScoreList?exists>
                    <#list roundScoreList as roundScore>
                        <div class="am-u-sm-12">
                        <li class="tpl-left-nav-item">
                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                        <i class="am-icon-table"></i>
                        <label style="font-size: 1.7rem;">第${roundScore_index+1}轮讨论课 <label
                                style="font-size: 1.7rem;margin-left: 5rem">${roundScore.getTotalScore()}</label>
                        </label>

                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <#if seminarList?exists>
                            <#list seminarList as seminar>
                                <#list klassSeminarList as klassSeminar>
                                    <#if seminar.getRoundId()==roundScore.getRoundId() && seminarScoreList?exists>
                                        <#list seminarScoreList as seminarScore>
                                            <#if seminarScore.getKlassSeminarId()==klassSeminar.getId()&&klassSeminar.getSeminarId()==seminar.getId()>
                                                <ul class="tpl-left-nav-sub-menu">
                                                <li class="tpl-left-nav-item">
                                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                                                <label style="font-size: 1.5rem;margin-left: 2%">${seminar.getSeminarName()}</label>
                                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                                </a>
                                                <ul class="tpl-left-nav-sub-menu">
                                                <li>
                                                <table class="am-table am-table-striped am-table-hover table-main">
                                            <thead>
                                            <tr>
                                                <th class="table-title">展示</th>
                                                <th class="table-title">提问</th>
                                                <th class="table-title">报告</th>
                                                <th class="table-title">总分</th>
                                            </tr>
                                            </thead>
                                                <tbody>
                                            <tr>
                                                <td>${seminarScore.getPresentationScore()}</td>
                                                <td>${seminarScore.getQuestionScore()}</td>
                                                <td>${seminarScore.getReportScore()}</td>
                                                <td>${seminarScore.getTotalScore()}</td>

                                                </tr>
                                                </tbody>
                                                </table>

                                                </li>
                                                </ul>
                                                </li>
                                                </ul>
                                            </#if>
                                        </#list>
                                    </#if>
                                </#list>

                            </#list>
                        </#if>
                        </li>
                        </div>
                    </#list>
                </#if>
            </div>
        </div>
    </div>
</div>

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>