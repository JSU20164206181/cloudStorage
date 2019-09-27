<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<base href="<%=basePath%>">
<style type="text/css">
	.mainContent{
		overflow: auto;
	} 
   </style >     
<header>
<script>
function fileManager() {

    window.location.href("toFileList.action");          
}
function personCenter() {
    $("#mainContent").load("personCenter.html");
}

function about() {
    $("#mainContent").load("about.html");
}

function redirectUpdateUpwd() {
    $("#mainContent").load("updateUpwd.html");
}

function showCharts() {
    $("#mainContent").load("analysis.html");
}

function exit() {
    layer.confirm("确认要真的退出系统么？", {title: "确认提示", btn: ['残忍离开', '继续使用']}, function (index) {
        sessionStorage.clear();//销毁所有session存储
        window.location.href = "index.html";
    });
} 

function uploadUserFile() {
    $("#mainContent").load("uploadFile.html");
}

/* 模糊查找 */
function fuzzyFind() {
	var content=$("#content").val();
	window.location.href = "fuzzyFindMyFiles.action?content="+content;
}

function openAdminIndex() {
    $("#mainContent").load("welcome.html");
}
    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

        //监听导航点击
        element.on('nav(test)', function (elem) {
            alert(elem);
            layer.msg(elem.text());
        });
    });
</script>   
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">
            <img src="web/images/logo_admin.png" alt="login" style="width: 100%;"/>
            <!--  融创软通网络云盘客户端-->
        </div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">

            <li class="layui-nav-item">
                <button class="layui-btn layui-btn-primary" onclick="javascript:openAdminIndex()">
                    <i class="layui-icon layui-icon-home"></i> 首页
                </button>
            </li>
            <li class="layui-nav-item">
                <button class="layui-btn layui-bg-green" onclick="javascript:fileManager(null,null)"
                        style="margin-left: 10px">
                    <i class="layui-icon layui-icon-template-1"></i> 全部文件
                </button>
            </li>
            <li class="layui-nav-item">
                <button class="layui-btn layui-btn-danger" onclick="uploadUserFile()" style="margin-left: 10px">
                    <i class="layui-icon layui-icon-upload-drag"></i> 上传文件
                </button>
            </li>
            <li class="layui-nav-item">&nbsp;&nbsp;&nbsp;&nbsp;</li>
            <li class="layui-nav-item">
                <input id="content" value="${content }" class="layui-input-block" placeholder="搜索文件/文件夹">
                <button id="search_btn" class="layui-btn layui-btn-danger" onclick="fuzzyFind()">
                    <i class="layui-icon layui-icon-search"></i>
                </button>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img id="userPhoto" src="web/images/myphoto.jpg" class="layui-nav-img">
                    <span id="loginUserName"></span>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:personCenter()"><span class="layui-icon layui-icon-user"></span> 完善个人信息</a>
                    </dd>
                    <dd><a href="javaScript:redirectUpdateUpwd()"><span class="layui-icon layui-icon-util"></span> 修改密码</a>
                    </dd>
                    <dd><a href="javaScript:about()"><span class="layui-icon layui-icon-util"></span> 关于我们</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="javascript:exit()">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <!--普通用户也有-->
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="#"><span class="layui-icon layui-icon-password"></span> 我的私有文件</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:fileManager('isVideo',0);"><span
                                class="layui-icon layui-icon-video"></span> 视频</a></dd>
                        <dd><a href="javascript:fileManager('isAudio',0);"><span
                                class="layui-icon layui-icon-headset"></span> 音乐</a></dd>
                        <dd><a href="javascript:fileManager('isPicture',0);"><span
                                class="layui-icon layui-icon-picture"></span> 照片</a></dd>
                        <dd><a href="javascript:fileManager('isDocument',0);"><span
                                class="layui-icon layui-icon-file"></span> 文档</a></dd>
                        <dd><a href="javascript:fileManager('isOthers',0);"><span
                                class="layui-icon layui-icon-component"></span> 其他</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#"><span class="layui-icon layui-icon-share"></span> 我的共享文件</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:fileManager('isVideo',1);"><span
                                class="layui-icon layui-icon-video"></span> 视频</a></dd>
                        <dd><a href="javascript:fileManager('isAudio',1);"><span
                                class="layui-icon layui-icon-headset"></span> 音乐</a></dd>
                        <dd><a href="javascript:fileManager('isPicture',1);"><span
                                class="layui-icon layui-icon-picture"></span> 照片</a></dd>
                        <dd><a href="javascript:fileManager('isDocument',1);"><span
                                class="layui-icon layui-icon-file"></span> 文档</a></dd>
                        <dd><a href="javascript:fileManager('isOthers',1);"><span
                                class="layui-icon layui-icon-component"></span> 其他</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="#"><span class="layui-icon layui-icon-util"></span> 个人资源统计</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:showCharts();"><span class="layui-icon layui-icon-chart"></span>
                            统计分析</a></dd>
                        <dd><a href="javascript:sousou()"><span class="layui-icon layui-icon-chart-screen"></span> 报表打印</a>
                        </dd>

                    </dl>
                </li>

            </ul>
        </div>
    </div>
 
    <div class="layui-footer" align="center">
        <!-- 底部固定区域 -->
        © 2018-2019 融创软通科技股份 Copy Right
    </div>
</div>



</header>