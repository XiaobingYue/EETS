<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="keywords" content="基础教育语文研究中心" />
		<meta name="description" content="陕西师范大学基础教育语文研究中心" />
		<title>工程教育教学系统</title>
		<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/popup.css"/>
        <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
        <link rel="stylesheet" href="${APP_PATH}/css/main.css">
        <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
	</head>
	<body>
		<!--header start-->
		<div class="header_wrap">
			<%@include file="/WEB-INF/jsp/common/header.jsp" %>
		</div>
		<!--nav start-->
		<%@include file="/WEB-INF/jsp/common/menu.jsp" %>
		<!--inside content start-->
		<div class="inside_wrap">
			<div class="inside_con">
				<div class="adr">
					<a href="${APP_PATH}/toIndex.do">首页</a>&nbsp;>&nbsp;批量导入
				</div>
				<div class="register_box">
					<div class="tc_login">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-inline" role="form" style="float:left;">
                                    <div class="form-group has-feedback">
                                        <div class="input-group">
                                            <div class="input-group-addon">查询条件</div>
                                            <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                                        </div>
                                    </div>
                                    <button type="button" id="queryBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                                </form>
                                <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteUsers()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                                <button type="button" class="btn btn-primary" style="float:right;margin-left:10px;" onclick="window.location.href='${APP_PATH}/manager/user/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                                <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/manager/user/multiadd.htm'"><i class="glyphicon glyphicon-plus"></i> 批量新增</button>
                                <br>
                                <hr style="clear:both;">
                                <div class="table-responsive">
                                    <table class="table  table-bordered">
                                        <thead>
                                        <tr >
                                            <th width="30">#</th>
                                            <th width="30"><input type="checkbox" onclick="selUserBox(this)"></th>
                                            <th>账号</th>
                                            <th>名称</th>
                                            <th>邮箱地址</th>
                                            <th width="100">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="userTableBody"></tbody>
                                        <tfoot>
                                        <tr >
                                            <td colspan="6" align="center">
                                                <div id="Pagination" class="pagination">
                                            </td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
		<!--footer start-->
		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
		<script src="${APP_PATH}/js/jquery-1.11.0.min.js" type="text/javascript"></script>
		<script src="${APP_PATH}/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
		<script src="${APP_PATH}/js/common.js"></script>
		<script src="${APP_PATH}/script/layer/layer.js"></script>
        <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
        <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
        <script src="${APP_PATH}/script/layer/layer.js"></script>
        <script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
		<script type="text/javascript">
		function doregister(){
			var username = $("#username");
			if(username.val() == ""){
				layer.msg("请输入注册账号", {time:2000, icon:5, shift:6}, function(){
	        		// 设定页面焦点
	        		username.focus();
	    		});
				return;
			}
			var password = $("#password");
			if(password.val() == ""){
				layer.msg("请输入注册密码", {time:2000, icon:5, shift:6}, function(){
	        		// 设定页面焦点
	        		password.focus();
	    		});
				return;
			}
			var password1 = $("#password1");
			if(password1.val() == ""){
				layer.msg("请再次输入注册密码", {time:2000, icon:5, shift:6}, function(){
	        		// 设定页面焦点
	        		password1.focus();
	    		});
				return;
			}
			var email = $("#email");
			if(email.val() == ""){
				layer.msg("请输入注册邮箱", {time:2000, icon:5, shift:6}, function(){
	        		// 设定页面焦点
	        		email.focus();
	    		});
				return;
			}
			if(password.val() != password1.val()){
				layer.msg("两次密码输入不一致，请重新输入", {time:2000, icon:5, shift:6}, function(){
	        		// 设定页面焦点
	        		password.focus();
	    		});
				return;
			}
			var url = "loginController/register.do";
	    	var jsonData = {
	   			"username"  : username.val(),
	   			"password"  : password.val(),
	   			"email"		: email.val()
	    	};
	    	/* if ( $("#usertype").val() == "member" ) {
	    		url = "doMemberLogin.do";
	    		jsonData.memberpswd = userpswd.val();
	    	} */
	    	
	    	var loadingIndex = -1;
	    	$.ajax({
	    		url : "${APP_PATH}/"+url,
	    		type : "POST",
	    		//dataType : "json",
	    		data : jsonData,
	    		beforeSend : function() {
	    			loadingIndex = layer.msg('处理中', {icon: 16});
	    			//loadingIndex = layer.load(2, {time: 10*1000});
	    		}, 
	    		success : function(result) {
	    			layer.close(loadingIndex);
	    			//console.log(result);
	    			// 200
	    			// 从后台获取返回的结果
	    			if (result.success) {
	    				/* if ( $("#usertype").val() == "member" ) {
	    					window.location.href = "${APP_PATH}/member.htm";
	    				} else { */
	    					window.location.href = "${APP_PATH}/toindex.do";
	    				//}
	    			} else {
	    				//alert("用户账户或密码输入不正确，登陆失败");
	    				layer.msg("注册失败", {time:2000, icon:5, shift:6}, function(){
			        		// 设定页面焦点
			        		username.focus();
			    		});
	    			}
	    		},
	    		error : function() {
	    			// 404， 500
	    			//alert("用户登陆失败");
	    			layer.msg("注册失败", {time:2000, icon:5, shift:6}, function(){
		        		// 设定页面焦点
		        		username.focus();
		    		});
	    		}
	    	});
		}
		</script>
	</body>
</html>
