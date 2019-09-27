<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
/*滑动效果*/
#loginDiv {
	transition: all 0.6s ease-in;
}

#loginDiv:target {
	top: 50px;
}

.layui-footer {
	left: 0px;
	position: fixed;
	width: 100%;
	height: 100px;
	color: #555;
	text-align: center;
	font-size: 16px;
	font-weight: bold;
	bottom: 0px;
}
</style>
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/ecmascript" src="web/js/sha1/sha1.js"></script>
<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>
<script>
       
        //注册验证
        function registerValidate(){
        	
            var uname = $("#re_uname").val();
            if (uname.length == 0||uname.indexOf(" ")!=-1||uname.length<6) {
                layer.tips("用户名格式错误!", "#re_uname", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            var upwd = $("#re_upwd").val();
            if (upwd.length == 0) {
                layer.tips("密码不能为空!", "#re_upwd", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            if (upwd.length < 6 || upwd.length > 10) {
                layer.tips("请输入6~10位密码!", "#re_upwd", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            var rupwd = $("#re_rupwd").val();
            if (rupwd.length == 0) {
                layer.tips("确认密码不能为空!", "#re_rupwd", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            if (upwd != rupwd) {
                layer.tips("密码输入不一致!", "#re_rupwd", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
           
        }
      

        // 捕捉回车键
        document.onkeydown = function () {
            //先判断是否是登录
            if (window.event.keyCode == 13) {
                var btn_type = $(".layui-this").html();
                // alert(btn_type);
                if (btn_type == "账户登录") {
                    loginValidate();
                } else {
                    registerValidate();
                }
            }
        }
    </script>

</head>
<body class="layui-bg-gray">
	<!-- nav部分 -->
	<div class="nav index">
		<div class="layui-container">
			<div class="nav-logo">
				<a href="front_page/html/index.html"> <img
					src="web/images/logo_login.png" alt="我的网盘"
					style="opacity: 0.4; width: 360px;">
				</a>
			</div>
		</div>
	</div>
     
    
     
     
	<div id="loginDiv" class="layui-fluid" style="width: 40%;"
		align="center">
		<div class="layui-card"
			style="background-color: rgba(255, 255, 255, 0.98)">
			<div class="layui-card-header">

				<img src="web/images/logo_login.png" alt="login" style="width: 40%;" />
			</div>

			<div class="layui-card-body">
				<div class="layui-tab layui-tab-brief">
					<ul class="layui-tab-title">
						<li><a href="web/jsp/login.jsp">账户登录</a></li>
						<li class="layui-this">注册用户</li>
					</ul>
					<div class="layui-tab-content">				
						<div class="layui-tab-item layui-show">
							<!-- 注册的表单 -->
							<form id="registerForm" method="post" class="layui-form" 
							action="addUser.action" onsubmit="return registerValidate()">
								<div class="layui-form-item">
									<label class="layui-form-label">用户名</label>
									<div class="layui-input-block">
										<input id="re_uname" name="userName" type="text"
											class="layui-input" placeholder="请输入用户名" />
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">密码</label>
									<div class="layui-input-block">
										<input id="re_upwd" name="userPassword" type="password"
											class="layui-input" placeholder="请输入6~10位的密码" />
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">确认密码</label>
									<div class="layui-input-block">
										<input id="re_rupwd" type="password" class="layui-input"
											placeholder="请输入确认密码" />
									</div>
								</div>
								
								

								<div class="layui-form-item" align="center">
									<div id="register_loading"></div>
									<input type="submit" value="注册"
										class="layui-btn layui-btn-lg layui-btn-normal"
										style="margin-right: 100px" />
								</div>
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



</body>


<script type="text/javascript" src="web/layui/layui.all.js"></script>

<script type="text/javascript">
    
    /*设置登录窗口垂直居中*/
    $(function () {
        var height = document.body.scrollHeight;
        var logo_wrap = $("#loginDiv").get(0);
        var margin_top = (height - 150) / 2;
        logo_wrap.style.marginTop = margin_top + "px";
    });
    
    
    //判断用户名是否可以注册
	   $("#re_uname").blur(function(){
		
		//获取 输入的用户名
	   var  userName =	$("#re_uname").val();
	  
	   if (userName.length == 0||userName.indexOf(" ")!=-1||userName.length<6) {
		   
        layer.tips("用户名格式错误!", "#re_uname", {
     	   
            tips: [2, "#FF0000"],
            time: 2000
        });
       
    }	
	   else{
		
	  	$.ajax({
		 type: "post",	
		 url: "judgeUser.action?userName="+userName,
		 success: function(data) {
			
			if(userName==data){
				$("#re_uname").val("");
				layer.tips("用户名已存在!", "#re_uname", {
                 tips: [2, "#FF0000"],
                 time: 2000
             });
			}
			else if(data="账号可以使用"){
				layer.tips("账号可以使用!", "#re_uname", {
                 tips: [2, "#00FFFF"],
                 time: 2000
              });
			  }
		   },
		
	     });  	
	  	
	   }
	  	
	 });
	  


    
</script>

</html>