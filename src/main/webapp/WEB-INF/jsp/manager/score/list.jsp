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
                    <c:if test="${result.maxScore > 0}">
                        <table id="analysisTable" class="table table-bordered table-hover">
                            <tr>
                                <th colspan="12" style="text-align: center">试卷分析统计结果</th>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">课程名称：</td>
                                <td>${exam.courseName}</td>
                                <td style="font-weight: bold">开课学院：</td>
                                <td>${exam.instituteName}</td>
                                <td style="font-weight: bold">专业班级：</td>
                                <td colspan="5">${exam.classesName}</td>
                                <td width="100px" style="font-weight: bold">任课教师：</td>
                                <td>${exam.developerName}</td>
                            </tr>
                            <tr>
                                <td rowspan="2" align="center" style="font-weight: bold">考试总体情况</td>
                                <td style="font-weight: bold">考试人数</td>
                                <td style="font-weight: bold">最高成绩</td>
                                <td style="font-weight: bold">最低成绩</td>
                                <td style="font-weight: bold">平均成绩</td>
                                <td style="font-weight: bold">不及格率</td>
                                <td colspan="6"></td>
                            </tr>
                            <tr>
                                <td>${result.examCount}</td>
                                <td>${result.maxScore}</td>
                                <td>${result.minScore}</td>
                                <td>${result.average}</td>
                                <td>${result.unPassRate}%</td>
                                <td colspan="6"></td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold" rowspan="3" align="center">考试成绩分布</td>
                                <td style="font-weight: bold">分数段</td>
                                <td style="font-weight: bold">>=90</td>
                                <td style="font-weight: bold">89~80</td>
                                <td style="font-weight: bold">79~70</td>
                                <td style="font-weight: bold">69~60</td>
                                <td style="font-weight: bold">59~30</td>
                                <td style="font-weight: bold">29~0</td>
                                <td style="font-weight: bold" colspan="4"></td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">人数</td>
                                <td>${result.thanNinetyCount}</td>
                                <td>${result.between80To89Count}</td>
                                <td>${result.between70To79Count}</td>
                                <td>${result.between60To69Count}</td>
                                <td>${result.between30To59Count}</td>
                                <td>${result.between0To29Count}</td>
                                <td colspan="4"></td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">所占比例</td>
                                <td>${result.thanNinetyRate}%</td>
                                <td>${result.between80To89Rate}%</td>
                                <td>${result.between70To79Rate}%</td>
                                <td>${result.between60To69Rate}%</td>
                                <td>${result.between30To59Rate}%</td>
                                <td>${result.between0To29Rate}%</td>
                                <td colspan="4"></td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold" rowspan="4">每道题得分情况</td>
                                <td style="font-weight: bold">题号</td>
                                <td style="font-weight: bold">实验</td>
                                <td style="font-weight: bold">平时</td>
                                <td style="font-weight: bold">一</td>
                                <td style="font-weight: bold">二</td>
                                <td style="font-weight: bold">三</td>
                                <td style="font-weight: bold">四</td>
                                <td style="font-weight: bold" width="80px">五</td>
                                <td style="font-weight: bold" width="80px">六</td>
                                <td style="font-weight: bold" width="80px">七</td>
                                <td style="font-weight: bold" width="80px">八</td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">题型</td>
                                <c:choose>
                                    <c:when test="${not empty result.testMethodList}">
                                        <c:forEach items="${result.testMethodList}" var="testMethod">
                                            <td>${testMethod.testMode}</td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">题分</td>
                                <c:choose>
                                    <c:when test="${not empty result.testMethodList}">
                                        <c:forEach items="${result.testMethodList}" var="testMethod">
                                            <td>${testMethod.scores}</td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <td style="font-weight: bold">平均得分</td>
                                <c:choose>
                                    <c:when test="${not empty result.testMethodList}">
                                        <c:forEach items="${result.testMethodList}" var="testMethod">
                                            <td>${testMethod.average}</td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </table>
                    </c:if>
                    <button type="button" data-toggle="modal" data-target="#myModal"
                            class="btn btn-primary tooltip-test"
                            style="float:right;"><i
                            class="glyphicon glyphicon-plus"></i> 计算总成绩
                    </button>
                    <br>
                    <hr>
                    <p style="color: red;text-align: center">注：录入所有数据之后点击计算总成绩会对分数结果进行分析</p>
                    <table id="scoreTable" style="margin-top:1px;">
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
                    <table>
                        <tr>
                            <td></td>
                        </tr>
                    </table>
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
                        <table id="testMethod" class="table">
                            <thead>
                            <tr>
                                <th>指标点关系</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${result.testMethodList}" var="testMethod" varStatus="status">
                                <tr>
                                    <td>
                                        <c:if test="${status.count ==1}">实验成绩</c:if>
                                        <c:if test="${status.count == 2}">平时成绩</c:if>
                                        <c:if test="${status.count >2}">题目${status.count-2}</c:if>
                                        ：${testMethod.testMode}</td>
                                    <td>分数：${testMethod.scores}</td>
                                    <c:forEach items="${indexPointList}" var="indexPoint">
                                        <td><label title="${indexPoint.name}">
                                            <input type="checkbox" value="${indexPoint.id}" name="indexPointId"
                                            <c:forEach items="${subIndexPointList}" var="subIndexPoint" varStatus="state">
                                                    <c:if test="${subIndexPoint.indexPointId == indexPoint.id && subIndexPoint.testMethodId == testMethod.id}">checked</c:if>
                                            </c:forEach>
                                                   onchange="changeState(this,${testMethod.id})">指标点${indexPoint.code}
                                        </label></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <button id="addBtn" style="margin-top: 10px" type="button" onclick="analysisScore()"
                            class="btn btn-success"><i
                            class="glyphicon glyphicon-pencil"></i> 提交
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
    <script src="${APP_PATH}/bootstrap/js/bootstrap-table-export.js"></script>
    <script src="${APP_PATH}/bootstrap/js/tableExport.js"></script>
    <script src="${APP_PATH}/bootstrap/js/jspdf.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/jspdf.plugin.autotable.js"></script>
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
            var jsonData = {"id": ${exam.id}};
            console.info(jsonData);
            init(jsonData);
        });

        function changeState(indexPoint, testMethodId) {
            $.ajax({
                type: "post",
                url: "${APP_PATH}/scoreController/changeState.do",
                data: {
                    "indexPointId": $(indexPoint).val(),
                    "testMethodId": testMethodId
                },
                dataType: 'JSON',
                success: function (data, status) {
                    if (data.success) {
                        layer.msg("设置成功", {time: 1000, icon: 6}, function () {
                        });
                    } else {
                        layer.msg("设置失败" + data.data, {time: 1000, icon: 5}, function () {
                        });
                    }
                },
                error: function () {
                    layer.msg("设置失败", {time: 1000, icon: 5, shift: 6});
                },
                complete: function () {

                }

            });
        }

        function DoOnMsoNumberFormat(cell, row, col) {
            var result = "";
            if (row > 0 && col == 0)
                result = "\\@";
            return result;
        }


        function init(data) {

            var colums = [{
                field: "stuCode",
                title: "学号"
            }, {
                field: "stuName",
                title: "姓名 "
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
            }];

            var methodCount = ${methodCount};

            var newColumns = colums.slice(0,methodCount);

            newColumns.push( {
                field: "examScore",
                title: "考试成绩"
            }, {
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
            }, {
                field: "dailyScore",
                title: "平时成绩",
                width:"50px",
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
                field: "allScore",
                title: "总成绩"
            });

            var jsonIndexPoint = ${jsonIndexPoint};
            $.each(jsonIndexPoint,function (i, indexPoint) {
               var colum = {field:"target"+i,titleTooltip:indexPoint.name,title:"指标点"+indexPoint.code};
                newColumns.push(colum);
            });

            $("#scoreTable").bootstrapTable({
                toolbar: "#toolbar",
                idField: "Id",
                pagination: false,
                showRefresh: true,
                cache: false,
                /*method: "POST",*/
                search: true,
                showExport: true,
                exportDataType: 'all',
                exportTypes: ['csv', 'txt', 'sql', 'doc', 'excel', 'xlsx', 'pdf'],  //导出文件类型
                clickToSelect: true,
                queryParams: data,
                url: "${APP_PATH}/scoreController/queryScoreTable.do",
                exportOptions: {
                    ignoreColumn: [0],  //忽略某一列的索引
                    fileName: '分数统计',  //文件名称设置
                    worksheetName: 'sheet1',  //表格工作区名称
                    tableName: '分数统计',
                    excelstyles: ['background-color', 'color', 'font-size', 'font-weight'],
                    onMsoNumberFormat: DoOnMsoNumberFormat
                },
                columns : newColumns,
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
                                    $("#scoreTable").bootstrapTable('refresh', '');
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
            if (parseFloat(dailyScore) + parseFloat(testScore) + parseFloat(examScore) != 1) {
                layer.msg("三项成绩总和必须为100%", {time: 2000, icon: 5, shift: 6}, function () {
                    // 设定页面焦点
                    $("#dailyScore").focus();
                });
            } else {
                $.ajax({
                    url: "${APP_PATH}/scoreController/analysisScore.do",
                    type: "POST",
                    data: {
                        "dailyScale": dailyScore,
                        "testScale": testScore,
                        "examScale": examScore,
                        "examId": ${exam.id}
                    },
                    beforeSend: function () {
                        loadingIndex = layer.msg('数据分析中', {icon: 16});
                    },
                    success: function (result) {
                        layer.close(loadingIndex);
                        if (result.success) {
                            layer.msg("分析成功", {time: 1000, icon: 6, shift: 6});
                            setTimeout("window.location.href = '${APP_PATH}/scoreController/toAddScore.do?id=${exam.id}'", 1000);
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
