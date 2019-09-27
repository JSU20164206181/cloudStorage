<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; 
%> 
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<title>webuploader上传</title>
<link rel="stylesheet" type="text/css" href="webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="webuploader/bootstrap.css">
<script type="text/javascript" src="webuploader/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="webuploader/webuploader.js"></script>
<script type="text/javascript" src="webuploader/hashmap.js"></script>
<!-- 头部引入公共部分 -->
	<link rel="stylesheet" href="web/layui/css/layui.css">
    <link rel="stylesheet" href="web/font-awesome/css/font-awesome.css"> 
    <script type="text/javascript" src="web/js/vcode/jquery.min.js"> </script> 
    <script type="text/javascript"  src="web/layui/layui.all.js" ></script> 
    <script type="text/javascript"  src="web/layui/layui.js" ></script>     
    <script type="text/javascript"  src="web/layui/lay/modules/laypage.js" ></script>  
	
<!-- /头部引入公共部分  -->  
<style type="text/css">
#picker {
    display: inline-block;
    line-height: 1.428571429;
    vertical-align: middle;
    margin: 0 12px 0 0;
}
</style>
</head>
<!-- 公共部分 -->
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<jsp:include page="user-head.jsp"></jsp:include>
	<div class="layui-body">
    <div id="mainContent" style="padding: 15px;">
    <!-- /公共部分 -->
    
    <!-- 业务界面 -->
	<div id="uploader" class="container">
		<!--用来存放文件信息-->
		<div id="thelist" class="row">
			<div class="panel panel-primary">
  				
  				<table class="table table-striped table-bordered" id="uploadTable">
  					<thead>
  						<tr>
  							<th>序号</th>
  							<th>文件名称</th>
  							<th>文件大小</th>
  							<th>上传状态</th>
  							<th>上传进度</th>
  							<th>操作</th>
  						</tr>
  					</thead>
  					<tbody></tbody>
  				</table>
  				<div class="panel-footer">
  					<div id="picker">选择文件</div>
					<button id="btn" class="btn btn-default">开始上传</button>
  				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- /业务界面 -->
	
	<!-- 底部公共部分 -->
    <div class="layui-footer" align="center">
       
        © 2018-2019 阿里云网盘 Copy Right
    </div>
</div>
</div>


<!-- /底部公共部分 -->
	<script type="text/javascript">
		
		var $list=$("#thelist table>tbody");
		var state = 'pending';//初始按钮状态
		var $btn=$("#btn");
		var count=0;
		var fileList=[];
		var fileCount;
		var map=new HashMap();
		//监听分块上传过程中的三个时间点  
		WebUploader.Uploader.register({
			
			
			"before-send-file" : "beforeSendFile",
			"before-send" : "beforeSend",
			"after-send-file" : "afterSendFile",
		}, {
			
			//时间点1：所有分块进行上传之前调用此函数  
			beforeSendFile : function(file) {
				
				
				
				var deferred = WebUploader.Deferred();
				var md5Val = $('#' + file.id).find("td input").val();
				//检测当前文件是否是上一次未传输完成的文件
				if(md5Val==""){
					//1、计算文件的唯一标记，用于断点续传  
				
					(new WebUploader.Uploader()).md5File(file, 0,50 * 1024 * 1024)
							.progress(function(percentage) {
								$('#' + file.id).find("td.state").text("正在读取文件信息...");
							}).then(function(val) {
								fileCount = file.id.charAt(file.id.length-1);
								fileList[fileCount].fileMd5 = val;
								$('#' + file.id).find("td.state").text("成功获取文件信息...");
								/*//存入文件块信息入数据库
								$.ajax({
									type : "POST",
									url : "addFileChunk.action",
									data : {
										//文件唯一标记  
										fileMd5 : fileMd5,
										percentage : 0,
										fileStatus: 1,
										chunk: 0,
										fileName: file.name,
									},
									
									success : function(data) {
										console.log("存入数据库成功")
										//获取文件信息后进入下一步  
										deferred.resolve();
										
									}
								});
								*/
								deferred.resolve();
							});
					
				}else{
					
					fileMd5 = md5Val;
					console.log(fileMd5)
				}
				
				
				return deferred.promise();
			},
			//时间点2：如果有分块上传，则每个分块上传之前调用此函数  
			beforeSend : function(block) {
				//console.log(block)
				
				var deferred = WebUploader.Deferred();
				
				$.ajax({
					type : "POST",
					url : "checkFile.action?action=checkChunk",
					data : {
						//文件唯一标记  
						fileMd5 : fileList[fileCount].fileMd5,
						//当前分块下标  
						chunk : block.chunk,
						//当前分块大小  
						chunkSize : block.end - block.start
					},
					dataType : "json",
					success : function(response) {
						if (response.ifExist) {
							//分块存在，跳过  
							deferred.reject();
						} else {
							//分块不存在或不完整，重新发送该分块内容  
							deferred.resolve();
						}
					}
				});

				this.owner.options.formData.fileMd5 = fileList[fileCount].fileMd5;
				deferred.resolve();
				return deferred.promise();
			},
			//时间点3：所有分块上传成功后调用此函数  
			afterSendFile : function(file) {
				//如果分块上传成功，则通知后台合并分块  
				fileCount = file.id.charAt(file.id.length-1);
				console.log(fileCount+"@@@"+fileList[fileCount].fileMd5)
				$.ajax({
					type : "POST",
					url : "checkFile.action?action=mergeChunks",
					data : {
						fileMd5 : fileList[fileCount].fileMd5,
						fileSuffix: fileList[fileCount].fileSuffix,
						fileName: fileList[fileCount].fileName,
						fileSize: fileList[fileCount].fileSize,
					},
					success : function(response) {
						console.log("上传成功")
						
					}
				});
				
				
			}
		});

		var uploader = WebUploader.create({
					// swf文件路径  
					swf : 'webuploader/Uploader.swf',
					// 文件接收服务端。  
					server : 'webUploader.action',
					// 选择文件的按钮。可选。  
					// 内部根据当前运行是创建，可能是input元素，也可能是flash.  
					pick : {
						id : '#picker',//这个id是你要点击上传文件的id
						multiple : true
					},
					prepareNextFile: false,
					// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！  
					resize : true,
					auto : false,
					//开启分片上传  
					chunked : true,
					chunkSize :50 * 1024 * 1024,

					/* accept : {
						extensions : "txt,jpg,jpeg,bmp,png,zip,rar,war,pdf,cebx,doc,docx,ppt,pptx,xls,xlsx,iso",
						mimeTypes : '.txt,.jpg,.jpeg,.bmp,.png,.zip,.rar,.war,.pdf,.cebx,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.iso'
					} */
				});
		//添加上次未传输完毕的文件
		//var file1 = $("#1").get(0).files[0];
		/* var obj = {};
		obj.name = item.fileName;
		obj.size = item.size;
		obj.lastModifiedDate = item.createTime;
		obj.id = item.id;
		obj.ext = item.fileType.substr(1); */

		//var file = new WebUploader.File(file1);
		//此处是关键，将文件状态改为'已上传完成'
		//file.setStatus('queued');
		//uploader.addFiles(file);
		//console.log(file);
		//console.log(file1);
		//console.log(uploader.lib);
		//uploader.queue.prototype.append(file)
		//console.log(WebUploader.Queue.prototype.append(file));
		//if (files != "") {
			//console.log($("#1").get(0).files)
			//uploader.addFiles($("#1").get(0).files);
			//console.log($("#1").get(0).files)
		//}

		var a = 0;
		// 当有文件被添加进队列的时候  
		uploader.on('fileQueued',function(file) {
			//console.log(file);

			fileList.push({fileMd5:"",fileSuffix:file.ext,fileName:file.name,fileSize:file.size});
			//console.log(fileList);
			var fileSize = file.size;
			var fileSizeStr = "";
							
			fileSizeStr = WebUploader.Base.formatSize(fileSize);
			count++;
			$list.append('<tr id="' + file.id + '" class="item" flag=0>'
							+ '<td hidden><input class="md5" value="" type="text" /></td>'
							+ '<td class="index">'+ count+ '</td>'
							+ '<td class="info">'+ file.name+ '</td>'
							+ '<td class="size">'+ fileSizeStr+ '</td>'
							+ '<td class="state">等待上传...</td>'
							+ '<td class="percentage"></td>'
							+ '<td class="operate"><button name="delete" class="btn btn-error">删除</button></td></tr>');
			map.put(file.id + "", file);
		});

		// 文件上传过程中创建进度条实时显示。  
		uploader.on('uploadProgress', function(file, percentage) {
			$('#' + file.id).find('td.percentage').text(
					'上传中 ' + Math.round(percentage * 100) + '%');
		});

		uploader.on('uploadSuccess', function(file) {
			$('#' + file.id).find('td.state').text('已上传');
		});

		uploader.on('uploadError', function(file) {
			$('#' + file.id).find('td.state').text('上传出错');
		});

		uploader.on('uploadComplete', function(file) {
			uploader.removeFile(file);
		});

		uploader.on('all', function(type) {
			if (type === 'startUpload') {
				state = 'uploading';
			} else if (type === 'stopUpload') {
				state = 'paused';
			} else if (type === 'uploadFinished') {
				state = 'done';
			}

			if (state === 'uploading') {
				$btn.text('暂停上传');
			} else {
				$btn.text('开始上传');
			}
		});

		$btn.on('click', function() {
			if (state === 'uploading') {
				uploader.stop(true);
			} else {
				uploader.upload();
			}
		});

		$("body").on("click", "#uploadTable button[name='upload']", function() {
			flag = $(this).parents("tr.item").attr("flag") ^ 1;
			$(this).parents("tr.item").attr("flag", flag);
			var id = $(this).parents("tr.item").attr("id");
			if (flag == 1) {
				$(this).text("暂停");
				uploader.upload(uploader.getFile(id, true));
				fileCount++;
				if(fileCount==fileList.length()){
					fileCount = 0;
				}
			} else {
				//console.log("---"+uploader.getFile(id,true)+id)
				$(this).text("开始");
				uploader.stop(uploader.getFile(id, true));
				//uploader.stop(true);
				//uploader.skipFile(file);
				//uploader.removeFile(file);
				//uploader.getFile(id,true);
			}
		});

		$("body").on("click", "#uploadTable button[name='delete']", function() {
			var id = $(this).parents("tr.item").attr("id");
			$(this).parents("tr.item").remove();
			uploader.removeFile(uploader.getFile(id, true));
			map.remove(id);
		});
	</script>
</body>
</html>