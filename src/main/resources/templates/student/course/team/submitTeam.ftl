<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>学生组队</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>
    <script type="text/javascript">
        var data = "";
        function getAccount(){
            $("#table2").find(":checkbox:checked").each(function(){
                var val = $(this).parent().next().text();
                data=data +val+",";
            });
            return data;
        }
    </script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="seminar1.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>OOAD</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">

        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
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
                <div class="am-u-sm-12">
                    <form>
                        <label class="myLabel" style="font-size: 1.6rem">小组名:</label>
                        <input class="myLabel" type="text" placeholder="请填写小组名称" style="margin-top: -0.4rem;margin-left: 3rem;font-size: 1.6rem">
                        <br>
                        <div style="margin-top: 0.5rem">
                            <label class="myLabel" style="font-size: 1.6rem">选择班级：</label>
                            <select class="data-am-selected" style="margin-left: 0.5rem;font-size: 1.5rem;width: 9rem">
                                <#if teamList?exists>
                                <#list teamList as team>
                                    <option value="${team.getKlassSerial()}-${team.getTeamSerial()}">${team.getKlassSerial()}-${team.getTeamSerial()}<</option>
                                </#list>
                                </#if>
                            </select>
                        </div>
                        <#if noTeams?exists>
                            <div style="margin-top: 0.5rem">
                                <label class="myLabel" style="font-size: 1.6rem">添加成员:</label>
                            </div>
                            <table class="am-table">
                            <tbody>
                            <tr>
                            <td>
                            <table class="am-table am-table-striped am-table-hover table-main" id="table2">
                            <#list noTeams as noteam>
                                <tr id="${noteam.getAccount()}">
                                <td><input type="checkbox" name="check" class="data-am-ucheck" style="margin-left: 1rem"></td>
                                <td><input type="text" value="${noteam.getAccount()}"></td>
                                <td>${noteam.getStudentName()}</td>
                                </tr>
                            </#list>
                            </table>
                            </td>
                            </tr>
                            </tbody>
                            </table>
                        </#if>
                        <a type="submit" class="am-btn am-btn-success" style="width: 100%;margin-top: 3rem" onclick="getAccount()">确认提交
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>