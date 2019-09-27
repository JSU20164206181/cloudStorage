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
<meta charset="utf-8">
<title>文件管理</title>
<link rel="stylesheet" href="web/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/javascript" src="web/js/jquery.min.js">
	
</script>
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

.pathHerf:link, .pathHerf:visited, .pathHerf:hover, .pathHerf:active {
	text-decoration: none;
	color: #3cb7ef;
}

.pathHerf {
	margin-right: 5px;
}
</style>


</head>
<body>
	<div class="layui-layout layui-layout-admin">
		<jsp:include page="user-head.jsp"></jsp:include>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="mainContent" style="padding: 15px;">

				<div class=""
					style="z-index: 99; position: fixed ! important; top: 60px; left: 13.2%; width: 85.7%; background: #f2f2f2;">
					<div style="width: 100%; margin-left: 40px; margin-top: 20px;">
						<button type="button"
							class="layui-btn layui-btn-primary layui-btn-sm"
							style="color: #3cb7ef;" onclick="deleteRecDir()">
							<i class="fa fa-trash" aria-hidden="true"></i>清空回收站
						</button>
						<button type="button"
							class="layui-btn layui-btn-primary layui-btn-sm"
							style="color: #3cb7ef;" onclick="recoveryRecDir()">
							<i class="fa fa-repeat" aria-hidden="true"></i>批量恢复
						</button>

					</div>
					<div class="layui-row layui-col-space10" style="margin: 10px;">
						<div class="layui-col-md10"></div>



					</div>

					<div style="width: 98.8%; margin-left: 14px;">
						<table class="layui-table" lay-skin="nob">
							<thead>
								<tr>
									<th width="260">
										<div class="layui-row ">
											<div class="layui-col-md12" style="margin-right: -20px;">
												<input style="color: blue;" id="delAll"
													onclick="deleteAll()" type="checkbox" /> <span
													style="margin-right: 10px;" id="choseNum">文件名</span>
											</div>
										</div>
									</th>
									<th width="50" style="text-align: left;">大小</th>
									<th width="80">修改时间</th>
								</tr>

							</thead>
						</table>
					</div>
				</div>

				<table class="layui-table" lay-skin="line"
					style="position: absolute; top: 140px;">
					<tbody id="tableClass">
						<c:forEach items="${listDir}" var="dir" varStatus="i" step="1">

							<tr class="listOne" id="listOneDir${i.index}">
								<td width="150">
									<div class="layui-row ">
										<div class="layui-col-md1" style="margin-right: -20px;">
											<input class="deleteOne dirId" onclick="deleteOne()"
												value="${dir.directoryId}" type="checkbox">
										</div>
										<div class="layui-col-md11" onclick="choseOne()">
											<a style="text-decoration: none"> <span
												class='fa fa-folder'
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
										<a style="text-decoration: none" title="恢复"
											onclick="recoveryRecDir()"> <i class="fa fa-repeat"
											aria-hidden="true"></i>
										</a> <a style="text-decoration: none"
											onclick="deleteChoseRecDir()" title="删除"> <i
											class="fa  fa-trash" aria-hidden="true"></i>
										</a>
									</div>
								</td>
								<td width="50" onclick="choseOne()"></td>
								<td width="30" style="text-align: left;" onclick="choseOne()">
									--</td>

								<td width="100" onclick="choseOne()"><span><fmt:formatDate
											value='${file.createDatetime}' type='both'
											pattern='yyyy-MM-dd hh:mm' /></span></td>

							</tr>
						</c:forEach>

						<c:forEach items="${listFile}" var="file" varStatus="i" step="1">
							<tr class="listOne" id="listOneFile${i.index}">
								<td width="150">
									<div class="layui-row ">
										<div class="layui-col-md1" style="margin-right: -20px;">
											<input class="deleteOne fileId" onclick="deleteOne()"
												value="${file.fileId}" type="checkbox">
										</div>
										<div class="layui-col-md11" onclick="choseOne()">

											<a style="text-decoration: none"> <c:if
													test="${file.fileType==1}">
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
									<div class="hidenfa" onclick="choseOne()">
										<a style="text-decoration: none" href="javascript:;"
											title="恢复" onclick="recoveryRecDir()"> <i
											class="fa fa-repeat" aria-hidden="true"></i>
										</a> <a style="text-decoration: none"
											onclick="deleteChoseRecDir() " title="删除"> <i
											class="fa  fa-trash" aria-hidden="true"></i>
										</a>
									</div>
								</td>
								<td width="50" onclick="choseOne()"></td>
								<td width="30" style="text-align: left;" onclick="choseOne()">

									<c:if test="${file.fileSize<921}"> 
      ${file.fileSize}KB
     </c:if> <c:if test="${file.fileSize>=921}">
										<c:if test="${file.fileSize<1024}">
											<fmt:formatNumber value="${file.fileSize/1024}"
												pattern="0.00" />MB   
        </c:if>
									</c:if> <c:if test="${file.fileSize>=1024}">
										<c:if test="${file.fileSize<943718}">
											<fmt:formatNumber value="${file.fileSize/1024}" pattern="#.0" />MB   
        </c:if>
									</c:if> <c:if test="${file.fileSize>=943718}">
										<c:if test="${file.fileSize<1048576}">
											<fmt:formatNumber value="${file.fileSize/1048576}"
												pattern="0.00" />GB      
        </c:if>
									</c:if> <c:if test="${file.fileSize>=1048576}">
										<fmt:formatNumber value="${file.fileSize/1048576}"
											pattern="#.0" />GB           
     </c:if>
								</td>

								<td width="100" onclick="choseOne()"><span><fmt:formatDate
											value='${file.uploadDatetime}' type='both'
											pattern='yyyy-MM-dd hh:mm' /></span></td>

							</tr>

						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>

	</div>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							//显示路径 
							var allname = "${nameList}";
							var allid = "${idList}";
							var hStr = "";
							if (allname == null || allname == "") {
								var nameList = "全部文件";
								var idList = "0";
								hStr = nameList;
							} else {
								allname = "全部文件/" + allname;
								allid = "0/" + allid;
								var nameList = allname.split("/");
								var idList = allid.split("/");
								//alert("全部文件/${nameList}"+"  nameSize:"+nameList.length+"  idSize:"+idList.length);   	
								if (nameList.length > 1) {

									hStr = hStr
											+ '<a class="pathHerf" href="toFileList.action?pId='
											+ idList[idList.length - 2]
											+ '">返回上一级</a>';

								}
								for (var i = 0; i < nameList.length - 1; i++) {

									var name = nameList[i];
									if (name.length >= 5) {
										name = name.substring(0, 2)
												+ ".."
												+ name.substring(
														name.length - 2,
														name.length);
									}

									hStr = hStr + '<a class="pathHerf" title="'
											+ nameList[i]
											+ '" href="toFileList.action?pId='
											+ idList[i] + '"> ' + name
											+ '></a>';
								}
								hStr = hStr + nameList[nameList.length - 1];
							}

							$("#pathSpan").html(hStr);

							//进入一行
							$(".listOne").hover(function() {
								$(this).addClass("enter");
								var a = ".enter .hidenfa";
								$(a).show();
							}, function() {
								var a = ".enter .hidenfa";
								$(a).hide();
								$(this).removeClass("enter");
							});
							//数据为空
							if ($("#tableClass tr").length == 0) {
								$("#tableClass")
										.append(
												"<tr> <td ></td> <td></td><td>没有数据</td><td></td><td></td></tr> ");
							}
							$
							{
								dirList.size() + fileList.size()
							}

						});

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
			if (checkNum == 0) {
				$("#choseNum").html("文件名");
			} else {
				$("#choseNum").html("已选中" + checkNum + "文件/文件夹");
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
			if (checkNum == 0) {
				$("#choseNum").html("文件名");
			} else {
				$("#choseNum").html("已选中" + checkNum + "文件/文件夹");
			}
		}
		//选择一行
		function choseOne() {
			//取消全选
			$("#delAll").prop("checked", false);
			$(".deleteOne").prop("checked", false);
			checkNum = 1;
			var a = ".enter .deleteOne";
			if ($(a).is(':checked')) {
				$(a).prop("checked", false);
			} else {
				$(a).prop("checked", true);
			}
			if (checkNum == 0) {
				$("#choseNum").html("文件名");
			} else {
				$("#choseNum").html("已选中" + checkNum + "文件/文件夹");
			}
		}
		//恢复多个recoveryRecDir()
		function recoveryRecDir() {
			var allnum = 0;
			deleteFileList = new Array();
			deleteDirList = new Array();
			$(".fileId").each(function() {
				if ($(this).is(':checked')) {
					var id = $(this).val();
					deleteFileList.push(id);
					allnum++;
				}
			});
			$(".dirId").each(function() {
				if ($(this).is(':checked')) {
					var id = $(this).val();
					deleteDirList.push(id);
					allnum++;
				}
			});
			//  alert("文件夹："+deleteDirList+"  文件："+deleteFileList+"num:"+allnum);  

			if (allnum > 0) {
				layer.confirm('确定恢复' + allnum + '个文件/文件夹吗？</br>', {

					btnAlign : 'c',
					title : '删除',
					btn : [ '确认', '取消' ]

				}, function(index, layero) {
					//按钮【按钮一】的回调 
					$.ajax({
						type : 'POST',
						url : 'recoveryRecDir.action?dirIdList='
								+ deleteDirList + '&fileIdList='
								+ deleteFileList,
						success : function(data) {

							if (data == "success") {
								layer.msg('恢复成功!', {
									icon : 1,
									time : 1000
								});
								$("#delAll").prop("checked", false);
								$(".deleteOne").prop("checked", false);
								location.reload();
							} else
								layer.msg('恢复失败!', {
									icon : 2,
									time : 1000
								});
						},
						error : function(data) {
							layer.msg('找不到服务器!', {
								icon : 3,
								time : 1000
							});
						},
					});

				}, function(index) {
					//按钮【按钮二】的回调
				});
			} else {
				layer.msg('请选择一个文件/文件夹!', {
					icon : 2,
					time : 2000
				});
			}
		}

		//删除多个
		function deleteChoseRecDir() {
			var allnum = 0;
			deleteFileList = new Array();
			deleteDirList = new Array();
			$(".fileId").each(function() {
				if ($(this).is(':checked')) {
					var id = $(this).val();
					deleteFileList.push(id);
					allnum++;
				}
			});
			$(".dirId").each(function() {
				if ($(this).is(':checked')) {
					var id = $(this).val();
					deleteDirList.push(id);
					allnum++;
				}
			});
			//  alert("文件夹："+deleteDirList+"  文件："+deleteFileList+"num:"+allnum);  

			if (allnum > 0) {
				layer.confirm('文件删除后不可恢复,确认要彻底删除' + allnum + '个文件/文件夹吗？</br>',
						{

							btnAlign : 'c',
							title : '删除',
							btn : [ '确认', '取消' ]

						}, function(index, layero) {
							//按钮【按钮一】的回调 
							$.ajax({
								type : 'POST',
								url : 'deleteDir.action?dirIdList='
										+ deleteDirList + '&fileIdList='
										+ deleteFileList,
								success : function(data) {

									if (data == "success") {
										layer.msg('删除成功!', {
											icon : 1,
											time : 1000
										});
										$("#delAll").prop("checked", false);
										$(".deleteOne").prop("checked", false);
										location.reload();
									} else
										layer.msg('删除失败!', {
											icon : 2,
											time : 1000
										});
								},
								error : function(data) {
									layer.msg('找不到服务器!', {
										icon : 3,
										time : 1000
									});
								},
							});

						}, function(index) {
							//按钮【按钮二】的回调
						});
			} else {
				layer.msg('回收站为空!', {
					icon : 2,
					time : 2000
				});
			}
		}
		//清空回收站
		function deleteRecDir() {
			var allnum = 0;
			deleteFileList = new Array();
			deleteDirList = new Array();
			$(".fileId").each(function() {
				var id = $(this).val();
				deleteFileList.push(id);
				allnum++;
			});
			$(".dirId").each(function() {
				var id = $(this).val();
				deleteDirList.push(id);
				allnum++;

			});
			//  alert("文件夹："+deleteDirList+"  文件："+deleteFileList+"num:"+allnum);  

			if (allnum > 0) {
				layer.confirm('文件删除后不可恢复,确认要彻底删除' + allnum + '个文件/文件夹吗？</br>',
						{

							btnAlign : 'c',
							title : '删除',
							btn : [ '确认', '取消' ]

						}, function(index, layero) {
							//按钮【按钮一】的回调 
							$.ajax({
								type : 'POST',
								url : 'deleteDir.action?dirIdList='
										+ deleteDirList + '&fileIdList='
										+ deleteFileList,
								success : function(data) {

									if (data == "success") {
										layer.msg('删除成功!', {
											icon : 1,
											time : 1000
										});
										$("#delAll").prop("checked", false);
										$(".deleteOne").prop("checked", false);
										location.reload();
									} else
										layer.msg('删除失败!', {
											icon : 2,
											time : 1000
										});
								},
								error : function(data) {
									layer.msg('找不到服务器!', {
										icon : 3,
										time : 1000
									});
								},
							});

						}, function(index) {
							//按钮【按钮二】的回调
						});
			} else {
				layer.msg('回收站为空!', {
					icon : 2,
					time : 2000
				});
			}
		}
		function setSelectionRange(input, selectionStart, selectionEnd) {
			//alert("aaaa");  
			if (input.setSelectionRange) {
				input.focus();
				input.setSelectionRange(selectionStart, selectionEnd);
			} else if (input.createTextRange) {
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