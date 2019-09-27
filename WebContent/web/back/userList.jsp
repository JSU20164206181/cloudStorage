<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/9/2
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <!--[if lt IE 9]>
    <script type="text/javascript" src="web/lib/html5shiv.js"></script>
    <script type="text/javascript" src="web/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="web/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="web/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="web/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>用户管理</title>
</head>
<body>
<jsp:include page="menu.jsp"/>
<jsp:include page="head.jsp"/>
<section class="Hui-article-box">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 用户列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c"> 输入关键词：
     <%--   <input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}' })" id="datemin" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d' })" id="datemax" class="input-text Wdate" style="width:120px;">--%>
        <input type="text" class="input-text" style="width:250px" placeholder="输入会员名称、电话、邮箱" id="" name="">
        <button type="submit" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe665;</i> 搜用户</button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
            <a href="javascript:;" onclick="member_add('添加用户','web/back/user-add.jsp','','610')" class="btn btn-primary radius">
                <i class="Hui-iconfont">&#xe600;</i> 添加用户</a>
        </span>
        <span class="r">共有数据：<strong>${totalNum}</strong> 条&nbsp;&nbsp;&nbsp;
        <li class="dropDown dropDown_hover"><a href="" class="dropDown_A" onclick="return false">
            <i class="Hui-iconfont" style="font-size: 25px; color: #5a98de; margin-right: 100px; margin-top: 10px;">&#xe641;</i></a>
        <ul class="dropDown-menu menu radius box-shadow">
            <li><a href="javascript:;" onClick="impUsers('onePage')">导出本页</a></li>
            <li><a href="javascript:;" onClick="impUsers('allPage')">全部导出</a></li>

        </ul></li></span> </div>
    <div class="mt-20">

        <form action="batchDeleteUser.action" id="deleteform" method="post">

        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" onclick="selectAll(this)" value=""></th>
                <th width="80">ID</th>
                <th width="100">用户名</th>
                <th width="100">真实姓名</th>
                <th width="40">性别</th>
                <th width="110">手机</th>
                <th width="150">邮箱</th>
                <th width="200">会员等级</th>
                <th width="200">加入时间</th>
                <th width="70">状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${userList}" var="user">
            <tr class="text-c">
                <td><input type="checkbox"  name="userId" value="${user.userId}"></td>
                <td>${user.userId}</td>
                <td><u style="cursor:pointer" class="text-primary" onclick="member_show('用户信息查看','userDetail.action?userId=${user.userId}','${user.userId}','360','470')">${user.userName}</u></td>
                <td>${user.person.realName}</td>
                <td>${user.person.sex}</td>
                <td>${user.person.phone}</td>
                <td>${user.person.email}</td>
                <td>
                    <c:choose>
                        <c:when test="${user.memberOrder ==1}">普通用户</c:when>
                        <c:when test="${user.memberOrder ==2}">会员</c:when>
                        <c:otherwise>超级会员</c:otherwise>
                    </c:choose>
                </td>
                <td><fmt:formatDate value="${user.person.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                <td class="td-status">
                    <c:choose>
                        <c:when test="${user.userStatus == 1}">
                            <span class="label label-success radius">已启用</span>
                        </c:when>
                        <c:otherwise>
                            <span class="label label-defaunt  radius">已停用</span>
                        </c:otherwise>
                    </c:choose></td>
                <td class="td-manage">
                    <c:choose>
                        <c:when test="${user.userStatus == 1}">
                            <a style="text-decoration:none" onClick="member_StopAndStart(this,${user.userId},1)" href="javascript:;" title="停用">
                                <i class="Hui-iconfont">&#xe631;</i></a>
                        </c:when>
                        <c:otherwise>
                            <a style="text-decoration:none" onClick="member_StopAndStart(this,${user.userId},0)" href="javascript:;" title="启用">
                                <i class="Hui-iconfont">&#xe6e1;</i></a>
                        </c:otherwise>
                    </c:choose>
                    <a title="编辑" href="javascript:;" onclick="member_edit('编辑','modifyUser.action?userId=${user.userId}','','510')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a style="text-decoration:none" class="ml-5" onClick="change_password('修改密码','change-password.html','10001','600','270')" href="javascript:;" title="修改密码"><i class="Hui-iconfont">&#xe63f;</i></a>
                    <a title="删除" href="javascript:;" onclick="member_del(this,${user.userId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe60b;</i></a></td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
        <div class="dataTables_info">每页显示10条 ，共 ${totalPage} 页</div>
        <div id="DataTables_Table_0_wrapper"
             class="dataTables_wrapper no-footer">
            <div class="dataTables_paginate paging_full_numbers" id="tablePage">
                <a class="paginate_button first disabled"
                   aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0"
                   id="firstPage" href="showUsers.action?page=1">第一页</a>
                <c:choose>
                    <c:when test="${page<totalPage}">
                        <a class="paginate_button next disabled"
                           aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
                           id="nextPage" href="showUsers.action?page=${page-1 }">上一页</a>
                    </c:when>
                    <c:otherwise>
                        <a class="paginate_button previous disabled"
                           aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
                           id="previousPage" href="javascript:(0);">上一页</a>
                    </c:otherwise>
                </c:choose>
                <span><a class="paginate_button current"
                         aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${page}</a></span>
                <c:choose>
                    <c:when test="${page<totalPage}">
                        <a class="paginate_button next disabled"
                           aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
                           id="nextPage" href="showUsers.action?page=${page+1 }">下一页</a>
                    </c:when>
                    <c:otherwise>
                        <a class="paginate_button previous disabled"
                           aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
                           id="previousPage" href="javascript:(0);">下一页</a>
                    </c:otherwise>
                </c:choose>
                <a class="paginate_button last disabled"
                   aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
                   id="lastPage" href="showUsers.action?page=${totalPage}">最后一页</a>
            </div>
        </div>

    </div>
</div>
</section>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="web/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="web/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="web/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="web/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="web/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="web/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="web/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    /*$(function(){
        $('.table-sort').dataTable({
            "aaSorting": [[ 1, "desc" ]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
              //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
              {"orderable":false,"aTargets":[0,8,9]}// 制定列不参与排序
            ]
        });

    });*/

    function datadel() {
        if($('input[type=checkbox][name=userId]').length<1){
            alert("请选择要删除的数据！");
            return;
        }
        layer.confirm('确认要删除这几条记录吗？', function(index) {
            document.getElementById('deleteform').submit();
        });
    }

    /*导出数据*/
    function impUsers(choose){
        var ch;
        var pag = ${page};
        if(choose == 'onePage')
            ch = '本页';
        else
            ch = '全部';

        layer.confirm('确认要导出'+ch+'数据吗？',function () {
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath}/exportUser.action',
                data:{
                    'page':pag
                },
                async: false,
                success:function (data) {
                    if(data!='error'){
                        layer.msg('已成功导出到'+data,{icon:1,btn:'明白了',offset:'40%',time:20000});
                    }else {
                        layer.msg('导出失败',{icon:2,offset:'40%',time:1000});
                    }
                }
            });
        });
    }

    /*全选与取消全选*/
    function  selectAll(obj) {
        console.log($('input[type=checkbox][name=userId]').length);
        console.log(obj.checked);
        if(obj.checked==true){
            $('input[type=checkbox][name=userId]').prop("checked",true);
        }else {
            $('input[type=checkbox][name=userId]').prop("checked",false);
        }
    }

    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }


    /*用户-查看*/
    function member_show(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*用户-停用和启用*/
    function member_StopAndStart(obj,id,flag){
        var  making;
        if(flag == 1){
           making = '停用';
        }else
            making = '启用';
        layer.confirm('确认要'+making+'吗？',function(index){
            $.ajax({
                type: 'POST',
                data:{
                    'userId':id
                },
                url: '${pageContext.request.contextPath}/stopAndStart.action',

                success: function(data){
                    console.log(data);
                    if(data == 'success') {
                        if (flag == 1) {
                            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="member_StopAndStart(this,id,0)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
                            $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>');
                            $(obj).remove();
                            layer.msg('已停用!', {icon: 1, offset:'40%',time: 1000});
                        } else {
                            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="member_StopAndStart(this,1)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>');
                            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
                            $(obj).remove();
                            layer.msg('已启用!', {icon: 1, offset:'40%',time: 1000});
                        }
                    }else {
                        layer.msg('操作失败',{icon:2,time:1000,offset:'40%'});
                    }
                },
                error:function(data) {
                    console.log(data);
                    console.log(data.msg);
                },
            });
        });
    }


    /*用户-编辑*/
    function member_edit(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*密码-修改*/
    function change_password(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*用户-删除*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                type: 'POST',
                data:{
                    "userId":id
                },
                url: '${pageContext.request.contextPath}/deleteUser.action',
                success: function(data){
                    if(data=="success") {
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', {icon: 1, offset: '40%', time: 1000});
                    }else {
                        layer.msg('删除失败！',{icon:2,offset:'40%',time:1000});
                    }
                },
                error:function(data) {
                    console.log(data.msg);
                },
            });
        });
    }
</script>
</body>
</html>
