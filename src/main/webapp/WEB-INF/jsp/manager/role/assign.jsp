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
    <link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">
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
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <button id="assignBtn" class="btn btn-success">分配许可</button>
                    <br><br>
                    <ul id="permissionTree" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-3.1.0.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
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

        var setting = {
            check: {
                enable: true
            },
            view: {
                selectedMulti: false,
                addDiyDom: function (treeId, treeNode) {
                    var icoObj = $("#" + treeNode.tId + "_ico");
                    if (treeNode.icon) {
                        icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background", "");
                    }
                }
            },
            async: {
                enable: true,
                url: "${APP_PATH}/permissionController/loadAsyncCheckedData.do?roleId=${role.id}",
                autoParam: ["id", "name=n", "level=lv"]
            },
            callback: {
                onClick: zTreeOnClick
            }
        };
        $.fn.zTree.init($("#permissionTree"), setting);
    });
    
    function zTreeOnClick(event , treeId , treeNode) {
        if(treeNode.checked) {
            treeNode.checked = false;
        } else {
            treeNode.checked = true;
        };
    }

    $("#assignBtn").click(function () {
        // 获取树形结构中被勾选的数据
        var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
        var nodes = treeObj.getCheckedNodes(true);

        var jsonData = {roleId: "${role.id}"};
        $.each(nodes, function (i, n) {
            jsonData["ids[" + i + "]"] = n.id;
        });

        // 分配权限
        $.ajax({
            type: "POST",
            url: "${APP_PATH}/roleController/assignPermission.do",
            data: jsonData,
            success: function (result) {
                if (result.success) {
                    layer.msg("许可信息分配成功", {time: 1500, icon: 6});
                } else {
                    layer.msg("许可信息分配失败", {time: 1500, icon: 5, shift: 6});
                }
            },
            error:function () {
                layer.msg("许可信息分配失败", {time: 1500, icon: 5, shift: 6});
            }
        });
    });
</script>
</body>
</html>
