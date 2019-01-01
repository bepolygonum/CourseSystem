<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>

</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="homepage.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>查看成绩</h3>
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
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <div class="tpl-portlet-components">
        <div class="tpl-block">
            <div class="am-g tpl-amazeui-form">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                        <th style="width: 20%"></th>
                        <th style="width: 20%;">展示</th>
                        <th style="width:20%">提问</th>
                        <th style="width:20%">报告</th>
                        <th style="width:20%">总分</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if seminarScoreList?exists>
                    <#list seminarScoreList as seminarScore>
                        <#list teamList as team>
                        <#if team_index=seminarScore_index>
                        <tr>
                            <td>${team.getTeamName()}</td>
                            <td>${seminarScore.getPresentationScore()}</td>
                            <td> ${seminarScore.getQuestionScore()}</td>
                            <td>${seminarScore.getReportScore()}</td>
                            <td>${seminarScore.getTotalScore()}</td>
                        </tr>
                        </#if>
                        </#list>
                    </#list>
                    </#if>
                    </tbody>
                </table>
                <button class="am-btn am-btn-success" style="width: 100%;margin-top: 3rem">确认</button>
            </div>

        </div>
    </div>
</div>


<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>