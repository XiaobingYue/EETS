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
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 流程定义维护</a></div>
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
  <button type="button" class="btn btn-warning" onclick="queryUser()"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button id="uploadBtn" type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-upload"></i> 上传流程定义文件</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" onclick="allSel(this)"></th>
                  <th>流程名称</th>
                  <th>流程标识</th>
                  <th>流程版本号</th>
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
    <form id="procDefForm" method="post" enctype="multipart/form-data" action="${APP_PATH}/manager/process/uploadFile.do">
        <input type="file" style="display:none;" id="fprocDefFile" name="procDefFile">
    </form>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/layer/layer.js"></script>
	<script src="${APP_PATH}/jquery/jquery.form.js"></script>
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
            	// 使用AJAX异步分页查询流程定义数据
            	
            	var obj = {
           			"pageno" : pageno,
           			"pagesize" : 10
            	};
            	if ( cond ) {
            		// 增加模糊查询参数
            		obj.pagetext = $("#queryText").val();
            	}
            	
            	$.ajax({
            		url : "${APP_PATH}/manager/process/pageQuery.do",
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
            				var procDefList = pageObj.datas;
            				
            				var content = "";
            				$.each(procDefList, function(i, procDef){
             				   content = content +  '<tr>';
          	                   content = content +  '  <td>'+(i+1)+'</td>';
          					   content = content +  '  <td><input type="checkbox" value="'+procDef.id+'"></td>';
          	                   content = content +  '  <td>'+procDef.name+'</td>';
          	                   content = content +  '  <td>'+procDef.key+'</td>';
          	                   content = content +  '  <td>'+procDef.version+'</td>';
          	                   content = content +  '  <td>';
          					   content = content +  '      <button type="button" onclick="window.location.href=\'${APP_PATH}/manager/process/view.htm?id='+procDef.id+'\'"class="btn btn-success btn-xs"><i class="glyphicon glyphicon-search"></i></button>';
          					   content = content +  '	   <button type="button" onclick="deleteProcess(\''+procDef.deployid+'\', \''+procDef.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
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
            				layer.msg("流程定义分页查询数据失败", {time:1000, icon:5, shift:6});
            			}
            		}
            	});
            }
            var cond = false;
            function queryUser() {
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
            
            function deleteProcess(id, name) {
    			layer.confirm("删除流程定义: "+name+", 是否继续？",  {icon: 3, title:'提示'}, function(cindex){
    				// 删除数据
    				$.ajax({
    					url : "${APP_PATH}/manager/process/delete.do",
    					type : "POST",
    					data  : {
    						id : id
    					},
    					success : function(result) {
    						if ( result.success ) {
                				layer.msg("流程定义信息删除成功", {time:1000, icon:6}, function(){
                					pageQuery(1);
                				});
    						} else {
    							layer.msg("流程定义信息删除失败", {time:1000, icon:5, shift:6});
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
            
            function deleteUsers() {
            	var checkBox = $("tbody :checked");
            	if ( checkBox.length == 0 ) {
            		layer.msg("请选择需要删除的流程定义数据", {time:1000, icon:5, shift:6});
            	} else {
        			layer.confirm("删除选择的流程定义数据, 是否继续？",  {icon: 3, title:'提示'}, function(cindex){
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
                    				layer.msg("流程定义信息删除成功", {time:1000, icon:6}, function(){
                    					pageQuery(1);
                    				});
        						} else {
        							layer.msg("流程定义信息删除失败", {time:1000, icon:5, shift:6});
        						}
        					}
        				});
        			    layer.close(cindex);
        			}, function(cindex){
        			    layer.close(cindex);
        			});
            	}
            }
            
            // $("#username").val();
            // $("#username").val("zhangsan");
            
            $("#uploadBtn").click(function(){
            	$("#fprocDefFile").click();
            });
            
            $("#fprocDefFile").change(function(){
            	
            	// 文件上传
            	var loadingIndex = -1;
        		$("#procDefForm").ajaxSubmit({
        			beforeSubmit : function() {
        				loadingIndex = layer.load(2, {time: 10*1000});
        			},
        			resetForm: true,
        			success : function (result) {
        				layer.close(loadingIndex);
        				if ( result.success ) {
        		    		layer.msg("流程定义文件上传成功", {time:1000, icon:6}, function(){
        		    			pageQuery(1);
        		    		});
        				} else {
        		    		layer.msg("流程定义文件上传失败", {time:1000, icon:5, shift:6});
        				}
        			}
        		});
            });
        </script>
  </body>
</html>
