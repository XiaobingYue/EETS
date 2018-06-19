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
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-select.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
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
                <%@include file="/WEB-INF/jsp/common/menu.jsp" %>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" exam="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" style="width: 310px"
                                       placeholder="可按名称模糊查询">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" onclick="queryExam()"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr align="center">
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" onclick="allSel(this)"></th>
                                <th>课程名称</th>
                                <th>命题教师</th>
                                <th>适用班级</th>
                                <th>命题方式</th>
                                <th>状态</th>
                                <th>附件</th>
                                <th width="133">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="8" align="center">
                                    <ul class="pagination"></ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="choose">请选择审批人</h4>
            </div>
            <div class="modal-body">
                <form id="taskForm"
                      action="${APP_PATH}/examController/assignApprover.do" method="post"
                      role="form">
                    <div class="form-group">
                        <label>请选择审批人</label>
                        <select class="selectpicker show-tick form-control" id="teacherIds"
                                name="teacherId" data-live-search="true">
                            <c:forEach items="${userList}" var="teacher" varStatus="vs">
                                <option id="${teacher.id}" value="${teacher.id}"> ${teacher.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="hidden" id="examId" name="examId"/>
                    <button id="releaseBtn" type="button" class="btn btn-success"><i
                            class="glyphicon glyphicon-ok"></i> 确定
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-3.1.0.js"></script>
<script src="${APP_PATH}/bootstrap/js/fileinput.js"></script>
<script src="${APP_PATH}/bootstrap/js/zh.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.form.js"></script>
<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
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
        <c:if test="${empty param.pageNo}">
        pageQuery(1);
        </c:if>
        <c:if test="${not empty param.pageNo}">
        pageQuery(${param.pageNo});
        </c:if>
    });

    $("#releaseBtn").click(function () {
        var options = $("#teacherIds option:selected");
        if (options.length == 0) {
            layer.msg("请选择审批人", {time: 1000, icon: 5, shift: 6});
            return;
        }
        $("#examId").val(_id);
        var loadingIndex = -1;
        // 提交表单
        $("#taskForm").ajaxSubmit({
            beforeSend: function () {
                loadingIndex = layer.msg('执行中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("选择成功", {time: 1000, icon: 6}, function () {
                        window.location.href = "${APP_PATH}/examController/toMyTestDoList.do?pageNo=${param.pageNo}";
                    });
                } else {
                    layer.msg("操作失败" + result.data, {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    });

    var _id = "";

    function setId(id) {
        _id = id;
    }

    initUpload("file", '${APP_PATH}/examController/uploadPdf.do');

    function initUpload(ctrlName, uploadUrl) {
        var control = $('#' + ctrlName);
        control.fileinput({
            language: 'zh', //设置语言
            uploadUrl: uploadUrl, //上传的地址
            uploadAsync: true, //默认异步上传
            showCaption: true,//是否显示标题
            showUpload: true, //是否显示上传按钮
            textEncoding: 'UTF-8',
            browseClass: "btn btn-primary", //按钮样式
            allowedFileExtensions: ["pdf"], //接收的文件后缀
            maxFileCount: 1,//最大上传文件数限制
            previewFileIcon: '<i class="glyphicon glyphicon-file"></i>',
            showPreview: true, //是否显示预览
            previewFileIconSettings: {
                'docx': '<i ass="fa fa-file-word-o text-primary"></i>',
                'xlsx': '<i class="fa fa-file-excel-o text-success"></i>',
                'xls': '<i class="fa fa-file-excel-o text-success"></i>',
                'pptx': '<i class="fa fa-file-powerpoint-o text-danger"></i>',
                'jpg': '<i class="fa fa-file-photo-o text-warning"></i>',
                'pdf': '<i class="fa fa-file-archive-o text-muted"></i>',
                'zip': '<i class="fa fa-file-archive-o text-muted"></i>',
            },
            uploadExtraData: function () {
                var extraValue = _id;
                return {"id": extraValue};
            }
        });
    }

    $("#file").on("fileuploaded", function (event, data, previewId, index) {
        console.log(data);
        if (data.response.success == true) {
            layer.msg(data.files[index].name + "上传成功!", {time: 2000, icon: 6, shift: 6}, function () {
            });
            window.location.href = "${APP_PATH}/examController/toIndex.do"
            //$(".close").click();
        } else {
            layer.msg(data.files[index].name + "上传失败!", {time: 2000, icon: 5, shift: 6}, function () {
            });
            //重置
            $("#file").fileinput("clear");
            $("#file").fileinput("reset");
            $('#file').fileinput('refresh');
            $('#file').fileinput('enable');
        }
    });

    function changepageNo(pageNo) {
        pageQuery(pageNo);
    }

    function isEmpty(obj) {
        if (typeof obj == "undefined" || obj == null || obj == "") {
            return true;
        } else {
            return false;
        }
    }

    function pageQuery(pageNo) {
        var loadingIndex = -1;
        // 使用AJAX异步分页查询角色数据

        var obj = {
            "pageNo": pageNo,
            "pageSize": 5
        };
        if (cond) {
            // 增加模糊查询参数
            obj.queryText = $("#queryText").val();
        }

        $.ajax({
            url: "${APP_PATH}/examController/queryMyExam.do",
            type: "POST",
            data: obj,
            beforeSend: function () {
                loadingIndex = layer.msg('数据查询中', {icon: 16});
                return true;
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    var pageObj = result.page;
                    var examList = pageObj.data;

                    if (examList == null) {
                        var empty = "";
                        $("tbody").html(empty);
                        $(".pagination").html(empty);
                        return;
                    }

                    var content = "";
                    $.each(examList, function (i, exam) {
                        content = content + '<tr>';
                        content = content + '  <td>' + (i + 1) + '</td>';
                        content = content + '  <td><input type="checkbox" value="' + exam.id + '"></td>';
                        content = content + '  <td>' + exam.courseName + '</td>';
                        content = content + '  <td>' + exam.developerName + '</td>';
                        content = content + '  <td>' + exam.classesName + '</td>';
                        content = content + '  <td>' + exam.propositionType + '</td>';
                        var _state = "";
                        if (exam.state == 1) {
                            _state = "已创建，待指派试做人";
                        } else if (exam.state == 2) {
                            _state = "待试做";
                        } else if (exam.state == 3) {
                            _state = "已试做，待指定审核人";
                        } else if (exam.state == 4) {
                            _state = "待审核";
                        } else if (exam.state == 5) {
                            _state = "审核通过";
                        } else if (exam.state == 6) {
                            _state = "审核不通过";
                        }
                        content = content + '  <td>' + _state + '</td>';
                        content = content + '  <td>';
                        if (!isEmpty(exam.fileName)) {
                            content = content + '      <button type="button" title="下载附件" onclick="window.location.href=\'${APP_PATH}/examController/downloadPdf.do?id=' + exam.id + '\'"class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-arrow-down"></i></button>';
                        } else {
                            content = content + '无附件';
                        }
                        content = content + '  </td>';
                        content = content + '  <td>';

                        if(exam.state == 3) {
                            content = content + '      <button type="button" title="指定审核人" onclick="setId(' + exam.id +')" class="btn btn-success btn-xs tooltip-test" data-toggle="modal" data-target="#myModal1"><i class=" glyphicon glyphicon-ok"></i></button>';
                        }

                        if (exam.state == 2) {
                            content = content + '      <button type="button" title="上报试做信息" onclick="window.location.href=\'${APP_PATH}/examController/toEditMyList.do?pageNo=' + pageObj.pageNo + '&id=' + exam.id + '\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-edit"></i></button>';
                        }
                        content = content + '      <button type="button" title="详情" onclick="window.location.href=\'${APP_PATH}/examController/toDetail.do?pageNo=' + pageObj.pageNo + '&id=' + exam.id + '\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-list-alt"></i></button>';
                        content = content + '  </td>';
                        content = content + '</tr>';
                    });
                    $("tbody").html(content);

                    $("#Pagination").pagination(pageObj.totalSize, {
                        num_edge_entries: 1, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: pageQuery,
                        items_per_page: 5, //每页显示1项
                        prev_text: "上一页",
                        next_text: "下一页",
                        current_page: pageNo
                    });

                    var pageContent = "";

                    if (pageObj.pageNo != 1) {
                        pageContent = pageContent + '<li><a href="#" onclick="changepageNo(' + (pageObj.pageNo - 1) + ')">上一页</a></li>';
                    }
                    for (var i = 1; i <= pageObj.totalNo; i++) {
                        if (i == pageObj.pageNo) {
                            pageContent = pageContent + '<li class="active"><a href="#" onclick="changepageNo(' + i + ')">' + i + '</a></li>';
                        } else {
                            pageContent = pageContent + '<li><a href="#" onclick="changepageNo(' + i + ')">' + i + '</a></li>';
                        }
                    }
                    if (pageObj.pageNo != pageObj.totalNo) {
                        pageContent = pageContent + '<li><a href="#" onclick="changepageNo(' + (pageObj.pageNo + 1) + ')">下一页</a></li>';
                    }

                    $(".pagination").html(pageContent);

                } else {
                    layer.msg("毕业要求分页查询数据失败", {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    }

    var cond = false;

    function queryExam() {
        var queryText = $("#queryText");
        if (queryText.val() == "") {
            layer.msg("查询条件不能为空，请输入", {time: 1000, icon: 5, shift: 6}, function () {
                queryText.focus();
            });
            return;
        }
        cond = true;
        pageQuery(1);
    }

    function deletEexam(id, name) {
        layer.confirm("删除毕业要求: " + name + ", 是否继续？", {icon: 3, title: '提示'}, function (cindex) {
            // 删除数据
            $.ajax({
                url: "${APP_PATH}/examController/deleteById.do",
                type: "POST",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.success) {
                        layer.msg("删除成功", {time: 1000, icon: 6}, function () {
                            pageQuery(1);
                        });
                    } else {
                        layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                    }
                }
            });


            layer.close(cindex);
        }, function (cindex) {
            layer.close(cindex);
        });
    }

    function allSel(obj) {
        // 获取全选框的勾选状态
        var flg = obj.checked;

        var examBox = $("tbody :checkbox");

        $.each(examBox, function (i, n) {
            n.checked = flg;
        });
    }

    function deleteexams() {
        var checkBox = $("tbody :checked");
        if (checkBox.length == 0) {
            layer.msg("请选择需要删除的角色数据", {time: 1000, icon: 5, shift: 6});
        } else {
            layer.confirm("删除选择的角色数据, 是否继续？", {icon: 3, title: '提示'}, function (cindex) {
                // 删除数据
                var obj = {}
                $.each(checkBox, function (i, n) {
                    obj["ids[" + i + "]"] = n.value;
                });
                $.ajax({
                    url: "${APP_PATH}/manager/exam/deletes.do",
                    type: "POST",
                    data: obj,
                    success: function (result) {
                        if (result.success) {
                            layer.msg("角色信息删除成功", {time: 1000, icon: 6}, function () {
                                pageQuery(1);
                            });
                        } else {
                            layer.msg("角色信息删除失败", {time: 1000, icon: 5, shift: 6});
                        }
                    }
                });
                layer.close(cindex);
            }, function (cindex) {
                layer.close(cindex);
            });
        }
    }

</script>
</body>
</html>
