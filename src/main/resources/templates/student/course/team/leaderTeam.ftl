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
        function inva() {
            var person = prompt("申请理由", "");
        }

        function standardPost(to) {
            var form = $("<form method='post'></form>");
            form.attr({"action": "/student/topnavigation"});
            var input;
            input = $("<input type='hidden'>");
            input.attr({"name": "to"});
            input.val(to);
            form.append(input);
            input = $("<input type='hidden'>");
            input.attr({"name": "id"});
            input.val(window.sessionStorage.getItem("studentId"));
            form.append(input);
            $(document.body).append(form);
            form.submit();
        }
    </script>
    <script src="../../../../static/js/jquery.min.js"></script>
    <script>
        function submitFunction() {
            var tableId = document.getElementById("groupTable");
            var myArray = new Array();
            for (var i = 0; i < tableId.rows.length; i++) {
                myArray.push(tableId.rows[i].cells[1].innerHTML)
                console.log(myArray);
            }

            $.ajax({
                //接口地址
                url: '/student/check',
                type: 'POST',
                data: {
                    team: myArray,
                    teamid: '${teamid}',
                    sid: '${student.getId()}',
                    courseId: '${course.getId()}',
                    teamname: '${myteam.getTeamName()}',
                    klassId: '${klass.getId()}'
                },
                traditional: true,
                success: function () {
                    alert("修改小组成功！");
                    window.location.reload();
                },
            });
        }

        function removeMember(td) {
            if (window.confirm("确定将学生:" + $(td).parent().attr("id") + "移出小组?\n当前页面所有操作最终需要点击下方保存按钮才会生效")) {
                $(td.parentNode).find("td:first").html("<input type=\"checkbox\" name=\"radio\" class=\"data-am-ucheck\" style=\"margin-left: 1rem\" class=\"data-am-ucheck\"  style=\"margin-left: 1rem\">");
                console.log($(td.parentNode).find("td:last").find("a").html());
                $(td.parentNode).find("td:last").html($(td.parentNode).find("td:last").find("a").html());
                $("#table2").append(td.parentNode);
            } else {
                return;
            }
        }

        function addMemberToTeam() {
            $("table input[type=checkbox]:checked").each(function () {
                var tr = $(this).parent("td").parent("tr");
                $(this).parent("td").parent("tr").find("td:last").html("<a onclick=\"removeMember(this.parentNode)\">" + $(this).parent("td").parent("tr").find("td:last").html() + "</a>");
                $(this).parent("td").parent("tr").find("td:first").html("组员");
                $("#groupTable").append(tr);
            })
        }

        function dismiss() {
            return confirm("确定解散该小组吗?");
        }
    </script>
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
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
            <li><a onclick="standardPost('personalInfo')" class="tpl-header-list-link"><span
                            class="am-icon-user"></span> 个人信息</a></li>
            <li><a onclick="standardPost('seminar')" class="tpl-header-list-link"><span class="am-icon-leanpub"></span>
                    讨论课</a></li>
            <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>

<div class="tpl-page-container1 tpl-page-header-fixed">
    <div class="tpl-portlet-components2">
        <div class="tpl-block">
            <div class="am-g">

                <div class="am-u-sm-12">
                    <div style="text-align: center"><label class="myLabel">${myteam.getTeamName()}</label>

                        <#if myteam.getStatus()==0> <a style="font-size: 1.5rem; color: #0b76ac" href="javascript:doPost('/student/apply', {'id':'${student.getId()}','course_id':'${course.getId()}'})">不合法  </a>
                        <#elseif myteam.getStatus()==1><label style="font-size: 1.5rem; color: #0b76ac">合法</label>
                        <#else><label style="font-size: 1.5rem; color: #0b76ac">审核中</label>
                        </#if>

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
                                    <tr id="${member.getAccount()}">
                                <td>组员</td>
                                    <td>${member.getAccount()}</td>
                                    <td>
                                    <a onclick="removeMember(this.parentNode)">${member.getStudentName()}</a></td>
                                    </tr>
                                </#if>
                            </#list>
                        </#if>
                        </tbody>
                    </table>
                    <#if myteam.getStatus()!=2>
                        <a class="am-btn am-btn-danger" onclick="return dismiss()"
                        href="javascript:doPost('/student/dismiss', {'id':'${student.getId()}','teamid':'${myteam.getId()}'})"
                        style="margin-left:2rem;width: 25%;margin-top: 2rem;border-radius: 0.5rem;">
                        解散
                        </a>
                        <a onclick="addMemberToTeam()" class="am-btn am-btn-primary"
                           style="margin-left:1rem;width: 25%;margin-top: 2rem;border-radius: 0.5rem">
                            添加
                        </a>
                        <a class="am-btn am-btn-success" type="submit" onclick="submitFunction()"
                           style="margin-left:1rem;width: 25%;margin-top: 2rem;border-radius: 0.5rem">
                            保存
                        </a>
                    </#if>
                    <#if noTeams?exists>
                        <div style="margin-top: 0.5rem">
                            <label class="myLabel">添加成员:</label>
                        </div>
                        <table class="am-table">
                        <tbody>
                        <tr>
                        <td>
                        <table class="am-table am-table-striped am-table-hover table-main" id="table2">
                        <#list noTeams as noteam>
                            <tr id="${noteam.getAccount()}">
                        <td><input type="checkbox" name="radio" class="data-am-ucheck" style="margin-left: 1rem"></td>
                            <td>${noteam.getAccount()}</td>
                            <td>${noteam.getStudentName()}</td>
                            </tr>
                        </#list>
                        </table>
                        </td>
                        </tr>
                        </tbody>
                        </table>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>