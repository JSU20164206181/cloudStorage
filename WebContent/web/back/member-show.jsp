<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="text/css" href="web/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="web/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/style.css" />
<title>用户信息</title>
<style>
.text-r{
width: 100px;
}
</style>
</head>
<body>
<div class="cl pd-20" style=" background-color:#5bacb6">
	<img class="avatar size-XL l" src="${user.person.picture }" style="left: 10px;">
	<dl style="margin-left:100px; color:#fff">
		<dt>
			<span class="f-18">${user.userName }</span>
			<c:if test="${user.memberOrder == 1 }">
			<span class="pl-10 f-12">普通用户</span>
			</c:if>
			<c:if test="${user.memberOrder == 2 }">
			<span class="pl-10 f-12">会员</span>
			</c:if>
			<c:if test="${user.memberOrder == 3 }">
			<span class="pl-10 f-12">超级会员</span>
			</c:if>
		</dt>
		<dd class="pt-10 f-12" style="margin-left:0">${user.person.introduction }</dd>
	</dl>
</div>
<div class="pd-20">
	<table class="table">
		<tbody>
			<tr>
				<th class="text-r" width="80">姓名：</th>
				<td>${user.person.realName }</td>
			</tr>
			<tr>
				<th class="text-r" width="80">性别：</th>
				<td>${user.person.sex }</td>
			</tr>
			<tr>
				<th class="text-r" width="80">年龄：</th>
				<td>${user.person.age }</td>
			</tr>
			<tr>
				<th class="text-r">电话：</th>
				<td>${user.person.phone }</td>
			</tr>
			<tr>
				<th class="text-r">邮箱：</th>
				<td>${user.person.email }</td>
			</tr>
			<tr>
			<th class="text-r">已用空间大小：</th>
			<c:choose>
					<c:when test="${user.usedSize >=  1073741824}">
					<td><fmt:formatNumber type="number" value="${user.totalSize / 1073741824}" pattern="0.00" maxFractionDigits="2"/> TB</td>
					</c:when>
					<c:when test="${user.usedSize >=  1048576}">
					<td><fmt:formatNumber type="number" value="${user.totalSize / 1048576}" pattern="0.00" maxFractionDigits="2"/> GB</td>
					</c:when>
					<c:when test="${user.usedSize >= 1024}">
					<td><fmt:formatNumber type="number" value="${user.usedSize / 1024}" pattern="0.00" maxFractionDigits="2"/> MB</td>
					</c:when>
					<c:when test="${user.usedSize < 1024}">
					<td>${user.usedSize } KB</td>
					</c:when>
			</c:choose>
			</tr>
			<tr>
			<th class="text-r">可用空间大小：</th>
			<c:choose>
					<c:when test="${user.totalSize - user.usedSize >=  1048576}">
					<td><fmt:formatNumber type="number" value="${(user.totalSize - user.usedSize) / 1048576}" pattern="0.00" maxFractionDigits="2"/> GB</td>
					</c:when>
					<c:when test="${user.totalSize - user.usedSize >= 1024}">
					<td><fmt:formatNumber type="number" value="${(user.totalSize - user.usedSize) / 1024}" pattern="0.00" maxFractionDigits="2"/> MB</td>
					</c:when>
					<c:when test="${user.totalSize - user.usedSize < 1024}">
					<td>${user.totalSize - user.usedSize } KB</td>
					</c:when>
			</c:choose>
			</tr>
			<tr>
			<th class="text-r">总空间大小：</th>
			<c:choose>
					<c:when test="${user.totalSize >=  1048576}">
					<td><fmt:formatNumber type="number" value="${user.totalSize / 1048576}" pattern="0.00" maxFractionDigits="2"/> GB</td>
					</c:when>
			</c:choose>
			</tr>
			<tr>
				<th class="text-r">注册时间：</th>
				<td><fmt:formatDate value="${user.createDatetime }" type="both"/></td>
			</tr>
			<tr>
				<th class="text-r">上次修改时间：</th>
				<td><fmt:formatDate value="${user.person.createDatetime }" type="both"/></td>
			</tr>
			<tr>
				<th class="text-r">上次登录时间：</th>
				<td><fmt:formatDate value="${user.latestLoginDatetime }" type="both"/></td>
			</tr>
			<tr>
				<th class="text-r">上次登录IP：</th>
				<td>${user.latestLoginIp }</td>
			</tr>
			<tr>
				<th class="text-r">用户状态：</th>
				<c:if test="${user.userStatus == 0}">
				<td>未激活</td>
				</c:if>
				<c:if test="${user.userStatus == 1}">
				<td>正常</td>
				</c:if>
				<c:if test="${user.userStatus == 2}">
				<td>已禁用</td>
				</c:if>
				<c:if test="${user.userStatus == 3}">
				<td>已删除</td>
				</c:if>
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