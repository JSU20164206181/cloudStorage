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
    <title>文件管理</title>  
     <link rel="stylesheet" href="web/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="web/layui/css/layui.css">
    <script type="text/javascript" src="web/js/jquery.min.js"> </script> 
    <script type="text/javascript"  src="web/layui/layui.all.js" ></script> 
    <script type="text/javascript"  src="web/layui/layui.js" ></script>     
    <script type="text/javascript"  src="web/layui/lay/modules/laypage.js" ></script>  
   <script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>  
                   
    <style type="text/css">
    .layui-btn-sm{ 
    color:#3cb7ef;
    text-decoration: none;
    }
    .layui-btn-group{ 
    margin-left:20px;
    
    }
    .hidenfa {
     display:none;   
    }
    .hidenfa .fa{
    color:#3cb7ef;
    margin-left:10px; 

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
		<jsp:include page="user-head.jsp"></jsp:include>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="mainContent" style="padding: 15px;">
				 
			
  <div class="" style="z-index: 99; position: fixed ! important;top: 60px;left:14.7%;width:84.1%;background:#f2f2f2;"> 
  <div style="width:100%;margin-left:40px;margin-top:20px;">       
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;" onclick="addDir(${pId})"  > <i class="fa fa-plus" aria-hidden="true"></i>新建文件夹</button>
  <div class="layui-btn-group">    
  
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;"> <i class="fa fa-share-alt" aria-hidden="true"></i>分享</button>
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;"><i class="fa fa-download" aria-hidden="true"></i>下载</button>
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;"onclick="deleteChose()"><i class="fa fa-trash" aria-hidden="true"></i>删除</button>
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;" onclick="reName()">重命名</button> 
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;"onClick="copyDir('复制到','showTree.action?type=copy')">复制</button>   
    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" style=" color:#3cb7ef;"onClick="copyDir('移动到','showTree.action?type=move')">移动</button>
  </div> 
  </div>   
  <div class="layui-row layui-col-space10" style=" margin:10px;">
  <div class="layui-col-md10" > 
   <span id="pathSpan" style="margin-left:20px;"></span> 
  </div>
  
 
  <div class="layui-col-md2">
    已加载：${dirList.size()+fileList.size()}个  
  </div>
  </div>
 
<div style="width:98.8%;margin-left:14px;"> 
<table  class="layui-table" lay-skin="nob"  >    
  <thead>
    <tr >
      <th  width="260">
      <div class="layui-row ">
  <div class="layui-col-md12" style="margin-right: -20px;"> 
   <input style="color:blue;" id="delAll" onclick="deleteAll()" type="checkbox"/>
  
  
 <span style="margin-right:10px;" id="choseNum">文件名</span> 
  </div>
  </div>
     </th>   
      <th width="50" style="text-align:left;">大小</th>   
      <th width="80">修改时间</th>
    </tr> 
 
  </thead>
  </table>
  </div>
   </div>  
   
<table  class="layui-table" lay-skin="line"  style="position: absolute; top: 140px;"  >    
  <tbody id="tableClass" >    
    <c:forEach items="${fileList}" var="file" varStatus="i" step="1">  
    <tr  class="listOne" id="listOneFile${i.index}" >  
   <td width="150">  
    <div class="layui-row ">
  <div class="layui-col-md1" style="margin-right: -20px;">
     <input class="deleteOne fileId" onclick="deleteOne()" value="${file.fileId}" type="checkbox">    
  </div>
  <div class="layui-col-md11"  onclick="choseOne()" >
  
   <a style="text-decoration:none" href="?pId=${file.fileId}"  title="打开">   
    <c:if test="${file.fileType==1}">
   <span class='fa fa-file-image-o' style="margin-left:10px;color:#317ef3; font-size:25px"></span>  
   </c:if>
   <c:if test="${file.fileType==2}">
   <span class='fa fa-file-video-o' style="margin-left:10px;color:#317ef3; font-size:25px"></span> 
   </c:if>
   <c:if test="${file.fileType==3}">
   <span class='fa fa-file-text-o' style="margin-left:10px;color:#317ef3; font-size:25px"></span> 
   </c:if>
   <c:if test="${file.fileType==4}">
   <span class='fa fa-file-audio-o' style="margin-left:10px;color:#317ef3; font-size:25px"></span> 
   </c:if>
   <c:if test="${file.fileType==5}">
   <span class='fa fa-paper-plane-o' style="margin-left:10px;color:#317ef3; font-size:25px"></span> 
   </c:if> 
   <c:if test="${file.fileType==6}"> 
   <span class='fa fa-file-archive-o' style="margin-left:10px;color:#317ef3; font-size:25px"></span>   
   </c:if> 
   <span class="showName" style="margin-left:5px;font-size:12px;">${file.fileName}</span>  
   <input class="reNameId"  value="${file.fileId}" type="hidden">  
   </a>   
   </div> </div>
    </td >  
    <td width="30" onclick="choseOne()" >   
    <div class="hidenfa"  >   
     <a style="text-decoration:none" href="javascript:;"title="分享"> 
     <i  class="fa fa-share-alt fengxiang" aria-hidden="true"></i> 
	</a> 
	<a style="text-decoration:none" href="javascript:;"title="下载">
	 <i class="fa fa-download" aria-hidden="true"></i>
	</a> 	
	<a style="text-decoration:none" href="javascript:;" title="更多">
	<i class="fa fa-trash" aria-hidden="true"></i> 
	</a> 
		
	</div>   
    </td>
     <td width="50" onclick="choseOne()" ></td> 
     <td width="30" style="text-align:left;" onclick="choseOne()">   
     
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
  <tfoot> 
   <td><span >${nowPage}/${allPage}</span> </td>
   <td> </td>
   <td> </td>
   <td> </td>
 <td >   
 
    
   <div class="layui-btn-group "  >     
    <button type="button" class="layui-btn layui-btn-primary layui-btn-xs" style=" color:#3cb7ef;" onclick="window.location.href='showForType.action?type=${type}&nowPg=1'"> 第一页</button>
    <button type="button" class="layui-btn layui-btn-primary layui-btn-xs" style=" color:#3cb7ef;"  onclick="window.location.href='showForType.action?type=${type}&nowPg=${nowPage-1}'">上一页</button>
    <button type="button" class="layui-btn layui-btn-primary layui-btn-xs" style=" color:#3cb7ef;" onclick="window.location.href='showForType.action?type=${type}&nowPg=${nowPage+1}'">下一页</button>
    <button type="button" class="layui-btn layui-btn-primary layui-btn-xs" style=" color:#3cb7ef;" onclick="window.location.href='showForType.action?type=${type}&nowPg=${allPage}'">最后一页</button> 
  </div>  
  
  </td>
  </tfoot>
  
</table> 
  
</div> 

 </div>
  </div>
<script type="text/javascript"> 
$(document).ready(function(){    
	//显示路径 
	var allname="${nameList}";
	var allid="${idList}";
	var hStr="";
	if(allname==null||allname==""){
		var nameList="全部文件";
		var idList="0";
		hStr=nameList; 
	}else{
		allname="全部文件/"+allname; 
		allid="0/"+allid; 
		var nameList=allname.split("/");
		var idList=allid.split("/");  
		//alert("全部文件/${nameList}"+"  nameSize:"+nameList.length+"  idSize:"+idList.length);   	
		if(nameList.length>1){     
		
			hStr=hStr+'<a class="pathHerf" href="toFileList.action?pId='+idList[idList.length-2]+'">返回上一级</a>';        		
	  
		}
		for(var i=0;i<nameList.length-1;i++){ 
			
			var name=nameList[i];
			if(name.length>=5){  
				name=name.substring(0,2)+".."+name.substring(name.length-2,name.length);   
			}
			
			hStr=hStr+'<a class="pathHerf" title="'+nameList[i]+'" href="toFileList.action?pId='+idList[i] +'"> '+name+'></a>';     		
		}
		hStr=hStr+nameList[nameList.length-1];   
	}	
	    
	$("#pathSpan").html(hStr);  
	
	
	 
     //进入一行
	 $(".listOne").hover(function(){
		   $(this).addClass("enter");
		     var a=".enter .hidenfa";       		    
		     $(a).show();    
		},function(){			  
			     var a=".enter .hidenfa";       		    
			     $(a).hide(); 		
			     $(this).removeClass("enter");  
		}); 
      //数据为空
	 if($("#tableClass tr").length==0){
		 $("#tableClass").append("<tr> <td ></td> <td></td><td>没有数据</td><td></td><td></td></tr> ");  
		 	}
	 ${dirList.size()+fileList.size()}
	  
	  
	
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
//添加文件夹
function addDir() { 
	if( $(".dirName").length > 0){           	 	
	}else{
		$("#tableClass tr:first-child").before('<tr class="addTr"><td> <input class="deleteOne" onclick="deleteOne()" type="checkbox">'+       		     
           '<span style="margin-left:20px;color:#efb642;font-size:25px; ">'+ 
 		 '<i class="fa fa-folder"  style="color:#efb642;" aria-hidden="true"></i>'+       
		  '<input class="dirName" id="dirName" value="新建文件夹"  style="padding-left:4px;margin-left:20px;font-size:12px;border:1px solid #3cb7ef;color:#3cb7ef; height:27px;width:180px;" onclick="deleteOne()" type="text"> '+
		  '<i onclick="addDirtrue()" class="fa fa-check"  style="font-size:16px;padding:4px;color:#3cb7ef;" aria-hidden="true"></i>'+     
		  ' <i onclick="addDirFalse()" class="fa fa-times"  style="font-size:16px;padding:1px 6px;color:#3cb7ef;" aria-hidden="true"></i>'+     
		   '</span><td></td><td></td><td></td><td></td></tr>');   
		
		}
	  $(".dirName").select();   
}
function  removeValue() {
	//$(".dirName").val("");
} 
function addDirFalse() {
	$(".addTr").remove(); 	
}      
 function addDirtrue() { 
	 var name=$(".dirName").val();  
	 var pId="${pId}";  
	 if(name==""||name==null){
		 layer.msg('文件名不能为空!',{icon: 2,time:1000});   
		 $(".dirName").focus();   
	 }
	 else{
	// alert( 'addMyDir.action?pId='+pId+'dirName='+name);     
	 $.ajax({
			type: 'POST',
			url: 'addMyDir.action?pId='+pId+'&dirName='+name,  
			success: function(data){ 
				
				if(data=="success"){
		       layer.msg('添加成功!',{icon: 1,time:1000});  
		       location.reload();  
				}
				else
			   layer.msg('添加失败!',{icon: 2,time:1000});  
			},
			error:function(data) {
				 layer.msg('找不到服务器!',{icon: 3,time:1000});  
			},
		});		
 }
 }
 //删除
 var deleteFileList; 
 var deleteDirList;   
 function deleteChose() { 
	var allnum=0;
	deleteFileList= new Array(); 
	deleteDirList= new Array();  
	 $(".fileId").each(function() {		      
			if ($(this).is(':checked')) {			
				var id=$(this).val(); 		
				deleteFileList.push(id); 
				allnum++;
			}	
			});   
	    $(".dirId").each(function() {		      
			if ($(this).is(':checked')) {			
				var id=$(this).val(); 		
				deleteDirList.push(id); 
				allnum++;
			}	 
			});  
	  //  alert("文件夹："+deleteDirList+"  文件："+deleteFileList+"num:"+allnum);  
	
	    if(allnum>0){    
	    	layer.confirm('确认要把'+allnum+'个文件/文件夹放入回收站吗？</br>删除的文件可通过回收站还原.', {
	    		 btnAlign: 'c',
	    		  btn: ['确认', '取消'] 
	    		  
	    		}, function(index, layero){
	    		  //按钮【按钮一】的回调
	    			 $.ajax({
	    					type: 'POST',
	    					url: 'moveToRecycle.action?dirIdList='+deleteDirList+'&fileIdList='+deleteFileList,    
	    					success: function(data){  
	    						
	    						if(data=="success"){
	    				       layer.msg('删除成功!',{icon: 1,time:1000});  
	    				       $("#delAll").prop("checked", false);
	    					   $(".deleteOne").prop("checked", false);  
	    				       location.reload();  
	    						}
	    						else
	    					   layer.msg('删除失败!',{icon: 2,time:1000});  
	    					},
	    					error:function(data) {
	    						 layer.msg('找不到服务器!',{icon: 3,time:1000});  
	    					},
	    				});	
	    		  
	    		  
	    		}, function(index){
	    		  //按钮【按钮二】的回调
	    		});  
	    }  else{
			   layer.msg('请选择文件/文件夹!',{icon: 2,time:2000});  
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
	 
 //重命名
var className;
var dirName;
var reNameId;
var type; 	 
 function reName() {      
		//添加输入框	 
		var allnum=0;
	 if( $(".dirName").length > 0){ //是否·已有输入框            	 	
		}else{
			 $(".fileId").each(function() {	
			if ($(this).is(':checked')) {			
				className=$(this).parent().parent().find("a");	  				      
				 type="file";					
				 allnum++;
			}	
			});  
			 $(".dirId").each(function() {	
					if ($(this).is(':checked')) {			
						className=$(this).parent().parent().find("a");	  				
						type="dir"; 
						 allnum++; 
					}	
					}); 
   if(allnum==1){ 
			// alert("name:"+dirName+" type:"+type);  
			dirName=className.find(".showName").text();
			reNameId=className.find(".reNameId").val();
			className.find(".showName").text("");
	        className.after(''+          		      
	           '<span style="margin-left:20px;color:#efb642;font-size:25px; " class="reNmaeInp">'+        
	  		  '<input class="dirName" id="dirName" value="'+dirName+'"  style="padding-left:4px;margin-left:-20px;font-size:12px;border:1px solid #3cb7ef;color:#3cb7ef; height:27px;width:180px;" onclick="deleteOne()" type="text"> '+
	  		  '<i onclick="reNametrue()" class="fa fa-check"  style="font-size:16px;padding:4px;color:#3cb7ef;" aria-hidden="true"></i>'+     
	  		  ' <i onclick="reNameFalse()" class="fa fa-times"  style="font-size:16px;padding:1px 6px;color:#3cb7ef;" aria-hidden="true"></i>'+     
	  		   '</span>');    		
	  						   
			var len=dirName.length;  
			if(dirName.indexOf(".")!=-1){ 
				len=dirName.indexOf(".");   
				//alert(len); 	
			}
			 setSelectionRange(document.getElementById("dirName"),0,len);   
      }  
            else if(allnum>1){ 
				 layer.msg('只能选择一个文件/文件夹!',{icon: 2,time:1000});   
			 }
			 else if(allnum==0){
				 layer.msg('至少选择一个文件/文件夹!',{icon: 2,time:1000});   
			 } 
	 }
	 
	 
 }  
 function reNameFalse(){    
	 var name=dirName;
	 className.find(".showName").text(name); 
	 $(".reNmaeInp").remove(); 
	 	 
 }
 function reNametrue(){   
	 var name=$(".dirName").val();
	 className.find(".showName").text(name); 
	 $(".reNmaeInp").remove(); 
	 if(name==""||name==null){
		 layer.msg('文件名不能为空!',{icon: 2,time:1000});   
		 $(".dirName").focus();   
	 }
	 else{
	// alert( 'addMyDir.action?pId='+pId+'dirName='+name);     
	 $.ajax({
			type: 'POST',
			url: 'reName.action?id='+reNameId+'&type='+type+'&name='+name,  
			success: function(data){  			
				if(data=="success"){
		       layer.msg('重命名成功!',{icon: 1,time:1000});  
				}
				else
			   layer.msg('重命名失败!',{icon: 2,time:1000});  
			},
			error:function(data) {
				 layer.msg('找不到服务器!',{icon: 3,time:1000});  
			},
		});		
 }	 	 
 }
 
 // 复制文件夹
 function copyDir(title,url){ 
	   var allnum=0;
		deleteFileList= new Array(); 
		deleteDirList= new Array();  
		 $(".fileId").each(function() {		      
				if ($(this).is(':checked')) {			
					var id=$(this).val(); 		
					deleteFileList.push(id); 
					allnum++;
				}	
				});   
		    $(".dirId").each(function() {		      
				if ($(this).is(':checked')) {			
					var id=$(this).val(); 		
					deleteDirList.push(id); 
					allnum++;
				}	 
				});  
		   if(allnum>=1){
		    
	        url=url+"&dirList="+deleteDirList+"&fileList="+deleteFileList;  
	      //  alert("url"+url);   
	              //文件树子窗口
	 				layer.open({
						  title:title, 
						  type: 2, 
						  content: url,
						  area: ['400px', '300px'] 
							}); 
    			   } else{
    				   layer.msg('请选择文件/文件夹!',{icon: 2,time:2000});  
    			   }   
		   }
    </script>
</body>
</html>