<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css" />
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
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">
        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
                    <li><a href="index_message.html"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
                    <li><a href="index_personal.html"><span class="am-icon-user"></span> 个人信息</a></li>
                    <li><a href="index_personal.html"><span class="am-icon-leanpub"></span> 讨论课</a></li>
                    <li><a href="login.html"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>
<div class="tpl-page-container tpl-page-header-fixed">
    <div class="tpl-portlet-components">
        <div class="tpl-block">
            <div class="am-g">
                <#if roundScoreList?exists>
                    <#list roundScoreList as roundScore>
                        <div class="am-u-sm-12">
                            <li class="tpl-left-nav-item">
                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list" style="width: 100%;margin-left: -2rem">
                                    <label style="font-size: 1.7rem;color: #007431">第${roundScore_index+1}轮</label>
                                    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right" style="margin-top: 0.1rem"></i>
                                </a>
                                <#if seminarList?exists>
                                <#list seminarList as seminar>
                                <#list klassSeminarList as klassSeminar>
                                    <#if seminar.getRoundId()==roundScore.getRoundId() && seminarScoreList?exists>
                                        <#list seminarScoreList as seminarScore>
                                            <#if seminarScore.getKlassSeminarId()==klassSeminar.getId()&&klassSeminar.getSeminarId()==seminar.getId()>
                                                <ul class="tpl-left-nav-sub-menu">
                                                    <div>
                                                        <a href="javascript:;" class="nav-link tpl-left-nav-link-list" style="width: 100%;margin-left: -2rem">
                                                            <span style="margin-left: 2rem;color: #3bb4f2">${seminar.getSeminarName()}</span>
                                                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                                        </a>
                                                        <div class="tpl-left-nav-sub-menu">
                                                            <span class="myLabel">展示:</span><span class="myScore">${seminarScore.getPresentationScore()}</span><br>
                                                            <span class="myLabel">提问:</span><span class="myScore">${seminarScore.getQuestionScore()}</span><br>
                                                            <span class="myLabel">书面报告:</span><span class="myScore">${seminarScore.getReportScore()}</span><br>
                                                            <span class="myLabel">本次总成绩:</span><span class="myScore">${seminarScore.getTotalScore()}</span><br>
                                                            <span class="myLabel">本轮总成绩:</span><span class="myScore">${roundScore.getTotalScore()}</span>
                                                        </div>
                                                    </div>
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