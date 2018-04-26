<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header">
	<span class="wel_word fl">欢迎访问河南工业大学工程教育教学系统网站！</span> <span
		class="corner fr">
		<ul>
			<c:if test="${not empty userInfo}">
				<li class="user_li nLi"><a href="javascript:void(0);">欢迎你，${userInfo.name}</a>
					<div class="user_handle">
						<a href="personal.html">个人中心</a> <a href="ownTopic.html">我的话题</a>
						<a href="${APP_PATH}/userController/logout.do">退出</a>
					</div></li>
			</c:if>
		</ul>
		<div class="clear"></div>
	</span>
	<div class="clear"></div>
</div>