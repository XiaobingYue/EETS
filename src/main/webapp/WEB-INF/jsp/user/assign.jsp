<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="keywords" content="工程教育教学系统" />
		<meta name="description" content="河南工业大学工程教育教学系统" />
		<title>工程教育教学系统</title>
		<link rel="stylesheet" href="${APP_PATH}/css/style.css" />
        <link rel="stylesheet" type="text/css" href="${APP_PATH}/css/popup.css"/>
        <%--<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
        <link rel="stylesheet" href="${APP_PATH}/css/main.css">
        <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css"
        <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">--%>
        <style type="text/css">

        </style>
	</head>
	<body>
		<!--header start-->
		<div class="header_wrap">
		<%@include file="/WEB-INF/jsp/common/header.jsp"%>
		</div>
		<!--nav start-->
		<%@include file="/WEB-INF/jsp/common/menu.jsp"%>
		<!--inside content start-->
		<div class="inside_wrap">
			<div class="inside_con">
				<div class="adr">
					<a href="${APP_PATH}/toIndex.do">首页</a>&nbsp;>&nbsp;<a href="${APP_PATH}/userController/toUserList.do">用户管理</a>&nbsp;>&nbsp;赋权页面
				</div>
				<div class="inside_box">
					<div class="sidemenu fl">
						<div class="s_title">用户管理</div>
                            <c:forEach items="${rootPermission}" var="permission">
                                <c:if test="${permission.name == '用户管理' && not empty permission.children}">
                                    <c:forEach items="${permission.children}" var="permission">
                                        <ul>
                                            <c:if test="${permission.name == '用户列表'}">
                                                <li class="on"><a href="${APP_PATH}/${permission.url}">${permission.name}</a></li>
                                            </c:if>
                                            <c:if test="${permission.name != '用户列表'}">
                                                <li class="off"><a href="${APP_PATH}/${permission.url}">${permission.name}</a></li>
                                            </c:if>
                                        </ul>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
					</div>
					<div class="ic_wrap fr">
                        <div class="table-responsive">
                            <form role="form" class="form-inline">
                                <div class="form-group">
                                    <label for="exampleInputPassword1">未分配角色列表</label><br>
                                    <select id="leftList" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                        <c:forEach items="${unassignList}" var="role">
                                            <option value="${role.id}">${role.name}</option>
                                        </c:forEach>
                                        <!--                         <option value="pm">PM</option>
                                                                <option value="sa">SA</option>
                                                                <option value="se">SE</option>
                                                                <option value="tl">TL</option>
                                                                <option value="gl">GL</option> -->
                                    </select>
                                </div>
                                <div class="form-group">
                                    <ul>
                                        <li id="left2RightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                        <br>
                                        <li id="right2LeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                                    </ul>
                                </div>
                                <div class="form-group" style="margin-left:40px;">
                                    <label for="exampleInputPassword1">已分配角色列表</label><br>
                                    <select id="rightList" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                        <c:forEach items="${assignList}" var="role">
                                            <option value="${role.id}">${role.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!--footer start-->
		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
		<script src="${APP_PATH}/js/jquery-1.11.0.min.js" type="text/javascript"></script>
		<script src="${APP_PATH}/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
		<script src="${APP_PATH}/js/common.js"></script>
        <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
        <script src="${APP_PATH}/script/layer/layer.js"></script>
        <script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
        <script type="text/javascript">

        </script>
	</body>
</html>
