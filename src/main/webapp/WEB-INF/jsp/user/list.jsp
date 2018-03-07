<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	<link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">工程教育教学系统</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
            <%@include file="/WEB-INF/jsp/common/userinfo.jsp"%>
			</li>
            <li style="margin-left:10px;padding-top:8px;">
				<button type="button" class="btn btn-default btn-danger">
				  <span class="glyphicon glyphicon-question-sign"></span> 帮助
				</button>
			</li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
			    <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
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
<button type="button" class="btn btn-primary" style="float:right;margin-left:10px;" onclick="window.location.href='${APP_PATH}/userController/toAddUser.do'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
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
        </div>
      </div>
    </div>

    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/layer/layer.js"></script>
	<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});

			    <c:if test="${empty param.pageno}">
			    pageQuery(0);
			    </c:if>
			    <c:if test="${not empty param.pageno}">
			    pageQuery(${param.pageno}-1);
			    </c:if>
			    
			    
			    $("#queryBtn").click(function(){
			    	var queryText = $("#queryText");
			    	if ( queryText.val() == "" ) {
			    		layer.msg("请输入查询条件", {time:1500, icon:5, shift:6}, function(){
			    			queryText.focus();
			    		});
			    	} else {
			    		cond = true;
			    		pageQuery(0);
			    	}
			    });
            });
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            function changePageno( pageno ) {
            	//window.location.href = "${APP_PATH}/manager/user/list.htm?pageno=" + pageno;
            	pageQuery(pageno);
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
	          					userContent = userContent + '	  <button type="button" onclick="deleteUser('+user.id+', \''+user.username+'\')"  class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
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
            
            function deleteUser(id, username) {
    			layer.confirm("删除用户信息:"+username+"，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
    			    // 主键删除用户信息
    			    $.ajax({
    			    	type : "POST",
    			    	url  : "${APP_PATH}/userController/deleteUser.do",
    			    	data : {
    			    		id : id
    			    	},
    			    	success : function(result) {
    			    		if ( result.success ) {
    			    			layer.msg("用户数据删除成功", {time:1500, icon:6}, function(){
    			    				pageQuery(0);
    			    			});
    			    		} else {
    			    			layer.msg("用户数据删除失败", {time:1500, icon:5, shift:6});
    			    		}
    			    	}
    			    });
    			    
    				layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
            
            function deleteUsers() {
            	// 获取被选中的用户复选框
            	var userBoxes = $("tbody :checked");
            	
            	// 判断复选框的数量
            	if ( userBoxes.length == 0 ) {
            		layer.msg("请选择需要删除的用户信息", {time:1500, icon:5, shift:6});
            	} else {
            		
        			layer.confirm("删除选择的用户信息，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
                		// 删除数据
                		var jsonData = {};
                		$.each(userBoxes, function(i, n){
                			jsonData["ids["+i+"]"] = n.value;
                		});
                		
                		$.ajax({
                			type : "POST",
                			url  : "${APP_PATH}/manager/user/deletes.do",
                			data : jsonData,
                			success : function (result) {
                				if ( result.success ) {
                					layer.msg("用户信息删除成功", {time:1500, icon:6}, function(){
                						pageQuery(0);
                					});
                				} else {
                					layer.msg("用户信息删除失败", {time:1500, icon:5, shift:6});
                				}
                			}
                		});
        			    
        				layer.close(cindex);
        			}, function(cindex){
        			    layer.close(cindex);
        			});
            		

            	}
            }
            
            function selUserBox(obj) {
            	var flg = obj.checked;
            	
            	// 获取用户复选框
            	// tbody ==> checkbox
            	// $.each
            	$("tbody :checkbox").each(function(){
            		this.checked = flg;
            	});
            }
        </script>
  </body>
</html>
