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
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-table.css">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-editable.css">
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
                    <form class="form-inline" course="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">选择班级</div>
                                <select class="form-control has-success selectpicker show-tick" id="classesId1"
                                        name="classesId" data-live-search="true">
                                    <option value=""></option>
                                    <c:forEach items="${classesList}" var="classes" varStatus="vs">
                                        <option id="${classes.id}" value="${classes.id}"> ${classes.className}</option>
                                    </c:forEach></select>
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" onclick="queryCourseTable()"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                        <div class="radio">
                            <input type="radio" , name="type" id="personal" checked value="1"> 查询个人课表
                        </div>
                        <div class="radio">
                            <input type="radio" name="type" id="classes" value="0"> 查询班级课表
                        </div>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"
                            onclick="deleteCourses()"><i class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" data-toggle="modal" data-target="#myModal"
                            class="btn btn-primary tooltip-test"
                            style="float:right;"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr>
                    <div class="table-responsive">
                        <table id="courseTable" class="table table-bordered table-hover" style="margin-top:1px;">
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
                <h4 class="modal-title" id="myModalLabel">选择课表类型</h4>
            </div>
            <div class="modal-body">
                <form id="courseTableForm" role="form">
                    <div class="form-group">
                        <label>课表名称</label>
                        <input type="text" class="form-control" id="name" name="name"
                               placeholder="请输入课表名称">
                    </div>
                    <div class="form-group">
                        <label>课表类型</label>
                        <select class="form-control" id="type" onchange="addClasses(this.id)">
                            <option value="1">个人课表</option>
                            <option value="0">班级课表</option>
                        </select>
                    </div>
                    <div id="classesSel">
                    </div>
                    <button id="addBtn" style="margin-top: 10px" type="button" onclick="addCourseTable()"
                            class="btn btn-success"><i
                            class="glyphicon glyphicon-pencil"></i> 添加
                    </button>
                </form>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/fileinput.js"></script>
    <script src="${APP_PATH}/bootstrap/js/zh.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/script/layer/layer.js"></script>
    <script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap-table.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap-table-zh-CN.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap-editable.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap-table-editable.js"></script>
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
            var jsonData = {"type": 1};
            init(jsonData);
        });

        function addClasses(id) {
            var options = $("#" + id + " option:selected");
            if (options.val() == 0) {
                var content = '<label>请选择班级</label><select class="form-control" id="classesId" name="classesId" onchange="setCourseCode(this.id)">' +
                    '<c:forEach items="${classesList}" var="classes" varStatus="vs"> <option id="${classes.id}" value="${classes.id}"> ${classes.className}</option> </c:forEach></select>';
                $("#classesSel").html(content);
            } else {
                $("#classesSel").html("");
            }
        }

        function init(data) {
            $("#courseTable").bootstrapTable({
                toolbar: "#toolbar",
                idField: "Id",
                pagination: false,
                showRefresh: false,
                method: "POST",
                search: false,
                clickToSelect: true,
                queryParams: {},
                url: "${APP_PATH}/courseTableController/queryCourseTable.do",
                columns: [{
                    checkbox: true
                }, {
                    field: "section",
                    title: "课节",
                }, {
                    field: "monday",
                    title: "星期一",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }, {
                    field: "tuesday",
                    title: "星期二",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }, {
                    field: "wednesday",
                    title: "星期三",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }, {
                    field: "thursday",
                    title: "星期四",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }, {
                    field: "friday",
                    title: "星期五",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }, {
                    field: "saturday",
                    title: "星期六",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }, {
                    field: "sunday",
                    title: "星期日",
                    editable: {
                        type: 'select',
                        source: function () {
                            var data = ${courseList};
                            var result = [];
                            $.each(data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                            return result;
                        },
                        title: '请选择课程',
                        mode: "inline",
                        validate: function (v) {
                            if (!v) return '不能为空';

                        }
                    }
                }],
                onEditableSave: function (field, row, oldValue, $el) {
                    row.field = field;
                    row.type = $("input[type='radio']:checked").val();
                    if (row.type == undefined) {
                        layer.msg("请选择修改课程的类型", {time: 1000, icon: 5}, function () {
                        });
                        return;
                    }
                    row.classesId = $("#classesId1 option:selected").val();
                    $.ajax({
                        type: "post",
                        url: "${APP_PATH}/courseTableController/editCourseTable.do",
                        data: row,
                        dataType: 'JSON',
                        success: function (data, status) {
                            if (data.success) {
                                layer.msg("修改成功", {time: 1000, icon: 6}, function () {
                                });
                            } else {
                                layer.msg("修改失败" + data.data, {time: 1000, icon: 5}, function () {
                                });
                            }
                        },
                        error: function () {
                            layer.msg("修改失败", {time: 1000, icon: 5, shift: 6});
                        },
                        complete: function () {

                        }

                    });
                }
            });
        }

        function queryCourseTable() {
            var queryText = $("#classesId1 option:selected");
            var type = $("input[type='radio']:checked").val();
            var classesId = "";
            if (queryText.val() != "") {
                classesId = queryText.val();
                type = "";
            } else if (type == undefined) {
                layer.msg("请输入查询条件", {time: 1500, icon: 5, shift: 6}, function () {
                    queryText.focus();
                });
                return;
            }
            var opt = {
                url: "${APP_PATH}/courseTableController/queryCourseTable.do?type=" + type + "&classesId=" + classesId
            };
            $("#courseTable").bootstrapTable('refresh', opt);
        }

        $(function () {
            $("td[id*='cou']").editable({
                type: "select",              //编辑框的类型。支持text|textarea|select|date|checklist等
                source: function () {
                    var result = [];
                    $.ajax({
                        url: '/courseController/queryAllCourse.do',
                        async: false,
                        type: "get",
                        data: {},
                        success: function (data, status) {
                            $.each(data.data, function (key, value) {
                                result.push({value: value.id, text: value.name});
                            });
                        }
                    });
                    return result;
                },
                title: "选择课程",           //编辑框的标题
                disabled: false,           //是否禁用编辑
                emptytext: "空文本",       //空值的默认文本
                mode: "inline",            //编辑框的模式：支持popup和inline两种模式，默认是popup
                validate: function (value) { //字段验证
                    if (!$.trim(value)) {
                        return '不能为空';
                    }
                },
                success: function (value) {
                    alert(value);
                }
            });
        });

        function addCourseTable() {
            var name = $("#name");
            var type = $("#type");
            var classesId = $("#classesId option:selected");
            if (name.val() == "") {
                layer.msg("课程名称不可违为空", {time: 2000, icon: 5, shift: 6}, function () {
                    // 设定页面焦点
                    name.focus();
                });
            } else if (type.val() == "") {
                layer.msg("类型不可为空", {time: 2000, icon: 5, shift: 6}, function () {
                    // 设定页面焦点
                    type.focus();
                });
            } else {
                $.ajax({
                    url: "${APP_PATH}/courseTableController/addCourseTable.do",
                    type: "POST",
                    data: {
                        "name": $("#name").val(),
                        "type": $("#type").val(),
                        "classesId": classesId.val()
                    },
                    beforeSend: function () {
                        loadingIndex = layer.msg('数据保存中', {icon: 16});
                    },
                    success: function (result) {
                        layer.close(loadingIndex);
                        if (result.success) {
                            window.location.href = "${APP_PATH}/courseTableController/toIndex.do";
                        } else {
                            layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                        }
                    }
                });
            }
        }
    </script>
</body>
</html>
