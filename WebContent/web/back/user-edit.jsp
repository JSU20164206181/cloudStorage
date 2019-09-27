<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/9/6
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="Bookmark" href="/favicon.ico" >
    <link rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="lib/html5shiv.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="web/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="web/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="web/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <!--/meta 作为公共模版分离出去-->

    <title>添加用户 - H-ui.admin v3.1</title>
    <meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
    <form action="" method="post" class="form form-horizontal" id="form-member-add">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${user.userName}" placeholder="" id="username" name="userName">
                <input type="text" name="userId" value="${user.userId}" hidden>
                <input type="text" name="personId" value="${user.person.personId}" hidden>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>性别：</label>
            <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                <div class="radio-box">
                    <input name="sex" type="radio" id="sex-1" value="男" <c:if test="${user.person.sex == '男'}">checked</c:if>>
                    <label for="sex-1">男</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="sex-2" name="sex" value="女" <c:if test="${user.person.sex == '女'}">checked</c:if>>
                    <label for="sex-2">女</label>
                </div>

            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>手机：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${user.person.phone}" placeholder="请输入手机号" id="phone" name="phone">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>邮箱：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" placeholder="@" name="email" id="email" value="${user.person.email}">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">年龄：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" placeholder="年龄" name="age" id="age" value="${user.person.age}">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">用户等级：</label>
            <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
				<select class="select" size="1" name="memberOrder">
					<%--<option value="" selected>请选择城市</option>--%>
                    <option value="1" <c:if test="${user.memberOrder==1}">selected</c:if>>普通用户</option>
					<option value="2" <c:if test="${user.memberOrder==2}">selected</c:if>>会员</option>
					<option value="3" <c:if test="${user.memberOrder==3}">selected</c:if>>超级会员</option>
				</select>
				</span> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">备注：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea name="introduction" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符">${user.person.introduction}</textarea>
                <%--<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>--%>
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="web/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="web/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="web/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="web/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="web/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="web/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="web/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="web/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-member-add").validate({
            rules:{
                userName:{
                    required:true,
                    minlength:2,
                    maxlength:16
                },
                sex:{
                    required:true,
                },
                phone:{
                    required:true,
                    isMobile:true,
                },
                email:{
                    required:true,
                    email:true,
                },
                age:{
                    required:true,
                    range:[0,150],
                },

            },
            onkeyup:false,
            focusCleanup:true,
            success:"valid",
            submitHandler:function(form){
                //$(form).ajaxSubmit();
                $.ajax({
                   type:'post',
                   url:'${pageContext.request.contextPath}/submitModify.action',
                    data: $("#form-member-add").serialize(),
                    success:function (data) {
                       console.log(data);
                       if(data=='success') {
                           layer.msg('修改成功!', {icon: 1, offset: '40%', time: 1000});
                           setTimeout(close, 1000);
                       }else {
                           layer.msg('修改失败!', {icon: 2, offset: '40%', time: 1000});
                           setTimeout(close, 1000);
                       }
                    }
                });
             //   var index = parent.layer.getFrameIndex(window.name);
                //parent.$('.btn-refresh').click();
               // parent.layer.close(index);
            }
        });

        function  close() {
            var index = parent.layer.getFrameIndex(window.name);
            //  window.parent.location.reload();
            parent.layer.close(index);
        }
    });
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
