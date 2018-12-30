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
    <script src="../../../static/js/art.js"></script>
    <script>
        function cancel() {
            $("#modDiv").remove();
        }
    </script>
    <style type="text/css">
        .pstyle {
            font-size: 1.5rem;
            width: 50%;
            text-align: center;
            margin-left: 25%;
        }

        .myLabel2 {
            float: left;
            font-size: 1.5rem;
            width: 40%;
        }

        .modDiv {
            position: absolute;
            width: 80%;
            margin-left: 10%;
            margin-top: -325;
            background-color: #f7f7f7;
            padding: 5% 5% 5% 5%;
            border-radius: 0.3rem;
        }
    </style>
</head>

<body id="body">
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
                            <span>第${round.getRoundSerial()}轮讨论课</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>

                        <ul class="tpl-left-nav-sub-menu">
                            <#if klassList?exists>
                                <#list klassList as klass>
                                    <#if teamList?exists>
                                        <#list teamList as team>
                                            <#if klass.getId()==team.getKlassId()>
                                                <#if roundScoreList?exists>
                                                    <#list  roundScoreList as item>
                                                        <#if round.getId()==item.getRoundId()>
                                                            <#if team.getId()==item.getTeamId()>
                            <li class="tpl-left-nav-item">
                                <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
                                    <span>${klass.getKlassSerial()}-${team.getTeamSerial()}</span>
                                    <span style="margin-left: 4rem">${item.getTotalScore()}</span>
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
                                        <table class="am-table am-table-striped am-table-hover table-main" id="myTable">
                                            <thead>
                                            <tr>
                                                <th class="table-title">展示</th>
                                                <th class="table-title">提问</th>
                                                <th class="table-title">报告</th>
                                                <th class="table-set">操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td name="pre"><#if seminarScore.getPresentationScore()?exists>${seminarScore.getPresentationScore()}</#if></td>
                                                <td name="qa"><#if seminarScore.getQuestionScore()?exists>${seminarScore.getQuestionScore()}</#if></td>
                                                <td name="report"><#if seminarScore.getReportScore()?exists>${seminarScore.getReportScore()}</#if></td>
                                                <td>
                                                    <button class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                                            onclick="modify(this)">
                                                        <span class="am-icon-pencil-square-o"></span>
                                                        修改
                                                    </button>
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
                                                        </#if>
                                                    </#list>
                                                </#if>
                                            </#if>
                                        </#list>
                                    </#if>
                                </#list>
                            </#if>
                        </ul>
                    </li>
                        </#list>
                    </#if>
                </div>

            </div>
        </div>
    </div>
</div>
<script id="myTr" type="text/html">
    <div class="modDiv" id="modDiv">
        <form>
            <div style="text-align: center">
                <p class="myLabel2">当前小组为</p><span>{{group}}</span>
            </div>
            <br>
            <div style="text-align: center">
                <p class="myLabel2">展示得分</p><input type="text" placeholder="{{preScore}}" style="width: 30%">
            </div>
            <br>
            <div style="text-align: center">
                <p class="myLabel2">提问得分</p><input type="text" placeholder="{{qaScore}}" style="width: 30%">
            </div>
            <br>
            <div style="text-align: center">
                <p class="myLabel2">报告得分</p><input type="text" placeholder="{{reportScore}}" style="width:30%">
            </div>
            <br>
            <input type="button" onclick="cancel()" class="am-btn am-btn-danger " style="width: 40%;margin-left: 5%"
                   value="取消">
            <input type="submit" class="am-btn am-btn-success" value="提交" style="margin-left: 10%;width: 40%;">
        </form>
    </div>

</script>
<script>
    var MyBuilder = function (container, conId, model) {
        this.container = container;
        this.model = model;
        this.conId = conId;
        this.render();
    }

    MyBuilder.prototype = {
        render: function () {
            var conId = this.conId;
            var myBuilder = template.compile(conId.html());
            var container = this.container;
            var model = this.model;
            var result = myBuilder(model);
            container.append(result);
        },
    }


    function modify(obj) {
        var row = obj.parentNode.parentNode;
        var preScore = row.children[0].innerHTML;
        var qaScore = row.children[1].innerHTML;
        var reportScore = row.children[2].innerHTML;
        var groupNum = row.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children[0].innerHTML;
        var title = new MyBuilder($("#body"), $("#myTr"), {
            preScore: preScore,
            qaScore: qaScore,
            reportScore: reportScore,
            group: groupNum
        });
    }
</script>
<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>