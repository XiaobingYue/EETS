<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        .tree-closed {
            height: 40px;
        }

        .tree-expanded {
            height: auto;
        }

        ::-webkit-scrollbar {
            display: none;
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
            <h1 class="page-header">主页</h1>
            <div class="row placeholders">
                <c:if test="${not empty myTaskCount}">
                    <div class="col-xs-6 col-sm-3 placeholder">
                        <img data-src="holder.js/50x50?theme=sky&text=${myTaskCount}" class="img-responsive" style="cursor:pointer;"
                             alt="Generic placeholder thumbnail"
                             onclick="window.location.href='${APP_PATH}/teachTaskController/toMyTask.do'">
                        <h6>My Task</h6>
                    </div>
                </c:if>
                <div class="col-xs-6 col-sm-3 placeholder">
                    <img data-src="holder.js/50x50?theme=vine" class="img-responsive"
                         alt="Generic placeholder thumbnail">
                    <h6>Label</h6>
                </div>
                <div class="col-xs-6 col-sm-3 placeholder">
                    <img data-src="holder.js/50x50?theme=sky" class="img-responsive"
                         alt="Generic placeholder thumbnail">
                    <h6>Label</h6>
                </div>
                <div class="col-xs-6 col-sm-3 placeholder">
                    <img data-src="holder.js/50x50?theme=vine" class="img-responsive"
                         alt="Generic placeholder thumbnail">
                    <h6>Label</h6>
                </div>
            </div>
            <hr>
            <div class="col-sm-9 col-md-9 column">
                <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                    <b>
                        最近登录统计
                    </b>
                </blockquote>
                <div id="main3" style="width: 100%;height:400px;"></div>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/js/holder.js"></script>
<script src="${APP_PATH}/script/echarts.js"></script>
<script type="text/javascript">
    $(function () {
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
    var myChart = echarts.init(document.getElementById('main3'));
    // 指定图表的配置项和数据
    option = {
        title: {
            text: '最近登录统计(人)'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data:[]
        },
        toolbox: {
            show: true,
            feature: {
                dataZoom: {
                    yAxisIndex: 'none'
                },
                dataView: {readOnly: false},
                magicType: {type: ['line', 'bar']},
                restore: {},
                saveAsImage: {}
            }
        },
        xAxis:  {
            type: 'category',
            boundaryGap: false,
            data: []
        },
        yAxis: {
            type: 'value',
            axisLabel: {
                formatter: '{value} '
            }
        },
        series: []
    };

    jQuery.ajax({
        url:"${APP_PATH}/userController/recentLogin.do",
        type:'get',
        dataType:'json',
        success:function(jsons){
            var legends = [];
            var Series = [];
            var json = jsons.data;
                var it = {
                    name: '基金',
                    type: 'line',
                    data: [],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'}
                        ]
                    }
                };
                it.name = json.name;
                legends.push(json.name);
                it.data = json.data;
                Series.push(it);

            option.xAxis.data = jsons.xContent;
            option.legend.data = legends;
            option.series = Series; // 设置图表
            myChart.setOption(option);// 重新加载图表
        },
        error:function(){
            alert("数据加载失败！请检查数据链接是否正确");
        }
    });
    myChart.setOption(option);
    /*var myChart1 = echarts.init(document.getElementById('main1'));

    // 指定图表的配置项和数据
    option1 = {
        color: ['#3398DB'],
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['基金', '票据', '定期理财', '变现贷'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'直接访问',
                type:'bar',
                barWidth: '60%',
                data:[10, 52, 200, 334, 390, 330, 220]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart1.setOption(option1);

    var myChart2 = echarts.init(document.getElementById('main2'));

    // 指定图表的配置项和数据
    option2 = {
        title : {
            text: '某站点用户访问来源',
            subtext: '纯属虚构',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
        },
        series : [
            {
                name: '访问来源',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    {value:335, name:'直接访问'},
                    {value:310, name:'邮件营销'},
                    {value:234, name:'联盟广告'},
                    {value:135, name:'视频广告'},
                    {value:1548, name:'搜索引擎'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart2.setOption(option2);*/
</script>
</body>
</html>
