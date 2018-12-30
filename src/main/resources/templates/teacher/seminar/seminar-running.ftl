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
            position: absolute;
            width: 80%;
            margin-left: 10%;
            margin-top: -35rem;
            background-color: #f7f7f7;
            padding: 5% 5% 5% 5%;
        }
    </style>
</head>

<body id="body">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <a href="seminar1.html">
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
            <li><a href="index_message.html"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
            <li><a href="index_personal.html"><span class="am-icon-user"></span> 个人信息</a></li>
            <li><a href="index_personal.html"><span class="am-icon-leanpub"></span> 讨论课</a></li>
            <li><a href="login.html"><span class="am-icon-power-off"></span>退出</a></li>
        </ul>
    </div>
</header>
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <div class="tpl-portlet-components1">
        <div style="text-align: center">
            <label style="font-size: 2rem">${seminar.getSeminarName()}</label><br>
            <!--根据teacher controller的/seminarRunning返回的teamlist和attendance点击下一组展示，更换到下一个team-->
            <label style="color: #555555">第6：1-3组展示，</label>
        </div>
        <div class="tpl-block">
            <div class="am-g tpl-amazeui-form">
                <div style="width: 40%;float: left;margin-left: 6%">
                    <table class="am-table am-table-striped am-table-hover table-main" id="QA">
                        <tbody>
                        <p class="myLabel">有5位同学提问</p>
                        <tr>
                            <td>1-1</td>
                            <td>燕小六</td>
                        </tr>
                        <tr>
                            <td>1-1</td>
                            <td>燕小六</td>
                        </tr>
                        <tr>
                            <td>1-1</td>
                            <td>燕小六</td>
                        </tr>
                        <tr>
                            <td>1-1</td>
                            <td>燕小六</td>
                        </tr>
                        <tr>
                            <td>1-1</td>
                            <td>燕小六</td>
                        </tr>

                        </tbody>
                    </table>
                </div>
                <form class="am-form">
                    <div style="width: 54%;float: left;text-align: center">
                        <p>展示分数</p>
                        <div style="text-align: center">
                            <input type="number" style="font-size: 3rem;width: 40%;margin-left: 30%">
                        </div>

                    </div>
                    <button onclick="questionSomeone()" type="button" class="am-btn am-btn-danger  am-radius" style="width: 80%;margin-left: 10%;margin-top: 3rem">抽取提问</button>
                    <button onclick="nextTeam()" type="button" class="am-btn am-btn-success  am-radius" style="width: 80%;margin-left: 10%;margin-top: 1rem" data-am-modal="{target: '#my-prompt'}">下组展示</button>
                </form>
            </div>

            <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
                <div class="am-modal-dialog">
                    <div class="am-modal-bd">
                        讨论课已结束，请设定书面报告截止时间
                        <input type="date" class="am-modal-prompt-input">
                    </div>
                    <div class="am-modal-footer">
                        <span class="am-modal-btn" data-am-modal-cancel>取消</span>
                        <span class="am-modal-btn" data-am-modal-confirm>提交</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script>
    var message = new Object();
    message.role = "teacher";
    var stompClient = null;
    var connected = false;
    function setConnected (con) {
        connected = con;
    }
    if(!window.WebSocket) {
        alert("您当前浏览器不支持WebSocket哟！部分功能可能存在问题！");
    } else{
        (function teacherEnterSeminar() {
            if(!connected){
                // model.addAttribute("seminar",seminar);
                // 展示的team，按展示顺序排列
                // model.addAttribute(teamList);
                // 展示的attendance，按展示顺序排列
                // model.addAttribute(attendances);
                var socket = new SockJS("/websocket/seminar");
                stompClient = Stomp.over(socket);
                stompClient.connect({"id": "teacher"}, function(frame){
                    setConnected(true);
                    console.log('self: Connected: ' + frame);
                    message.action = "begin";
                    stompClient.send("/websocket/teacher/seminar/begin", {}, JSON.stringify(message));
                    stompClient.subscribe('/teacher-websocket/seminar/all', function (message) {
                        console.log("self: /teacher-websocket/seminar/all\n" + message);
                    });
                    stompClient.subscribe("/teacher-websocket/seminar/question", function (message) {
                        console.log("self: /teacher-websocket/seminar/question\n" + message);

                    });
                });
            }
        })();
    }
    function questionSomeone(){
        console.log("self: questionSomeone!");
        // 教师抽取提问
        message.action = "question";
        stompClient.send("/websocket/teacher/seminar/questionsomeone", {}, JSON.stringify(message));
    }
    function nextTeam() {
        console.log("self: nextTeam!");
        // 教师开始下一组
        message.action = "next";
        stompClient.send("/websocket/teacher/seminar/begin", {}, JSON.stringify(message));
    }
    console.log("1");
</script>
<script id="myTr" type="text/html">
    <div class="modDiv">
        <table class="am-table am-table-radius am-table-striped">
            <thead>
            <tr>
                <td style="width: 30%;">组号</td>
                <td style="width: 40%;">学生姓名</td>
                <td style="width: 30%;">打分</td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1-1</td>
                <td>张三丰</td>
                <td><input type="number" required="required"
                           style="width: 4rem;background-color: #f7f7f7;border: 0.2rem solid #c8c8c8"></td>
            </tr>
            </tbody>
        </table>
        <button class="am-btn am-btn-success am-table-radius" style="width: 100%;margin-top: 2rem" onclick="Check()">
            下一个提问
        </button>
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
    function Check() {

        var title = new MyBuilder($("#body"), $("#myTr"));
    }
</script>

<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>