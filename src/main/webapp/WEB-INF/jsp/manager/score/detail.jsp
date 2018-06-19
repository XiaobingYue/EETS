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
                    <button type="button" data-toggle="modal" data-target="#myModal"
                            class="btn btn-primary tooltip-test"
                            style="float:right;"><i
                            class="glyphicon glyphicon-plus"></i> 分析成绩
                    </button>
                    <br>
                    <hr>
                        <table id="scoreTable" class="table table-bordered table-hover" style="margin-top:1px;">
                        </table>
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
                <h4 class="modal-title" id="myModalLabel">请选择各项成绩所占比例</h4>
            </div>
            <div class="modal-body">
                <form id="courseTableForm" role="form">
                    <div class="form-group">
                        <label>平时成绩</label>
                        <select class="form-control" id="dailyScore" onchange="addClasses(this.id)">
                            <option value="0.1" selected>10%</option>
                            <option value="0.2">20%</option>
                            <option value="0.3">30%</option>
                            <option value="0.4">40%</option>
                            <option value="0.5">50%</option>
                            <option value="0.6">60%</option>
                            <option value="0.7">70%</option>
                            <option value="0.8">80%</option>
                            <option value="0.9">90%</option>
                            <option value="1">100%</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>实验成绩</label>
                        <select class="form-control" id="testScore" onchange="addClasses(this.id)">
                            <option value="0.1">10%</option>
                            <option value="0.2" selected>20%</option>
                            <option value="0.3">30%</option>
                            <option value="0.4">40%</option>
                            <option value="0.5">50%</option>
                            <option value="0.6">60%</option>
                            <option value="0.7">70%</option>
                            <option value="0.8">80%</option>
                            <option value="0.9">90%</option>
                            <option value="1">100%</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>考试成绩</label>
                        <select class="form-control" id="examScore" onchange="addClasses(this.id)">
                            <option value="0.1">10%</option>
                            <option value="0.2">20%</option>
                            <option value="0.3">30%</option>
                            <option value="0.4">40%</option>
                            <option value="0.5">50%</option>
                            <option value="0.6">60%</option>
                            <option value="0.7" selected>70%</option>
                            <option value="0.8">80%</option>
                            <option value="0.9">90%</option>
                            <option value="1">100%</option>
                        </select>
                    </div>
                    <button id="addBtn" style="margin-top: 10px" type="button" onclick="analysisScore()"
                            class="btn btn-success"><i
                            class="glyphicon glyphicon-pencil"></i> 添加
                    </button>
                </form>
            </div>
        </div>
    </div>
    <script src="${APP_PATH}/jquery/jquery-3.1.0.js"></script>
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
            var jsonData = {"id": ${id}};
            console.info(jsonData);
            init(jsonData);
        });


        function init(data) {
            $("#scoreTable").bootstrapTable({
                toolbar: "#toolbar",
                idField: "Id",
                pagination: false,
                showRefresh: false,
                cache: false,
                /*method: "POST",*/
                search: false,
                clickToSelect: false,
                queryParams: data,
                url: "${APP_PATH}/scoreController/queryScoreTable.do",
                columns: [/*{
                    checkbox: false
                },*/ {
                    field: "stuCode",
                    title: "学号"
                }, {
                    field: "stuName",
                    title: "姓名  "
                }, {
                    field: "one",
                    title: "一",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "two",
                    title: "二",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "three",
                    title: "三",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "four",
                    title: "四",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "five",
                    title: "五",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "six",
                    title: "六",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "seven",
                    title: "七",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "eight",
                    title: "八",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "nine",
                    title: "九",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }, {
                    field: "ten",
                    title: "十",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                },{
                    field: "examScore",
                    title: "考试成绩",
                },{
                    field: "testScore",
                    title: "实验成绩",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                },{
                    field: "dailyScore",
                    title: "平时成绩",
                    editable: {
                        type: "text",//编辑框的类型。支持text|textarea|select|date|checklist等
                        title: "请输入分数",//编辑框的标题
                        disabled: false,//是否禁用编辑
                        emptytext: "空文本", //空值的默认文本
                        mode: "popup",//编辑框的模式：支持popup和inline两种模式，默认是popup
                        validate: function (value) { //字段验证
                            if (!$.trim(value)) {
                                return '不能为空';
                            }
                        }
                    }
                }],
                onEditableSave: function (field, row, oldValue, $el) {
                    row.field = field;
                    console.info(row);
                    $.ajax({
                        type: "post",
                        url: "${APP_PATH}/scoreController/editScore.do",
                        data: row,
                        dataType: 'JSON',
                        success: function (data, status) {
                            if (data.success) {
                                layer.msg("修改成功", {time: 1000, icon: 6}, function () {
                                    $("#scoreTable").bootstrapTable('refresh','');
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

        function analysisScore() {
            var dailyScore = $("#dailyScore").val();
            var testScore = $("#testScore").val();
            var examScore = $("#examScore").val();
            alert(parseFloat(dailyScore)+parseFloat(testScore)+parseFloat(examScore));
            if (parseFloat(dailyScore)+parseFloat(testScore)+parseFloat(examScore) != 1) {
                layer.msg("三项成绩总和必须为100%", {time: 2000, icon: 5, shift: 6}, function () {
                    // 设定页面焦点
                    $("#dailyScore").focus();
                });
            } else {
                $.ajax({
                    url: "${APP_PATH}/scoreController/analysisScore.do",
                    type: "POST",
                    data: {
                        "dailyScale" : dailyScore,
                        "testScale" : testScore,
                        "examScale" : examScore,
                        "examId" : ${id}
                    },
                    beforeSend: function () {
                        loadingIndex = layer.msg('数据分析中', {icon: 16});
                    },
                    success: function (result) {
                        layer.close(loadingIndex);
                        if (result.success) {
                            layer.msg("分析成功，即将跳转到详情页面", {time: 3000, icon: 6, shift: 6});

                            window.location.href = "${APP_PATH}/scoreController/toDetail.do?examId = ${id}";
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
