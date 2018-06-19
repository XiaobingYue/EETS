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
                <li><a href="${APP_PATH}/examController/toMyTestDoList.do">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form method="post" action="${APP_PATH}/examController/editMyList.do" id="examForm"
                          role="form">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th colspan="4" style="text-align: center">课程基本信息</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <input type="hidden" value="${exam.id}" name="id">
                                <td colspan="2">课程名称：
                                    <c:set var="courseId" value="${exam.courseId}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="courseId" name="courseId"
                                            data-live-search="true" disabled="true">
                                        <c:forEach items="${courseList}" var="course" varStatus="vs">
                                            <option id="${course.id}" value="${course.id}"
                                                    <c:if test="${course.id==courseId}">selected</c:if>> ${course.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td colspan="2">课程所在学院：
                                    <c:set var="instituteId" value="${exam.instituteId}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="instituteId"
                                            name="instituteId" data-live-search="true" disabled="true">
                                        <c:forEach items="${instituteList}" var="institute" varStatus="vs">
                                            <option id="${institute.id}" value="${institute.id}"
                                                    <c:if test="${institute.id==instituteId}">selected</c:if>
                                            > ${institute.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="hidden" value="${exam.staffRoomId}" name="staffRoomId">
                                    <c:set var="staffRoomId" value="${exam.staffRoomId}" scope="request"/>
                                    系（教研室）：<select class="selectpicker show-tick form-control" disabled="true" id="staffRoomId" name="staffRoomId" data-live-search="true">
                                        <option value="0"></option>
                                        <c:forEach items="${staffRoomList}" var="staffRoom" varStatus="vs">
                                            <option id="${staffRoom.id}" value="${staffRoom.id}"
                                                    <c:if test="${staffRoom.id==staffRoomId}">selected</c:if>
                                            >${staffRoom.name}</option>
                                        </c:forEach>
                                    </select></td>
                                <td colspan="2">命题教师：
                                    <c:set var="developerId" value="${exam.developerId}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="developerId"
                                            name="developerId" data-live-search="true" disabled="true">
                                        <c:forEach items="${teacherList}" var="teacher" varStatus="vs">
                                            <option id="${teacher.id}" value="${teacher.id}"
                                                    <c:if test="${teacher.id==developerId}">selected</c:if>
                                            > ${teacher.name}</option>
                                        </c:forEach>
                                    </select></td>
                            </tr>
                            <tr>
                                <td colspan="4">适用班级：
                                    <select class="selectpicker show-tick form-control"
                                            id="classIdList"
                                            name="classIdList" data-live-search="true" multiple disabled="true">
                                        <c:forEach items="${classesList}" var="classes" varStatus="vs">
                                            <option id="${classes.id}"
                                                    value="${classes.id}"> ${classes.className}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">考核方式：
                                    <select class="selectpicker show-tick form-control" id="testType"
                                            name="testType" data-live-search="true" disabled="true">
                                        <option value="开卷"> 开卷</option>
                                        <option value="闭卷"> 闭卷</option>
                                        <option value="机试"> 机试</option>
                                        <option value="论文"> 论文</option>
                                        <option value="其他"> 其他</option>
                                    </select>
                                </td>
                                <td colspan="2">命题方式：<select class="selectpicker show-tick form-control"
                                                             id="propositionType"
                                                             name="propositionType" data-live-search="true"
                                                             disabled="true">
                                    <option value="题库抽题"> 题库抽题</option>
                                    <option value="集体出题"> 集体出题</option>
                                    <option value="任课教师出题"> 任课教师出题</option>
                                    <option value="他人出题"> 他人出题</option>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">课程结束日期：<br><input type="text" id="courseEndTime"
                                                                  class="form-control form_datetime"
                                                                  name="courseEndTime" value="${exam.courseEndTime}"
                                                                  disabled="true"
                                                                  placeholder="课程结束日期"></td>
                                <td colspan="2">命题日期：<br><input type="text" id="createTime"
                                                                class="form-control form_datetime"
                                                                name="createTime" value="${exam.createTime}"
                                                                disabled="true"
                                                                placeholder="命题日期"></td>
                            </tr>
                            </tbody>
                            <thread>
                                <tr>
                                    <th colspan="4" style="text-align: center">试做信息</th>
                                </tr>
                            </thread>
                            <tbody>
                            <tr>
                                <td>试卷类别：
                                    <select class="selectpicker show-tick form-control" id="testPaperType"
                                            name="testPaperType" data-live-search="true">
                                        <option value="0">请选择</option>
                                        <option value="试卷A">试卷A</option>
                                        <option value="试卷B"> 试卷B</option>
                                    </select>
                                </td>
                                <td>标准答案及评分标准：
                                    <select class="selectpicker show-tick form-control" id="ifHaveAnswer"
                                            name="ifHaveAnswer" data-live-search="true">
                                        <option value="0">请选择</option>
                                        <option value="有">有</option>
                                        <option value="无">无</option>
                                    </select>
                                </td>
                                <td>试卷考试时间：<br><input type="text" class="form-control" id="examTime" name="examTime">
                                </td>
                                <td>试做所需时间：<br><input type="text" class="form-control" id="testDoNeedTime"
                                                      name="testDoNeedTime">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    试做总结（从命题与教学大纲、考试大纲的符合程度、命题的难易度和覆盖面、试卷重复率、题量、题型等方面进行总结）
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"><textarea class="form-control" id="testDoSummary"
                                                          name="testDoSummary"></textarea></td>
                            </tr>
                            </tbody>
                        </table>
                        <table class="table">
                            <thread>
                                <tr>
                                    <th colspan="3" style="text-align: center">课程考核办法</th>
                                </tr>
                                <c:forEach items="${testMethodList}" var="testMethod" varStatus="status">
                                    <tr><td>题目${status.count}：${testMethod.testMode}</td><td>分数：${testMethod.scores}</td></tr>
                                </c:forEach>
                            </thread>
                        </table>
                        <button type="button" id="updateBtn" class="btn btn-success"><i
                                class="glyphicon glyphicon-pencil"></i> 提交
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
<script src="${APP_PATH}/jquery/jquery.form.js"></script>
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
        var classIdList = ${exam.classIdList};
        $('#classIdList').selectpicker('val', classIdList);

        var testType = "${exam.testType}";
        $("#testType").selectpicker('val', testType);

        var propositionType = "${exam.propositionType}";
        $("#propositionType").selectpicker('val', propositionType);
    });

    var flag = true;
    $("#resetBtn").click(function () {
        // JQuery对象[0] ==》 DOM对象
        // $(DOM对象) ==》 JQuery对象
        $("#userForm")[0].reset();
    });

    $("#updateBtn").click(function () {
        //获取表单对象
        var testPaperType = $("#testPaperType");
        var ifHaveAnswer = $("#ifHaveAnswer");
        var examTime = $("#examTime");
        var testDoNeedTime = $("#testDoNeedTime");
        var testDoSummary = $("#testDoSummary");
        if (!flag) {
            return;
        } else if (testPaperType.val() == "") {
            layer.msg("请选择正确的试卷类型", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                testPaperType.focus();
            });
        } else if (ifHaveAnswer.val() == "") {
            layer.msg("请选择正确的答案类型", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                ifHaveAnswer.focus();
            });
        } else if (examTime.val() == "") {
            layer.msg("请输入正确的考试时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                examTime.focus();
            });
        } else if (testDoNeedTime.val() == "") {
            layer.msg("请输入正确的试做所需时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                testDoNeedTime.focus();
            });
        } else if (testDoSummary.val() == "") {
            layer.msg("请输入正确的试做总结", {time: 1000, icon: 5, shift: 6});
            testDoSummary.focus();
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
                            window.location.href = "${APP_PATH}/examController/toMyTestDoList.do";
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
