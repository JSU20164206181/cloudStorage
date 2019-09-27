<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/9/2
  Time: 16:08
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
    <title>用户查看</title>
</head>
<body>
<div class="cl pd-20" style=" background-color:#5bacb6">
    <img class="avatar size-XL l" src="${user.person.picture}">
    <dl style="margin-left:80px; color:#fff">
        <dt>
            <span class="f-18">${user.userName}</span>
            <span class="pl-10 f-12">会员等级：
                <c:choose>
                    <c:when test="${user.memberOrder ==1}">普通用户</c:when>
                    <c:when test="${user.memberOrder ==2}">会员</c:when>
                    <c:otherwise>超级会员</c:otherwise>
                </c:choose></span>
        </dt>
        <dd class="pt-10 f-12" style="margin-left:0"><c:if test="${empty user.person.introduction}">这家伙很懒，什么都没有留下</c:if></dd>
    </dl>
</div>
<div class="pd-20">
    <table class="table">
        <tbody>
        <tr>
            <th class="text-r" width="80">性别：</th>
            <td>${user.person.sex}</td>
        </tr>
        <tr>
            <th class="text-r">手机：</th>
            <td>${user.person.phone}</td>
        </tr>
        <tr>
            <th class="text-r">邮箱：</th>
            <td>${user.person.email}</td>
        </tr>
        <tr>
            <th class="text-r">地址：</th>
            <td>北京市 海淀区</td>
        </tr>
        <tr>
            <th class="text-r">注册时间：</th>
            <td><fmt:formatDate value="${user.person.createDatetime}" pattern="yyyy.MM.dd"></fmt:formatDate> </td>
        </tr>
        <tr>
            <th class="text-r">云盘总容量：</th>
            <td>${(user.totalSize)/1048576}Gb</td>
        </tr>
        <tr>
            <th class="text-r">云盘剩余空间：</th>
            <td>${(user.totalSize-user.usedSize)/1048576}Gb</td>
        </tr>
        </tbody>
    </table>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="web/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="web/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="web/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="web/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
</body>
</html>