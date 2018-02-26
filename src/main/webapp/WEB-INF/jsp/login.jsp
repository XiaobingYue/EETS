<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">工程教育教学系统</a></div>
        </div>
      </div>
    </nav>

    <div class="container">
      <h1>${errorMsg}</h1>
      <form id="loginForm" action="${APP_PATH}/dologin.htm" method="post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-picture"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="username" name="username" value="lisi" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="password" name="password" value="123123" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select id="usertype" class="form-control" >
                <option value="member" >会员</option>
                <option value="user" selected>管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="reg.html">我要注册</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/script/layer/layer.js"></script>
    <script>
    function dologin() {
        var loginacct = $("#username");
        if ( loginacct.val() == "" ) {
            //alert("登陆账号不能为空，请输入");
            layer.msg("登陆账号不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
                // 设定页面焦点
                loginacct.focus();
            });
            return;
        }
        var userpswd = $("#password");
        if ( userpswd.val() == "" ) {
            //alert("登陆密码不能为空，请输入");
            layer.msg("登陆密码不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
                userpswd.focus();
            });
            return;
        }
        // 使用AJAX线程提交数据
        //$.post, $.get, $.ajax
        //function Student() {}
        // JS运行给对象添加的属性
        //var student = new Student();
        //student.name = "zhangsan";

        // {} ==> 声明对象
        // JavaScriptObjectNotation对象
        // [{ 属性名称:属性值, 属性名称1:属性值1 }]
        // JSON字符串
        // "{'username':'zhangsan', 'sex':'男'}"

        // JS : 全局变量，局部变量(var)
        var url = "loginController/login.do";
        var jsonData = {
            "username" : loginacct.val(),
            "password"  : userpswd.val()
        };
        /* if ( $("#usertype").val() == "member" ) {
            url = "doMemberLogin.do";
            jsonData.memberpswd = userpswd.val();
        } */

        var loadingIndex = -1;
        $.ajax({
            url : "${APP_PATH}/"+url,
            type : "POST",
            //dataType : "json",
            data : jsonData,
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
                //loadingIndex = layer.load(2, {time: 10*1000});
            },
            success : function(result) {
                layer.close(loadingIndex);
                //console.log(result);
                // 200
                // 从后台获取返回的结果
                if (result.success) {
                    window.location.href = "${APP_PATH}/toIndex.do";
                    //}
                } else {
                    //alert("用户账户或密码输入不正确，登陆失败");
                    layer.msg("用户账户或密码输入不正确，登陆失败", {time:2000, icon:5, shift:6}, function(){
                        // 设定页面焦点
                        loginacct.focus();
                    });
                }
            },
            error : function() {
                // 404， 500
                //alert("用户登陆失败");
                layer.msg("用户登陆失败", {time:2000, icon:5, shift:6}, function(){
                    // 设定页面焦点
                    loginacct.focus();
                });
            }
        });
    }
    </script>
  </body>
</html>