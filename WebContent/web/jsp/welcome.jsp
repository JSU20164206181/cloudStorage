<%@page import="com.qst.entity.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<base href="<%=basePath%>">
<head>
<meta charset="UTF-8">
<title>网络云盘客户端-个人中心</title>
<link rel="stylesheet"
	href="web/layui/css/modules/laydate/default/laydate.css">
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>

</head>
<body>

</body>
</html>