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
                <label style="color: #337ab7">第二组展示</label>
            </div>
            <div class="tpl-block">
                <div class="am-g tpl-amazeui-form">
                    <div class="">
                        <!--循环，动态获取正在展示的小组名，attendances为正在展示的小组的attendance对象，将其class变为myLabelQA-->
                        <#list teamList as team>
                            <div style="margin-bottom:0.5rem">
                                <lable class="mylabel">第${team_index}组：</lable>
                                <div class="myDiv">
                                    <label class="myLabel">${team.getTeamName()}</label>
                                </div>
                            </div>
                        </#list>
                        <!--正在展示的组的显示-->
                        <div style="margin-bottom:0.5rem">
                            <lable class="mylabel">第四组：</lable>
                                <div class="myDiv">
                                    <label class="myLabelQA">1-4 </label>
                                </div>
                        </div>
                    </div>
                    <button onclick="question()" class="am-btn am-btn-success  am-radius" style="width: 80%;margin-left: 10%;border: none;margin-top: 3rem">发起提问</button>
                </div>
            </div>
        </div>
    </div>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script>
    function showTips(content, height, time) {
        console.log("self: showTips;")
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
            'font-size': 12 + 'px',
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
    message.role = "student";
    var stompClient = null;
    var connected = false;
    function setConnected (con) {
        connected = con;
    }
    if(!window.WebSocket){
        alert("您当前浏览器不支持WebSocket哟！部分功能存在问题！")
    }else{
        (function studentEnterQuestion(){
            if(!connected){
                console.log("self: studentQuestion;");
                message.action = "question";
                var socket = new SockJS("/websocket/seminar");
                stompClient = Stomp.over(socket);
                stompClient.connect({"id": "student"}, function (frame) {
                    setConnected(true);
                    console.log("self: connected: " + frame);
                    message.action = "enter";
                    stompClient.send("/websocket/student/seminar/enter", {}, JSON.stringify(message));
                    // 每个学生都订阅("/student-websocket/seminar/all"); 教师开始下一组时，发送到这个接口
                    stompClient.subscribe("/student-websocket/seminar/all", function (message) {
                        console.log("self: /student-websocket/seminar/all\n" + message);
                    });
                })
            }
        })();
    }
    function question () {
        console.log("self: question;");
        showTips(233,200,5);
        message.action = "question";
        message.studentId = ${student.getId()};
        stompClient.send("/websocket/student/seminar/question", {}, JSON.stringify(message));
        // 提问学生订阅("student-websocket/seminar/questionseomeone")，接受教师抽取提问信息
        stompClient.subscribe("/student-websocket/seminar/questionsomeone", function(message){
            console.log("self: /student-websocket/seminar/questionsomeone\n" + message);
        })
    }
</script>
<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>