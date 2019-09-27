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
<title>用户文件列表</title>
</head>
<body>
<jsp:include page="head.jsp"/>
<jsp:include page="menu.jsp"/>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 文件管理 <span class="c-gray en">&gt;</span> 用户文件管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>

<div class="page-container">
	<div class="text-c">
		<button onclick="removeIframe()" class="btn btn-primary radius">关闭选项卡</button>
	 <span class="select-box inline">
		<select name="file-type" id="file-type" class="select" onchange="type_find()">
		<c:choose>
			<c:when test="${fileType == 0 }">
			<option value="0" selected="selected">所有分类</option>
			</c:when>
			<c:otherwise>
			<option value="0">所有分类</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileType == 1 }">
			<option value="1" selected="selected">图片</option>
			</c:when>
			<c:otherwise>
			<option value="1">图片</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileType == 2 }">
			<option value="2" selected="selected">视频</option>
			</c:when>
			<c:otherwise>
			<option value="2">视频</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileType == 3 }">
			<option value="3" selected="selected">文档</option>
			</c:when>
			<c:otherwise>
			<option value="3">文档</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileType == 4 }">
			<option value="4" selected="selected">音乐</option>
			</c:when>
			<c:otherwise>
			<option value="4">音乐</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileType == 5 }">
			<option value="5" selected="selected">种子</option>
			</c:when>
			<c:otherwise>
			<option value="5">种子</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileType == 6 }">
			<option value="6" selected="selected">其它</option>
			</c:when>
			<c:otherwise>
			<option value="6">其它</option>
			</c:otherwise>
		</c:choose>
		</select>
		</span>
		<span class="select-box inline">
		<select name="file-status" id="file-status" class="select" onchange="type_find()">
		<c:choose>
			<c:when test="${fileStatus == 0 }">
			<option value="0" selected="selected">所有状态</option>
			</c:when>
			<c:otherwise>
			<option value="0">所有状态</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileStatus == 1 }">
			<option value="1" selected="selected">已启用</option>
			</c:when>
			<c:otherwise>
			<option value="1">已启用</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileStatus == 2 }">
			<option value="2" selected="selected">已禁用</option>
			</c:when>
			<c:otherwise>
			<option value="2">已禁用</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${fileStatus == 3 }">
			<option value="3" selected="selected">已删除</option>
			</c:when>
			<c:otherwise>
			<option value="3">已删除</option>
			</c:otherwise>
		</c:choose>
		</select>
		</span>
		<a type="button" class="btn btn-success" href="findAllFilesByPage.action?fileStatus=0"><i class="Hui-iconfont"></i> 所有用户文件</a>
		&nbsp;
		<!-- <form action="findFileByAttribute.action" method="post" style="display: inline"> -->
		日期范围：
		<input name="startTime" id="startTime" value="${startTime }" placeholder="开始日期(必填)" type="text" onfocus="WdatePicker({ minDate:'',maxDate:'%y-%M-%d' })" id="logmin" class="input-text Wdate" style="width:120px;">
		-		
		<input name="endTime" id="endTime" value="${endTime }" placeholder="结束日期(必填)" type="text" onfocus="WdatePicker({ minDate:'',maxDate:'%y-%M-%d' })" id="logmax" class="input-text Wdate" style="width:120px;"> 
		<input type="text" name="content" id="content" placeholder="模糊查找内容(必填)"  value="${content }" onfocus="this.select()" style="width:150px" class="input-text"> 
		<span class="select-box inline">
		<select id="findAttribute" name="findAttribute" class="select">
		<c:choose>
			<c:when test="${findAttribute == 1 }">
			<option value="1" selected="selected">按文件名</option>
			</c:when> 
			<c:otherwise>
			<option value="1">按文件名</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${findAttribute == 2 }">
			<option value="2" selected="selected">按上传用户</option>
			</c:when>
			<c:otherwise>
			<option value="2">按上传用户</option>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${findAttribute == 3 }">
			<option value="3" selected="selected">按上传文件IP</option>
			</c:when>
			<c:otherwise>
			<option value="3">按上传文件IP</option>
			</c:otherwise>
		</c:choose>
		</select>
		</span>
		<button id="find" class="btn btn-success" onclick="fuzzyFind()"><i class="Hui-iconfont">&#xe665;</i> 搜文件</button>
		<!-- </form> -->
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="file_batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> </span> 
	<c:if test="${fileTotal != null && fileTotal != 0}">
	<span class="r">共有数据：<strong>${fileTotal }</strong> 条</span> 
	</c:if>
	<c:if test="${fileTotal == null || fileTotal == 0}">
	<span class="r">共有数据：<strong>0</strong> 条</span> 
	</c:if>
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" class="checkAll"></th>
					<th width="80">ID</th>
					<th>文件名</th>
					<th width="80">分类</th>
					<th width="80">大小</th>
					<th width="120">修改时间</th>
					<th width="80">上传用户</th>
					<th width="100">上传文件IP</th>
					<th width="60">状态</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${fileList }" var="file" varStatus="i">
				<tr class="text-c">
					<td><input type="checkbox" id="check${i.index }" value="${file.fileId }" class="check" onclick="check(${i.index},this)"></td>
					<td>${file.fileId }</td>
					<td>${file.fileName }</td>
					<c:if test="${file.fileType == 1}">
					<td>图片</td>
					</c:if>
					<c:if test="${file.fileType == 2}">
					<td>视频</td>
					</c:if>
					<c:if test="${file.fileType == 3}">
					<td>文档</td>
					</c:if>
					<c:if test="${file.fileType == 4}">
					<td>音乐</td>
					</c:if>
					<c:if test="${file.fileType == 5}">
					<td>种子</td>
					</c:if>
					<c:if test="${file.fileType == 6}">
					<td>其它</td>
					</c:if>
					<c:choose>
					<c:when test="${file.fileSize >=  1048576}">
					<td><fmt:formatNumber type="number" value="${file.fileSize / 1048576}" pattern="0.00" maxFractionDigits="2"/> GB</td>
					</c:when>
					<c:when test="${file.fileSize >= 1024}">
					<td><fmt:formatNumber type="number" value="${file.fileSize / 1024}" pattern="0.00" maxFractionDigits="2"/> MB</td>
					</c:when>
					<c:when test="${file.fileSize < 1024}">
					<td>${file.fileSize } KB</td>
					</c:when>
					</c:choose>
					<td><fmt:formatDate value="${file.uploadDatetime}" type="both"/></td>
					<td><u style="cursor:pointer" class="text-primary" onclick="member_show('用户信息','findUser.action?userId=${file.userId }',${file.userId },'430','660')">${file.userName }</u></td>
					<td>${file.uploadIp }</td>
					<c:if test="${file.fileStatus == 1}">
					<td class="td-status"><span class="label label-success radius">已启用</span></td>
					<td class="f-14 td-manage"><a style="text-decoration:none" onClick="file_stop(this,${file.fileId})" href="javascript:;" title="禁用"><i class="Hui-iconfont">&#xe631;</i></a> <a style="text-decoration:none" class="ml-5" onClick="file_del(this,${file.fileId},${i.index })" href="javascript:;" title="彻底删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
					</c:if>
					<c:if test="${file.fileStatus == 2}">
					<td class="td-status"><span class="label label-defaunt radius">已禁用</span></td>
					<td class="f-14 td-manage"><a style="text-decoration:none" onClick="file_start(this,${file.fileId})" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a> <a style="text-decoration:none" class="ml-5" onClick="file_del(this,${file.fileId},${i.index })" href="javascript:;" title="彻底删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
					</c:if>
					<c:if test="${file.fileStatus == 3}">
					<td class="td-status"><span class="label label-danger radius">已删除</span></td>
					<td class="f-14 td-manage"><a style="text-decoration:none" onClick="file_restore(this,${file.fileId})" href="javascript:;" title="还原"><i class="Hui-iconfont">&#xe66b;</i></a> <a style="text-decoration:none" class="ml-5" onClick="file_del(this,${file.fileId},${i.index })" href="javascript:;" title="彻底删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
					</c:if>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:choose>
		<c:when test="${fileType == 0 && fileStatus == 0 && findAttribute == null && fileList != null}">
		<div id="DataTables_Table_0_wrapper"
				class="dataTables_wrapper no-footer">
				<div class="dataTables_paginate paging_full_numbers" id="tablePage">
					<a class="paginate_button first disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0"
						id="firstPage" href="findAllFilesByPage.action?page=1&fileStatus=0">第一页</a> <a
						class="paginate_button previous disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
						id="previousPage" href="findAllFilesByPage.action?page=${nowPage-1 }&fileStatus=0">上一页</a>
					<span><a class="paginate_button current"
						aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${totalPage }</a></span>
					<a class="paginate_button next disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
						id="nextPage" href="findAllFilesByPage.action?page=${nowPage+1 }&fileStatus=0">下一页</a>
					<a class="paginate_button last disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
						id="lastPage" href="findAllFilesByPage.action?page=${totalPage}&fileStatus=0">最后一页</a>
				</div>
		</div>
		</c:when>
		<c:when test="${findAttribute == null && fileList != null}">
		<div id="DataTables_Table_0_wrapper" 
				class="dataTables_wrapper no-footer">
				<div class="dataTables_paginate paging_full_numbers" id="tablePage">
					<a class="paginate_button first disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0"
						id="firstPage" href="findFilesByType.action?fileType=${fileType }&fileStatus=${fileStatus }&page=1">第一页</a> <a
						class="paginate_button previous disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
						id="previousPage" href="findFilesByType.action?fileType=${fileType }&fileStatus=${fileStatus }&page=${nowPage-1 }">上一页</a>
					<span><a class="paginate_button current"
						aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${totalPage }</a></span>
					<a class="paginate_button next disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
						id="nextPage" href="findFilesByType.action?fileType=${fileType }&fileStatus=${fileStatus }&page=${nowPage+1 }">下一页</a>
					<a class="paginate_button last disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
						id="lastPage" href="findFilesByType.action?fileType=${fileType }&fileStatus=${fileStatus }&page=${totalPage}">最后一页</a>
				</div>
		</div>
		</c:when>
		<c:when test="${findAttribute != null && fileList != null}">
		<div id="DataTables_Table_0_wrapper"
				class="dataTables_wrapper no-footer">
				<div class="dataTables_paginate paging_full_numbers" id="tablePage">
					<a class="paginate_button first disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0"
						id="firstPage" href="findFileByAttribute.action?startTime=${startTime }&endTime=${endTime }&content=${content }&findAttribute=${findAttribute}&page=1">第一页</a> <a
						class="paginate_button previous disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
						id="previousPage" href="findFileByAttribute.action?startTime=${startTime }&endTime=${endTime }&content=${content }&findAttribute=${findAttribute}&page=${nowPage-1 }">上一页</a>
					<span><a class="paginate_button current"
						aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${nowPage }/${totalPage }</a></span>
					<a class="paginate_button next disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
						id="nextPage" href="findFileByAttribute.action?startTime=${startTime }&endTime=${endTime }&content=${content }&findAttribute=${findAttribute}&page=${nowPage+1 }">下一页</a>
					<a class="paginate_button last disabled"
						aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
						id="lastPage" href="findFileByAttribute.action?startTime=${startTime }&endTime=${endTime }&content=${content }&findAttribute=${findAttribute}&page=${totalPage}">最后一页</a>
				</div>
		</div>
		</c:when>
		</c:choose>
	</div>
</div>
</section>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="web/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="web/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="web/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="web/static/h-ui.admin/js/H-ui.admin.js"></script> 
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="web/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="web/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="web/lib/laypage/1.2/laypage.js"></script>
   
<script type="text/javascript"> 
/* $(function(){
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,8,9]}// 制定列不参与排序
		]
	});
	
}); */

/* 模糊查找 */
function fuzzyFind(){
	var startTime=$("#startTime").val();
	var endTime=$("#endTime").val();
	var content=$("#content").val();
	var findAttribute=$("#findAttribute").val();
	window.location.href="findFileByAttribute.action?startTime="+startTime+"&endTime="+endTime+"&content="+content+"&findAttribute="+findAttribute
}

var totalNum=$(".check").length;//总数
var checkNum=0;//已选择的数量
var checkFileId=[];//已选择的文件
/*文件-分类查询*/
function type_find(){
	console.log($("#file-type").val());
	console.log($("#file-status").val());
	var fileType=$("#file-type").val();
	var fileStatus=$("#file-status").val();
	window.location.href="findFilesByType.action?fileType="+fileType+"&fileStatus="+fileStatus;
}
/*用户-查看*/
function member_show(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*文件-禁用*/
function file_stop(obj,id){
	layer.confirm('确认要禁用吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'changeFileStatus.action',
			data:{
				'fileId':id,
				'fileStatus':2
			},
			//dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="file_start(this,'+id+')" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已禁用</span>');
				$(obj).remove();
				layer.msg('已禁用!',{icon: 5,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}
/*文件-启用*/
function file_start(obj,id){
	layer.confirm('确认要启用吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'changeFileStatus.action',
			data:{
				'fileId':id,
				'fileStatus':1
			},
			//dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="file_stop(this,'+id+')" href="javascript:;" title="禁用"><i class="Hui-iconfont">&#xe631;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
				$(obj).remove();
				layer.msg('已启用!',{icon: 6,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});
	});
}
/*文件-还原*/
function file_restore(obj,id){
	layer.confirm('确认要还原吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'changeFileStatus.action',
			data:{
				'fileId':id,
				'fileStatus':1
			},
			//dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="file_stop(this,'+id+')" href="javascript:;" title="禁用"><i class="Hui-iconfont">&#xe631;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
				$(obj).remove();
				layer.msg('已还原!',{icon: 6,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});
	});
}
/*文件-彻底删除*/
function file_del(obj,id,i){
	var checked=$("#check"+i).prop("checked");
	layer.confirm('确认要彻底删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'deleteFile.action',
			data:{
				'fileIdList':id
			},
			//dataType: 'json',
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已彻底删除!',{icon:1,time:1000});
				if(checked==true){
					totalNum-=1;
					checkNum-=1;
					delArrElementByValue(checkFileId,id);
				}else{
					totalNum-=1;
					if(checkNum==totalNum && totalNum!=0){
						$(".checkAll").prop("checked",true);
					}
				}
				console.log(totalNum);
				console.log(checkFileId);
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}
/*文件-批量彻底删除*/
function file_batchDel(){
	layer.confirm('确认要彻底删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'deleteFile.action?fileIdList='+checkFileId,
			success: function(data){
				layer.msg('已彻底删除!',{icon:1,time:1000});
				alert("已彻底删除!");
				window.location.reload();
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}
/*全选/全不选 */
$(".checkAll").click(function() {
	if($(this).prop("checked")==true){
		checkNum=totalNum;
		for(i=0;i<totalNum;i++){
			checkFileId.push($("#check"+i).val());
		}
	}else{
		checkNum=0;
		checkFileId=[];
	}
	console.log(totalNum);
	console.log(checkFileId);
})
/*逐个选择 */
function check(i,obj){
	if($(obj).prop("checked")==true){
		checkNum+=1;
		checkFileId.push($(obj).val());
	}else{
		checkNum-=1;
		delArrElementByValue(checkFileId,$(obj).val());
	}
	if(checkNum==totalNum){
		$(".checkAll").prop("checked",true);
	}else{
		$(".checkAll").prop("checked",false)
	}
	console.log(totalNum);
	console.log(checkFileId);
}
/*根据值删除数组中的指定元素 */
function delArrElementByValue(arr, val) {
	for(var i=0;i<arr.length;i++){
		if(arr[i]==val){
			arr.splice(i,1);
			break;
		}
	}
}
</script> 
</body>
</html>