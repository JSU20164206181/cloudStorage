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
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="web/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/javascript" src="web/js/vcode/jquery.min.js">
	
</script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>
<!--  ZTree -->
<link type="text/css" rel="stylesheet"
	href="web/zTree_v3/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="web/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="web/zTree_v3/js/jquery.ztree.excheck.js"></script>
<style type="text/css">
.ztree li span.button.diy03_ico_docu {
	
}
</style>
</head>
<body>
	<div class="edit_content" style="position: absolute;">
		<div class="qxlb" style="margin-top: 10px; margin-bottom: 50px;">
			<div class="add_title"></div>
			<div class="qxlb_content">
				<ul id="tree" class="ztree"></ul>
			</div>
		</div>
		<div class=""
			style="z-index: 9999; position: fixed ! important; top: 210px; width: 405px; height: 50px; background: #f2f2f2;">
			<button type="button" onclick="chose()"
				class="layui-btn layui-btn-primary layui-btn-sm"
				style="margin-top: 10px; margin-left: 30%; background: #3cb7ef; color: white;">确认</button>
			<button type="button" onclick="closeWindow()"
				class="layui-btn layui-btn-primary layui-btn-sm"
				style="margin-top: 10px; margin-left: 10%; background: white; color: #3cb7ef;">取消</button>
		</div>
	</div>

	<SCRIPT type="text/javascript">
		var jsonStr = '${listTree}';
		var jsonObj = $.parseJSON(jsonStr);
		var zTree;
		//创建树型结构
		function createTree() {
			var setting = {
				check : {
					nable : false,
					autoCheckTrigger : false
				},

				view : {
					dblClickExpand : true,
					txtSelectedEnable : true,
					expandSpeed : "",

				},
				//异步加载
				async : {
					enable : true
				},
				//这个data里面的pIdKey,idKey,name等等之类的都是对应后台查出的字段名字，在sql中写好或者在拼接json的时候先拼接好，前太接收的时候只要对应一直就可以了
				data : {
					simpleData : {
						enable : true,
						pId : "pId",
						id : "id"
					},
					key : {
						checked : "CHECKED",
						name : "name"
					}
				},
				callback : {
					onAsyncSuccess : zTreeOnAsyncSuccess
				}
			};
			//初始化    
			zTree = $.fn.zTree.init($("#tree"), setting, jsonObj);
			zTree.expandAll(false);

		}
		/* 异步加载无法展开tree 默认展开一级菜单 */
		var firstAsyncSuccessFlag = 0;
		function zTreeOnAsyncSuccess(event, treeId, msg) {
			if (firstAsyncSuccessFlag == 0) {
			}
		}
		$(function() {
			//页面加载完成创建树
			createTree();
		});
		var dirList;
		var fileList;
		dirList = "${dirList}";
		fileList = '${fileList}';
		//alert(dirList[0] + "0-----0" + fileList);
		//alert(dirList);   
		function chose() {

			var type='${type}';
			var tip = "";
			if (type == "copy") {
				tip = "复制";
				url = "copyDir.action"
			} else if (type == "move") {
				tip = "移动";
				url = "moveDir.action"
			}

			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var sNodes = treeObj.getSelectedNodes();
			if (sNodes.length > 0) {
				var tId = sNodes[0].id;
				url = url + "?dirList=" + dirList + "&fileList=" + fileList
						+ "&aimId=" + tId;
				var next = 0;
				//复制
				if (type == "copy") {
					$
							.ajax({
								type : 'POST',
								url : url,
								success : function(data) {
									if (data == "have") {
										layer
												.confirm(
														'文件/文件夹已存在，是否继续？</br>',
														{

															btn : [ '确认', '取消' ]

														},
														function(index) {
															//按钮【按钮一】的回调 
															layer.close(index);
															next = 1;
															$
																	.ajax({
																		type : 'POST',
																		url : url
																				+ "&status=yes",
																		success : function(
																				data) {
																			alert("result"
																					+ data);
																			if (data == "success") {
																				layer
																						.msg(
																								tip
																										+ '成功!',
																								{
																									icon : 1,
																									time : 2000
																								});
																				var index = parent.layer
																						.getFrameIndex(window.name);
																				parent.location
																						.reload();
																				parent.layer
																						.close(index);
																			} else if (data == "aim") {
																				layer
																						.msg(
																								tip
																										+ '失败!移动文件不能包含目标文件。',
																								{
																									icon : 2,
																									time : 1000
																								});
																			} else if (data == "have") {
																			} else {
																				layer
																						.msg(
																								tip
																										+ '失败!未知原因',
																								{
																									icon : 2,
																									time : 1000
																								});
																			}

																		},
																		error : function(
																				data) {
																			layer
																					.msg(
																							'找不到服务器!',
																							{
																								icon : 3,
																								time : 1000
																							});

																		},
																	});

														}, function(index) {
															//按钮【按钮二】的回调
															next = 0;
														});
									} else {
										next = 1;
										$
												.ajax({
													type : 'POST',
													url : url + "&status=yes",
													success : function(data) {
														alert("result" + data);
														if (data == "success") {
															layer.msg(tip
																	+ '成功!', {
																icon : 1,
																time : 2000
															});
															var index = parent.layer
																	.getFrameIndex(window.name);
															parent.location
																	.reload();
															parent.layer
																	.close(index);
														} else if (data == "aim") {
															layer
																	.msg(
																			tip
																					+ '失败!移动文件不能包含目标文件。',
																			{
																				icon : 2,
																				time : 1000
																			});
														} else if (data == "have") {
														} else {
															layer
																	.msg(
																			tip
																					+ '失败!未知原因',
																			{
																				icon : 2,
																				time : 1000
																			});
														}

													},
													error : function(data) {
														layer.msg('找不到服务器!', {
															icon : 3,
															time : 1000
														});

													},
												});
									}

									if (next == 1) {

									}

								},
								error : function(data) {
									layer.msg('找不到服务器1!', {
										icon : 3,
										time : 1000
									});
									next = 0;
								},
							});
					//移动
				} else if (type == "move") {
					// alert("move");
					$.ajax({
						type : 'POST',
						url : url + "&status=yes",
						success : function(data) {
							//alert("result" + data);
							if (data == "success") {
								layer.msg(tip + '成功!', {
									icon : 1,
									time : 2000
								});
								var index = parent.layer
										.getFrameIndex(window.name);
								parent.location.reload();
								parent.layer.close(index);
							} else if (data=="aim1") {  
								layer.msg(tip + '失败!移动文件不能包含目标文件。', {
									icon : 2,
									time : 2000
								});
							} else if (data == "aim2") {
								layer.msg('文件已在当前目录下，无需移动。', { 
									icon : 2,
									time : 2000 
								});
							}else if (data == "have") {
							} else {
								layer.msg(tip + '失败!未知原因', {
									icon : 2,
									time : 1000
								});
							}

						},  
						error : function(data) {
							layer.msg('找不到服务器!', {
								icon : 3,
								time : 1000
							});

						},
					});

				}

			} else {
				layer.msg('请选择一个文件夹!', {
					icon : 2,
					time : 1000
				});
			}
		} 
		function closeWindow() {
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);

		}
	</SCRIPT>

</body>
</html>