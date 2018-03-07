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
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 审核任务维护</a></div>
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
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th>流程名称</th>
                  <th>流程版本</th>
                  <th>任务名称</th>
                  <th>申请会员</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
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
			    pageQuery(1);
			    </c:if>
			    <c:if test="${not empty param.pageno}">
			    pageQuery(${param.pageno});
			    </c:if>
            });
            
            function changePageno( pageno ) {
            	pageQuery(pageno);
            }
            
            function pageQuery(pageno) {
            	var loadingIndex = -1;
            	// 使用AJAX异步分页查询审核任务数据
            	
            	var obj = {
           			"pageno" : pageno,
           			"pagesize" : 10
            	};
            	
            	$.ajax({
            		url : "${APP_PATH}/manager/auth_cert/pageQuery.do",
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
            				var roleList = pageObj.datas;
            				
            				var content = "";
            				$.each(roleList, function(i, task){
             				   content = content +  '<tr>';
          	                   content = content +  '  <td>'+(i+1)+'</td>';
          	                   content = content +  '  <td>'+task.procDefName+'</td>';
          	                   content = content +  '  <td>'+task.procDefVersion+'</td>';
          	                   content = content +  '  <td>'+task.name+'</td>';
          	                   content = content +  '  <td>'+task.memberName+'</td>';
          	                   content = content +  '  <td>';
          					   content = content +  '      <button type="button" onclick="window.location.href=\'${APP_PATH}/manager/auth_cert/detail.htm?memberid='+task.memberid+'&id='+task.id+'\'"class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
          					   content = content +  '  </td>';
          	                   content = content +  '</tr>';
            				});
            				
            				var pageContent = "";
            				
            				if ( pageObj.pageno != 1 ) {
            					pageContent = pageContent + '<li><a href="#" onclick="changePageno('+(pageObj.pageno-1)+')">上一页</a></li>';
            				}
            				for ( var i = 1; i <= pageObj.totalno; i++ ) {
            					if ( i == pageObj.pageno ) {
            						pageContent = pageContent + '<li class="active"><a href="#" onclick="changePageno('+i+')">'+i+'</a></li>';	
            					} else {
            						pageContent = pageContent + '<li><a href="#" onclick="changePageno('+i+')">'+i+'</a></li>';
            					}
            				}
            				if ( pageObj.pageno != pageObj.totalno ) {
            					pageContent = pageContent + '<li><a href="#" onclick="changePageno('+(pageObj.pageno+1)+')">下一页</a></li>';
            				}
            				
            				$(".pagination").html(pageContent);
            				
            				$("tbody").html(content);
            			} else {
            				layer.msg("审核任务分页查询数据失败", {time:1000, icon:5, shift:6});
            			}
            		}
            	});
            }
            
        </script>
  </body>
</html>
