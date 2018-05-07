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
                            style="float:right;" onclick="addCourseTable()"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr>
                    <div class="table-responsive">
                        <table id="courseTable" class="table table-bordered table-hover" style="margin-top:1px;">
                           <%-- <thead>
                            <tr>
                                <td align="center" valign="middle">项目</td>
                                <td colspan="5" align="center" valign="middle">上课</td>
                                <td colspan="2" align="center" valign="middle">休息</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td align="center" valign="middle">星期</td>
                                <td align="center" valign="middle">星期一</td>
                                <td align="center" valign="middle">星期二</td>
                                <td align="center" valign="middle">星期三</td>
                                <td align="center" valign="middle">星期四</td>
                                <td align="center" valign="middle">星期五</td>
                                <td align="center" valign="middle">星期六</td>
                                <td align="center" valign="middle">星期天</td>
                            </tr>
                            <tr>
                                <td rowspan="4" align="center" valign="middle">上午</td>
                                <td id="couMon1" align="center" valign="middle">数学</td>
                                <td id="couTue1" align="center" valign="middle">语文</td>
                                <td id="couWed1" align="center" valign="middle">英语</td>
                                <td id="couThu1" align="center" valign="middle">数学</td>
                                <td id="couFri1" align="center" valign="middle">语文</td>
                                <td id="couSat1" align="center" valign="middle">英语</td>
                                <td id="couSun1" rowspan="4" align="center" valign="middle">休息</td>
                            </tr>
                            <tr>
                                <td id="couMon2" align="center" valign="middle">语文</td>
                                <td id="couTue2" align="center" valign="middle">数学</td>
                                <td id="couWed2" align="center" valign="middle">语文</td>
                                <td id="couThu2" align="center" valign="middle">数学</td>
                                <td id="couFri2" align="center" valign="middle">英语</td>
                                <td id="couSat2" align="center" valign="middle">数学</td>
                            </tr>
                            <tr>
                                <td id="couMon3" align="center" valign="middle">政治</td>
                                <td id="couTue3" align="center" valign="middle">历史</td>
                                <td id="couWed3" align="center" valign="middle">地理</td>
                                <td id="couThu3" align="center" valign="middle">政治</td>
                                <td id="couFri3" align="center" valign="middle">历史</td>
                                <td id="couSat3" align="center" valign="middle">地理</td>
                            </tr>
                            <tr>
                                <td id="couMon4" align="center" valign="middle">物理</td>
                                <td id="couTue4" align="center" valign="middle">化学</td>
                                <td id="couWed4" align="center" valign="middle">生物</td>
                                <td id="couThu4" align="center" valign="middle">体育</td>
                                <td id="couFri4" align="center" valign="middle">美术</td>
                                <td id="couSat4" align="center" valign="middle">计算机</td>
                            </tr>
                            <tr>
                                <td rowspan="2" align="center" valign="middle">下午</td>
                                <td id="couMon5" align="center" valign="middle">英语</td>
                                <td id="couTue5" align="center" valign="middle">物理</td>
                                <td id="couWed5" align="center" valign="middle">数学</td>
                                <td id="couThu5" align="center" valign="middle">政治</td>
                                <td id="couFri5" align="center" valign="middle">体育</td>
                                <td id="couSat5" align="center" valign="middle">语文</td>
                                <td id="couSun5" rowspan="2" align="center" valign="middle">休息</td>
                            </tr>
                            <tr>
                                <td id="couMon6" align="center" valign="middle">语文</td>
                                <td id="couTue6" align="center" valign="middle">数学</td>
                                <td id="couWed6" align="center" valign="middle">英语</td>
                                <td id="couThu6" align="center" valign="middle">物理</td>
                                <td id="couFri6" align="center" valign="middle">化学</td>
                                <td id="couSat6" align="center" valign="middle">生物</td>
                            </tr>
                            </tbody>--%>
                        </table>
                    </div>
                </div>
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
<script src="${APP_PATH}/bootstrap/js/bootstrap-table.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-table-zh-CN.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-editable.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap-table-editable.js"></script>
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
        $("#courseTable").bootstrapTable({
            toolbar: "#toolbar",
            idField: "Id",
            pagination: false,
            showRefresh: false,
            search: false,
            clickToSelect: true,
            queryParams: function (param) {
                return {};
            },
            url: "/courseTableController/queryCourseTable.do",
            columns: [{
                checkbox: true
            }, {
                field: "section",
                title: "课节",
            },{
                field: "monday",
                title: "星期一",
                editable: {
                    type: 'select',
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
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
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
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
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
                    validate: function (v) {
                        if (!v) return '不能为空';

                    }
                }
            },{
                field: "thursday",
                title: "星期四",
                editable: {
                    type: 'select',
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
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
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
                    validate: function (v) {
                        if (!v) return '不能为空';

                    }
                }
            },{
                field: "saturday",
                title: "星期六",
                editable: {
                    type: 'select',
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
                    validate: function (v) {
                        if (!v) return '不能为空';

                    }
                }
            },{
                field: "sunday",
                title: "星期日",
                editable: {
                    type: 'select',
                    source: function () {
                        var result = [];
                        $.ajax({
                            url: '/courseController/queryAllCourse.do',
                            async: false,
                            type: "get",
                            emptytext:"无课程",
                            data: {},
                            success: function (data, status) {
                                $.each(data.data, function (key, value) {
                                    result.push({ value: value.id, text: value.name });
                                });
                            }
                        });
                        return result;
                    },
                    title: '请选择课程',
                    mode:"inline",
                    validate: function (v) {
                        if (!v) return '不能为空';

                    }
                }
            }],
            onEditableSave: function (field, row, oldValue, $el) {
                row.field = field;
                $.ajax({
                    type: "post",
                    url: "/courseTableController/editCourseTable.do",
                    data: row,
                    dataType: 'JSON',
                    success: function (data, status) {
                        if (status == "success") {
                            alert('提交数据成功');
                        }
                    },
                    error: function () {
                        alert('编辑失败');
                    },
                    complete: function () {

                    }

                });
            }
        });
    });
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
                            result.push({ value: value.id, text: value.name });
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
            success:function (value) {
                alert(value);
            }
        });
    });
    
    function addCourseTable() {
        $.ajax({
            url: "${APP_PATH}/courseTableController/addCourseTable.do",
            type: "POST",
            data: {},
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
</script>
</body>
</html>
