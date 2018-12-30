<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>学生成绩</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
    <style type="text/css">
        .pstyle {
            font-size: 1.5rem;
            width: 50%;
            text-align: center;
            margin-left: 25%;
        }
    </style>
</head>

<script>
    function doPost(to) { // to:提交动作（action）,p:参数
        var myForm = document.createElement("form");
        myForm.method = "post";
        myForm.action = to;

        var myInput = document.createElement("input");
        myInput.setAttribute("name", "id"); // 为input对象设置name

        myInput.setAttribute("value", "${id}"); // 为input对象设置value
        myForm.appendChild(myInput);

        document.body.appendChild(myForm);
        myForm.submit();
        document.body.removeChild(myForm); // 提交后移除创建的form
    }
</script>

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
        <h3>学生成绩</h3>
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
        <div class="tpl-block">
            <div class="am-g">
                <div class="am-u-sm-12">
                    <#if roundList?exists>
                        <#list roundList as round>

                            <li class="tpl-left-nav-item">
                            <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                            <i class="am-icon-table"></i>
                            <label style="font-size: 1.7rem;">第${round.getRoundSerial()}轮讨论课</label>
                        <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                            </a>
                            <#if roundScoreList?exists>
                                <#list  roundScoreList as item>
                                    <#if round.getId()==item.getRoundId()>
                                        <ul class="tpl-left-nav-sub-menu">
                                        <#if teamList?exists>
                                            <#list teamList as team>
                                                <#if team.getId()==item.getTeamId()>
                                                    <#if klassList?exists>
                                                        <#list klassList as klass>
                                                            <#if klass.getId()==team.getKlassId()>
                                                                <li class="tpl-left-nav-item">
                                                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                                                                <span>${klass.getKlassSerial()}-${team.getTeamSerial()}</span>
                                                            <!-- 1-1 -->
                                                                <span style="margin-left: 100px">${item.getTotalScore()}</span>
                                                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                                                                </a>
                                                                <ul class="tpl-left-nav-sub-menu">
                                                                <li>
                                                                <#if seminarScoreList?exists>
                                                                    <#list seminarScoreList as seminarScore>
                                                                        <#if seminarScore.getTeamId()==team.getId()>
                                                                            <#if klassSeminarList?exists>
                                                                                <#list klassSeminarList as klassSeminar>
                                                                                    <#if klassSeminar.getId()==seminarScore.getKlassSeminarId()>
                                                                                        <#if seminarList?exists>
                                                                                            <#list seminarList as seminar>
                                                                                                <#if seminar.getId()==klassSeminar.getSeminarId()>
                                                                                                    <#if seminar.getRoundId()==item.getRoundId()>
                                                                                                        <p class="pstyle">${seminar.getSeminarName()}</p>
                                                                                                        <table class="am-table am-table-striped am-table-hover table-main">
                                                                                                        <thead>
                                                                                                        <tr>
                                                                                                            <th class="table-title">
                                                                                                                展示
                                                                                                            </th>
                                                                                                            <th class="table-title">
                                                                                                                提问
                                                                                                            </th>
                                                                                                            <th class="table-title">
                                                                                                                报告
                                                                                                            </th>
                                                                                                            <th class="table-set">
                                                                                                                操作
                                                                                                            </th>
                                                                                                        </tr>
                                                                                                        </thead>
                                                                                                        <tbody>
                                                                                                        <tr>
                                                                                                        <td><#if seminarScore.getPresentationScore()?exists>${seminarScore.getPresentationScore()}</#if></td>
                                                                                                        <td><#if seminarScore.getQuestionScore()?exists>${seminarScore.getQuestionScore()}</#if></td>
                                                                                                        <td><#if seminarScore.getReportScore()?exists>${seminarScore.getReportScore()}</#if></td>
                                                                                                        <td>
                                                                                                            <div class="am-btn-toolbar">
                                                                                                                <div class="am-btn-group am-btn-group-xs">
                                                                                                                    <button class="am-btn am-btn-default am-btn-xs am-text-secondary"><span
                                                                                                                                class="am-icon-pencil-square-o"></span>
                                                                                                                        修改
                                                                                                                    </button>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </td>
                                                                                                        </tr>
                                                                                                        </tbody>
                                                                                                        </table>
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
                                                                </li>
                                                                </ul>
                                                                </li>
                                                            </#if>
                                                        </#list>
                                                    </#if>
                                                </#if>
                                            </#list>
                                        </#if>
                                        </ul>
                                    </#if>
                                </#list>
                            </#if>
                            </li>

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