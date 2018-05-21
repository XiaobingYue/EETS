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
    <style type="text/css">
        a { color:#555}
        html { height: 100%; width: 100%; background: url(img/bj.png) repeat; }
        body {margin: 0px auto;}
        .cw404 { width:755px; margin: 0px auto; }
        .cw404_nr { height: 284px; width: 750px; background: #e5e5e5; border: 1px solid #aaaaaa; margin: 0px auto; }
        .cw404_top { height: 200px; width: 750px; margin: 0px auto; }
        .top_left { float: left; height: 150px; width: 150px; }
        .top_right { font-size: 100px; line-height: 150px; text-align: center; float: left; height: 150px; width: 600px; color: #3f8bc7; font-family: "微软雅黑"; font-weight: bold; }
        .nr_top { font-size: 25px; line-height: 40px; height: 40px; margin-right: 5px; margin-left: 5px; border-bottom: 1px solid #aaaaaa; text-align: center; font-weight: bold; color: #555555; }
        .nr_min { height: 200px; border-top: 1px solid #FFFFFF; margin-right: 5px; margin-left: 5px; border-bottom: 1px solid #aaaaaa; }
        .nr_foot { font-size: 12px; line-height: 40px; background: #eaeaea; height: 40px; border-top: 1px solid #FFFFFF; color: #555; margin-right: 5px; margin-left: 5px; }
        .min_top { font-size: 14px; line-height: 30px; height: 30px; }
        .min_choose { height: 30px; width: 100px; border: 1px solid #aaa; font-size: 12px; line-height: 30px; text-align: center; background: #eaeaea; }
        .else { height: 30px;  }
        .else li{ width:100px; float:left; margin-left:10px; font-size:12px; line-height:30px; display:inline}
        a:link { text-decoration: none; }
        a:visited { text-decoration: none; }
        a:hover { text-decoration: none; }
        a:active { text-decoration: none; }
    </style>
<body>
<div class="cw404">
    <div class="cw404_top">
        <div class="top_left"><img src="img/cw4.png"></div>

        <div class="top_right">ERROR</div>
    </div>
    <div class="cw404_nr">
        <div class="nr_top">Ooops:the pcman has eaten this page</div>

        <div class="nr_min">
            <div class="min_top">You can choose:</div>

            <div class="min_choose"><a href="${APP_PATH}/toMain.do">返回首页</a></div>
            <br>
            <div class="min_choose"><a href="#" onclick="javascript:history.back(-1);">返回上一页</a></div>
        </div>
    </div>
</div>
</body>
</html>

