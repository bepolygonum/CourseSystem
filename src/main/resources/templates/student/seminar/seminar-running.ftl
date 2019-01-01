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
    <!-- 目前前端WebSocket所需js从cdn节点加载-->
    <#--<script src="https://cdn.bootcss.com/sockjs-client/1.3.0/sockjs.min.js" async="async"></script>-->
    <#--<script src="https://cdn.bootcss.com/stomp.js/2.3.3/stomp.min.js" async="async"></script>-->
</head>

<body>
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="homepage.html">
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
            <li><a href="index_message.html" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a href="index_personal.html" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a href="index_personal.html" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="login.html" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>
    <div class="tpl-content-wrapper" style="margin-top: 5rem">
        <div class="tpl-portlet-components1">
            <div style="text-align: center">
                <label style="font-size: 2rem">${seminar.getSeminarName()}</label><br>
                <label id="currentTeamLabel0" style="color: #337ab7"></label>
            </div>
            <div class="tpl-block">
                <div class="am-g tpl-amazeui-form">
                    <div class="">
                        <!--循环，动态获取正在展示的小组名，attendances为正在展示的小组的attendance对象，将其class变为myLabelQA-->
                        <#list teamList as team>
                            <div style="margin-bottom:0.5rem">
                                <lable class="mylabel">第${team_index + 1}组：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">${team.getTeamName()}</label>
                                </div>
                            </div>
                        </#list>
                        <!--正在展示的组的显示-->
                        <div style="margin-bottom:0.5rem">
                            <lable id="currentTeamLabel1" class="mylabel"></lable>
                                <div class="myDiv">
                                    <label id="currentTeamLabel2" class="myLabelQA"> </label>
                                </div>
                        </div>
                    </div>
                    <button id="question" onclick="question()" class="am-btn am-btn-success  am-radius" style="width: 80%;margin-left: 10%;border: none;margin-top: 3rem">发起提问</button>
                </div>
            </div>
        </div>
    </div>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="../../../static/js/jquery.min.js"></script>
<script>
    function showTips(content, height, time) {
        console.log(new Date() + "showTips")
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
        }).show();
        setTimeout(function () {
            $('div.tipsClass').fadeOut();
        }, (time * 1000));
    }

    var message = new Object();
    var stompClient = null;
    var connected = false;
    message.role = "student";
    message.action = "enter";
    message.seminarId = ${seminar.getId()};
    // 学生进入界面，请求信息，更新currentTeamIndex
    var currentTeamIndex = 0;
    var teamArray = [];
    <#if teamList?exists>
        <#list teamList as team>
            var tempTeam = "${team.getTeamName()}";
            teamArray.push(tempTeam);
        </#list>
    </#if>
    function updateCurrentTeam(){
        console.log(new Date() + "updateCurrentTeam");
        if(currentTeamIndex >= teamArray.length){
            console.log("当前已是最后一组！");
        }else{
            $("#currentTeamLabel0").html("第" + (currentTeamIndex + 1) + "小组展示");
            $("#currentTeamLabel1").html("第" + (currentTeamIndex + 1) + "小组：");
            $("#currentTeamLabel2").html(teamArray[currentTeamIndex]);
        }
    }
    $.post("/student_websocket/seminar/enter", { "message": JSON.stringify(message) }, function(message){
        console.log(new Date() + "/student_websocket/seminar/enter " +  " message:\n" + message);
        if(message == "" || typeof (message) == undefined){
            return;
        }else{
            var messageJSON = JSON.parse(message);
            if(messageJSON != null){
                currentTeamIndex = messageJSON.currentTeamIndex;
                updateCurrentTeam();
            }
        }
    });
    // 更新需要 currentTeamIndex 的界面
    $(document).ready(function(){
        updateCurrentTeam();
        showTips("已获取当前页面最新信息！", 200, 1);
    });
    function setConnected (con) {
        connected = con;
    }
    if(!window.WebSocket){
        showTips("您当前浏览器不支持WebSocket哟！部分功能存在问题！", 200, 1);
    }else{
        (function studentEnterSeminar(){
            if(!connected){
                console.log(new Date() + " studentEnterSeminar");
                var socket = new SockJS("/websocket/seminar");
                stompClient = Stomp.over(socket);
                stompClient.connect({"id": "student"}, function (frame) {
                    setConnected(true);
                    console.log(new Date() + "***********************************");

                    // 学生向 "/websocket/student/seminar/enter" 发送信息
                    stompClient.send("/websocket/student/seminar/enter", {}, JSON.stringify(message))
                    // 所有学生都订阅("/student-websocket/seminar/all"); 教师广播给全部学生的信息：开始下一组
                    stompClient.subscribe("/student-websocket/seminar/all", function (message) {
                        console.log(new Date() + "/student-websocket/seminar/all" + "message:\n" + message.body);
                        if(message == null || typeof (message) == undefined){
                            return;
                        }else{
                            var messageJSON = JSON.parse(message.body);
                            console.log(${seminar.getId()});
                            if(messageJSON.seminarId == ${seminar.getId()} && messageJSON.action == "next"){
                                currentTeamIndex++;
                                updateCurrentTeam();
                                showTips("当前已经切换到下一组展示！", 200, 1);
                            }
                        }
                    });
                })
            }
        })();
    }
    function question () {
        showTips("您发起了提问请求,30秒之后您才可以再次发起提问请求！", 200, 1);
        console.log(new Date() + "self: question;");
        $('#question').attr("disabled", true);
        setTimeout(function () {
            $('#question').attr("disabled", false);
        }, 30000);
        message.action = "question";
        message.studentId = ${student.getId()};
        message.studentName = "${student.getStudentName()}";
        // 学生向 "/websocket/student/seminar/question" 发送提问信息
        stompClient.send("/websocket/student/seminar/question", {}, JSON.stringify(message));
        // 提问学生订阅("student-websocket/seminar/questionseomeone")，接受教师抽取提问信息
        stompClient.subscribe("/student-websocket/seminar/questionsomeone", function(message){
            console.log(new Date() + "/student-websocket/seminar/questionsomeone" + "message:\n" + message.body);
            if(message == null){
                return;
            }else{
                var messageJSON = JSON.parse(message.body);
                if(messageJSON.seminarId == ${seminar.getId()} && messageJSON.studentId == ${student.getId()}){
                    showTips("当前轮到您回答问题！", 200, 1);
                }
            }
        })
    }
</script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>