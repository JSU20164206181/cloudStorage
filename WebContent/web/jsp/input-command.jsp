<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<% 
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<title>验证提取码</title>
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/javascript" src="web/js/jquery.min.js"> </script> 
<script type="text/javascript"  src="web/layui/layui.all.js" ></script>
<script type="text/javascript"  src="web/layui/layui.js" ></script> 
<script type="text/javascript"  src="web/layui/lay/modules/laypage.js" ></script> 
</head>
<style>
        html,body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .content {
            width: 300px;
            height: 300px;
            margin: 0 auto; /*水平居中*/
            position: relative;
            top: 50%; /*偏移*/
            transform: translateY(-50%);
        }
        span{
        font-size: 20px;
        }
</style>
<body>
<div class="content">
<img alt="" src="web/images/logo.png">
<div style="margin-top: 30px;margin-left:30px;">
<span class="verify-property"><strong style="color: #4F94CD;">${share.userName }</strong>&nbsp;给您加密分享了文件</span>
<br>
<br>
<span>请输入提取码：</span><br>
<input id="command" style="padding: 5px 0px;">
<input type="button" class="layui-btn layui-btn-danger" onclick="extractFile()" value="提取文件">
</div>
</div>
<script type="text/javascript">
function extractFile(){
	var command=$("#command").val();
	var shareCommand='${share.shareCommand}';
	console.log(command);
	console.log(shareCommand);
	if(command!=shareCommand){
		layer.msg("提取码错误", {icon : 1,time : 1000});
	}else{
		var url='${share.shareUrl}';
		window.location.href="viewShare.action?url="+url+"&status=1";
	}
}
</script>
</body>
</html>