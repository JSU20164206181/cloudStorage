<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<% 
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    
<base href="<%=basePath%>">
<meta charset="utf-8">
<title>分享文件下载</title>
<link rel="stylesheet" href="web/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/javascript" src="web/js/jquery.min.js"> </script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>
<script type="text/javascript" src="web/layui/layui.js"></script>
<script type="text/javascript" src="web/layui/lay/modules/laypage.js"></script>
<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>

<style type="text/css">
.layui-btn-sm {
	color: #3cb7ef;
	text-decoration: none;
}

.layui-btn-group {
	margin-left: 20px;
}

.hidenfa {
	display: none;
}

.hidenfa .fa {
	color: #3cb7ef;
	margin-left: 10px;
}

     } 
    .pathHerf:link ,.pathHerf:visited ,.pathHerf:hover ,.pathHerf:active{  
    text-decoration:none; 
	color:#3cb7ef;
	} 
	.pathHerf{	
	margin-right:5px;  
	}
</style>
</head> 
<body><div class="layui-layout layui-layout-admin">
		
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="mainContent" style="padding: 15px;">
			  <div class="" style="z-index: 99; position: fixed ! important;top: 0px;left:0%;width:100%;background:#f2f2f2;">  

					<div style="width: 100%; margin-left: 40px; margin-top: 20px;"> 
						<div class="layui-btn-group">
							<button type="button"
								class="layui-btn layui-btn-primary layui-btn-sm"
								style="color: #3cb7ef;" onclick="download()">
								<i class="fa fa-download" aria-hidden="true"></i>下载
							</button>
						</div>
					</div>
					<div class="layui-row layui-col-space10" style="margin: 10px;">
						<div class="layui-col-md10">
							<span id="pathSpan" style="margin-left: 20px;"><strong style="color: #4F94CD;">${share.userName }</strong></span>
							<span id="pathSpan" style="margin-left: 20px;">给您分享了：${share.shareName }</span>
						</div>
						<div class="layui-col-md2">${dirList.size()+fileList.size()}个文件/文件夹</div>
					</div>

					<div style="width: 98.8%;">
						<table class="layui-table" lay-skin="nob">
							<thead>
								<tr>
									<th style="width: 1000px;">
										<div class="layui-row ">
											<div class="layui-col-md12" style="margin-right: -20px;">
												<input style="color: blue;" id="delAll"
													onclick="deleteAll()" type="checkbox" /> <span
													style="margin-left: 12px;" id="choseNum">文件名</span>
											</div>
										</div>
									</th>
									<th style="width: 225px; text-align: left;">大小</th>
									<th>分享时间</th>
								</tr>

							</thead>
						</table>
						<table class="layui-table" lay-skin="line"
					style="position: absolute; top: 140px;">
					<tbody id="tableClass">
						<c:forEach items="${dirList}" var="dir" varStatus="i" step="1">

							<tr class="listOne" id="listOneDir${i.index}">
								<td width="150">
									<div class="layui-row ">
										<div class="layui-col-md1" style="margin-right: -20px;">
											<input class="deleteOne dirId" onclick="deleteOne()"
												value="${dir.directoryId}" type="checkbox">
										</div>
										<div class="layui-col-md11" onclick="choseOne()">
												<span class='fa fa-folder'
												style="margin-left: 10px; color: #efb642; font-size: 25px"></span>
												<span class="showName"
												style="margin-left: 5px; font-size: 12px;">${dir.directoryName}</span>
												<input class="reNameId" value="${dir.directoryId}"
												type="hidden">
											</a>

										</div>



									</div>
								</td>
								<td width="30" onclick="choseOne()">
									<div class="hidenfa" onclick="choseOne()">
									</div>
								</td>
								<td width="50" onclick="choseOne()"></td>
								<td width="30" style="text-align: left;" onclick="choseOne()"></td>

								<td width="100" onclick="choseOne()"><span><fmt:formatDate
											value='${file.createDatetime}' type='both'
											pattern='yyyy-MM-dd hh:mm' /></span></td>

							</tr>
						</c:forEach>

						<c:forEach items="${fileList}" var="file" varStatus="i" step="1">
							<tr class="listOne" id="listOneFile${i.index}">
								<td width="150">
									<div class="layui-row ">
										<div class="layui-col-md1" style="margin-right: -20px;">
											<input class="deleteOne fileId" onclick="deleteOne()"
												value="${file.fileId}" type="checkbox">
										</div>
										<div class="layui-col-md11" onclick="choseOne()">
                                           
											<a style="text-decoration: none"
												onclick='showFile("预览","${file.fileType}","${file.filePath}")'  
												title="预览"> 
												<c:if test="${file.fileType==1}">
													<span class='fa fa-file-image-o'
														style="margin-left: 10px; color: #317ef3; font-size: 25px"></span>
												</c:if> <c:if test="${file.fileType==2}">
													<span class='fa fa-file-video-o'
														style="margin-left: 10px; color: #317ef3; font-size: 25px"></span>
												</c:if> <c:if test="${file.fileType==3}">
													<span class='fa fa-file-text-o'
														style="margin-left: 10px; color: #317ef3; font-size: 25px"></span>
												</c:if> <c:if test="${file.fileType==4}">
													<span class='fa fa-file-audio-o'
														style="margin-left: 10px; color: #317ef3; font-size: 25px"></span>
												</c:if> <c:if test="${file.fileType==5}">
													<span class='fa fa-paper-plane-o'
														style="margin-left: 10px; color: #317ef3; font-size: 25px"></span>
												</c:if> <c:if test="${file.fileType==6}">
													<span class='fa fa-file-archive-o'
														style="margin-left: 10px; color: #317ef3; font-size: 25px"></span>
												</c:if> <span class="showName"
												style="margin-left: 5px; font-size: 12px;">${file.fileName}</span>
												<input class="reNameId" value="${file.fileId}" type="hidden">
											</a>
										</div>
									</div>
								</td>
								<td width="30" onclick="choseOne()">
									<div class="hidenfa">
									</div>
								</td>
								<td width="50" onclick="choseOne()"></td>
								<td width="30" style="text-align: left;" onclick="choseOne()">

									<c:if test="${file.fileSize<921}"> 
      ${file.fileSize}KB
     </c:if>  
      <c:if test="${file.fileSize>=921}">
        <c:if test="${file.fileSize<1024}"> 
         <fmt:formatNumber value="${file.fileSize/1024}" pattern="0.00"/>MB   
        </c:if>          
     </c:if>  
      <c:if test="${file.fileSize>=1024}">
        <c:if test="${file.fileSize<943718}"> 
         <fmt:formatNumber value="${file.fileSize/1024}" pattern="#.0"/>MB   
        </c:if>          
     </c:if>  
      <c:if test="${file.fileSize>=943718}">
        <c:if test="${file.fileSize<1048576}"> 
         <fmt:formatNumber value="${file.fileSize/1048576}" pattern="0.00"/>GB      
        </c:if>          
     </c:if> 
     <c:if test="${file.fileSize>=1048576}"> 
         <fmt:formatNumber value="${file.fileSize/1048576}" pattern="#.0"/>GB           
     </c:if>       
   </td > 
  
     <td width="100" onclick="choseOne()"> 
       <span><fmt:formatDate  value='${file.uploadDatetime}' type='both' pattern='yyyy-MM-dd hh:mm' /></span> 
   </td > 
  
    </tr>
         
   </c:forEach>
  </tbody>
</table>
					</div>
				</div>

				

</div> 
		</div>
		
	</div>
	<script type="text/javascript">
	function exit() {
		layer.confirm("确认要真的退出系统么？", {
			title : "确认提示",
			btn : [ '残忍离开', '继续使用' ]
		
		},
		function(index) {
			  $.ajax({
				type : "post",
				url : "logout.action",
				success : function(data) {
				window.location.href = "web/jsp/login.jsp";
				},
			});  
		});
		
	}
	
		//文件下载
		function download(){
			var filesId = [];
			var dirsId = [];
			var thisDirId = '${pId}';
			 $.each($('input:checkbox:checked'),function(){
				 var type = this.className;
				 if(type.indexOf("file")>=0){
					 filesId.push($(this).val());
				 }else if(type.indexOf("dir")>=0){
					 dirsId.push($(this).val());
				 }
				
			 });
			 location.href = "batchDownLoadFile.action?filesId="+filesId+"&dirsId="+dirsId+"&thisDirId=0";
		}
	</script>
<script type="text/javascript"> 

/* 全选 */
var check = $(".deleteOne");  
var checkNum = 0;
function deleteAll() {
	if ($('#delAll').is(':checked')) {
		$(".deleteOne").prop("checked", true);//全选		 
		checkNum = check.length;

	} else {
		$(this).prop("checked", false);
		$(".deleteOne").prop("checked", false);//取消全选 		
		checkNum = 0;
	} 	
	if(checkNum==0){
	$("#choseNum").html("文件名"); 
	}else{
		$("#choseNum").html("已选中"+checkNum+"文件/文件夹"); 	
	}		
}
//单选
function deleteOne() {
	checkNum = 0;
	$(".deleteOne").each(function() {
		if ($(this).is(':checked')) {
			checkNum++; 
		}
	});
	if (checkNum == check.length) {
		$("#delAll").prop("checked", true);
	} else {
		$("#delAll").prop("checked", false)
	}
	if(checkNum==0){
		$("#choseNum").html("文件名"); 
		}else{
			$("#choseNum").html("已选中"+checkNum+"文件/文件夹"); 	
		} 
}
//选择一行
function choseOne() {
	//取消全选
		$("#delAll").prop("checked", false);
		$(".deleteOne").prop("checked", false) 	;
		checkNum = 1;
		 var a=".enter .deleteOne";  
		if ($(a).is(':checked')) { 
			 $(a).prop("checked", false); 
		}else{
			 $(a).prop("checked",true);  
		}  
	if(checkNum==0){
	$("#choseNum").html("文件名"); 
	}else{
		$("#choseNum").html("已选中"+checkNum+"文件/文件夹"); 	
	}		
}
 function setSelectionRange(input, selectionStart, selectionEnd) {
	 //alert("aaaa");  
	  if (input.setSelectionRange) {
	    input.focus();
	    input.setSelectionRange(selectionStart, selectionEnd);
	  }
	  else if (input.createTextRange) {
	    var range = input.createTextRange();
	    range.collapse(true);
	    range.moveEnd('character', selectionEnd);
	    range.moveStart('character', selectionStart);
	    range.select();
	  }
	} 
	 
    </script>
</body>
</html>