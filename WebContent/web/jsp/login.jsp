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
       
 
      //登录验证
        function loginValidate(){
    	  
            var uname = $("#uname").val();
            if (uname.length == 0||uname.length<6||uname.indexOf(" ")!=-1) {
                layer.tips("用户名格式错误!", "#uname", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            var upwd = $("#upwd").val();
            if (upwd.length == 0) {
                layer.tips("密码不能为空!", "#upwd", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }

            if (upwd.length < 6 || upwd.length > 10) {
                layer.tips("请输入6~10位密码!", "#upwd", {
                    tips: [2, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            var vcode = $("#vcode").val();
            if (vcode.length == 0) {
                layer.tips("验证码不能为空!", "#vcode", {
                    tips: [1, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            if (vcode.length != 4) {
                layer.tips("请输入4位验证码!", "#vcode", {
                    tips: [1, "#FF0000"],
                    time: 2000
                });
                return false;
            }
            if (vcode.toLowerCase() != verVal.toLowerCase()) {
                layer.tips("验证码输入错误!", "#vcode", {
                    tips: [1, "#FF0000"],
                    time: 2000
                });
                return false;
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
     
    
     <c:if test="${sessionScope.error!=null}">
			<script type="text/javascript">
			var a="<%=session.getAttribute("error")%>";
			alert(a);
			</script>
			<%session.removeAttribute("error");%>
	 </c:if>
     
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
						<li class="layui-this">账户登录</li>
						<li><a href="web/jsp/register.jsp">注册用户</a></li>
					</ul>
					<div class="layui-tab-content">
						<div class="layui-tab-item layui-show">
							<!-- 登录的表单 -->
							<form id="loginForm" class="layui-form" action="tologin.action"
								method="post" onsubmit="return loginValidate()">
								<div class="layui-form-item">
									<label class="layui-form-label">用户名</label>
									<div class="layui-input-block">
										<input id="uname" name="userName" type="text"
											class="layui-input" placeholder="请输入用户名" />
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">密码</label>
									<div class="layui-input-block">
										<input id="upwd" name="userPassword" type="password"
											class="layui-input" placeholder="请输入密码" />
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">验证码</label>
									<div class="layui-input-inline">
										<input id="vcode" type="text" class="layui-input"
											placeholder="请输入验证码" />
									</div>
									<a href="javascript:resetCode()"> <canvas width="100"
											height="35" id="verifyCanvas"></canvas> <img id="img_vcode"
										alt="4位验证码"></a>
								</div>
								<div class="layui-form-item">
									<div class="layui-input-block">
										<input type="checkbox" name="remember" title="记住密码"
											checked="checked"> <a href="pages/emailLogin.jsp"
											style="color: #5ba878; margin-right: 130px; text-decoration: underline">忘记密码？</a>
									</div>
								</div>
								<div class="layui-form-item" align="center">
									<div id="login_loading"></div>
									<a href="web/jsp/emailLogin.jsp"
										style="color: #5ba878; margin-right: 130px; text-decoration: underline">邮箱快速登录</a>
									<input type="submit" value="登录"
										class="layui-btn layui-btn-lg layui-btn-normal"
										style="margin-right: 100px" />

									<!-- <a id="loginBtn" href="javascript:loginValidate()"
                                 onclick="document:loginBtn.submit()"  class="layui-btn layui-btn-lg layui-btn-normal" style="margin-right: 100px">登录</a> -->
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
<!--<script type="text/javascript" src="js/vcode/vcode.js"></script>-->
<script type="text/javascript">
    var nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    ];
    var str = '';
    var verVal = drawCode();

    function drawCode(str) {
        var canvas = document.getElementById("verifyCanvas"); //获取HTML端画布
        var context = canvas.getContext("2d"); //获取画布2D上下文
        context.fillStyle = "red"; //画布填充色
        context.fillRect(0, 0, canvas.width, canvas.height); //清空画布
        context.fillStyle = "white"; //设置字体颜色
        context.font = "20px Arial"; //设置字体
        var rand = new Array();
        var x = new Array();
        var y = new Array();
        for (var i = 0; i < 4; i++) {
            rand.push(rand[i]);
            rand[i] = nums[Math.floor(Math.random() * nums.length)]
            x[i] = i * 20 + 10;
            y[i] = Math.random() * 20 + 20;
            context.fillText(rand[i], x[i], y[i] - 10);
        }
        str = rand.join('').toUpperCase();
       
        convertCanvasToImage(canvas);
        return str;
    }

    // 绘制图片
    function convertCanvasToImage(canvas) {
        document.getElementById("verifyCanvas").style.display = "none";
        var image = document.getElementById("img_vcode");
        image.src = canvas.toDataURL("image/png");
        return image;
    }

    function resetCode() {
        $('#verifyCanvas').remove();
        $('#img_vcode').before('<canvas width="100" height="35" id="verifyCanvas"></canvas>')
        verVal = drawCode();
    }
	
    // 随机线
    function drawline(canvas, context) {
        context.moveTo(Math.floor(Math.random() * canvas.width), Math.floor(Math.random() * canvas.height)); //随机线的起点x坐标是画布x坐标0位置，y坐标是画布高度的随机数
        context.lineTo(Math.floor(Math.random() * canvas.width), Math.floor(Math.random() * canvas.height)); //随机线的终点x坐标是画布宽度，y坐标是画布高度的随机数
        context.lineWidth = 0.5; //随机线宽
        context.strokeStyle = 'rgba(50,50,50,0.3)'; //随机线描边属性
        context.stroke(); //描边，即起点描到终点
    }

    // 随机点(所谓画点其实就是画1px像素的线，方法不再赘述)
    function drawDot(canvas, context) {
        var px = Math.floor(Math.random() * canvas.width);
        var py = Math.floor(Math.random() * canvas.height);
        context.moveTo(px, py);
        context.lineTo(px + 1, py + 1);
        context.lineWidth = 0.2;
        context.stroke();
    }

    $(function () {
        resetCode();
    });
    /*设置登录窗口垂直居中*/
    $(function () {
        var height = document.body.scrollHeight;
        var logo_wrap = $("#loginDiv").get(0);
        var margin_top = (height - 150) / 2;
        logo_wrap.style.marginTop = margin_top + "px";
    });
    
    
  


    
</script>

</html>