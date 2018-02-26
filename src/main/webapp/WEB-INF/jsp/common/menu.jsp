<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="nav_menu">
	<a href="${APP_PATH}/toindex.do" class="logo fl"><img src="${APP_PATH}/images/logo.png" /></a>
	<div class="nav_list fr">
		<ul id="nav" class="nav clearfix">
			<li class="nLi"></li>
			<c:forEach items="${rootPermission}" var="permission">
			<li class="nLi">
				<h3>
					<a href="${APP_PATH}/${permission.url}">${permission.name}</a>
				</h3>
				<c:if test="${not empty permission.children}">
					<ul class="sub">
					<c:forEach items="${permission.children}" var="permission">
					<li><a href="${APP_PATH}/${permission.url}">${permission.name}</a></li>
					</c:forEach>
					</ul>
				</c:if>
			</li>
			</c:forEach>
		</ul>
	</div>
	<div class="clear"></div>
</div>