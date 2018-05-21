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
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" onclick="allSel(this)"></th>
                                <th>任务名称</th>
                                <th>所属专业</th>
                                <th>所属课程</th>
                                <th>所属班级</th>
                                <th>学期</th>
                                <th>状态</th>
                                <th width="133">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="12" align="center">
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

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">请选择接收任务的老师</h4>
            </div>
            <div class="modal-body">
                <form id="taskForm"
                      action="${APP_PATH}/teachTaskController/releaseTask.do" method="post"
                      role="form">
                    <div class="form-group">
                    </div>
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
<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
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
        <c:if test="${empty param.pageNo}">
        pageQuery(1);
        </c:if>
        <c:if test="${not empty param.pageNo}">
        pageQuery(${param.pageNo});
        </c:if>
    });

    var _id = "";

    function setId(id) {
        _id = id;
    }


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
    function setTask(task) {
        console.info(task);
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
            url: "${APP_PATH}/teachTaskController/queryMyTask.do",
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
                    var teachTaskList = pageObj.data;

                    if (teachTaskList == null) {
                        var empty = "";
                        $("tbody").html(empty);
                        $(".pagination").html(empty);
                        return;
                    }

                    var content = "";
                    $.each(teachTaskList, function (i, teachTask) {
                        content = content + '<tr>';
                        content = content + '  <td>' + (i + 1) + '</td>';
                        content = content + '  <td><input type="checkbox" value="' + teachTask.id + '"></td>';
                        content = content + '  <td>' + teachTask.name + '</td>';
                        content = content + '  <td>' + teachTask.proName + '</td>';
                        content = content + '  <td>' + teachTask.courseName + '</td>';
                        content = content + '  <td>' + teachTask.classesName + '</td>';
                        content = content + '  <td>' + teachTask.term + '</td>';
                        var _status = "";
                        if (!isEmpty(teachTask.status)) {
                            if (teachTask.status == 1) {
                                _status = "已创建";
                            } else if (teachTask.status == 2) {
                                _status = "已发布";
                            }
                        }
                        content = content + '  <td>' + _status + '</td>';
                        content = content + '  <td>';
                        content = content + '      <button type="button" onclick="window.location.href=\'${APP_PATH}/teachTaskController/toDetil.do?pageNo=' + pageObj.pageNo + '&id=' + teachTask.id + '\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-list-alt"></i></button>';
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
                    layer.msg("教学任务分页查询数据失败", {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    }

    var cond = false;

    function queryteachTask() {
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

    $("#releaseBtn").click(function () {
        var options = $("#teacherIds option:selected");
        if (options.length == 0) {
            layer.msg("请选择要发布任务的老师", {time: 1000, icon: 5, shift: 6});
            return;
        }
        var loadingIndex = -1;
        // 提交表单
        $("#taskForm").ajaxSubmit({
            beforeSend: function () {
                loadingIndex = layer.msg('执行中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("发布成功", {time: 1000, icon: 6}, function () {
                        window.location.href = "${APP_PATH}/classesController/toClassesList.do?pageNo=${param.pageNo}";
                    });
                } else {
                    layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    });

    function deleteteachTask(id, name) {
        layer.confirm("删除教学任务: " + name + ", 是否继续？", {icon: 3, title: '提示'}, function (cindex) {
            // 删除数据
            $.ajax({
                url: "${APP_PATH}/teachTaskController/deleteTeachTask.do",
                type: "POST",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.success) {
                        layer.msg("教学任务信息删除成功", {time: 1000, icon: 6}, function () {
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

        var teachTaskBox = $("tbody :checkbox");

        $.each(teachTaskBox, function (i, n) {
            n.checked = flg;
        });
    }

    function deleteteachTasks() {
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
                    url: "${APP_PATH}/manager/teachTask/deletes.do",
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
