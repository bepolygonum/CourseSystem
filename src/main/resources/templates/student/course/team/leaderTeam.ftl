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
    <script src="../../../../static/js/art.js"></script>
    <script>
        function conf() {
            var r = confirm("将 王二 移出小组？");
            if (r == true) {
            } else {
            }
        }
    </script>
    <script>
        function inva() {
            var person = prompt("申请理由", "");
        }

    </script>
</head>

<body >
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="seminar1.html">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
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
                <div class="am-u-sm-12">
                    <div style="text-align: center"><span class="myLabel">${myteam.getTeamName()}</span>
                        <a onclick="inva()" style="margin-left: 10%">
                            <#if myteam.getStatus()==0>不合法
                            <#else>合法</#if>
                        </a>
                    </div>

                    <table class="am-table am-table-striped am-table-hover table-main" id="groupTable">
                        <tbody id="myBody">
                        <tr>
                            <td>组长</td>
                            <td>${student.getAccount()}</td>
                            <td>${student.getStudentName()}</td>
                        </tr>
                        <#if memberTeam?exists>
                            <#list memberTeam as member>
                                <#if member.getId()!=student.getId()>
                                    <tr>
                                    <td>组员</td>
                                    <td>${member.getAccount()}</td>
                                    <td><a onclick="javascript:this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)">${member.getStudentName()}</a></td>
                                    </tr>
                                </#if>
                            </#list>
                        </#if>
                        </tbody>
                    </table>

                    <#if noTeams?exists>

                        <div style="margin-top: 0.5rem">
                            <span class="myLabel">添加成员:</span>
                        </div>
                        <input type="text" class="form-control1 form-control-solid " name="info" placeholder="搜索成员"
                               style="width: 60%;margin-left: 2%">
                        <input  class="formSubmit" value="">
                        <button  onclick="Check()" class="am-btn am-btn-success"
                                style="height: 34px;padding-top:6px;width: 25%;margin-left: 2rem;margin-top: -5.5rem;border-radius: 0.5rem">
                            添加
                        </button>
                        <table class="am-table" style="margin-top: -1.5rem" >
                        <tbody>
                        <tr>
                        <td>
                        <table class="am-table am-table-striped am-table-hover table-main" id="table2">
                        <#list noTeams as noteam>
                            <tr id="${noteam.getAccount()}">
                            <td><input type="checkbox" name="radio1" class="data-am-ucheck" style="margin-left: 1rem" value="${noteam.getAccount()}"
                        class="data-am-ucheck"  style="margin-left: 1rem"></td>
                            <td>${noteam.getAccount()}</td>
                            <td>${noteam.getStudentName()}</td>
                            </tr>
                        </#list>
                        </table>
                        </td>
                        </tr>
                        </tbody>
                        </table>
                        <button type="submit" class="am-btn am-btn-danger"
                                style="border-radius: 0.5rem;width: 35%;margin-top: 2rem;padding-left: 1rem;margin-left: 1rem">
                            解散小组
                        </button>
                        <button type="submit" class="am-btn am-btn-success"
                                style="margin-left:4rem;width: 35%;margin-top: 2rem;padding-left: 1rem;border-radius: 0.5rem">
                            保存
                        </button>

                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
<script id="myTr" type="text/html">
    <tr>
        <td>
        </td>
        <td>
            {{num}}
        </td>
        <td><a onclick="javascript:this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)"">{{name}}</a>
        </td>
    </tr>
</script>
<script>
    var MyBuilder = function (container, conId, model) {
        this.container = container;
        this.model = model;
        this.conId = conId;
        this.render();
    }
    {
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
    }

    function Check() {
        var Tabobj = $("#table2");
        var Check = $("table input[type=checkbox]:checked");
        Check.each(function () {//遍历
            var row = $(this).parent("td").parent("tr");
            var snum = row.find("[name='number']").html();
            var sname = row.find("[name='name']").html();
            var title = new MyBuilder($("#myBody"), $("#myTr"), {num: snum, name: sname});
            row.remove();
        })

    }
</script>
<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>