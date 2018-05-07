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
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
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
                <li><a href="${APP_PATH}/toIndex.do">首页</a></li>
                <li><a href="${APP_PATH}/syllabusController/toSyllabus.do">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form method="post" action="${APP_PATH}/syllabusController/addSyllabus.do" id="syllabusForm"
                          role="form">
                        <table class="table table-bordered">
                            <thread>
                                <tr>
                                    <th colspan="3" style="text-align: center">课程基本信息</th>
                                </tr>
                            </thread>
                            <tbody>
                            <tr>
                                <td>课程代码：<input type="text" id="courseCode" class="form-control" name="courseCode"
                                                placeholder="请输入版本"></td>
                                <td colspan="2">课程名称：<input type="text" id="courseName" class="form-control"
                                                            name="courseName"
                                                            placeholder="课程名称"></td>
                            </tr>
                            <tr>
                                <td>课程性质：<input type="text" id="courseProperty" class="form-control"
                                                name="courseProperty"
                                                placeholder="课程性质"></td>
                                <td>学分：<input type="text" id="score" class="form-control" name="score"
                                              placeholder="学分"></td>
                                <td>适用专业：<input type="text" id="applicableProfessional" class="form-control"
                                                name="applicableProfessional"
                                                placeholder="适用专业"></td>
                            </tr>
                            <tr>
                                <td colspan="2">开课单位：<input type="text" id="courseUnit" class="form-control" name="courseUnit" placeholder="开课单位"></td>
                                <td>大纲版本：<input type="text" id="version" class="form-control" name="version"
                                                placeholder="大纲版本"></td>
                            </tr>
                            <tr>
                                <td>制定人：<input type="text" id="developer" class="form-control" name="developer"
                                               placeholder="制定人"></td>
                                <td>审核人：<input type="text" id="reviewer" class="form-control" name="reviewer"
                                               placeholder="审核人"></td>
                                <td>批准人：<input type="text" id="approver" class="form-control" name="approver"
                                               placeholder="批准人"></td>
                            </tr>
                            <tr>
                                <td>制定时间：<br><input type="text" id="developTime" class="form-control form_datetime" name="developTime"
                                                placeholder="制定时间"></td>
                                <td>审核时间：<input type="text" id="reviewTime" class="form-control form_datetime" name="reviewTime"
                                                placeholder="审核时间"></td>
                                <td>批准时间：<input type="text" id="approveTime" class="form-control form_datetime" name="approveTime"
                                                placeholder="批准时间"></td>
                            </tr>
                            </tbody>
                        </table>
                        <%--  <div class="form-group">
                            <label for="exampleInputEmail1">头像</label>
                            <input type="file" class="form-control" id="userIcon" name="userIcon" placeholder="请上传个人头像">
                          </div>--%>
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
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.form.js"></script>
<script src="${APP_PATH}/bootstrap/js/moment-with-locales.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"></script>
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
        } else if (developer.val() == "") {
            layer.msg("请输入正确的创建者", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                developer.focus();
            });
        } else if (developTime.val() == "") {
            layer.msg("请输入正确的创建时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                courseUnit.focus();
            });
        } else if (reviewer.val() == "") {
            layer.msg("请输入正确的审核人", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                reviewer.focus();
            });
        } else if (reviewTime.val() == "") {
            layer.msg("请输入正确的审核时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                reviewTime.focus();
            });
        } else if (approver.val() == "") {
            layer.msg("请输入正确的批准人", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                approver.focus();
            });
        } else if (approveTime.val() == "") {
            layer.msg("请输入正确的批准时间", {time: 2000, icon: 5, shift: 6}, function () {
                // 设定页面焦点
                approveTime.focus();
            });
        } else {
            // 提交表单
            var loadingIndex = -1;
            $("#syllabusForm").ajaxSubmit({
                beforeSubmit: function () {
                    loadingIndex = layer.load(2, {time: 10 * 1000});
                },
                success: function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("教学大纲信息保存成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/syllabusController/toSyllabus.do";
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
