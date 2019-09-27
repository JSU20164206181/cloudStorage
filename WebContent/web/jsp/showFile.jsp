<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>Insert title here</title>
</head>
<body>
<div style="text-align:center;">
<c:if test="${type==4}">  
   
<audio controls > 
  <source src="${path}" >      
</audio>
</c:if>
<c:if test="${type==2}"> 
<video width="100%" height="100%" controls>
  <source src="${path}"  type="video/mp4">   
</video>
</c:if>
<c:if test="${type==1}"> 
  <img src="${path}" width="100%" height="100%"  >   
</c:if>
</div> 
</body>
</html>