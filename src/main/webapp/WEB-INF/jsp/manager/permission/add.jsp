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
                <li><a href="${APP_PATH}/permissionController/permissionTreeList.do">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form role="form">
                        <div class="form-group">
                            <label>许可名称</label>
                            <input type="text" class="form-control" id="permissionname" placeholder="请输入许可名称">
                        </div>
                        <div class="form-group">
                            <label>链接地址</label>
                            <input type="text" class="form-control" id="url" placeholder="请输入链接地址">
                        </div>
                        <div class="form-group">
                            <label>类型</label>
                            <select class="form-control" id="type">
                                <option value="1">同步</option>
                                <option value="2">异步</option>
                            </select>
                        </div>
                        <button id="saveBtn" type="button" class="btn btn-success"><i
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

    $("#saveBtn").click(function () {
        var loadingIndex = -1;
        // 提交表单
        $.ajax({
            url: "${APP_PATH}/permissionController/addPermission.do",
            type: "POST",
            data: {
                "name": $("#permissionname").val(),
                "url": $("#url").val(),
                "parentId": "${param.id}",
                "type" : $("#type").val()
            },
            beforeSend: function () {
                loadingIndex = layer.msg('数据保存中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("许可信息保存成功", {time: 1000, icon: 6}, function () {
                        window.location.href = "${APP_PATH}/permissionController/permissionTreeList.do";
                    });
                } else {
                    layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                }
            }
        });
    });
</script>
</body>
</html>
