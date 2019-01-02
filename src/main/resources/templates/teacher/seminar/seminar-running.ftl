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
    <script src="../../../static/js/art.js"></script>
    <!-- 目前前端WebSocket所需js从cdn节点加载-->
    <#--<script src="https://cdn.bootcss.com/sockjs-client/1.3.0/sockjs.min.js"></script>-->
    <#--<script src="https://cdn.bootcss.com/stomp.js/2.3.3/stomp.min.js"></script>-->
    <style type="text/css">
        .modDiv {
            display: none;
            position: absolute;
            width: 100%;
            margin-left: 0%;
            margin-top: -35rem;
            background-color: #f7f7f7;
            padding: 5% 5% 5% 5%;
        }
    </style>
    <script>
        console.log(new Date() + "window.sessionStorage.getItem(): " + window.sessionStorage.getItem("teacherId"));
        function standardPost(to){
            var form = $("<form method='post'></form>");
            form.attr({"action": "/teacher/topnavigation"});
            var input;
            input = $("<input type='hidden'>");
            input.attr({"name": "to"});
            input.val(to);
            form.append(input);
            input = $("<input type='hidden'>");
            input.attr({"name": "id"});
            input.val(window.sessionStorage.getItem("teacherId"));
            form.append(input);
            $(document.body).append(form);
            form.submit();
        }
    </script>
</head>

<body id="body">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>讨论课</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}">

        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li><a onclick="standardPost('message')" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a onclick="standardPost('personalInfo')" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a onclick="standardPost('seminar')" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <div class="tpl-portlet-components1">
        <div style="text-align: center">
            <label style="font-size: 2rem">${seminar.getSeminarName()}</label><br>
            <!--根据teacher controller的/seminarRunning返回的teamlist和attendance点击下一组展示，更换到下一个team-->
            <label id="currentTeamLabel" style="color: #555555">有**小组展示</label>
        </div>
        <div class="tpl-block">
            <div class="am-g tpl-amazeui-form">
                <div style="width: 40%;float: left;margin-left: 6%">
                    <table class="am-table am-table-striped am-table-hover table-main" id="QA">
                        <tbody id="currentQuestionStudentInfoList">
                            <p class="myLabel"></p>
                        </tbody>
                    </table>
                </div>
                <form class="am-form">
                    <div style="width: 54%;float: left;text-align: center">
                        <p>展示分数</p>
                        <div style="text-align: center">
                            <input id="presentationScoreInput" type="number" style="font-size: 3rem;width: 40%;margin-left: 30%">
                        </div>
                    </div>
                    <button id="questionStudent" type="button" class="am-btn am-btn-danger  am-radius" style="width: 80%;margin-left: 10%;margin-top: 3rem">抽取下一个提问</button>
                    <button id="scoreQuestionStudent" type="button" class="am-btn am-btn-primary  am-radius" style="width: 80%;margin-left: 10%;margin-top: 3rem">给当前提问学生打分</button>
                    <button id="nextTeam" type="button" class="am-btn am-btn-success  am-radius" style="width: 80%;margin-left: 10%;margin-top: 1rem">下组展示</button>
                </form>
            </div>
            <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
                <div class="am-modal-dialog">
                    <div class="am-modal-bd">
                        讨论课已结束，请设定书面报告截止时间
                        <input id="deadlineInput" type="date" class="am-modal-prompt-input">
                    </div>
                    <div class="am-modal-footer">
                        <span class="am-modal-btn" data-am-modal-cancel>取消</span>
                        <span class="am-modal-btn" data-am-modal-confirm>提交</span>
                    </div>
                </div>
            </div>

            <div class="modDiv" id="questionScoreDiv">
                <table class="am-table am-table-radius am-table-striped">
                    <thead>
                        <tr>
                            如果当前学生提问成绩您已经提交，则再次提交会覆盖掉上次提交的结果！
                        </tr>
                        <tr>
                            <td style="width: 25%;">组号</td>
                            <td style="width: 35%;">学生姓名</td>
                            <td style="width: 40%;">打分</td>
                        </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td id="currentQuestionStudentInfo0"></td>
                        <td id="currentQuestionStudentInfo1"></td>
                        <td><input id="questionScoreInput" type="number" required="required" style="width: 6rem;background-color: #f7f7f7;border: 0.2rem solid #c8c8c8"></td>
                    </tr>
                    </tbody>
                </table>
                <button onclick="updateQuestionScore()" class="am-btn am-btn-success am-table-radius" style="width: 40%;margin-top: 2rem">提交</button>
                <button onclick="cancelQuestionScore()" class="am-btn am-btn-success am-table-radius" style="width: 40%;margin-top: 2rem">取消</button>
            </div>

        </div>
    </div>
</div>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="../../../static/js/jquery.min.js"></script>
<script>
    function showTips(content, height, time) {
        //窗口的宽度
        var windowWidth = $(window).width();
        var tipsDiv = '<div class="tipsClass">' + content + '</div>';

        $('body').append(tipsDiv);
        $('div.tipsClass').css({
            'top': height + 'px',
            'margin-left': '20%',
            'position': 'absolute',
            'padding': '3px 5px',
            'background': '#8FBC8F',
            'font-size': '2rem',
            'text-align': 'center',
            'width': '60%',
            'height': 'auto',
            'color': '#fff',
            "z-index": '999',
        }).show();
        setTimeout(function () {
            $('div.tipsClass').fadeOut();
            $('div.tipsClass').remove();
        }, (time * 1000));
    }
    var message = new Object();
    message.role = "teacher";
    message.action = "enter";
    message.seminarId = ${seminar.getId()};
    var stompClient = null;
    var connected = false;
    var teamArray = [];
    <#if teamList?exists>
        var teamListSize = "${teamList?size}";
        if(teamListSize != 0){
            <#list teamList as team>
                var tempTeam = new Object();
                tempTeam.teamName = "${team.getTeamName()}";
                tempTeam.teamId = "${team.getId()}";
                teamArray.push(tempTeam);
            </#list>
        }
    </#if>
    // 教师进入页面，默认更新 currentTeamIndex 和 currentQuestionStudentInfoList
    var currentTeamIndex  = 0; // 当前正在展示的小组 index 默认为 0
    var currentQuestionStudentInfoList = new Array(); // 当前提问学生列表
    var currentQuestionStudentInfo = null; // 当前被抽取的提问学生信息
    // 教师进入界面，请求当前讨论课信息
    $.post("/teacher_websocket/seminar/enter", { "message": JSON.stringify(message) }, function(message){
        console.log(new Date() + "/teacher_websocket/seminar/enter; " + "message:" + message);
        if(message == "" || typeof(message) == undefined){
            return;
        }else{
            var messageJSON = JSON.parse(message);
            if(messageJSON != null){
                if(messageJSON.currentTeamIndex != null && typeof (messageJSON.currentTeamIndex) != undefined){
                    console.log(new Date() + "currentTeamIndex:" + currentTeamIndex);
                    currentTeamIndex = messageJSON.currentTeamIndex;
                }
                if(messageJSON.currentQuestionStudentInfoList != null && typeof (messageJSON.currentQuestionStudentInfoList) != undefined && messageJSON.currentQuestionStudentInfoList.length != 0){
                    console.log(new Date() + "currentQuestionStudentInfoList:" + currentQuestionStudentInfoList);
                    currentQuestionStudentInfoList = messageJSON.currentQuestionStudentInfoList;
                    loadCurrentStudentInfo(currentTeamIndex, currentQuestionStudentInfoList);
                }else{
                    return;
                }
            }
        }
    });
    $(document).ready(function () {
        console.log(new Date() + "$(document).ready(function())");
        $("#questionStudent").click(function () {
            questionSomeone();
        });
        $("#nextTeam").click(function(){
            nextTeam();
        });
        $("#scoreQuestionStudent").click(function () {
            // 显示问题分数显示界面
            $('#questionScoreDiv').toggle();
            if(currentQuestionStudentInfo == null || typeof (currentQuestionStudentInfo) == undefined ){
                return;
            }else{
                $("#currentQuestionStudentInfo0").html(currentQuestionStudentInfo.classSerial + "-" + currentQuestionStudentInfo.teamSerial);
                $("#currentQuestionStudentInfo1").html(currentQuestionStudentInfo.studentName);
            }
        });
        loadCurrentStudentInfo(currentTeamIndex, currentQuestionStudentInfoList);
        showTips("已获取当前页面最新信息！", 200, 1);
    });
    // 提交提问分数
    function updateQuestionScore () {
        var currentQuestionScore = $("#questionScoreInput").val();
        if(currentQuestionScore >= 0 && currentQuestionScore <= 5){
            var sendData = new Object();
            sendData.questionScore = $("#questionScoreInput").val();
            sendData.klassSeminarId = ${klassSeminarId};
            sendData.teamId = teamArray[currentTeamIndex].teamId;
            $.ajax({
                url: "/modifyQuestionScore",
                type: "post",
                async: true,
                data: sendData,
                success: function(){
                    showTips("修改提问分数成功！", 200, 1);
                },
                error: function () {
                    showTips("当前页面发生了错误，请尝试刷新或者退出后重新进入系统！", 200, 3);
                }
            });
        }else{
            showTips("您输入的提问分数不符合要求(0-5)分，请重新输入提交", 200, 1);
            return;
        }
    }
    // 隐藏提交提问分数界面
    function cancelQuestionScore () {
        $('#questionScoreDiv').toggle();
    }
    // 根据 currentQuestionStudentInfoList 更新界面
    function loadCurrentStudentInfo(currentTeamIndex, currentQuestionStudentInfoList){
        console.log(new Date() + "loadCurrentStudentInfo");
        console.log(new Date() + "currentStudentInfoList:" + currentQuestionStudentInfoList);
        $("#currentTeamLabel").html("第" + (currentTeamIndex + 1) + "组: " + teamArray[currentTeamIndex].teamName + "正在展示");
        if(currentQuestionStudentInfoList == null || typeof (currentQuestionStudentInfoList) == undefined || currentQuestionStudentInfoList.length == 0){
            $("#currentQuestionStudentInfoList").html("");
            var newP = document.createElement("p");
            $("#currentQuestionStudentInfoList").append(newP);
            $("#currentQuestionStudentInfoList").find("p").html("当前没有学生提问");
            $("#questionStudent").attr("disabled",true);
            if(currentQuestionStudentInfoList == 0 && currentQuestionStudentInfo != null){
                $("#scoreQuestionStudent").attr("disabled", false);
            }else{
                $("#scoreQuestionStudent").attr("disabled", true);
            }
            return;
        }else{
            var _length = currentQuestionStudentInfoList.length;
            $("#currentQuestionStudentInfoList").html("");
            var newP = document.createElement("p");
            $("#currentQuestionStudentInfoList").append(newP);
            $("#currentQuestionStudentInfoList").find("p").html("当前有" + _length + "个学生提问");
            for(var i = 0; i < _length; i++){
                var newTr = document.createElement("tr");
                $(newTr).html("<td>" + currentQuestionStudentInfoList[i].classSerial + "-" + currentQuestionStudentInfoList[i].teamSerial + "</td><td>" + currentQuestionStudentInfoList[i].studentName + "</td>");
                $("#currentQuestionStudentInfoList").append(newTr);
            }
            $("#questionStudent").attr("disabled",false);
            $("#scoreQuestionStudent").attr("disabled", false);
        }
    }
    // 教师点击抽取下一位学生提问
    function questionSomeone(){
        if(currentQuestionStudentInfoList.length == 0){
            $("#questionStudent").attr("disabled",true);
            $("#scoreQuestionStudent").attr("disabled", true);
        }else{
            if(window.confirm("您确定要抽取学生提问吗？")){
                showTips("您开始了抽取提问！", 200, 1);
                console.log(new Date() + "questionSomeone! ");
                // 教师抽取提问
                message.action = "question";
                // 教师 "/websocket/teacher/seminar/questionsomeone" 发送信息
                stompClient.send("/websocket/teacher/seminar/questionsomeone", {}, JSON.stringify(message));
                currentQuestionStudentInfo = currentQuestionStudentInfoList.shift();
                $("#scoreQuestionStudent").attr("disabled", false);
                loadCurrentStudentInfo(currentTeamIndex, currentQuestionStudentInfoList);
            }else{
                showTips("您取消了抽取提问操作！", 200, 1);
            }
        }
    }
    // 教师点击开始下一组
    function nextTeam() {
        console.log(new Date() + "nextTeam! ");
        if((currentTeamIndex + 1) >= teamArray.length){
            showTips("当前已经是最后一组！", 200, 1);
            $("#nextTeam").html("修改报告截止日期");
            $("#my-prompt").modal();
            var $confirm = $('#my-prompt');
            var $confirmBtn = $confirm.find('[data-am-modal-confirm]');
            var $cancelBtn = $confirm.find('[data-am-modal-cancel]');
            $confirmBtn.off('click.confirm.modal.amui').on('click', function() {
                // 将当前选择的时间返回到后端
                var sendData = new Object();
                sendData.reportDdl = $("#deadlineInput").val();
                sendData.klassSeminarId = ${klassSeminarId};
                $.ajax({
                    url: "/modifyReportDdl",
                    type: "post",
                    async: false,
                    data: sendData,
                    success: function(){
                        showTips("修改报告截止时间成功！", 200, 1);
                    },
                    error: function () {
                        showTips("当前页面发生了错误，请尝试刷新或者退出后重新进入系统！", 200, 3);
                    }
                });
            });
            $cancelBtn.off('click.cancel.modal.amui').on('click', function() {
                showTips("您取消提交当前讨论课报告截至日期！" + $("#deadlineInput").val(), 200, 1);
            });
        }else{
            if(window.confirm("您确定开始下一小组的展示吗？您当前的输入的展示分数将作为当前展示小组的展示成绩，请确认！")){
                var currentPresentationScore = $("#presentationScoreInput").val();
                if( currentPresentationScore >=0 && currentPresentationScore <= 5){
                    // 将当前展示的分数发送到后端
                    var sendData = new Object();
                    sendData.presentationScore = $("#presentationScoreInput").val();
                    sendData.klassSeminarId = ${klassSeminarId};
                    sendData.teamId = teamArray[currentTeamIndex].teamId;
                    $.ajax({
                        url: "/modifyPresentationScore",
                        type: "post",
                        async: false,
                        data: sendData,
                        success: function(){
                            showTips("修改展示分数成功！", 200, 1);
                        },
                        error: function () {
                            showTips("当前页面发生了错误，请尝试刷新或者退出后重新进入系统！", 200, 3);
                        }
                    });
                    showTips("切换到下一组！", 200, 1);
                    currentTeamIndex++;
                    // 教师开始下一组
                    message.action = "next";
                    var ts = stompClient.begin();
                    // 教师向 "/websocket/teacher/seminar/info" 发送信息：开始下一组
                    stompClient.send("/websocket/teacher/seminar/info", {}, JSON.stringify(message));
                    ts.commit();
                    $("#currentTeamLabel").html("第" + (currentTeamIndex + 1) + "组: " + teamArray[currentTeamIndex].teamName + "正在展示");
                }else{
                    showTips("您输入的展示分数不符合要求(0-5)分，请重新输入提交", 200, 1);
                }
            }else{
                showTips("您取消了开始下一组的操作！", 200, 1);
            }
        }
    }
    function setConnected (con) {
        connected = con;
    }
    if(!window.WebSocket) {
        showTips("您当前浏览器不支持WebSocket，部分功能可能存在问题！", 200, 3);
    }else{
        (function teacherEnterSeminar() {
            if(!connected){
                var socket = new SockJS("/websocket/seminar");
                stompClient = Stomp.over(socket);
                stompClient.connect({"id": "teacher"}, function(frame){
                    setConnected(true);
                    console.log(new Date() + "***********************************");
                    // 教师订阅 "/teacher-websocket/seminar/all" 接口，然鹅在目前没有任何消息会发送到这个接口
                    stompClient.subscribe('/teacher-websocket/seminar/all', function (message) {
                        console.log(new Date() + "/teacher-websocket/seminar/all\n" + message.body);
                        if(message == null){
                            return;
                        }else{
                            var messageJSON = JSON.parse(message.body);
                            console.log(new Date() + "self1: /teacher-websocket/seminar/all\n" + messageJSON);
                            if(messageJSON.seminarId == ${seminar.getId()}){
                                console.log("currentStudents:" + messageJSON.currentStudents);
                            }
                        }
                    });
                    // 教师订阅 "/teacher-websocket/seminar/question"接口
                    stompClient.subscribe("/teacher-websocket/seminar/question", function (message) {
                        console.log(new Date() + "self: /teacher-websocket/seminar/question\n" + message.body);
                        if(message == null){
                            return;
                        }else{
                            var messageJSON = JSON.parse(message.body);
                            if(messageJSON.seminarId == ${seminar.getId()} && messageJSON.action == "question"){
                                showTips("有新的学生提问！", 200, 1);
                                var newQuestionStudentInfo = messageJSON.newQuestionStudentInfo;
                                currentQuestionStudentInfoList.push(newQuestionStudentInfo);
                                loadCurrentStudentInfo(currentTeamIndex, currentQuestionStudentInfoList);
                            }
                        }
                    });
                });
            }
        })();
    }
</script>

</script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>