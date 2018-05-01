<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<ul style="padding-left:0px;" class="list-group">
	<li class="list-group-item tree-closed" >
		<a href="${APP_PATH}/toMain.do"><i class="glyphicon glyphicon-dashboard"></i> 主页</a>
	</li>
    <c:forEach items="${rootPermission}" var="permission">
        <c:if test="${empty permission.children}">
			<li class="list-group-item tree-closed" >
				<a href="${APP_PATH}/${permission.url}"><i class="${permission.icon}"></i> ${permission.name}</a>
			</li>
        </c:if>
        <c:if test="${not empty permission.children}">
			<li class="list-group-item tree-closed">
				<span><i class="${permission.icon}"></i> ${permission.name} <span class="badge" style="float:right">${fn:length(permission.children)}</span></span> 
				<ul style="margin-top:10px;display:none;">
					<c:forEach items="${permission.children}" var="childPermission">
						<li style="height:30px;">
							<a href="${APP_PATH}/${childPermission.url}"><i class="${childPermission.icon}"></i> ${childPermission.name}</a>
						</li>
					</c:forEach>
				</ul>
			</li>
        </c:if>
    </c:forEach>
</ul>