<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet"
          href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${APP_PATH}/bootstrap/css/fileinput.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <link rel="stylesheet"
          href="${APP_PATH}/bootstrap/css/bootstrapValidator.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }
        ::-webkit-scrollbar{
            display:none;
        }
    </style>
</head>

<body>
<%@include file="/WEB-INF/jsp/common/userinfo.jsp" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="${APP_PATH}/toMain.do">首页</a></li>
                <li><a href="${APP_PATH}/userController/toUserList.do">数据列表</a></li>
                <li class="active">批量导入</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <button type="button" id="saveBtn"
                            style="margin-left:10px;margin-bottom:10px;" class="btn btn-danger">
                        <i class="glyphicon glyphicon-download-alt"></i> 下载模板
                    </button>
                </div>
                <div class="panel-body">
                    <form id="userForm"
                          action="${APP_PATH}/userController/importUser.do" enctype="multipart/form-data" method="post"
                          role="form">
                        <table id="usertable" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <td><input id="file" type="file" name="file" class="file"></td>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                           <%-- <button type="button" id="insertBtn"
                                    style="margin-bottom: 10px;" class="btn btn-success">
                                <i class="glyphicon glyphicon-plus"></i> 开始导入
                            </button>
                            <button type="button" id="saveBtn"
                                    style="margin-left:10px;margin-bottom:10px;" class="btn btn-danger">
                                <i class="glyphicon glyphicon-download-alt"></i> 下载模板
                            </button>--%>
                            </tfoot>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
        </div>
        -->
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-3.1.0.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/fileinput.js"></script>
<script src="${APP_PATH}/bootstrap/js/zh.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.form.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    initUpload("file", '${APP_PATH}/userController/importUser.do');
    function initUpload(ctrlName, uploadUrl) {
        var control = $('#' + ctrlName);
        control.fileinput({
            language: 'zh', //设置语言
            uploadUrl: uploadUrl, //上传的地址
            uploadAsync: true, //默认异步上传
            showCaption: true,//是否显示标题
            showUpload: true, //是否显示上传按钮
            textEncoding:'UTF-8',
            browseClass: "btn btn-primary", //按钮样式
            allowedFileExtensions: ["xls", "xlsx"], //接收的文件后缀
            //maxFileCount: 1,//最大上传文件数限制
            previewFileIcon: '<i class="glyphicon glyphicon-file"></i>',
            showPreview: true, //是否显示预览
            previewFileIconSettings: {
                'docx': '<i ass="fa fa-file-word-o text-primary"></i>',
                'xlsx': '<i class="fa fa-file-excel-o text-success"></i>',
                'xls': '<i class="fa fa-file-excel-o text-success"></i>',
                'pptx': '<i class="fa fa-file-powerpoint-o text-danger"></i>',
                'jpg': '<i class="fa fa-file-photo-o text-warning"></i>',
                'pdf': '<i class="fa fa-file-archive-o text-muted"></i>',
                'zip': '<i class="fa fa-file-archive-o text-muted"></i>',
            },
            uploadExtraData: function () {
                var extraValue = "test";
                return {"excelType": extraValue};
            }
        });
    }
    $("#file").on("fileuploaded", function (event, data, previewId, index) {
        console.log(data);
        if(data.response.success == true)
        {
            layer.msg(data.files[index].name + "上传成功!", {time: 2000, icon: 6, shift: 6}, function () {
            });
            window.location.href = "${APP_PATH}/userController/toUserList.do"
            //$(".close").click();
        }else{
            layer.msg(data.files[index].name + "上传失败!", {time: 2000, icon: 5, shift: 6}, function () {
            });
            //重置
            $("#file").fileinput("clear");
            $("#file").fileinput("reset");
            $('#file').fileinput('refresh');
            $('#file').fileinput('enable');
        }
    });

    $("#file").on("filebatchselected", function(event, files) {
        console.info(files)
    });

    $("#saveBtn").click(function () {
        window.location.href = "${APP_PATH}/downloadController/download.do?filename=tmp_imp_user.xlsx";
    });
</script>
</body>
</html>
