<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<base href="<%=basePath%>">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>云盘登录</title>
<link rel="stylesheet" href="web/layui/css/layui.css">
<style>
body {
    background-size:100%;
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

<body class="layui-bg-gray">
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

				<img src="web/images/logo_login.png" alt="login" style="width: 40%;" />
			</div>

			<div class="layui-card-body">
				<div class="layui-tab layui-tab-brief">
					<ul class="layui-tab-title">
						<li class="layui-this">邮箱快速登录</li>
					</ul>
					<div class="layui-tab-content">
						<div class="layui-tab-item layui-show">

							<form onsubmit="return check()" class="layui-form"
								action="tologin.action" method="post">
								<div class="layui-form-item">
									<label class="layui-form-label">邮箱</label>
									<div class="layui-input-inline">
										<input type="email" id="personEamil" name="email"
											lay-verify="email" placeholder="请输入邮箱" autocomplete="off"
											class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">邮箱验证码</label>
									<div class="layui-input-inline">
										<input id="emailCode" type="text" name="emailCode"
											lay-verify="required" placeholder="请输入邮箱验证码"
											autocomplete="off" class="layui-input" />

									</div>

									<a href="javaScript:;" onclick="getEamil()" id="send-email"
										class="layui-btn layui-btn-danger ">获取验证码</a>
								</div>
								<div class="layui-form-item">
									<span id="emailTip"></span>
								</div>

								<div class="layui-form-item" align="center">
									<div id="login_loading"></div>
									<a href="web/jsp/login.jsp"
										style="color: #5ba878; margin-right: 130px; text-decoration: underline">返回账户登录</a>
									<!--  <a id="submit-email-code" href="#"
                                   class="layui-btn layui-btn-lg layui-btn-normal" style="margin-right: 150px">登录</a> -->
									<input id="submit-email-code"
										class="layui-btn layui-btn-lg layui-btn-normal"
										style="margin-right: 150px" value="登录" type="submit"
										id="send-email-code" class="layui-btn layui-btn-danger " />
								</div>
							</form>
						</div>
					</div>
				</div>
				<input type="hidden" value="dsad" id="ajaxEmailCode">
			</div>
		</div>
	</div>

</body>
<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>
<script>
	layui.use([ 'form', 'jquery' ], function() {
		var form = layui.form, $ = layui.$;
	});
	//倒计时总时间
	var countdown = 60;
	//获取验证码的按钮
	var btn = $("#send-email");
	//获取验证码的时候 判断邮箱是否为空
	function getEamil() {
		var personEamil = $("#personEamil").val();
		var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
		if (personEamil == ""||!reg.test(personEamil)) {
			layer.tips("邮箱不能为空或者格式错误!", "#personEamil", {
				tips : [ 1, "#FF0000" ],
				time : 2000
			});
		} 
		else {
			//获取验证码
			 $.ajax({
				 type: "post",
				 url: "getEmail.action?personEamil="+personEamil,
				 success: function(data) {
					 //保存验证码到这个隐藏域里面
					$("#ajaxEmailCode").val(data);
				   },
				
			 }); 
			//定时器倒计时
			var timer = setInterval(function(){
				btn.html("重新发送(" + countdown + ")");
				countdown--;
 				if (countdown == 0) {
 					//清空存放的验证码
					$("#ajaxEmailCode").val("");
					btn.html("获取验证码");
					clearInterval(timer);
				}
			}, 1000);
			
			countdown = 60;
		}
	}

	

	//邮箱登录表单的验证
	function check() {
		var yzm = $("#ajaxEmailCode").val();
		var emailCode = $("#emailCode").val();
		var personEamil = $("#personEamil").val();
		if (yzm == emailCode && personEamil != "") {
			return true;
		}
		else if(yzm != emailCode){
			layer.tips("验证码错误 请检查!", "#emailCode", {
				tips : [ 1, "#FF0000" ],
				time : 2000
			});
			return false;
		}
		
	}
</script>

</html>
