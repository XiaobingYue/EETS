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
                <%@include file="/WEB-INF/jsp/common/menu.jsp" %>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text"
                                       placeholder="可按课程名称模糊查询">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" onclick="queryCourse()"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"
                            onclick="deleteCourses()"><i class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary tooltip-test"
                            style="float:right;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" onclick="allSel(this)"></th>
                                <th>课程名称</th>
                                <th>课程编号</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="5" align="center">
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
                <h4 class="modal-title" id="myModalLabel">新增课程</h4>
            </div>
            <div class="modal-body">
                <form id="courseForm" role="form">
                    <div class="form-group">
                        <label>课程名称</label>
                        <input type="text" class="form-control" id="name"
                               placeholder="请输入课程名称">
                    </div>
                    <div class="form-group">
                        <label>课程编号</label>
                        <input type="text" class="form-control" id="courseCode"
                               placeholder="请输入课程编号">
                    </div>
                    <button id="saveBtn" type="button" class="btn btn-success"><i
                            class="glyphicon glyphicon-pencil"></i> 添加
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel1">修改课程</h4>
            </div>
            <div class="modal-body">
                <form id="courseForm1" role="form">
                    <div class="form-group">
                        <label>课程名称</label>
                        <input type="text" class="form-control" id="name1"
                               placeholder="请输入课程名称">
                    </div>
                    <div class="form-group">
                        <label>课程编号</label>
                        <input type="text" class="form-control" id="courseCode1"
                               placeholder="请输入课程编号">
                    </div>
                    <button id="updateBtn" type="button" class="btn btn-success"><i
                            class="glyphicon glyphicon-pencil"></i> 修改
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/fileinput.js"></script>
<script src="${APP_PATH}/bootstrap/js/zh.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
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
    var _courseId = "";
    function setNameAndCode(id,name,code) {
        _courseId = id;
        $("#name1").val(name);
        $("#courseCode1").val(code);
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
            url: "${APP_PATH}/courseController/queryCourseList.do",
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
                    var courseList = pageObj.data;

                    if (courseList == null) {
                        var empty = "";
                        $("tbody").html(empty);
                        $(".pagination").html(empty);
                        return;
                    }

                    var content = "";
                    $.each(courseList, function (i, course) {
                        content = content + '<tr>';
                        content = content + '  <td>' + (i + 1) + '</td>';
                        content = content + '  <td><input type="checkbox" value="' + course.id + '"></td>';
                        content = content + '  <td>' + course.name + '</td>';
                        content = content + '  <td>' + course.courseCode + '</td>';
                        content = content + '  <td>';
                        content = content + '      <button type="button" data-toggle="modal" data-target="#editModal" onclick="setNameAndCode('+course.id+',\''+course.name+'\', \''+course.courseCode+ '\')"  class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        content = content + '	   <button type="button" onclick="deletecourse(' + course.id + ', \'' + course.name + '\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
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
                    layer.msg("课程分页查询数据失败", {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    }

    var cond = false;

    function queryCourse() {
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

    function deletecourse(id, name) {
        layer.confirm("删除课程: " + name + ", 是否继续？", {icon: 3, title: '提示'}, function (cindex) {
            // 删除数据
            $.ajax({
                url: "${APP_PATH}/courseController/deleteCourse.do",
                type: "POST",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.success) {
                        layer.msg("课程信息删除成功", {time: 1000, icon: 6}, function () {
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

        var courseBox = $("tbody :checkbox");

        $.each(courseBox, function (i, n) {
            n.checked = flg;
        });
    }

    function deleteCourses() {
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
                    url: "${APP_PATH}/manager/multiManage/deletes.do",
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

    $("#updateBtn").click(function () {
        var loadingIndex = -1;
        // 提交表单
        $.ajax({
            url: "${APP_PATH}/courseController/editCourse.do",
            type: "POST",
            data: {
                "name": $("#name1").val(),
                "courseCode":$("#courseCode1").val(),
                "id": _courseId
            },
            beforeSend: function () {
                loadingIndex = layer.msg('数据修改中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("课程信息修改成功", {time: 1000, icon: 6}, function () {
                        window.location.href = "${APP_PATH}/courseController/toCourseList.do?pageNo=${param.pageNo}";
                    });
                } else {
                    layer.msg("课程信息修改失败", {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    });

    $("#saveBtn").click(function () {
        var loadingIndex = -1;
        // 提交表单
        $.ajax({
            url: "${APP_PATH}/courseController/addCourse.do",
            type: "POST",
            data: {
                "name": $("#name").val(),
                "courseCode":$("#courseCode").val()
            },
            beforeSend: function () {
                loadingIndex = layer.msg('数据处理中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("课程信息增加成功", {time: 1000, icon: 6}, function () {
                        window.location.href = "${APP_PATH}/courseController/toCourseList.do";
                    });
                } else {
                    layer.msg("课程信息增加失败", {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    });
</script>
</body>
</html>
