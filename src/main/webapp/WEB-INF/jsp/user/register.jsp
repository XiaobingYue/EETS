<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="keywords" content="基础教育语文研究中心" />
		<meta name="description" content="陕西师范大学基础教育语文研究中心" />
		<title>基础教育语文研究中心</title>
		<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/popup.css"/>
	</head>
	<body>
		<!--header start-->
		<div class="header_wrap">
			<div class="header">
				<span class="wel_word fl">欢迎访问陕西师范大学基础教育语文研究中心网站！</span>
				<span class="corner fr">
					<!--<ul>
						<li><a href="upload.html">上传</a>|</li>
						<li><a href="javascript:void(0);">注册</a>|</li>
						<li class="login_li"><a href="javascript:void(0);">登录</a></li>
						<!--<li class="user_li">
							<a href="javascript:void(0);">登录名</a>
							<div class="user_handle">
								<a href="">个人中心</a>
								<a href="">上传资料</a>
								<a href="">我的话题</a>
								<a href="">我的下载</a>
								<a href="">退出</a>
							</div>
						</li>
					</ul> -->
					<div class="clear"></div>
				</span>
				<div class="clear"></div>
			</div>
		</div>
		<!--nav start-->
		<%@include file="/WEB-INF/jsp/common/menu.jsp" %>
		<!--inside content start-->
		<div class="inside_wrap">
			<div class="inside_con">
				<div class="adr">
					<a href="${APP_PATH}/toindex.do">首页</a>&nbsp;>&nbsp;用户注册
				</div>
				<div class="register_box">
					<div class="tc_login">
						<div class="login_register fl">
							<form method="POST" name="form_register" target="_top">
								<div align="center">
									<span class="error">请务必填写所有选项(填写的用户名已有时提示)</span>
									<i class="icon-mobile-phone"></i>
									<input type="text" name="name" id="name" required="required" placeholder="请输入用户名(字母或数字组成)" autocomplete="off" class="input_yh">
									<input type="password" name="pass" id="pass" required="required" placeholder="请输入密码(字母或数字组成)" autocomplete="off" class="input_mm">
									<input type="password" name="pass_agin" id="pass_agin" required="required" placeholder="请确认密码" autocomplete="off" class="input_mm">
									<input type="email" name="email" id="emial" required="required" placeholder="请输入邮箱(方便找回密码)" autocomplete="off" class="input_el">
								</div>
								<div align="center">
									<input type="submit" class="button" title="Sign In" value="注册">
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
	</body>
</html>
