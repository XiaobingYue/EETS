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
        ::-webkit-scrollbar{
            display:none;
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
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
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
            view: {
                selectedMulti: false,
                addDiyDom: function (treeId, treeNode) {
                    var icoObj = $("#" + treeNode.tId + "_ico");
                    if (treeNode.icon) {
                        icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background", "");
                    }
                },
                addHoverDom: function (treeId, treeNode) {
                    var aObj = $("#" + treeNode.tId + "_a");
                    aObj.attr("href", "javascript:;");
                    if (treeNode.editNameFlag || $("#btnGroup" + treeNode.tId).length > 0) return;
                    var s = '<span id="btnGroup' + treeNode.tId + '">';
                    if (treeNode.level == 0) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="window.location.href=\'${APP_PATH}/permissionController/toAddPermission.do?id=' + treeNode.id + '\'" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if (treeNode.level == 1) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="window.location.href=\'${APP_PATH}/permissionController/toEditPermission.do?id=' + treeNode.id + '\'" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        if (treeNode.children.length == 0) {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deletePermission(' + treeNode.id + ', \'' + treeNode.name + '\')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                        }
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="window.location.href=\'${APP_PATH}/permissionController/toAddPermission.do?id=' + treeNode.id + '\'"  >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if (treeNode.level == 2) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="window.location.href=\'${APP_PATH}/permissionController/toEditPermission.do?id=' + treeNode.id + '\'" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deletePermission(' + treeNode.id + ', \'' + treeNode.name + '\')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }

                    s += '</span>';
                    aObj.after(s);
                },
                removeHoverDom: function (treeId, treeNode) {
                    $("#btnGroup" + treeNode.tId).remove();
                }
            },
            async: {
                enable: true,
                url: "${APP_PATH}/permissionController/loadAsyncData.do",
                autoParam: ["id", "name=n", "level=lv"]
            }
        };
        $.fn.zTree.init($("#permissionTree"), setting);
        // 读取许可数据
        /*
        $.ajax({
            type : "POST",
            url  : "
        ${APP_PATH}/manager/permission/loadDatas.do",
			    	success : function( result ){
			    		if ( result.success ) {
						    // 树形组件初始化
						    $.fn.zTree.init($("#permissionTree"), setting, result.data);
			    		} else {
			    			layer.msg("许可数据查询失败", {time:1000, icon:5, shift:6});
			    		}
			    	}
			    });
			    */
    });

    function deletePermission(id, name) {
        layer.confirm("删除选择的权限数据：" + name + ", 是否继续？", {icon: 3, title: '提示'}, function (cindex) {
            // 删除数据
            $.ajax({
                url: "${APP_PATH}/permissionController/deletePermission.do",
                type: "POST",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.success) {
                        layer.msg("权限信息删除成功", {time: 1000, icon: 6}, function () {
                            var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
                            treeObj.reAsyncChildNodes(null, "refresh");
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

</script>
</body>
</html>
