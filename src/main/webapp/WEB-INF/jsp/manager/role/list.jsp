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
    ::-webkit-scrollbar{
        display:none;
    }
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<%@include file="/WEB-INF/jsp/common/userinfo.jsp" %>
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
                <%@include file="/WEB-INF/jsp/common/menu.jsp" %>
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
  <button type="button" class="btn btn-warning" onclick="queryRole()"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteRoles()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/roleController/toAddRole.do'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" onclick="allSel(this)"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
<%-- 	                <tr>
	                  <td>${status.count}</td>
					  <td><input type="checkbox"></td>
	                  <td>${role.loginacct}</td>
	                  <td>${role.rolename}</td>
	                  <td>${role.email}</td>
	                  <td>
					      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
					      <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
						  <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
					  </td>
	                </tr> --%>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="4" align="center">
						<ul class="pagination"></ul>
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
			    <c:if test="${empty param.pageNo}">
			    pageQuery(1);
			    </c:if>
			    <c:if test="${not empty param.pageNo}">
			    pageQuery(${param.pageNo});
			    </c:if>
            });
            
            function changepageNo( pageNo ) {
            	pageQuery(pageNo);
            }
            
            function pageQuery(pageNo) {
            	var loadingIndex = -1;
            	// 使用AJAX异步分页查询角色数据
            	
            	var obj = {
           			"pageNo" : pageNo,
           			"pageSize" : 5
            	};
            	if ( cond ) {
            		// 增加模糊查询参数
            		obj.queryText = $("#queryText").val();
            	}
            	
            	$.ajax({
            		url : "${APP_PATH}/roleController/queryRoleList.do",
            		type : "POST",
            		data : obj,
            		beforeSend : function() {
            			loadingIndex = layer.msg('数据查询中', {icon: 16});
            			return true;
            		},
            		success : function( result ) {
            			layer.close(loadingIndex);
            			if ( result.success ) {
            				var pageObj = result.page;
            				var roleList = pageObj.data;

                            if (roleList == null) {
                                var empty = "";
                                $("tbody").html(empty);
                                $(".pagination").html(empty);
                                return;
                            }
            				
            				var content = "";
            				$.each(roleList, function(i, role){
             				   content = content +  '<tr>';
          	                   content = content +  '  <td>'+(i+1)+'</td>';
          					   content = content +  '  <td><input type="checkbox" value="'+role.id+'"></td>';
          	                   content = content +  '  <td>'+role.roleName+'</td>';
          	                   content = content +  '  <td>';
          					   content = content +  '      <button type="button" onclick="window.location.href=\'${APP_PATH}/roleController/assign.do?id='+role.id+'\'"class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
          					   content = content +  '      <button type="button" onclick="window.location.href=\'${APP_PATH}/roleController/toModifyRolePage.do?pageNo='+pageObj.pageNo+'&id='+role.id+'\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
          					   content = content +  '	   <button type="button" onclick="deleteRole('+role.id+', \''+role.roleName+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
          					   content = content +  '  </td>';
          	                   content = content +  '</tr>';
            				});
            				$("tbody").html(content);

                            $("#Pagination").pagination(pageObj.totalSize, {
                                num_edge_entries: 1, //边缘页数
                                num_display_entries: 4, //主体页数
                                callback: pageQuery,
                                items_per_page:5, //每页显示1项
                                prev_text:"上一页",
                                next_text:"下一页",
                                current_page:pageNo
                            });

            				var pageContent = "";
            				
            				if ( pageObj.pageNo != 1 ) {
            					pageContent = pageContent + '<li><a href="#" onclick="changepageNo('+(pageObj.pageNo-1)+')">上一页</a></li>';
            				}
            				for ( var i = 1; i <= pageObj.totalNo; i++ ) {
            					if ( i == pageObj.pageNo ) {
            						pageContent = pageContent + '<li class="active"><a href="#" onclick="changepageNo('+i+')">'+i+'</a></li>';	
            					} else {
            						pageContent = pageContent + '<li><a href="#" onclick="changepageNo('+i+')">'+i+'</a></li>';
            					}
            				}
            				if ( pageObj.pageNo != pageObj.totalNo ) {
            					pageContent = pageContent + '<li><a href="#" onclick="changepageNo('+(pageObj.pageNo+1)+')">下一页</a></li>';
            				}
            				
            				$(".pagination").html(pageContent);
            				
            			} else {
            				layer.msg("角色分页查询数据失败", {time:1000, icon:5, shift:6});
            			}
            		}
            	});
            }
            var cond = false;
            function queryRole() {
            	var queryText = $("#queryText");
            	if ( queryText.val() == "" ) {
            		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
            			queryText.focus();
            		});
            		return;
            	}
            	cond = true;
            	pageQuery(1);
            }
            
            function deleteRole(id, name) {
    			layer.confirm("删除角色: "+name+", 是否继续？",  {icon: 3, title:'提示'}, function(cindex){
    				// 删除数据
    				$.ajax({
    					url : "${APP_PATH}/roleController/deleteRole.do",
    					type : "POST",
    					data  : {
    						id : id
    					},
    					success : function(result) {
    						if ( result.success ) {
                				layer.msg("角色信息删除成功", {time:1000, icon:6}, function(){
                					pageQuery(1);
                				});
    						} else {
    							layer.msg(result.data, {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
            
            function allSel( obj ) {
            	// 获取全选框的勾选状态
            	var flg = obj.checked;
            	
            	var roleBox = $("tbody :checkbox");
            	
            	$.each(roleBox, function(i, n){
            		n.checked = flg;
            	});
            }
            
            function deleteRoles() {
            	var checkBox = $("tbody :checked");
            	if ( checkBox.length == 0 ) {
            		layer.msg("请选择需要删除的角色数据", {time:1000, icon:5, shift:6});
            	} else {
        			layer.confirm("删除选择的角色数据, 是否继续？",  {icon: 3, title:'提示'}, function(cindex){
        				// 删除数据
        				var obj = {}
        				$.each(checkBox, function(i, n){
        					obj["ids["+i+"]"] = n.value;
        				});
        				$.ajax({
        					url : "${APP_PATH}/manager/role/deletes.do",
        					type : "POST",
        					data  : obj,
        					success : function(result) {
        						if ( result.success ) {
                    				layer.msg("角色信息删除成功", {time:1000, icon:6}, function(){
                    					pageQuery(1);
                    				});
        						} else {
        							layer.msg("角色信息删除失败", {time:1000, icon:5, shift:6});
        						}
        					}
        				});
        			    layer.close(cindex);
        			}, function(cindex){
        			    layer.close(cindex);
        			});
            	}
            }
            
        </script>
  </body>
</html>
