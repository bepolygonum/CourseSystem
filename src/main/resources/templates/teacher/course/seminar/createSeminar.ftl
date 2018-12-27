<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>新建讨论课</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>
</head>

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand1">
        <form id="_form" action="/teacher/course/seminar" method="get">
            <a onclick="document.getElementById('_form').submit();">
                <input value="${id}" name="id" hidden="hidden">
                <input value="${course.getId()}" name="courseId" hidden="hidden">
                <div class="am-icon-times" style="color: darkgray"></div>
            </a>
        </form>
    </div>
    <div class="am-topbar-brand">
        <h3>${course.getCourseName()}</h3>
    </div>
</header>
<form action="/teacher/course/seminar/createSeminar" method="post" onsubmit="return test();">
    <div class="tpl-page-container1 tpl-page-header-fixed">
        <div class="tpl-portlet-components2">
            <hr>
            <input value="${id}" name="id" hidden="hidden">
            <input value="${course.getId()}" name="courseId" hidden="hidden">
            <div style="text-align: center">
                <h3 style="margin-top: 1rem">新建讨论课</h3>
            </div>
            <hr>
            <div style="text-align: center"><input type="text" placeholder="讨论课主题" name="seminarName" id="seminarName" style="width: 90%;"></div>
            <hr>
            <div style="text-align: center">
                <textarea   placeholder="讨论课主要内容" style="border: none;width: 90%;" name="mainContent" id="mainContent"></textarea>
            </div>
            <hr>
            <div style="margin-top: 1rem">

                <p style="margin-left: 1rem;float: left;width: 40%" >讨论课次序号</p>

                <select data-am-selected="{btnWidth: '40%',}" style="width: 60%"  id="serial" name="serial">
                    <option value="1">1</option>
                    <#if seminarList?exists>
                    <#list seminarList as seminar>
                    <option value="${seminar.getSeminarSerial()+1}">${seminar.getSeminarSerial()+1}</option>
                    </#list>
                    </#if>
                </select>
            </div>
            <hr>
            <div style="margin-top: 1rem">

                <p style="margin-left: 1rem;float: left;width: 40%" >讨论课可见</p>
                <label class="am-radio" style="margin-left: 50%">
                    <input type="checkbox" name="isVisible" id="isVisible" value="1" data-am-ucheck style="margin-top: 0.4rem">
                    可见
                </label>
            </div>
            <hr>

            <p style="margin-left: 6%">展示报名</p>
            <div>
                <p style="width: 30%;float: left;margin-left: 6%">开始时间:</p>
                <input style="width: 55%;" class="border"  type="datetime-local" id="startDate" name="startDate"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">结束时间:</p>
                <input style="width: 55%;" class="border"  type="datetime-local" name="endDate" id="endDate"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">报名小组数:</p>
                <input style="width: 30%;margin-left: 10%" class="border"  type="number" name="number" id="number"/>
            </div>
            <div class="top">
                <p style="width: 30%;float: left;margin-left: 6%">报名顺序:</p>
                <label class="am-radio" style="margin-left: 50%">
                    <input name="order" id="order" type="checkbox" value="" data-am-ucheck style="margin-top: 0.4rem">
                    自定
                </label>
            </div>
            <div class="top">
                <p style="width: 40%;float: left;margin-left: 6%">所属Round:</p>
                <select data-am-selected="{btnWidth: '40%',}" name="round" id="round" >
                    <option value="0">新建</option>
                    <#if roundList?exists>
                        <#list roundList as round>
                        <option value="${round.getId()}">${round.getRoundSerial()}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <button type="submit" class="am-btn am-btn-success" style="width: 80%;margin-left: 10%;margin-top: 3rem;margin-bottom: 3rem">发布</button>

        </div>

    </div>

</form>
<script>
    function test() {
        var seminarName = document.getElementById('seminarName');
        var mainContent = document.getElementById('mainContent');
        var serial = document.getElementById('serial');
        var startDate = document.getElementById('startDate');
        var endDate = document.getElementById('endDate');
        var number = document.getElementById('number');
        var round = document.getElementById('round');
        if (seminarName.value == ''|mainContent.value == ''|serial.value == ''|startDate.value==''|endDate.value==''|number.value==''|round.value=='')
        {
            alert("These items cannot be empty!");
            return false;
        }
        return true;
    }
</script>
<script src="../../../../static/js/jquery.min.js"></script>
<script src="../../../../static/js/amazeui.min.js"></script>
<script src="../../../../static/js/app.js"></script>
</body>

</html>

<!--<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>新建讨论课</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../../static/css/app.css">
    <script src="../../../../static/js/echarts.min.js"></script>
    <style type="text/css">
        .inputext {
        height: 30px;
        border-radius: 5px;
        margin-left: 5%;
        margin-bottom: 3%;
        outline: none;
        border-top-style: groove;
        border-right-style: groove;
        border-bottom-style: groove;
        border-left-style: groove;
        border: 1px solid #a1a1a1;
        width: 60%;
        }

        .divtext {
        outline: none;
        border: none;
        width: 100%;
        }

        .tdstyle {
        word-break: keep-all;
        white-space: nowrap;
        }

        .mybutton {
        height: 40px;
        border-radius: 5px;
        width: 100%;
        background-color: #337ab7;
        color: #ffffff;
        margin-top: 4%;
        }
    </style>
</head>

<body data-type="index">
    <header class="am-topbar am-topbar-inverse admin-header">
        <div class="am-topbar-brand1">
            <a href="courseinformation.html">
                <div class="am-icon-times" style="color: darkgray"></div>
            </a>
        </div>
        <div class="am-topbar-brand">
            <h3>${course.getCourseName()}</h3>
        </div>
    </header>

    <div class="tpl-page-container tpl-page-header-fixed">
        <div class="tpl-portlet-components">
            <form action="/teacher/course/seminar/createSeminar" method="post" onsubmit="return test();">
            <hr>
                <input value="${id}" name="id" hidden="hidden">
            <div style="text-align: center">
                <h3 style="color:#000000">新建讨论课</h3>
            </div>
            <hr>
            <div><input type="text" placeholder="讨论课主题" name="seminarName" id="seminarName"></div>
            <hr>
            <div>
                <textarea rows="5" cols="30" class="divtext" placeholder="讨论课主要内容" name="mainContent" id="mainContent"></textarea>
            </div>
            <hr>
            <div>
                <table>
                    <tr>
                        <td class="tdstyle">讨论课次序号</td>
                        <td>
                            <select style="float:right" id="serial" name="serial">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <hr>
            <div>
                <table>
                    <tr>
                        <td class="tdstyle">讨论课次序号</td>
                        <td>
                            <input type="checkbox" name="isVisible" id="isVisible">可见</input>
                        </td>
                    </tr>
                </table>
            </div>
            <hr>
            <div>
                <table>
                    <tr>
                        <td class="tdstyle">报名开始时间</td>
                        <td>
                            <table>
                                <tr><input type="date" id="startDate" name="startDate"></tr>
                                <tr><input type="time" id="startTime" name="startTime"></tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdstyle">报名结束时间</td>
                        <td>
                            <table>
                                <tr><input type="date" name="endDate" id="endDate"></tr>
                                <tr><input type="time" name="endTime" id="endTime"></tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>报名小组数: </td>
                        <td><input type="text" class="inputext" name="number" id="number"></td>
                    </tr>
                    <tr>
                        <td class="tdstyle">报名顺序</td>
                        <td>
                            <input type="checkbox" name="order" id="order">自定</input>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdstyle">所属Round</td>
                        <td>
                            <select name="round" id="round">
                                <option>无(默认新建Round)</option>
                                <option>1</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <button type="submit" class="mybutton">发布</button>
            </form>
            <script>
                function test() {
                    var seminarName = document.getElementById('seminarName');
                    var mainContent = document.getElementById('mainContent');
                    var serial = document.getElementById('serial');
                    var startDate = document.getElementById('startDate');
                    var startTime = document.getElementById('startTime');
                    var endDate = document.getElementById('endDate');
                    var endTime = document.getElementById('endTime');
                    var number = document.getElementById('number');
                    var round = document.getElementById('round');
                    if (seminarName.value == ''|mainContent.value == ''|serial.value == ''|startDate.value==''|startTime.value==''
                            |endDate.value==''|endTime.value==''|number.value==''|round.value=='')
                    {
                        alert("These items cannot be empty!");
                        return false;
                    }
                    return true;
                }
            </script>
        </div>

    </div>

    <script src="../../../../static/js/jquery.min.js"></script>
    <script src="../../../../static/js/amazeui.min.js"></script>
    <script src="../../../../static/js/app.js"></script>
</body>

</html>-->