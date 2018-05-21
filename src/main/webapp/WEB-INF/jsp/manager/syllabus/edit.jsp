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
                <li><a href="${APP_PATH}/syllabusController/toSyllabus.do">数据列表</a></li>
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
                                    <th colspan="3" style="text-align: center">课程基本信息</th>
                                </tr>
                            </thread>
                            <tbody>
                            <tr>
                                <td>课程代码：
                                    <c:set var="code" value="${syllabus.courseCode}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="courseCode"
                                            name="courseCode"
                                            onchange="setCourseName(this.id)" data-live-search="true">
                                        <option value="0">==请选择==</option>
                                        <c:forEach items="${courseList}" var="course" varStatus="vs">
                                            <option id="${course.name}" value="${course.courseCode}"
                                                    <c:if test="${course.courseCode==code}">selected</c:if> > ${course.courseCode}</option>
                                        </c:forEach>
                                    </select>
                                <td colspan="2">课程名称：
                                    <c:set var="courseName" value="${syllabus.courseName}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="courseName"
                                            name="courseName" data-live-search="true"
                                            onchange="setCourseCode(this.id)">
                                        <option value="0">==请选择==</option>
                                        <c:forEach items="${courseList}" var="course" varStatus="vs">
                                            <option id="${course.courseCode}" value="${course.name}"
                                                    <c:if test="${course.name==courseName}">selected</c:if> > ${course.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>课程性质： <select class="form-control" id="courseProperty">
                                    <option value="0">==请选择==</option>
                                    <option value="1" <c:if test="${syllabus.courseProperty == 1}">selected</c:if>>必修
                                    </option>
                                    <option value="0" <c:if test="${syllabus.courseProperty == 0}">selected</c:if>>选修
                                    </option>
                                </select></td>
                                <td>学分：<input type="text" id="score" class="form-control" name="score"
                                              value="${syllabus.score}"
                                              placeholder="学分"></td>
                                <td>适用专业： <c:set var="professionName" value="${syllabus.applicableProfessional}"
                                                 scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="applicableProfessional"
                                            name="applicableProfessional" data-live-search="true">
                                        <option value="0">==请选择==</option>
                                        <c:forEach items="${professionList}" var="profession" varStatus="vs">
                                            <option id="${profession.id}" value="${profession.name}"
                                                    <c:if test="${profession.name==professionName}">selected</c:if> > ${profession.name}</option>
                                        </c:forEach>
                                    </select></td>
                            </tr>
                            <tr>
                                <td colspan="2">开课单位：
                                    <c:set var="instituteName" value="${syllabus.courseUnit}" scope="request"/>
                                    <select class="selectpicker show-tick form-control" id="courseUnit"
                                            name="courseUnit" data-live-search="true">
                                        <option value="0">==请选择==</option>
                                        <c:forEach items="${instituteList}" var="institute" varStatus="vs">
                                            <option id="${institute.id}" value="${institute.name}"
                                                    <c:if test="${institute.name==instituteName}">selected</c:if> > ${institute.name}</option>
                                        </c:forEach>
                                    </select></td>
                                <td>大纲版本：<input type="text" id="version" class="form-control" name="version"
                                                value="${syllabus.version}"
                                                placeholder="大纲版本"></td>
                            </tr>
                            <tr>
                                <td>制定人：<input type="text" id="developer" class="form-control" name="developer"
                                               value="${syllabus.developer}"
                                               placeholder="制定人"></td>
                                <td>审核人：<input type="text" id="reviewer" class="form-control" name="reviewer"
                                               value="${syllabus.reviewer}"
                                               placeholder="审核人"></td>
                                <td>批准人：<input type="text" id="approver" class="form-control" name="approver"
                                               value="${syllabus.approver}"
                                               placeholder="批准人"></td>
                            </tr>
                            <tr>
                                <td>制定时间：<br><input type="text" id="developTime" value="${syllabus.developTime}"
                                                    class="form-control form_datetime" name="developTime"
                                                    placeholder="制定时间"></td>
                                <td>审核时间：<input type="text" id="reviewTime" value="${syllabus.reviewTime}"
                                                class="form-control form_datetime" name="reviewTime"
                                                placeholder="审核时间"></td>
                                <td>批准时间：<input type="text" id="approveTime" value="${syllabus.approveTime}"
                                                class="form-control form_datetime" name="approveTime"
                                                placeholder="批准时间"></td>
                            </tr>
                            </tbody>
                        </table>
                        <%-- <div class="form-group">
                             <label>对应pdf文件</label>
                             <input type="file" class="form-control file" id="pdfFile" name="pdfFile" placeholder="请上传pdf文件">
                         </div>--%>
                        <button type="button" id="updateBtn" class="btn btn-success"><i
                                class="glyphicon glyphicon-pencil"></i> 修改
                        </button>
                        <%-- <button type="button" id="review" class="btn btn-success"><i
                                 class="glyphicon glyphicon-pencil"></i> 审核
                         </button>
                         <button type="button" id="approve" class="btn btn-success"><i
                                 class="glyphicon glyphicon-pencil"></i> 批准
                         </button>--%>
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

    $('#developTime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });
    $('#reviewTime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });
    $('#approveTime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'      /*此属性是显示顺序，还有显示顺序是mm-dd-yyyy*/
    });

    function setCourseName(id) {
        var options = $("#" + id + " option:selected");
        var courseName = options.attr("id");
        $('#courseName').selectpicker('val',courseName);
    }

    function setCourseCode(id) {
        var options = $("#" + id + " option:selected");
        var courseCode = options.attr("id");
        $('#courseCode').selectpicker('val',courseCode);
    }

    var flag = true;
    $("#resetBtn").click(function () {
        // JQuery对象[0] ==》 DOM对象
        // $(DOM对象) ==》 JQuery对象
        $("#userForm")[0].reset();
    });

    $("#updateBtn").click(function () {
        //获取表单对象
        var courseCode = $("#courseCode");
        var courseName = $("#courseName");
        var courseProperty = $("#courseProperty");
        var courseUnit = $("#courseUnit");
        var score = $("#score");
        var applicableProfessional = $("#applicableProfessional");
        var version = $("#version");
        var developer = $("#developer");
        var developTime = $("#developTime");
        var reviewer = $("#reviewer");
        var reviewTime = $("#reviewTime");
        var approver = $("#approver");
        var approveTime = $("#approveTime");
        if (!flag) {
            return;
        } else if (courseCode.val() == "") {
            layer.msg("请输入正确的课程编号", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseCode.focus();
            });
        } else if (courseName.val() == "") {
            layer.msg("请输入正确的课程名称", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseName.focus();
            });
        } else if (courseProperty.val() == "") {
            layer.msg("请输入正确的课程属性", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseProperty.focus();
            });
        } else if (score.val() == "") {
            layer.msg("请输入正确的课程学分", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                score.focus();
            });
        } else if (applicableProfessional.val() == "") {
            layer.msg("请输入正确的课程适用专业", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                applicableProfessional.focus();
            });
        } else if (version.val() == "") {
            layer.msg("请输入正确的大纲版本", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                version.focus();
            });
        } else if (courseUnit.val() == "") {
            layer.msg("请输入正确的开课单位", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseUnit.focus();
            });
        } else {
            // 提交表单
            var loadingIndex = -1;
            $.ajax({
                type: "POST",
                url: "${APP_PATH}/syllabusController/editSyllabus.do",
                data: {
                    "courseCode": $("#courseCode").val(),
                    "courseName": $("#courseName").val(),
                    "courseProperty": $("#courseProperty").val(),
                    "score": $("#score").val(),
                    "applicableProfessional": $("#applicableProfessional").val(),
                    "version": $("#version").val(),
                    "courseUnit": courseUnit.val(),
                    "id": "${syllabus.id}",
                    "developer": developer.val(),
                    "developTime": developTime.val(),
                    "reviewer": reviewer.val(),
                    "reviewTime": reviewTime.val(),
                    "approver": approver.val(),
                    "approveTime": approveTime.val()
                },
                beforeSend: function () {
                    loadingIndex = layer.load(2, {time: 10 * 1000});
                },
                success: function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("用户信息修改成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/syllabusController/toSyllabus.do?pageNo=${param.pageNo}";
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
