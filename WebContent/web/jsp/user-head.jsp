<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<base href="<%=basePath%>">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>阿里云盘</title>
<link rel="stylesheet" href="web/layui/css/layui.css">

<style type="text/css"> 
 .pathHerf:link ,.pathHerf:visited ,.pathHerf:hover ,.pathHerf:active{  
    text-decoration:none; 
	color:#3cb7ef;
	} 
	.pathHerf{	
	margin-right:5px;  
	}
progress {
	width: 168px;
	height: 5px;
	color: #f00;
	background: #EFEFF4;
	border-radius: 0.1rem;
}
/* 表示总长度背景色 */
progress::-webkit-progress-bar {
	background-color: #f2f2f2;
	border-radius: 0.2rem;
}
/* 表示已完成进度背景色 */
progress::-webkit-progress-value {
	background: #5FB878;
	border-radius: 0.2rem;
}
 .pathHerf:link ,.pathHerf:visited ,.pathHerf:hover ,.pathHerf:active{  
    text-decoration:none; 
	color:#3cb7ef;
	} 
	.pathHerf{	
	margin-right:5px;  
	}
</style>
<!-- 防止搜索框样式被覆盖 -->
<style type="text/css">
	.layui-input-block{
		height: 0;
		color: black;
	}
	
</style>
<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	 
	$.ajax({
		 type: "post",	
		 url: "findAllFile.action",
		 
		 success: function(data) {
				$("#usedSize").html(data);
		 },
	  });  	
	
});
function uploadUserFile() {		     
	   window.location.href="web/jsp/fileUpload.jsp";
	 		           
} 
function fileManager() {		     
	   window.location.href="toFileList.action";
	 		           
}  
	function exit() {
		layer.confirm("确认要真的退出系统么？", {
			title : "确认提示",
			btn : [ '残忍离开', '继续使用' ]
		
		},
		function(index) {
			  $.ajax({
				type : "post",
				url : "logout.action",
				success : function(data) {
				window.location.href = "web/jsp/login.jsp";
				},
			});  
		});
		
	}

	/* function sousou() {
		var searchInput = $("#searchInput").val();
		sessionStorage.setItem("searchInput", searchInput);
		sessionStorage.setItem("fileType", null);
		sessionStorage.setItem("isShare", null);
		$("#mainContent").load("searchResult.html");
	}
 */  
     function openAdminIndex(){
	     
	   window.location.href="web/jsp/index.jsp";
	 
      } 
 function fuzzyFind() {
		var content=$("#content").val();
		var userId=${cookie.userId.value};
		window.location.href = "fuzzyFindMyFiles.action?content="+content+"&userId="+userId;
	}

		layui.use('element', function() {
			var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

			//监听导航点击
			element.on('nav(test)', function(elem) {
				alert(elem);
				layer.msg(elem.text());
			});
		});
		 
</script>
</head>

<body class="layui-layout-body">
	
		<div class="layui-header">
			<!-- <div class="layui-logo">
				<img src="web/images/logo.png" alt="login" style="width: 100%;" />
				 融创软通网络云盘客户端
			</div> -->
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">

				<li class="layui-nav-item">
					<button class="layui-btn layui-bg-green"
						onclick="fileManager()"
						style="margin-left: 10px">
						<i class="layui-icon layui-icon-template-1"></i> 全部文件
					</button>
				</li>
				<li class="layui-nav-item">
					<button class="layui-btn layui-btn-danger"
						onclick="uploadUserFile()" style="margin-left: 10px">
						<i class="layui-icon layui-icon-upload-drag"></i> 上传文件
					</button> 
					
				</li>

				<li class="layui-nav-item">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li class="layui-nav-item">
				<input id="content" value="${content }" class="layui-input-block" placeholder="搜索文件/文件夹">
					<button id="search_btn" class="layui-btn layui-btn-danger"
						onclick="fuzzyFind(${cookie.userId.value})">
						<i class="layui-icon layui-icon-search"></i>
					</button></li>
				<li class="layui-nav-item">&nbsp;</li>
				
				 <li class="layui-nav-item" style="display: inline-block">
				 <c:choose>
						<c:when test="${sessionScope.userName!=null && sessionScope.userStatus==0 }">
							<c:if test="${sessionScope.member_order==1}">
							<a href="web/jsp/sensitivePerson.jsp">尊敬的普通用户：${sessionScope.userName},您还未激活
								请激活！ </a>
							</c:if>
							<c:if test="${sessionScope.member_order==3}">
							<a href="web/jsp/sensitivePerson.jsp">尊敬的超级会员用户：${sessionScope.userName},您还未激活
								请激活！ </a>
							</c:if>
							
						</c:when>
	
						<c:when test="${sessionScope.userName==null}">
						</c:when>
						
						<c:otherwise>
						    <c:if test="${sessionScope.member_order==1}">
						    <a href="showPerson.action">尊敬的普通用户：${sessionScope.userName},欢迎您 </a>
						    </c:if>
						    
						    <c:if test="${sessionScope.member_order==3}">
							<a href="showPerson.action">尊敬的超级会员用户：${sessionScope.userName},欢迎您</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				 </li>
			</ul>
			
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <img
						id="userPhoto" src="web/images/myphoto.jpg" class="layui-nav-img">
						<span id="loginUserName"></span>
                        <span class="layi-nav-more"></span>
				</a>
					<dl class="layui-nav-child layui-anim layui-anim-upbit">
						<dd>
							<progress value="20" max="120"
								style="width:120px;height:5px;margin-left:10px" />
						</dd>
						<dd>
							<a id="usedSize" href="javaScript:;"><span
								class="layui-icon layui-icon-user"></span>${sessionScope.used_size}/${sessionScope.user_totalSize}</a>
						</dd>
						<dd>
							<a  href="#">超级会员特权：</a>
						</dd> 
                        <dd>
						  <img style="margin-left:13px" title="5T超大内存" src="web/images/icon_5t.png"/>
						  <img title="急速下载" src="web/images/icon_download.png"/>
						  <img title="在线云解压" src="web/images/icon_zip.png"/>
						  <img title="视频高速通道" src="web/images/icon_video.png"/>
						  <img title="查看更多" src="web/images/icon_more.png"/>
						</dd>
						<dd>
							<a  href="buyVip.action">开通超级会员?</a>
						</dd>
                        
						<dd>
							<a href="showPerson.action"><span
								class="layui-icon layui-icon-user"></span> 完善个人信息</a>
						</dd>
						<dd>
							<a href="javaScript:redirectUpdateUpwd()"><span
								class="layui-icon layui-icon-util"></span> 修改密码</a>
						</dd>
						<dd>
							<a href="javaScript:about()"><span
								class="layui-icon layui-icon-util"></span> 关于我们</a>
						</dd>
					</dl>
					  
					</li>

				<li class="layui-nav-item"><a onclick="exit()"
					href="javaScript:;">退出</a></li>
				
			</ul>
			<span class="layui-nav-bar" style="left: 54px; top: 55px; width: 0px; opacity: 0;"></span>
		</div>
		
		<jsp:include page="welcome.jsp"></jsp:include>	
		
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<!--普通用户也有-->
					<li class="layui-nav-item layui-nav-itemed"><a href="toFileList.action">
							 我的文件</a> 
						<dl class="layui-nav-child">
							<dd>
								<a href="showForType.action?type=2"><span
									class="layui-icon layui-icon-video"></span> 视频</a>
							</dd>
							<dd>
								<a href="showForType.action?type=4"><span
									class="layui-icon layui-icon-headset"></span> 音乐</a>
							</dd>
							<dd>
								<a href="showForType.action?type=1"><span 
									class="layui-icon layui-icon-picture"></span> 图片</a>
							</dd>
							<dd>
								<a href="showForType.action?type=3"><span
									class="layui-icon layui-icon-file"></span> 文档</a>
							</dd>
							<dd>
								<a href="showForType.action?type=6"><span 
									class="layui-icon layui-icon-component"></span> 其他</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="findMyShares.action"><span
							class="layui-icon layui-icon-share"></span> 我的共享文件</a>
						
						</li>
					<li class="layui-nav-item layui-nav-itemed"><a href="toRecycle.action"><span
							class="layui-icon layui-icon-delete"></span> 回收站</a> 
						</li>

				</ul>
			</div>
		</div>

</body>
<script>
/* 模糊查找 */
function fuzzyFind(userId) {
	var content=$("#content").val();
	window.location.href = "fuzzyFindMyFiles.action?content="+content+"&userId="+userId;
}
</script>
</html>