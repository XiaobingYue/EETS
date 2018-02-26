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
						<div class="login_register fl">
						<a href="${APP_PATH}/downloadController/download.do?filename=tmp_imp_user.xls">模板下载</a>
							<form method="POST" name="form_register" target="_top">
								<div align="center">
									<span class="error">注：请确保您导入的excel文件中，满足以下内容和顺序： 用户名、email地址（共2列） </span>
									<span class="error">若导入记录超过一万条，建议分批导入。</span>
									<i class="icon-mobile-phone"></i>
									<input type="file" name="batchfile" id="batchfile" required="required" placeholder="请选择要导入的文件" autocomplete="off" class="input_yh">
								</div>
								<div align="center">
									<input type="button" class="button" title="Sign In" onclick="doregister()" value="导入">
								</div>
							</form>
						</div>
						<div class="l_img fl">
							<img src="${APP_PATH}/images/sj.jpg"/>
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
