<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-select.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }
        ::-webkit-scrollbar{
            display:none;
        }
    </style>
</head>

<body>
<%@include file="/WEB-INF/jsp/common/userinfo.jsp" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="${APP_PATH}/toMain.do">首页</a></li>
                <li><a href="${APP_PATH}/userController/toUserList.do">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form method="post" action="${APP_PATH}/userController/addUser.do" id="userForm" role="form">
                        <div class="form-group">
                            <label>登陆账号</label>
                            <input type="text" class="form-control" id="userAcct" name="userAcct" required
                                   onblur="checkUserAcct()" placeholder="请输入登陆账号">
                            <p class="help-block label label-warning" id="msg">请输入合法的账号</p>
                        </div>
                        <div class="form-group">
                            <label>用户名称</label>
                            <input type="text" class="form-control" id="username" name="name" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label>邮箱地址</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning" s>请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <div class="form-group">
                            <label>性别</label>
                            <select class="form-control" id="sex" name="sex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>角色</label>
                            <select class="selectpicker show-tick form-control" onchange="ifStudent()" id="roleIds" name="roleIds" multiple data-live-search="true">
                                <c:forEach items="${roleList}" var="role" varStatus="vs">
                                    <option id="${role.roleName}" value="${role.id}"> ${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group" id="classes">
                            <label>班级</label>
                            <select class="form-control selectpicker show-tick" data-live-search="true" id="classesId" name="classesId">
                                <option value=""></option>
                                <c:forEach items="${classesList}" var="classes" varStatus="vs">
                                    <option id="${classes.id}" value="${classes.id}"> ${classes.className}</option>
                                </c:forEach></select>
                        </div>
                        <div class="form-group" id="staffRoom">
                            <label>所属系</label>
                            <select class="form-control selectpicker show-tick" data-live-search="true" id="staffRoomId" name="staffRoomId">
                                <option value=""></option>
                                <c:forEach items="${staffRoomList}" var="staffRoom" varStatus="vs">
                                    <option id="${staffRoom.id}" value="${staffRoom.id}"> ${staffRoom.name}</option>
                                </c:forEach></select>
                        </div>
                        <div class="form-group">
                            <label>手机号</label>
                            <input type="text" class="form-control" id="phone" name="phone"
                                   placeholder="请输入用户手机号">
                        </div>
                        <div class="form-group">
                            <label>排序</label>
                            <input type="text" class="form-control" id="sort" name="sort"
                                   placeholder="请输入用户排序">
                        </div>
                        <button type="button" id="insertBtn" class="btn btn-success"><i
                                class="glyphicon glyphicon-plus"></i> 新增
                        </button>
                        <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-3.1.0.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.form.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-select.js"></script>
<script src="${APP_PATH}/bootstrap/js/defaults-zh_CN.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
        $("#classes").hide();
        $("#staffRoom").hide();
    });

    function isEmpty(obj) {
        if (typeof obj == "undefined" || obj == null || obj == "") {
            return true;
        } else {
            return false;
        }
    }

    function IsInArray(arr,val){

        var testStr=','+arr.join(",")+",";

        return testStr.indexOf(","+val+",")!=-1;

    }

    function ifStudent() {
        var str= $('#roleIds').selectpicker('val');
        if(isEmpty(str)) {
            $("#classes").hide();
            $("#staffRoom").hide();
            return;
        }
        if(IsInArray(str,'5')) {
            $("#classes").show();
        } else {
            $("#classes").hide();
        }
        if(IsInArray(str,'9')) {
            $("#staffRoom").show();
        } else {
            $("#staffRoom").hide();
        }
    }
    var flag = true;

    function checkUserAcct() {
        var userAcct = $("#userAcct");
        var loadingIndex = -1;
        $.ajax({
            url: "${APP_PATH}/userController/validateUserAcct.do",
            type: "POST",
            //dataType : "json",
            data: {"userAcct": userAcct.val()},
            beforeSend: function () {
                //loadingIndex = layer.msg('处理中', {icon: 16});
                loadingIndex = layer.load(2, {time: 10 * 1000});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (!result.success) {
                    layer.msg(result.data, {time: 2000, icon: 5, shift: 6}, function () {
                        // 设定页面焦点
                    });
                    flag = false;
                    userAcct.focus();
                } else {
                    flag = true;
                }
            }
        });
    }

    $("#insertBtn").click(function () {

        var userAcct = $("#userAcct");
        var username = $("#username");
        var email = $("#email");
        var sex = $("#sex");
        var phone = $("#phone");
        var sort = $("#sort");
        var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$");
        if (!flag) {
            return;
        } else if (userAcct.val() == "") {
            layer.msg("账号不能为空，请输入", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                userAcct.focus();
            });
        } else if (username.val() == "") {
            layer.msg("用户名不能为空，请输入", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                username.focus();
            });
        } else if (email.val() == "" || !reg.test(email.val())) {
            layer.msg("email不正确，请输入", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                email.focus();
            });
        } else if (sex.val() == "") {
            layer.msg("性别不能为空，请输入", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                sex.focus();
            });
        } else if (phone.val() == "" || !(/^1[34578]\d{9}$/.test(phone.val()))) {
            layer.msg("手机号不正确，请输入", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                phone.focus();
            });
        } else if (sort.val() != "" && !(/^(?!0)\d{1,3}$/.test(sort.val()))) {
            layer.msg("排序只能输入1-999的整数", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                phone.focus();
            });
        } else {
            // 提交表单
            var loadingIndex = -1;
            $("#userForm").ajaxSubmit({
                beforeSubmit: function () {
                    loadingIndex = layer.load(2, {time: 10 * 1000});
                },
                success: function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("用户信息保存成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/userController/toUserList.do";
                        });
                    } else {
                        layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                    }
                }
            });
        }
    });
</script>
</body>
</html>
