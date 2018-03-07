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
    input[type=checkbox] {
        width:18px;
        height:18px;        
    }
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th>名称</th>
				  <th >商业公司</th>
                  <th>个体工商户</th>
                  <th>个人经营</th>
                  <th>政府及非营利组织</th>
                </tr>
              </thead>
              <tbody>
                  <c:forEach items="${certs}" var="cert">
	                <tr >
	                  <th>${cert.name}</th>
					  <th ><input type="checkbox" accttype="0" certid="${cert.id}"></th>
	                  <th><input type="checkbox" accttype="1"  certid="${cert.id}"></th>
	                  <th><input type="checkbox" accttype="2"  certid="${cert.id}"></th>
	                  <th><input type="checkbox" accttype="3"  certid="${cert.id}"></th>
	                </tr>
                  </c:forEach>
              </tbody>
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
            });
            
            $("tbody :checkbox").click(function(){
            	// 获取当前点击复选框的选中状态
            	var flg = this.checked;
            	if ( flg ) {
            		// 建立关系
            		$.ajax({
            			type : "POST",
            			url  : "${APP_PATH}/manager/type/insertAccttypeCert.do",
            			data : {
            				"accttype" : $(this).attr("accttype"),
            				"certid"   : $(this).attr("certid")
            			}
            		});
            	} else {
            		// 取消关系
            		$.ajax({
            			type : "POST",
            			url  : "${APP_PATH}/manager/type/deleteAccttypeCert.do",
            			data : {
            				"accttype" : $(this).attr("accttype"),
            				"certid"   : $(this).attr("certid")
            			}
            		});
            	}
            });
            
            <c:forEach items="${datas}" var="data">
                $("tbody :checkbox[accttype='${data.accttype}'][certid='${data.certid}']")[0].checked = true;
            </c:forEach>
        </script>
  </body>
</html>
