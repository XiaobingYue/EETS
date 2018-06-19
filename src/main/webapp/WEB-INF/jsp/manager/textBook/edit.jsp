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
                <li><a href="${APP_PATH}/textBookController/toIndex.do">数据列表</a></li>
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
                                    <th colspan="3" style="text-align: center">教材清单详情</th>
                                </tr>
                            </thread>
                            <tbody>
                            <tr>
                                <td>教材名称：<input type="text" id="name" class="form-control" name="name"
                                                value="${textBook.name}"
                                                placeholder="请输入名称"></td>
                                <td colspan="2">出版社：<input type="text" id="publisher" class="form-control"
                                                           name="publisher" value="${textBook.publisher}"
                                                           placeholder="请输入名称"></td>
                            </tr>
                            <tr>
                                <td colspan="2">所属教学任务：
                                    <c:set var="taskId" value="${textBook.taskId}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="taskId" name="taskId"
                                            data-live-search="true">
                                        <option value="0"></option>
                                        <c:forEach items="${taskList}" var="task" varStatus="vs">
                                            <option id="${task.id}" value="${task.id}"
                                                    <c:if test="${task.id == taskId}">selected</c:if>>
                                                    ${task.name}</option>
                                        </c:forEach>
                                    </select></td>
                                <td>数量：<input type="text" id="count" class="form-control" name="count" value="${textBook.count}"
                                              placeholder="数量"></td>
                            </tr>
                            </tbody>
                        </table>
                        <button type="button" id="updateBtn" class="btn btn-success"><i
                                class="glyphicon glyphicon-pencil"></i> 修改
                        </button>
                        <button type="button" id="resetBtn" class="btn btn-danger"><i
                                class="glyphicon glyphicon-refresh"></i> 重置
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
        var publisher = $("#publisher");
        var taskId = $("#taskId");
        var count = $("#count");
        if (!flag) {
            return;
        } else if (name.val() == "") {
            layer.msg("请输入正确的名称", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                name.focus();
            });
        } else if (publisher.val() == "") {
            layer.msg("请输入正确的出版社", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                publisher.focus();
            });
        } else if (taskId.val() == 0) {
            layer.msg("请选择正确的任务", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                taskId.focus();
            });
        } else if (count.val() == "") {
            layer.msg("请输入正确的数量", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                count.focus();
            });
        } else {
            // 提交表单
            var loadingIndex = -1;
            $.ajax({
                type: "POST",
                url: "${APP_PATH}/textBookController/edit.do",
                data: {
                    "name": $("#name").val(),
                    "publisher": $("#publisher").val(),
                    "taskId": $("#taskId").val(),
                    "count": $("#count").val(),
                    "id":${textBook.id}
                },
                beforeSend: function () {
                    loadingIndex = layer.load(2, {time: 1000});
                },
                success: function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("任务信息修改成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/textBookController/toIndex.do?pageNo=${param.pageNo}";
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
