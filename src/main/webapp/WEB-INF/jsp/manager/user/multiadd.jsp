<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet"
	href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
<link rel="stylesheet" href="${APP_PATH}/css/main.css">
<link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
<link rel="stylesheet"
	href="${APP_PATH}/bootstrap/css/bootstrapValidator.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>

<body>
	<%@include file="/WEB-INF/jsp/common/userinfo.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<div class="tree">
					<jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
				</div>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="${APP_PATH}/toMain.do">首页</a></li>
					<li><a href="${APP_PATH}/userController/toUserList.do">数据列表</a></li>
					<li class="active">批量导入</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-heading">
						用户数据
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<form id="userForm"
							action="${APP_PATH}/userController/multiAdd.do" method="post"
							role="form">
							<table id="usertable" class="table table-striped table-bordered">
								<thead>
									<tr>
										<td><input type="file" name="filename"></td>
									</tr>
								</thead>
								<tbody>
								</tbody>
								<tfoot>
									<button type="button" id="insertBtn"
										style="margin-bottom: 10px;" class="btn btn-success">
										<i class="glyphicon glyphicon-plus"></i> 开始导入
									</button>
									<button type="button" id="saveBtn" 
										style="margin-left:10px;margin-bottom:10px;" class="btn btn-danger">
										<i class="glyphicon glyphicon-download-alt"></i> 下载模板
									</button>
								</tfoot>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
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
	<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/layer/layer.js"></script>
	<script src="${APP_PATH}/jquery/jquery.form.js"></script>
	<script src="${APP_PATH}/bootstrap/js/bootstrapValidator.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		$(".list-group-item").click(function() {
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

		var userCnt = 0;
		$("#insertBtn").click(function() {
			// 增加一行
			var usertable = $("#usertable");
			var trObj = "";
			trObj += '<tr>';
			trObj += '    <td><div class="form-group"><input type="text" class="form-control" id="userAcct" name="users[' + userCnt + '].userAcct"></div></td>';
			trObj += '    <td><input type="text" class="form-control" name="users[' + userCnt + '].username"></td>';
			trObj += '    <td><a class="btn btn-danger" onclick="deleteUser(this)"><i class="glyphicon glyphicon-remove"></i></a></td>';
			trObj += '</tr>';
			usertable.append(trObj);
			userCnt++;
		});

		function checkUserAcct() {
            var userAcct = $("#userAcct");
            var loadingIndex = -1;
            $.ajax({
                url : "${APP_PATH}/userController/validateUserAcct.do",
                type : "POST",
                //dataType : "json",
                data : {"userAcct" : userAcct.val()},
                beforeSend : function() {
                    //loadingIndex = layer.msg('处理中', {icon: 16});
                    loadingIndex = layer.load(2, {time: 10*1000});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if(!result.success){
                    	layer.msg(result.data, {time:2000, icon:5, shift:6}, function(){
                    		// 设定页面焦点
                		});
                        flag = false;
                        userAcct.focus();
                    }
                }
            });
        }
		
		function deleteUser(obj) {
			// obj ==> <a>
			// 查找tr
			var trObj = $(obj).parent().parent();
			// 删除tr
			trObj.remove();
		}

		$("#saveBtn").click(function() {
				/* // 提交表单
				var loadingIndex = -1;
				$("#userForm").ajaxSubmit({
					beforeSubmit : function() {
						loadingIndex = layer.load(2,{time : 10 * 1000});
					},
					success : function(result) {
						layer.close(loadingIndex);
						if (result.success) {
							layer.msg("用户信息批量保存成功",{time : 1000,icon : 6},function() {
								window.location.href = "${APP_PATH}/userController/toUserList.do";
											});
						} else {
							layer.msg("用户信息批量保存失败",{time : 1000,icon : 5,shift : 6});
						}
					}
				}); */
			window.location.href = "${APP_PATH}/downloadController/download.do?filename=tmp_imp_user.xls";
		});
	</script>
</body>
</html>
