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
        <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
       <%-- <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
        <link rel="stylesheet" href="${APP_PATH}/css/main.css">
        <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">--%>
        <style type="text/css">
            #table-5 thead th {
                background-color: rgb(85, 186, 32);
                color: #fff;
                border-bottom-width: 0;
            }

            /* Column Style */
            #table-5 td {
                color: #000;
                text-align: center;
            }
            /* Heading and Column Style */
            #table-5 tr, #table-5 th {
                border-width: 1px;
                border-style: solid;
                border-color: rgb(156, 186, 95);
            }

            /* Padding and font style */
            #table-5 td, #table-5 th {
                padding: 5px 10px;
                font-size: 12px;
                font-family: Verdana;
                font-weight: bold;
            }

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
					<a href="${APP_PATH}/toIndex.do">首页</a>&nbsp;>&nbsp;用户管理
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
                            <table id="table-5">
                                <thead>
                                <tr>
                                    <th width="60">#</th>
                                    <th width="60"><input type="checkbox" onclick="selUserBox(this)"></th>
                                    <th width="100">用户名</th>
                                    <th width="60">类型</th>
                                    <th width="150">邮箱地址</th>
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
            window.onload = function(){
                pageQuery(0);
            }
            var loadingIndex = -1;
            var cond = false;
            function pageQuery( pageIndex ) {

                var jsonData = {
                    pageno : pageIndex+1,
                    pagesize : 5
                };
                //jsonData["username"]

                if ( cond ) {
                    //jsonData.querytext = $("#queryText").val();
                    jsonData["querytext"] = $("#queryText").val();
                }

                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/userController/queryUserList.do",
                    data : jsonData,
                    beforeSend : function() {
                        loadingIndex = layer.load(2, {time: 10*1000});
                    },
                    success : function(result) {
                        layer.close(loadingIndex);
                        if ( result.success ) {
                            var pageObj = result.page;
                            var userList = result.data;

                            // 循环
                            // $("img").each
                            // 工具方法
                            var userContent = "";
                            $.each(userList, function(i, user){
                                // 循环体
                                userContent = userContent + '<tr>';
                                userContent = userContent + '  <td>'+(i+1)+'</td>';
                                userContent = userContent + '  <td><input type="checkbox" value="'+user.id+'"></td>';
                                userContent = userContent + '  <td>'+user.username+'</td>';
                                userContent = userContent + '  <td>'+user.username+'</td>';
                                userContent = userContent + '  <td>'+(user.email||"")+'</td>';
                                userContent = userContent + '  <td>';
                                userContent = userContent + '      <button type="button" onclick="window.location.href=\'${APP_PATH}/manager/user/assign.htm?id='+user.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                                userContent = userContent + '      <button type="button" onclick="window.location.href=\'${APP_PATH}/manager/user/edit.htm?pageno='+(pageIndex+1)+'&id='+user.id+'\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                                userContent = userContent + '	  <button type="button" onclick="deleteUser('+user.id+', \''+user.loginacct+'\')"  class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                                userContent = userContent + '  </td>';
                                userContent = userContent + '</tr>';
                            });
                            // 表格数据行
                            //$("#userTableBody").empty();
                            //$("#userTableBody").append(userContent);
                            $("#userTableBody").html(userContent);

                            $("#Pagination").pagination(pageObj.totalsize, {
                                num_edge_entries: 1, //边缘页数
                                num_display_entries: 4, //主体页数
                                callback: pageQuery,
                                items_per_page:5, //每页显示1项
                                prev_text:"上一页",
                                next_text:"下一页",
                                current_page:pageIndex
                            });

                            // 页码
                            // 相同类型的引号不能嵌套使用
                            // "''", '""'
                            /*
                            var pageContent = "";
                            if ( pageno != 1 ) {
                                pageContent = pageContent + '<li><a style="cursor: pointer" onclick="changePageno('+(pageno-1)+')">上一页</a></li>';
                            }
                            for ( var i = 1; i <= pageObj.totalno; i++ ) {
                                pageContent = pageContent + '<li '+(pageno==i?'class="active"':'')+'><a style="cursor:pointer;" onclick="changePageno('+i+')">'+i+'</a></li>';
                            }
                            if ( pageno != pageObj.totalno ) {
                                pageContent = pageContent + '<li><a style="cursor: pointer" onclick="changePageno('+(pageno+1)+')">下一页</a></li>';
                            }
                            */
                            //$(".pagination").empty();
                            //$(".pagination").append(pageContent);
                            //$(".pagination").html(pageContent);
                        } else {
                            layer.msg("用户分页数据查询失败", {time:1500, icon:5, shift:6});
                        }
                    }
                });
            }
        </script>
	</body>
</html>
