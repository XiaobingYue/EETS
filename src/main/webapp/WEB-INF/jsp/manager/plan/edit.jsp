<%@page pageEncoding="UTF-8" %>
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
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
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
            <ol class="breadcrumb">
                <li><a href="${APP_PATH}/toMain.do">首页</a></li>
                <li><a href="${APP_PATH}/planController/toIndex.do">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form id="roleForm" role="form">
                        <div class="form-group">
                            <label>计划名称</label>
                            <input type="text" class="form-control" id="name" value="${plan.name}"
                                   placeholder="请输入名称">
                        </div>
                        <div class="form-group">
                            <label>版本</label>
                            <input type="text" class="form-control" id="version" value="${plan.version}"
                                   placeholder="请输入版本">
                        </div>
                        <div class="form-group">
                            <label>适用年级</label>
                            <input type="text" class="form-control" id="grade" value="${plan.grade}"
                                   placeholder="请输入适用年级">
                        </div>
                        <div class="form-group">
                                <label>适用专业</label>
                            <c:set var="professionId" value="${plan.professionId}" scope="request"/>
                            <select class="selectpicker show-tick form-control" id="professionId"
                                    name="courseCode" data-live-search="true">
                                <c:forEach items="${professionList}" var="profession" varStatus="vs">
                                    <option id="${profession.id}" value="${profession.id}"
                                            <c:if test="${profession.id==professionId}">selected</c:if> > ${profession.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label>细节</label>
                        <textarea id="detail" class="form-control" name="detail"
                                  placeholder="细节" cols="30"
                                  rows="10">${plan.detail}</textarea>
                        </div>
                        <br>
                        <button id="updateBtn" type="button" class="btn btn-success"><i
                                class="glyphicon glyphicon-pencil"></i> 修改
                        </button>
                        <button id="resetBtn" type="button" class="btn btn-danger"><i
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
<script src="${APP_PATH}/script/layer/layer.js"></script>
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

    $("#updateBtn").click(function () {
        var loadingIndex = -1;
        // 提交表单
        $.ajax({
            url: "${APP_PATH}/planController/edit.do",
            type: "POST",
            data: {
                "name": $("#name").val(),
                "version":$("#version").val(),
                "professionId":$("#professionId").val(),
                "grade":$("#grade").val(),
                "detail":$("#detail").val(),
                "id": "${plan.id}"
            },
            beforeSend: function () {
                loadingIndex = layer.msg('数据修改中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("修改成功", {time: 1000, icon: 6}, function () {
                        window.location.href = "${APP_PATH}/planController/toIndex.do?pageNo=${param.pageNo}";
                    });
                } else {
                    layer.msg("修改失败", {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    });

    $("#resetBtn").click(function () {
        // JQuery[0] ==> DOM
        $("#roleForm")[0].reset();
    });
</script>
</body>
</html>
