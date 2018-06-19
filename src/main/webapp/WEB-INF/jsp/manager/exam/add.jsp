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
                <li><a href="${APP_PATH}/examController/toIndex.do">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form method="post" action="${APP_PATH}/examController/addExam.do" id="examForm"
                          role="form">
                        <table id="examTable" class="table table-bordered">
                            <thread>
                                <tr>
                                    <th colspan="2" style="text-align: center">命题基本信息</th>
                                </tr>
                            </thread>
                            <tbody>
                            <tr>
                                <td>课程名称：<select class="selectpicker show-tick form-control" id="courseId"
                                                 name="courseId" data-live-search="true" onchange="getIndexPoint()">
                                    <option value="0"></option>
                                    <c:forEach items="${courseList}" var="course" varStatus="vs">
                                        <option id="${course.id}" value="${course.id}"> ${course.name}</option>
                                    </c:forEach>
                                </select>
                                </td>
                                <td>课程所在学院：<select class="selectpicker show-tick form-control" id="instituteId"
                                                   name="instituteId" data-live-search="true">
                                    <option value="0"></option>
                                    <c:forEach items="${instituteList}" var="institute" varStatus="vs">
                                        <option id="${institute.id}" value="${institute.id}"> ${institute.name}</option>
                                    </c:forEach>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td>系（教研室）：<select class="selectpicker show-tick form-control" id="staffRoomId"
                                                   name="staffRoomId" data-live-search="true">
                                    <option value=""></option>
                                    <c:forEach items="${staffRoomList}" var="staffRoom" varStatus="vs">
                                        <option id="${staffRoom.id}" value="${staffRoom.id}"> ${staffRoom.name}</option>
                                    </c:forEach>
                                </select></td>
                                <td>命题教师：<select class="selectpicker show-tick form-control" id="developerId"
                                                 name="developerId" data-live-search="true">
                                    <option value="0"></option>
                                    <c:forEach items="${teacherList}" var="teacher" varStatus="vs">
                                        <option id="${teacher.id}" value="${teacher.id}"> ${teacher.name}</option>
                                    </c:forEach>
                                </select></td>
                            </tr>
                            <tr>
                                <td colspan="2">适用班级：<select class="selectpicker show-tick form-control"
                                                             id="classIdList"
                                                             name="classIdList" data-live-search="true" multiple>
                                    <option value="0"></option>
                                    <c:forEach items="${classesList}" var="classes" varStatus="vs">
                                        <option id="${classes.id}" value="${classes.id}"> ${classes.className}</option>
                                    </c:forEach>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td>考核方式：<select class="selectpicker show-tick form-control" id="testType"
                                                 name="testType" data-live-search="true">
                                    <option value="0"></option>
                                    <option value="开卷"> 开卷</option>
                                    <option value="闭卷"> 闭卷</option>
                                    <option value="机试"> 机试</option>
                                    <option value="论文"> 论文</option>
                                    <option value="其他"> 其他</option>
                                </select>
                                </td>
                                <td>命题方式：<select class="selectpicker show-tick form-control" id="propositionType"
                                                 name="propositionType" data-live-search="true">
                                    <option value="0"></option>
                                    <option value="题库抽题"> 题库抽题</option>
                                    <option value="集体出题"> 集体出题</option>
                                    <option value="任课教师出题"> 任课教师出题</option>
                                    <option value="他人出题"> 他人出题</option>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td>课程结束日期：<br><input type="text" id="courseEndTime" class="form-control form_datetime"
                                                      name="courseEndTime"
                                                      placeholder="课程结束日期"></td>
                                <td>命题日期：<br><input type="text" id="createTime" class="form-control form_datetime"
                                                    name="createTime"
                                                    placeholder="命题日期"></td>
                            </tr>
                            </tbody>
                        </table>
                        <table id="indexPointTable" class="table">
                            <thead>
                            <tr>
                                <th colspan="3" style="text-align: center">课程考核办法</th>
                            </tr>
                            </thead>
                            <tbody id="testMethod">
                            <tr>
                                <td>实验成绩：<br><input type="text" class="form-control" name="testMode" value="实验成绩" readonly placeholder="请输入题型或知识点"></td>
                                <td>分数：<br><input type="number" value="100" class="form-control" name="score" placeholder="请输入分值" ></td>
                            </tr>
                            <tr>
                                <td>平时成绩：<br><input type="text" class="form-control" name="testMode" readonly value="平时成绩" placeholder="请输入题型或知识点"></td>
                                <td>分数：<br><input type="number" value="100" class="form-control" name="score" placeholder="请输入分值" ></td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <button type="button" id="insertMethod" style="margin-bottom:10px;" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 添加题目</button>
                            </tfoot>
                        </table>
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
<script src="${APP_PATH}/jquery/jquery-3.1.0.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.form.js"></script>
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
    var methodCount = 1;
    $("#insertMethod").click(function(){

        // 增加一行
        var indexPointTable = $("#testMethod");
        var trObj = "";
        trObj += '<tr>';
        trObj += '    <td>题目'+methodCount+'：<br><input type="text" class="form-control" name="testMode" placeholder="请输入题型或知识点"></td>';
        trObj += '    <td>分数：<br><input type="number" class="form-control" name="score" placeholder="请输入分值" ></td>';
        trObj += '    <td><br><a class="btn btn-danger" onclick="deleteMethod(this)"><i class="glyphicon glyphicon-remove"></i></a></td>';
        trObj += '</tr>';
        indexPointTable.append(trObj);
        methodCount++;
    });

    function deleteMethod(obj) {
        // obj ==> <a>
        // 查找tr
        methodCount--;
        var trObj = $(obj).parent().parent();
        // 删除tr
        trObj.remove();
    }

    function getIndexPoint() {
        var courseId = $("#courseId").val();
        $.ajax({
            url: "${APP_PATH}/examController/queryIndexPointByCourseId.do",
            type: "POST",
            data: {"courseId": courseId},
            beforeSend: function () {
                loadingIndex = layer.msg('数据查询中', {icon: 16});
                return true;
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                  /*  var indexPointList = result.data;
                    var content = '<thread><tr><th colspan="4" style="text-align: center">课程目标考核办法</th></tr></thread>';
                    for (j = 1; j < 11; j++) {
                        content = content + '<tr>';
                        content = content + '<td>题目' + j + '：<br><input type="text" class="form-control" name="testMode" placeholder="请输入题型或知识点"></td>';
                        content = content + '<td>分值：<br><input type="text" class="form-control" name="score"></td>';
                        content = content + '<td>所属指标点：<select class="form-control" name="indexPointId">' +
                            '<option value="0"></option>';
                        $.each(indexPointList, function (i, indexPoint) {
                            content = content + '<option value="' + indexPoint.id + '">' + indexPoint.name + '</option>';
                        });
                        content = content + '</select></td>';
                        content = content + '</tr>';
                    }
                    $("#indexPointTable").html(content);*/

                } else {
                    layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                    $("#courseId").focus();
                }
            }
        });
    }

    $('#courseEndTime').datetimepicker({
        minView: "month",
        format: 'yyyy-mm-dd'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });
    $('#createTime').datetimepicker({
        minView: "month",
        format: 'yyyy-mm-dd'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });
    var flag = true;

    $("#insertBtn").click(function () {

        var courseId = $("#courseId");
        var instituteId = $("#instituteId");
        var staffRoom = $("#staffRoomId");
        var developerId = $("#developerId");
        var classIdList = $("#classIdList");
        var options = $("#classIdList option:selected");
        var testType = $("#testType");
        var propositionType = $("#propositionType");
        var courseEndTime = $("#courseEndTime");
        var createTime = $("#createTime");
        if (!flag) {
            return;
        } else if (courseId.val() == "") {
            layer.msg("请输入正确的课程", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseId.focus();
            });
        } else if (instituteId.val() == "") {
            layer.msg("请输入正确学院", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                instituteId.focus();
            });
        } else if (staffRoom.val() == "") {
            layer.msg("请输入正确的系", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                staffRoom.focus();
            });
        } else if (developerId.val() == "") {
            layer.msg("请选择正确的命题人", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                developerId.focus();
            });
        } else if (options.length == 0) {
            layer.msg("请选择适用班级", {time: 1000, icon: 5, shift: 6});
            classIdList.focus();
        } else if (testType.val() == "") {
            layer.msg("请选择正确的考试方式", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                testType.focus();
            });
        } else if (propositionType.val() == "") {
            layer.msg("请选择正确的命题方式", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                propositionType.focus();
            });
        } else if (courseEndTime.val() == "") {
            layer.msg("请输入正确的课程结束时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseEndTime.focus();
            });
        } else if (createTime.val() == "") {
            layer.msg("请输入正确的创建时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                createTime.focus();
            });
        } else {
            // 提交表单
            var loadingIndex = -1;
            $("#examForm").ajaxSubmit({
                beforeSubmit: function () {
                    loadingIndex = layer.load(2, {time: 10 * 1000});
                },
                success: function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("命题申请信息保存成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/examController/toIndex.do";
                        });
                    } else {
                        layer.msg("操作失败" + result.data, {time: 1000, icon: 5, shift: 6});
                    }
                }
            });
        }
    });
</script>
</body>
</html>
