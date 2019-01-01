<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>课程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../../../static/i/favicon.png">
    <link rel="stylesheet" href="../../../static/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../../static/css/admin.css">
    <link rel="stylesheet" href="../../../static/css/app.css">
    <script src="../../../static/js/echarts.min.js"></script>
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

<body data-type="index">
<header class="am-topbar am-topbar-inverse admin-header">
    <#--<div class="am-topbar-brand1">-->
            <#--<a href="/teacher/course/seminar?id=${id}&courseId=${courseId}">-->
                <#--<div class="am-icon-chevron-left" style="color: darkgray"></div>-->
            <#--</a>-->
    <#--</div>-->
    <div class="am-topbar-brand1">
        <a href="javascript:window.history.go(-1);">
            <div class="am-icon-chevron-left" style="color: darkgray"></div>
        </a>
    </div>
    <div class="am-topbar-brand">
        <h3>第${round.getRoundSerial()}轮</h3>
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">

        <span class="am-icon-bars"></span>
    </button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list tpl-header-list">
            <li class="am-dropdown" data-am-dropdown data-am-dropdown-toggle>
                <a class="am-dropdown-toggle tpl-header-list-link" href="javascript:;">
                    <span class="tpl-header-list-user-nick">用户名</span>
                </a>
                <ul class="am-dropdown-content" id="topbat-content">
                    <#--<li><a href="index_message.html"><span class="am-icon-envelope-o"></span> 消息管理</a></li>-->
                    <#--<li><a href="index_personal.html"><span class="am-icon-user"></span> 个人信息</a></li>-->
                    <#--<li><a href="index_personal.html"><span class="am-icon-leanpub"></span> 讨论课</a></li>-->
                    <#--<li><a href="/logout"><span class="am-icon-power-off"></span>退出</a></li>-->
                    <li><a onclick="standardPost('message')" class="tpl-header-list-link"><span class="am-icon-envelope-o"></span> 消息管理</a></li>
                    <li><a onclick="standardPost('personalInfo')" class="tpl-header-list-link"><span class="am-icon-user"></span> 个人信息</a></li>
                    <li><a onclick="standardPost('seminar')" class="tpl-header-list-link"><span class="am-icon-leanpub"></span> 讨论课</a></li>
                    <li><a href="/logout" class="tpl-header-list-link"><span class="am-icon-power-off"></span>退出</a></li>
                </ul>

            </li>
        </ul>
    </div>
</header>
<div class="tpl-content-wrapper" style="margin-top: 5rem">
    <form action="/teacher/course/setRound" method="post">
    <div class="tpl-portlet-components1">
        <div class="tpl-block">
            <div class="am-g tpl-amazeui-form">
                <div>
                    <p>讨论课:</p>
                    <input value="${id}" name="id" hidden="hidden">
                    <input value="${courseId}" name="courseId" hidden="hidden">
                    <input value="${round.getId()}" name="roundId" hidden="hidden">
                    <div style="text-align: center">
                        <#if seminarList?exists>
                            <#list seminarList as seminar>
                                <p class="top">${seminar.getSeminarName()}</p>
                            </#list>
                        </#if>
                    </div>
                </div>

                <div class="Top">
                    <p>成绩设置：</p>
                    <div class="top">
                        <p style="width: 40%;float: left;padding-left: 10%">展示：</p>
                        <select data-am-selected="{btnWidth: '40%',}" name="pre" id="pre">
                            <option value="0" >平均分</option>
                            <option value="1" >最高分</option>
                        </select>
                    </div>
                    <div class="top">
                        <p style="width: 40%;float: left;padding-left: 10%">提问：</p>
                        <select data-am-selected="{btnWidth: '40%',}" id="question" name="question">
                            <option value="0" >平均分</option>
                            <option value="1" >最高分</option>
                        </select>
                    </div>
                    <div class="top">
                        <p style="width: 40%;float: left;padding-left: 10%">报告：</p>
                        <select data-am-selected="{btnWidth: '40%',}" id="report" name="report">
                            <option value="0" >平均分</option>
                            <option value="1" >最高分</option>
                        </select>
                    </div>
                </div>
                <div class="Top">
                    <p>本轮讨论课报名次数</p>
                    <#if klassList?exists>
                        <#list klassList as klass>
                        <div>
                            <div class="top">
                                <p style="width: 40%;float: left;padding-left: 10%">${klass.getKlassSerial()}班：</p>
                                <input value="${klass.getId()}" name="klassIds" hidden="hidden">
                                <select data-am-selected="{btnWidth: '40%',}" name="apply" id="apply">
                                <#if numbers?exists>
                                    <#list numbers as number>
                                        <option value="${number}" >${number}</option>
                                    </#list>
                                </#if>
                                </select>
                            </div>
                        </div>
                        </#list>
                    </#if>
                </div>

                <button type="submit" onclick="" class="am-btn am-btn-success  am-radius" style="width: 80%;margin-left: 10%;border: none;margin-top: 1rem">修改</button>

            </div>
        </div>
    </div>
    </form>
</div>


<script src="../../../static/js/jquery.min.js"></script>
<script src="../../../static/js/amazeui.min.js"></script>
<script src="../../../static/js/app.js"></script>
</body>

</html>