<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/8/31
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <style type="text/css">



    </style>
</head>


<body>
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">
        <dl id="menu-article">
            <dt><i class="Hui-iconfont">&#xe616;</i> 文件管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="javascript:void(0)" data-title="用户文件管理" href="findAllFilesByPage.action?fileStatus=0">用户文件管理</a></li>
                    <li><a data-href="javascript:void(0)" data-title="分享文件管理" href="findAllSharesByPage.action">分享文件管理</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe613;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="javascript:void(0)" data-title="用户管理" href="showUsers.action">用户列表</a></li>
                    <li><a data-href="javascript:void(0)" data-title="用户审核" href="showAuditionUsers.action">用户审核</a></li>
                    <li><a data-href="javascript:void(0)" data-title="已删除用户" href="showDeleteUsers.action">已删除用户</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-tongji">
            <dt><i class="Hui-iconfont">&#xe61a;</i> 用户统计<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="javascript:void(0)" data-title="年龄分布" href="ageInfo.action">年龄分布</a></li>
                    <li><a data-href="javascript:void(0)" data-title="性别分布" href="sexInfo.action">性别分布</a></li>
                </ul>
            </dd>
        </dl>
    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
</body>
</html>
