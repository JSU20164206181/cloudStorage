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
		<title>我的分享</title>
		<link rel="stylesheet" href="web/font-awesome/css/font-awesome.css">
		<link rel="stylesheet" href="web/layui/css/layui.css">
		<script type="text/javascript" src="web/js/jquery.min.js"> </script>
		<script type="text/javascript" src="web/layui/layui.all.js"></script>
		<script type="text/javascript" src="web/layui/layui.js"></script>
		<script type="text/javascript" src="web/layui/lay/modules/laypage.js"></script>
		<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>

		<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
		<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
		<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

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

			.pathHerf:link,
			.pathHerf:visited,
			.pathHerf:hover,
			.pathHerf:active {
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
  <div class="" style="z-index: 99; position: fixed ! important;top: 60px;left:13.2%;width:85.7%;background:#f2f2f2;"> 
						<div style="width:100%;margin-left:40px;margin-top:20px;">
							<div class="layui-btn-group">
								<button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;" onclick="deleteChose()"><i
									 class="fa fa-trash" aria-hidden="true"></i>取消分享</button>
							</div>
						</div>

						<div class="layui-row layui-col-space10" style=" margin:10px;">
							<div class="layui-col-md10">
								<span id="pathSpan" style="margin-left:20px;"></span>
							</div>
							<div class="layui-col-md2">
								已加载：${shareList.size()}个
							</div>
						</div>

						<div style="width:98.8%;margin-left:14px;">
							<table class="layui-table" lay-skin="nob">
								<thead>
									<tr>
										<th width="90">
											<div class="layui-row ">
												<div class="layui-col-md12" style="margin-right: -20px;">
													<input style="color:blue;" id="delAll" onclick="deleteAll()" type="checkbox" />
													<span style="margin-right:10px;" id="choseNum">文件名</span>
												</div>
											</div>
										</th>
										<th width="50" style="text-align:left;">分享时间</th>
										<th width="100">有效期</th>
										<th width="100">链接</th>
										<th width="20">提取码</th> 
									</tr>
								</thead>
							</table>
						</div>
					</div>

					<table class="layui-table" lay-skin="line" style="position: absolute; top: 140px;">
						<tbody id="tableClass">
							<c:forEach items="${shareList}" var="share" varStatus="i" step="1">
								<tr class="listOne" id="listOneDir${i.index}">
									<td width="140">
										<div class="layui-row ">
											<div class="layui-col-md10" style="margin-right: -20px;">
												<input class="deleteOne dirId" onclick="deleteOne()" value="${share.shareId}" type="checkbox">
											     ${share.shareName }
											</div>
											<div class="layui-col-md2" onclick="choseOne()">
											
											</div>
										</div>
										
									</td>
									 
									<td width="50"><span><fmt:formatDate value='${share.createDatetime}' type='both' pattern='yyyy-MM-dd hh:mm' /></span></td>
									<c:if test="${share.validDate==1 }">
									<td width="80">1天</td>
									</c:if>
									<c:if test="${share.validDate==2 }">
									<td width="80">7天</td>
									</c:if>
									<c:if test="${share.validDate==3 }">
									<td width="80">永久</td>
									</c:if>
									<td width="80">${share.shareUrl }</td>
									<td width="80">${share.shareCommand }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			/* 全选 */
			var check = $(".deleteOne");
			var checkNum = 0;

			function deleteAll() {
				if ($('#delAll').is(':checked')) {
					$(".deleteOne").prop("checked", true); //全选		 
					checkNum = check.length;

				} else {
					$(this).prop("checked", false);
					$(".deleteOne").prop("checked", false); //取消全选 		
					checkNum = 0;
				}
				if (checkNum == 0) {
					$("#choseNum").html("文件名");
				} else {
					$("#choseNum").html("已选中" + checkNum + "文件");
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
					$("#choseNum").html("已选中" + checkNum + "文件");
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
					$("#choseNum").html("已选中" + checkNum + "文件");
				}
			}
			//删除
			var deleteFileList;
			var deleteDirList;

			function deleteChose() {
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
				
				console.log(deleteDirList);

				if (allnum > 0) {
					layer.confirm('确认要取消' + allnum + '个文件的分享吗？', {
						btnAlign: 'c',
						btn: ['确认', '取消']

					}, function(index, layero) {
						//按钮【按钮一】的回调
						$.ajax({
							type: 'POST',
							url:'deleteMyShare.action?shareIdList='+deleteDirList,
							success: function(data) {
									layer.msg('取消分享成功!', {
										icon: 1,
										time: 1000
									});
									$("#delAll").prop("checked", false);
									$(".deleteOne").prop("checked", false);
									alert("取消分享成功!");
									location.reload();
							},
							error: function(data) {
								layer.msg('找不到服务器!', {
									icon: 3,
									time: 1000
								});
							},
						});
					}, function(index) {
						//按钮【按钮二】的回调
					});
				} else {
					layer.msg('请选择文件!', {
						icon: 2,
						time: 2000
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
