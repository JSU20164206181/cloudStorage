<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/web/lib/html5shiv.js"></script>
    <script type="text/javascript" src="/web/lib/respond.min.js"></script>
    <![endif]-->
    <link href="web/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="web/static/h-ui.admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
    <link href="web/static/h-ui.admin/css/style.css" rel="stylesheet" type="text/css" />
    <link href="web/lib/Hui-iconfont/1.0.8/iconfont.css" rel="stylesheet" type="text/css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="web/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>阿里云盘后台登录</title>
</head>
<body>
<input type="hidden" id="TenantId" name="TenantId" value="" />
<div class="header"></div>
<div class="loginWraper">
    <div id="loginform" class="loginBox">
        <form class="form form-horizontal" action="adminLoginSubmit.action" method="post" onsubmit="return checkForm()">
            <div class="row cl">
                <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
                <div class="formControls col-xs-8">
                    <input type="text" id="name" name="adminName" type="text" onblur="checkName()" placeholder="用户名"  class="input-text size-L"/>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
                <div class="formControls col-xs-8">
                    <input type="password" id="passwd" name="adminPassword"  onblur="checkPass()" placeholder="密码" class="input-text size-L"/>
                </div>
            </div>
            <div class="row cl">
                <div class="formControls col-xs-8 col-xs-offset-3">
                    <input class="input-text size-L" type="text" placeholder="验证码" name="validateCode" onblur="if(this.value==''){this.value='验证码:'}" onclick="if(this.value=='验证码:'){this.value='';}" value="验证码:" style="width:150px;">
                    <img src="getValidateCode.action" id="codeValidateImg"
                         onClick="javascript:flushValidateCode();" > <a id="kanbuq" href="javascript:;" onclick="flushValidateCode();">看不清，换一张</a> </div>
            </div>
            <div class="row cl">
                <div class="formControls col-xs-8 col-xs-offset-3">
                   <%-- <label for="online">
                        <input type="checkbox" name="online" id="online" value="">
                        使我保持登录状态</label>--%>
                </div>
            </div>
            <div class="row cl">
                <div class="formControls col-xs-8 col-xs-offset-3">
                    <input type="submit"  class="btn btn-success radius size-L" value="登录"/>
                    <input type="reset"  class="btn btn-default radius size-L" value="取消"/>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="footer">Copyright 你的公司名称 by H-ui.admin v3.1</div>
<script type="text/javascript" src="web/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="web/static/h-ui/js/H-ui.min.js"></script>

</body>
<script type="text/javascript">


//跳转首页
if (window != top) {
    top.location.href = location.href; 
    }  
    /* 刷新生成验证码 */
    function flushValidateCode() {
        var validateImgObject = document.getElementById("codeValidateImg");
        validateImgObject.src = "${pageContext.request.contextPath }/getValidateCode.action?time="
            + new Date();
    }

    /*验证表单输入是否正确*/
    function checkForm() {
        if(checkName()&&checkPass())
            return true;
        else {
            alert("输入不规范");
            return false;
        }
    }

    function checkName() {
        var name = document.getElementById("name").value;
        var reg = /^\w+$/;

        if (name.length < 1) {
           $("#name").attr('placeholder',"输入不能为空");
           $("#name").css('border-color','#f70606');
        } else if (name.length < 3) {
            $("#name").val("");
            $("#name").attr('placeholder',"用户名至少要3位");
            $("#name").css('border-color','#f70606');
        } else if (!reg.test(name)) {
            $("#name").val("");
            $("#name").attr('placeholder',"只能由数字字母下划线组成");
            $("#name").css('border-color','#f70606');
        } else {
            $("#name").css('border-color','#fff');
            return true;
        }
    }

    function checkPass() {
        var name = document.getElementById("passwd").value;

        if (name.length < 1) {
            $("#passwd").attr('placeholder',"输入不能为空");
            $("#passwd").css('border-color','#f70606');
        } else if (name.length < 6) {
            $("#passwd").val("");
            $("#passwd").attr('placeholder',"密码至少要6位");
            $("#passwd").css('border-color','#f70606');
        }else if (name.length > 20) {
            $("#passwd").val("");
            $("#passwd").attr('placeholder',"密码最长为20位");
            $("#passwd").css('border-color','#f70606');
        }
        else {
            $("#passwd").css('border-color','#fff');
            return true;
        }
    }
</script>
<c:if test="${not empty error }">
    <script type="text/javascript">
        alert('${error}')
    </script>
</c:if>
</html>
