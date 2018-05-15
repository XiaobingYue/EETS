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
    <link rel="stylesheet"
          href="${APP_PATH}/bootstrap/css/fileinput.css">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrapValidator.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-select.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        ::-webkit-scrollbar {
            display: none;
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
                <li><a href="${APP_PATH}/teachTaskController/toMyTask.do">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form id="userForm" role="form">
                        <table class="table table-bordered">
                            <thread>
                                <tr>
                                    <th colspan="3" style="text-align: center">教学任务详情</th>
                                </tr>
                            </thread>
                            <tbody>
                            <tr>
                                <td>任务名称：<input type="text" id="name" class="form-control" name="name"
                                                value="${teachTask.name}" readonly
                                                placeholder="请输入名称"></td>
                                <td colspan="2">所属专业：
                                    <input type="text" id="proName" class="form-control" name="proName"
                                           value="${teachTask.proName}" readonly
                                           placeholder="请输入名称"></td>
                            </tr>
                            <tr>
                                <td>所属班级：
                                    <input type="text" id="classesName" class="form-control" name="classesName"
                                           value="${teachTask.classesName}" readonly
                                           placeholder="请输入名称"></td>
                                <td>学期：<input type="text" id="term" class="form-control" name="term"
                                              value="${teachTask.term}"
                                              placeholder="学期" readonly></td>
                                <td>所属课程：
                                    <input type="text" id="courseName" class="form-control" name="courseName"
                                           value="${teachTask.courseName}" readonly
                                           placeholder="请输入名称">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">任务内容：<textarea id="content" readonly class="form-control" name="content"
                                                               placeholder="任务内容" cols="30"
                                                               rows="10">${teachTask.content}</textarea></td>
                            </tr>
                            </tbody>
                        </table>
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
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/fileinput.js"></script>
<script src="${APP_PATH}/bootstrap/js/zh.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrapValidator.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/bootstrap/js/moment-with-locales.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"></script>
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


    });

    function setCourseName(id) {
        var courseName = $("#courseId option:selected").text();
        $("#courseName").val(courseName);
    }

    function setClassName() {
        var classesName = $("#classesId option:selected").text();
        $("#classesName").val(classesName);
    }

    function setProfessionName() {
        var professionName = $("#professionalId option:selected").text();
        $("#proName").val(professionName);
    }

    $('#developTime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });
    $('#reviewTime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });
    $('#approveTime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });

    var flag = true;
    $("#resetBtn").click(function () {
        // JQuery对象[0] ==》 DOM对象
        // $(DOM对象) ==》 JQuery对象
        $("#userForm")[0].reset();
    });

    $("#updateBtn").click(function () {
        //获取表单对象
        var name = $("#name");
        var professional = $("#professionalId");
        var classes = $("#classesId");
        var term = $("#term");
        var course = $("#courseId");
        var content = $("#content");
        if (!flag) {
            return;
        } else if (name.val() == "") {
            layer.msg("请输入正确的任务名称", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                name.focus();
            });
        } else if (professional.val() == "") {
            layer.msg("请输入正确的专业", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                professional.focus();
            });
        } else if (classes.val() == "") {
            layer.msg("请输入正确的班级", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                classes.focus();
            });
        } else if (term.val() == "") {
            layer.msg("请输入正确的学期", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                term.focus();
            });
        } else if (course.val() == "") {
            layer.msg("请输入正确的课程", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                course.focus();
            });
        } else if (content.val() == "") {
            layer.msg("请输入正确的任务内容", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                content.focus();
            });
        } else {
            // 提交表单
            var loadingIndex = -1;
            $.ajax({
                type: "POST",
                url: "${APP_PATH}/teachTaskController/editTeachTask.do",
                data: {
                    "name": $("#name").val(),
                    "professionalId": $("#professionalId").val(),
                    "proName": $("#proName").val(),
                    "classesId": $("#classesId").val(),
                    "classesName": $("#classesName").val(),
                    "term": $("#term").val(),
                    "courseId": $("#courseId").val(),
                    "courseName": $("#courseName").val(),
                    "content": $("#content").val(),
                    "id":${teachTask.id}
                },
                beforeSend: function () {
                    loadingIndex = layer.load(2, {time: 10 * 1000});
                },
                success: function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("任务信息修改成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/teachTaskController/toTeachTaskList.do?pageNo=${param.pageNo}";
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
