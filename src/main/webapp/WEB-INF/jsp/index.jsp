<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="keywords" content="工程教育教学系统" />
		<meta name="description" content="工程教育教学系统" />
		<title>工程教育教学系统</title>
		<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/popup.css"/>
	</head>
	<body>
		<!--header start-->
		<div class="header_wrap">
			<%@include file="/WEB-INF/jsp/common/header.jsp" %>
			<div id="gray"></div>				
			<div class="popup" id="popup">				
				<div class="top_nav" id='top_nav'>
					<div align="center">
						<i></i>
						<span>登录账号</span>
						<a class="guanbi"></a>
					</div>
				</div>					
				<div class="min">					
					<div class="tc_login">											
						<div class="login_register">
							<form action="${APP_PATH}/loginController/login.do" method="POST" name="form_login" target="_top">
								<div align="center">
									<i class="icon-mobile-phone"></i>
									<input type="text" name="username" id="username" required="required" placeholder="用户名" autocomplete="off" class="input_yh">
									<input type="password" name="password" id="password" required="required" placeholder="密码" autocomplete="off" class="input_mm">
								</div>
								<dd>
									<div class="user">
										<input type="checkbox" name="user" id="user" value="记住用户" class="r_user" />记住用户
										<a href="password.html" target="_blank">忘记密码？</a>
									</div>
								</dd>
								<div align="center">
									<input type="button" class="button" title="Sign In" value="登录" onclick="dologin()">
								</div>
								<dd>
									<div align="center"><a href="register.html" target="_blank">立即注册！</a></div>
								</dd>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="/WEB-INF/jsp/common/menu.jsp" %>
		<!--banner start-->
		<div class="banner">
			<div class="bd">
				<ul>
					<li class="first"><a href="javascript:void(0);"></a></li>
					<li class="second"><a href="javascript:void(0);"></a></li>
					<li class="third"><a href="javascript:void(0);"></a></li>
					<li class="fourth"><a href="javascript:void(0);"></a></li>
				</ul>
			</div>
			<div class="hd"><ul></ul></div>
		</div>
		<!--notice start-->
		<div class="notice_wrap">
			<div class="notice">
				<div class="bd fl">
					<b>通知公告：</b>
					<ul class="infoList">
						<li><span class="date">[2016-05-05]</span><a href="nDetail.html">通知公告名称通知公告名称，通知公告名称通知公告名称通知公告，名称通知公告名...</a></li>
						<li><span class="date">[2016-05-05]</span><a href="nDetail.html">通知公告名称通知公告名称，通知公告名称通知公告名称通知公告...</a></li>
						<li><span class="date">[2016-05-05]</span><a href="nDetail.html">通知公告名称通知公告名称，通知公告名称通知公告名称</a></li>
						<li><span class="date">[2016-05-05]</span><a href="nDetail.html">通知公告名称通知公告名称，通知公告名称通知公告名称通知公告，名称通知公告名名称通知公告名...</a></li>
					</ul>
				</div>
				<a href="notice.html" class="more fr">更多+</a>
				<div class="clear"></div>
			</div>
		</div>
		<!--content start-->
		<div class="content">
			<!--about、news and hot-->
			<div class="box1">
				<div class="fl">
					<div class="about">
						<div class="b_title">
							<h3>中心概况</h3>
							<a href="about.html" class="more">更多+</a>
						</div>
						<div class="b_wrap">
							<div class="a_img fl">
								<img src="${APP_PATH}/images/about.jpg" />
							</div>
							<div class="a_text fl">
								<p>基础教育语文研究中心基础，教育语文研究中心基础教育语文，研究中心基础教育语文研究中心基础教育语文研究中心。基础教育语文研究中心基础，教育语文研究中心基础教育语文，研究中心基础教育语文研究中心基础教育语文研究中心。基础教育语文研究中心基础，教育语文研究中心基础教育语文，研究中心基础教育语文研究中心基础教育语文研究中心。</p>
								<p>基础教育语文研究中心基础，教育语文研究中心基础教育语文，研究中心基础教育语文研究中心基础教育语文研究中心。基础教育语文研究中心基础，教育语文研究中心基础教育语文，研究中心基础教育语文研究中心基础教育语文研究中心...</p>
							</div>
							<div class="clear"></div>
						</div>
					</div>
					<div class="news">
						<div class="b_title">
							<h3>新闻热点</h3>
							<a href="news.html" class="more">更多+</a>
						</div>
						<div class="b_wrap">
							<div class="fl n_list">
								<h4>教育 · 新闻</h4>
								<ul>
									<li class="special">
										<div class="n_img">
											<img src="${APP_PATH}/images/n1.jpg" />
										</div>
										<div class="n_text">
											<b>新闻标题新闻标题新闻标题新闻标题</b>
											<p>新闻标题新闻标题新闻标题新闻,标题新,标题新闻标题新闻标题新闻标题...<a href="nDetail.html" class="detail">详细</a></p>
										</div>
									</li>
									<li><a href="nDetail.html">新闻标题新闻标题新闻标题新闻</a></li>
									<li><a href="nDetail.html">新闻标题新闻标题新闻标题新闻</a></li>
									<li><a href="nDetail.html">新闻标题新闻标题新闻标题新闻</a></li>
								</ul>
							</div>
							<div class="fr n_list">
								<h4>工作 · 动态</h4>
								<ul>
									<li class="special">
										<div class="n_img">
											<img src="${APP_PATH}/images/n2.jpg" />
										</div>
										<div class="n_text">
											<b>新闻标题新闻标题新闻标题新闻标题</b>
											<p>闻标题新闻标题新闻标题新闻标题新闻,标题新闻标题新闻标题新闻标题...<a href="nDetail.html" class="detail">详细</a></p>
										</div>
									</li>
									<li><a href="nDetail.html">新闻标题新闻标题新闻标题新闻</a></li>
									<li><a href="nDetail.html">新闻标题新闻标题新闻标题新闻</a></li>
									<li><a href="nDetail.html">新闻标题新闻标题新闻标题新闻</a></li>
								</ul>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<div class="hot fr">
					<div class="b_title">
						<h3>热门话题</h3>
						<a href="topic.html" class="more">更多+</a>
					</div>
					<div class="b_wrap">
						<ul>
							<li>
								<div class="h_img">
									<img src="${APP_PATH}/images/favicon.jpg" />
								</div>
								<div class="h_text">
									<b><a href="tDetail.html">话题名称话题名称话题名称</a></b>
									<p>话题名称话题名称话题名称,话题名称话题名称话题名称...<a href="tDetail.html" class="detail">详细</a></p>
								</div>
							</li>
							<li>
								<div class="h_img">
									<img src="${APP_PATH}/images/favicon.jpg" />
								</div>
								<div class="h_text">
									<b><a href="tDetail.html">话题名称话题名称话题名称</a></b>
									<p>话话题名称话题名称话名称,话题名称话题名称话题名称...<a href="tDetail.html" class="detail">详细</a></p>
								</div>
							</li>
							<li>
								<div class="h_img">
									<img src="${APP_PATH}/images/favicon.jpg" />
								</div>
								<div class="h_text">
									<b><a href="tDetail.html">话题名称话题名称话题名称</a></b>
									<p>话题名称话称话题名称,话题名称话题名称话题名称...<a href="tDetail.html" class="detail">详细</a></p>
								</div>
							</li>
							<li>
								<div class="h_img">
									<img src="${APP_PATH}/images/favicon.jpg" />
								</div>
								<div class="h_text">
									<b><a href="tDetail.html">话题名称话题名称话题名称</a></b>
									<p>话题名称称话题名称,话题名称话题名称话题名称...<a href="tDetail.html" class="detail">详细</a></p>
								</div>
							</li>
							<li>
								<div class="h_img">
									<img src="${APP_PATH}/images/favicon.jpg" />
								</div>
								<div class="h_text">
									<b><a href="tDetail.html">话题名称话题名称话题名</a></b>
									<p>题名称话题名称话题名称话题名称话题名称...<a href="tDetail.html" class="detail">详细</a></p>
								</div>
							</li>
							<li>
								<div class="h_img">
									<img src="${APP_PATH}/images/favicon.jpg" />
								</div>
								<div class="h_text">
									<b><a href="tDetail.html">话题名称话题名称话题名称话</a></b>
									<p>名称话题名称话题名称,话题名称话题名话题名称...<a href="tDetail.html" class="detail">详细</a></p>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<!--teachers and course-->
			<%-- <div class="box2">
				<div class="teachers fl">
					<div class="b_title">
						<h3>名师风采</h3>
						<a href="teachers.html" class="more">更多+</a>
					</div>
					<div class="b_wrap">
						<div class="fl n_list">
							<h4>名师 · 资源</h4>
							<ul>
								<li><a href="tcDetail.html">论文标题论文标题论文标题论文标题</a></li>
								<li><a href="tcDetail.html">论文标题论文标题论文标题论文标题</a></li>
								<li><a href="tcDetail.html">论文标题论文标题论文标题论文标题</a></li>
								<li><a href="tcDetail.html">论文标题论文标题论文标题论文标题</a></li>
								<li><a href="tcDetail.html">论文标题论文标题论文标题论文标题</a></li>
							</ul>
						</div>
						<div class="fr n_list">
							<h4>名师 · 推荐</h4>
							<ul>
								<li><a href="tcDetail.html">人名：课程名称课程名称课程名称</a></li>
								<li><a href="tcDetail.html">人名：课程名称课程名称课程名称</a></li>
								<li><a href="tcDetail.html">人名：课程名称课程名称课程名称</a></li>
								<li><a href="tcDetail.html">人名：课程名称课程名称课程名称</a></li>
								<li><a href="tcDetail.html">人名：课程名称课程名称课程名称</a></li>
							</ul>
						</div>
						<div class="clear"></div>
						<div class="t_list">
							<h4>名师 · 简介</h4>
							<ul>
								<li><a href="tDetail.html"><img src="${APP_PATH}/images/t1.jpg"/><span>老师</span></a></li>
								<li><a href="tDetail.html"><img src="${APP_PATH}/images/t2.jpg"/><span>老师</span></a></li>
								<li><a href="tDetail.html"><img src="${APP_PATH}/images/t1.jpg"/><span>老师</span></a></li>
								<li><a href="tDetail.html"><img src="${APP_PATH}/images/t2.jpg"/><span>老师</span></a></li>
								<li><a href="tDetail.html"><img src="${APP_PATH}/images/t1.jpg"/><span>老师</span></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="course fr">
					<div class="b_title">
						<h3>课程改革</h3>
						<a href="course.html" class="more">更多+</a>
					</div>
					<div class="b_wrap">
						<div class="n_list">
							<div class="intro">
								<img src="${APP_PATH}/images/course.jpg"/>
								<p>课程改革简介课程改革简介，课程改革简介课程改革简介课程改革，简介课程改革简介课程改革简介课程改革简介，课程改革简介课程改革简介...<a href="nDetail.html" class="detail">详细</a></p>
							</div>
							<ul>
								<li><a href="tcDetail.html">课程名称</a></li>
								<li><a href="tcDetail.html">课程名称课程名称</a></li>
								<li><a href="tcDetail.html">课程名称</a></li>
								<li><a href="tcDetail.html">课程名称课程名称</a></li>
								<li><a href="tcDetail.html">课程名称</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div> --%>
			<!--schoolmate-->
		<%-- 	<div class="schoolmate">
				<div class="b_title">
					<h3>学友之家</h3>
					<a href="schoolmate.html" class="more">更多+</a>
				</div>
				<div class="b_wrap">
					<div class="hd">
						<a class="next"></a>
						<a class="prev"></a>
					</div>
					<div class="s_list bd">
						<ul>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac1.jpg"/><span>活动名称</span></a></li>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac2.jpg"/><span>活动名称</span></a></li>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac1.jpg"/><span>活动名称</span></a></li>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac2.jpg"/><span>活动名称</span></a></li>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac1.jpg"/><span>活动名称</span></a></li>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac1.jpg"/><span>活动名称</span></a></li>
							<li><a href="tDetail.html"><img src="${APP_PATH}/images/ac2.jpg"/><span>活动名称</span></a></li>
						</ul>
					</div>
				</div>
			</div> --%>
			<!--resource and exam-->
			<!-- <div class="box3"> -->
<%-- 				<div class="resource fl">
					<div class="b_title">
						<h3>教学资源</h3>
						<a href="resource.html" class="more">更多+</a>
					</div>
					<div class="b_wrap">
						<div class="fl n_list">
							<h4>文献 · 资料</h4>
							<ul>
								<li><a href="tcDetail.html">文献名称文献名称文献名称文献名称</a></li>
								<li><a href="tcDetail.html">文献名称文献名称文献名称文献名称</a></li>
								<li><a href="tcDetail.html">文献名称文献名称文献名称文献名称</a></li>
								<li><a href="tcDetail.html">文献名称文献名称文献名称文献名称</a></li>
								<li><a href="tcDetail.html">文献名称文献名称文献名称文献名称</a></li>
							</ul>
						</div>
						<div class="fr n_list">
							<h4>学习 · 资料</h4>
							<ul>
								<li><a href="tcDetail.html">资料名称资料名称资料名称资料名称</a></li>
								<li><a href="tcDetail.html">资料名称资料名称资料名称资料名称</a></li>
								<li><a href="tcDetail.html">资料名称资料名称资料名称资料名称</a></li>
								<li><a href="tcDetail.html">资料名称资料名称资料名称资料名称</a></li>
								<li><a href="tcDetail.html">资料名称资料名称资料名称资料名称</a></li>
							</ul>
						</div>
						<div class="clear"></div>
						<div class="t_list">
							<h4>教学 · 视频</h4>
							<ul>
								<li><a href="tcDetail.html"><img src="${APP_PATH}/images/v1.jpg"/></a></li>
								<li><a href="tcDetail.html"><img src="${APP_PATH}/images/v1.jpg"/></a></li>
								<li><a href="tcDetail.html"><img src="${APP_PATH}/images/v1.jpg"/></a></li>
								<li><a href="tcDetail.html"><img src="${APP_PATH}/images/v1.jpg"/></a></li>
							</ul>
						</div>
					</div>
				</div> --%>
			<!-- 	<div class="exam fr">
					<div class="b_title">
						<h3>考试安排</h3>
						<a href="exam.html" class="more">更多+</a>
					</div>
					<div class="b_wrap">
						<div class="n_list">
							<ul>
								<li><a href="eDetail.html">课程名称</a><span class="plan">2016-06-06&nbsp;&nbsp;10:00-12:00(上午)</span></li>
								<li><a href="eDetail.html">课程名称课程名称</a><span class="plan">2016-06-06&nbsp;&nbsp;10:00-12:00(上午)</span></li>
								<li><a href="eDetail.html">课程名称</a><span class="plan">2016-06-06&nbsp;&nbsp;10:00-12:00(上午)</span></li>
								<li><a href="eDetail.html">课程名称课程名称</a><span class="plan">2016-06-06&nbsp;&nbsp;10:00-12:00(上午)</span></li>
								<li><a href="eDetail.html">课程名称</a><span class="plan">2016-06-06&nbsp;&nbsp;10:00-12:00(上午)</span></li>
								<li><a href="eDetail.html">课程名称</a><span class="plan">2016-06-06&nbsp;&nbsp;10:00-12:00(上午)</span></li>
							</ul>
						</div>
					</div>
				</div> -->
				<div class="clear"></div>
			</div>
			<!--friendly link-->
			<!-- <div class="friendlink">
				<b>友情链接：</b><a href="">友情链接</a><a href="">友情链接</a><a href="">友情链接</a><a href="">友情链接</a><a href="">友情链接</a>
			</div> -->
		<!-- </div> -->
		<!--footer start-->
		<%@include file="/WEB-INF/jsp/common/footer.jsp" %>
		<script src="${APP_PATH}/js/jquery-1.11.0.min.js" type="text/javascript"></script>
		<script src="${APP_PATH}/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
		<script src="${APP_PATH}/js/common.js"></script>
		<script src="${APP_PATH}/script/layer/layer.js"></script>
		<script type="text/javascript">
		function dologin() {
	    	var loginacct = $("#username");
	    	if ( loginacct.val() == "" ) {
	    		//alert("登陆账号不能为空，请输入");
	    		layer.msg("登陆账号不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
	        		// 设定页面焦点
	        		loginacct.focus();
	    		});
	    		return;
	    	}
	    	var userpswd = $("#password");
	    	if ( userpswd.val() == "" ) {
	    		//alert("登陆密码不能为空，请输入");
	    		 layer.msg("登陆密码不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		userpswd.focus();
	    		});
	    		return;
	    	}
	    	// 使用AJAX线程提交数据
	    	//$.post, $.get, $.ajax
	    	//function Student() {}
	    	// JS运行给对象添加的属性
	    	//var student = new Student();
	    	//student.name = "zhangsan";
	    	
	    	// {} ==> 声明对象
	    	// JavaScriptObjectNotation对象 
	    	// [{ 属性名称:属性值, 属性名称1:属性值1 }]
	    	// JSON字符串
	    	// "{'username':'zhangsan', 'sex':'男'}"
	    	
	    	// JS : 全局变量，局部变量(var)
	    	var url = "loginController/login.do";
	    	var jsonData = {
	   			"username" : loginacct.val(),
	   			"password"  : userpswd.val()
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
	    				layer.msg("用户账户或密码输入不正确，登陆失败", {time:2000, icon:5, shift:6}, function(){
			        		// 设定页面焦点
			        		loginacct.focus();
			    		});
	    			}
	    		},
	    		error : function() {
	    			// 404， 500
	    			//alert("用户登陆失败");
	    			layer.msg("用户登陆失败", {time:2000, icon:5, shift:6}, function(){
		        		// 设定页面焦点
		        		loginacct.focus();
		    		});
	    		}
	    	});
	    }
			jQuery(".banner").slide({ titCell:".hd ul", mainCell:".bd ul", effect:"fold",  autoPlay:true, autoPage:true, trigger:"click" });
			jQuery(".notice").slide({mainCell:".bd ul",autoPage:true,effect:"top",autoPlay:true,vis:1});
			jQuery(".schoolmate .b_wrap").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",autoPlay:true,vis:5,trigger:"click"});
		</script>
	</body>
</html>
