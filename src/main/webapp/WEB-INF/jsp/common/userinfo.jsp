<%@page pageEncoding="UTF-8" %>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">工程教育教学系统</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li style="padding-top:8px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-success dropdown-toggle"
                                data-toggle="dropdown">
                            <i class="glyphicon glyphicon-user"></i> ${userInfo.name} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="" data-toggle="modal" data-target="#myModal111"><i class="glyphicon glyphicon-cog"></i> 修改密码</a></li>
                            <li class="divider"></li>
                            <li><a href="${APP_PATH}/userController/logout.do"><i class="glyphicon glyphicon-off"></i>
                                退出系统</a></li>
                        </ul>
                    </div>
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

<div class="modal fade" id="myModal111" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <form id="ClassesForm" role="form">
                    <div class="form-group">
                        <label>原密码</label>
                        <input type="password" class="form-control" id="oldPassWord"
                               placeholder="请输入原密码">
                    </div>
                    <div class="form-group">
                        <label>新密码</label>
                        <input type="password" class="form-control" id="newPassword"
                               placeholder="请输入新密码">
                    </div>
                    <div class="form-group">
                        <label>请再次输入新密码</label>
                        <input type="password" class="form-control" id="newPassword1"
                               placeholder="请再次输入新密码">
                    </div>
                    <button id="saveBtn1" type="button" class="btn btn-success"><i
                            class="glyphicon glyphicon-pencil"></i> 保存
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script type="application/javascript">
    $("#saveBtn1").click(function () {
        var oldPwd = $("#oldPassWord").val();
        var newPwd = $("#newPassword").val();
        var newPwds = $("#newPassword1").val();
        if(oldPwd != "" && newPwd != "" && newPwds != "" && newPwd == newPwds) {
            $.ajax({
                url: "${APP_PATH}/userController/changePwd.do",
                type: "POST",
                data: {
                    "oldPwd": oldPwd,
                    "newPwd":newPwd,
                    "newPwds":newPwds
                },
                success: function (result) {
                    if (result.success) {
                        layer.msg("修改成功", {time: 1000, icon: 6}, function () {
                            window.location.href = "${APP_PATH}/userController/logout.do";
                        });
                    } else {
                        layer.msg(result.data, {time: 1000, icon: 5, shift: 6});
                    }
                }
            });
        } else {
            layer.msg("请检查输入是否正确", {time: 1000, icon: 5, shift: 6});
        }
    })
</script>