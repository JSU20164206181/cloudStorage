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

<link rel="stylesheet" href="web/layui/css/layui.css">
<style>
body {
	background-image: url(web/images/bg.jpg);
}

.nav {
	width: 100%;
	height: 80px;
	box-shadow: 0 3px 3px 0 #CCC;
	background: #FFF;
	position: fixed;
	left: 0;
	top: 0;
	z-index: 999;
	overflow: hidden;
	transition: 0.3s
}

.nav.index {
	background: rgba(255, 255, 255, 0.4);
	box-shadow: 0 0 0 0 rgba(0, 0, 0, 0.15);
}

.nav .nav-logo {
	height: 100%;
	position: absolute;
	top: 0;
	left: 15px;
	line-height: 80px;
}
</style>


</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<jsp:include page="user-head.jsp"></jsp:include>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="mainContent" style="padding: 15px;">
				<!-- nav部分 -->
				<div class="nav index">
					<div class="layui-container">
						<div class="nav-logo">
							<a href="web/jsp/registerAndLogin.jsp"> <img
								src="web/images/logo_login.png" alt="网易云盘" width="40%">
							</a>
						</div>
					</div>
				</div>
				<div id="loginDiv" class="layui-fluid"
					style="width: 40%; margin-top: 139.5px;" align="center">
					<div class="layui-card"
						style="background-color: rgba(255, 255, 255, 0.98)">
						<div class="layui-card-header">

							<img src="web/images/logo_login.png" alt="login"
								style="width: 40%;" />
						</div>

						<div class="layui-card-body">
							<div class="layui-tab layui-tab-brief">
								<ul class="layui-tab-title">
									<li class="layui-this">手机激活</li>
								</ul>
								<div class="layui-tab-content">
									<div class="layui-tab-item layui-show">

										<form id="phoneForm" action="sensitiveUser.action"
											method="post" onsubmit="return test()" class="layui-form">
											<div class="layui-form-item">
												<label class="layui-form-label">手机</label>
												<div class="layui-input-inline">
													<input type="text" name="personPhone" lay-verify="email"
														id="phone" placeholder="请输入手机号码" autocomplete="off"
														class="layui-input" required="required"
														placeholder="请填写电话号码"
														pattern="^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))[0-9]{8}$"
														maxlength="11" />
												</div>
											</div>
											<div class="layui-form-item">
												<label class="layui-form-label">手机验证码</label>
												<div class="layui-input-inline">
													<input id="phoneCode" type="text" name="emailCode"
														lay-verify="required" placeholder="请输入手机验证码"
														autocomplete="off" class="layui-input" /> <input
														value="xx" id="hiddenCode" type="hidden" />
												</div>
												<a href="javaScript:sendPhone()" id="send-email-code"
													class="layui-btn layui-btn-danger ">获取</a>
											</div>
											<div class="layui-form-item">
												<span id="emailTip"></span>
											</div>

											<div class="layui-form-item" align="center">
												<div id="login_loading"></div>
												<a href="web/jsp/registerAndLogin.jsp"
													style="color: #5ba878; margin-right: 130px; text-decoration: underline">返回账户登录</a>
												<!-- <a id="submit-email-code" href="#"
                                   class="layui-btn layui-btn-lg layui-btn-normal" style="margin-right: 150px">登录</a> -->
												<input type="submit" value="激活" style="margin-right: 150px"
													class="layui-btn layui-btn-lg layui-btn-normal" />

											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<div class="layui-footer" align="center">
			<!-- 底部固定区域 -->
		</div>
	</div>
</body>
<script>
	layui.use('element', function() {
		var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

		//监听导航点击
		element.on('nav(test)', function(elem) {
			alert(elem);
			layer.msg(elem.text());
		});
	});
</script>

<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>
<script>
	layui.use([ 'form', 'jquery' ], function() {
		var form = layui.form, $ = layui.$;
	});

	function sendPhone() {

		var telephone = $("#phone").val();
		if (telephone
				.match("^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))[0-9]{8}$") == null) {
			layer.tips("格式输入错误!", "#phone", {
				tips : [ 2, "#FF0000" ],
				time : 2000
			});
		} else {
			$("#send-email-code").html("已发送");
			$.ajax({
				type : "post",
				url : "sendPhone.action?telephone=" + telephone,
				success : function(data) {
					$("#hiddenCode").val(data);
				},
				error : function(data) {
					alert(data);
				},
			});
		}
	}

	function test() {
		var phoneCode = $("#phoneCode").val();
		var hiddenCode = $("#hiddenCode").val();

		if (phoneCode == hiddenCode) {
			return true;
		} else {
			layer.tips("请输入验证码!", "#phoneCode", {
				tips : [ 2, "#FF0000" ],
				time : 2000
			});
			return false;
		}
	}
</script>
</html>