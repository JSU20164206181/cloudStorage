<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="web/layui/css/modules/laydate/default/laydate.css">
<link rel="stylesheet" href="web/layui/css/layui.css">
<script type="text/javascript" src="web/js/vcode/jquery.min.js"></script>
<script type="text/javascript" src="web/layui/layui.all.js"></script>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<jsp:include page="user-head.jsp"></jsp:include>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="mainContent" style="padding: 15px;">
				<fieldset class="layui-elem-field layui-field-title"
					style="margin-top: 50px;">
					<legend>完善个人信息</legend>
				</fieldset>
				<div class="layui-row">
					<div class="layui-col-md6">
						<form method="post" action="updateUser.action" id="updateUserForm"
							class="layui-form" onsubmit="return check()">
							<div class="layui-form-item">
								<label class="layui-form-label">用户名</label>
								<div class="layui-input-inline">
									<input value="${sessionScope.userName}" id="username"
										name="userName" class="layui-input" type="text"
										placeholder="用户名不能小于6位数" autocomplete="off" lay-verify="title" />
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">真实姓名</label>
								<div class="layui-input-inline">
									<input value="${person.realName}" id="rname" name="realName"
										class="layui-input" type="text" placeholder="请输入真实姓名"
										autocomplete="off" lay-verify="title" />
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">性别</label> <input id="man"
									name="sex" title="男" type="radio" value="男" checked="checked" />

								<input id="woman" name="sex" title="女" type="radio" value="女"
									checked="checked" />
								<div class="layui-unselect layui-form-radio layui-form-radioed">
									<i class="layui-anim layui-icon"></i>
									<div>${person.sex}</div>
								</div>

							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label">你的邮箱</label>
									<div class="layui-input-inline">
										<input id="re_email" type="text" name="email"
											value="${person.email}"
											pattern="^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"
											required="required" class="layui-input" placeholder="请输入您的邮箱" />

									</div>
								</div>
							</div>
							<div class="layui-form-item">
								<div class="layui-inline">
									<label class="layui-form-label">联系电话</label>
									<div class="layui-input-inline">
										<input value="${person.phone}" id="telephone" name="phone"
											class="layui-input"
											pattern="^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))[0-9]{8}$"
											maxlength="11" type="tel" autocomplete="off"
											placeholder="请输入联系电话" />
									</div>
								</div>

							</div>

							<div class="layui-form-item">
								<label class="layui-form-label">你的年龄</label>
								<div class="layui-input-block">
									<input name="picture" value="${person.picture}" type="hidden" />
									<input value="${person.age}" id="page" name="age"
										class="layui-input" type="text" placeholder="请输入年龄"
										autocomplete="off" lay-verify="title">
								</div>
							</div>
							<div class="layui-form-item layui-form-text">
								<label class="layui-form-label">个人简介</label>
								<div class="layui-input-block">
									<textarea id="remark" name="introduction"
										class="layui-textarea" placeholder="请输入内容">${person.introduction}
                    </textarea>
								</div>
							</div>

							<div class="layui-form-item">
								<div class="layui-input-block">
									<input onclick="deleteWhite()" value="更新信息" type="submit"
										class="layui-btn" />
									<!-- <a href="document:updateUserForm.submit()" class="layui-btn">更新信息</a> -->
									<button class="layui-btn layui-btn-primary" type="reset">重置</button>
								</div>
							</div>
						</form>


					</div>
					<div class="layui-col-md3">
						<div class="layui-upload layui-col-lg-offset2" align="center">
							<div class="layui-upload-list">


								<img class="layui-upload-img" id="demo1" src="${person.picture}"
									style="width: 50%">
								<p id="demoText"></p>
							</div>
							<form action="HeadImgUpload.action" method="post"
								enctype="multipart/form-data">
								<button type="button" class="layui-btn" id="test1"
									onclick="uploadHeadImg()">更换头像</button>
								<input type="submit" id="tj" style="display: none" />

							</form>
							<input id="judgeName" type="hidden" /> <input id="judgeEmail"
								type="hidden" />
						</div>
					</div>
				</div>
				<script type="text/javascript">
					var aname = $("#username").val();
					$("#judgeName").val(aname);

					$("#username").blur(function() {
						var bname = $("#username").val();
						if (aname == bname) {
							$("#judgeName").val(aname);
						} else {
							$.ajax({
								type : "post",
								url : "updateUname.action?bname=" + bname,
								success : function(data) {

									var jsonobj = eval('(' + data + ')');
									if (jsonobj.pname == bname) {
										layer.tips("该名称已被注册!", "#username", {
											tips : [ 2, "#FF0000" ],
											time : 2000
										});
										$("#judgeName").val("");
									} else {
										$("#judgeName").val(aname);
									}

								},

							});
						}
					});
					//判断有没有被注册过的邮箱
					var email = $("#re_email").val();
					$("#judgeEmail").val(email);
					$("#re_email").blur(function() {
						var bemail = $("#re_email").val();
						if (email == bemail) {
							$("#judgeEmail").val(email);
						} else {
							$.ajax({
								type : "post",
								url : "updateEmail.action?bemail=" + bemail,
								success : function(data) {
									var emialObj = eval('(' + data + ')');
									if (emialObj.pemail == "no") {

										$("#judgeEmail").val("");
										layer.tips("该邮箱已被使用!", "#re_email", {
											tips : [ 2, "#FF0000" ],
											time : 2000
										});
									} else {
										$("#judgeEmail").val(bemail);
									}
								},

							});
						}

					});

					//动态在表单里面生成一个上传文件的input框
					function uploadHeadImg() {
						$("#test1")
								.after(
										'<input type="file" id="headImg" name="myfile" style="display:none" accept="image/*" onchange="uploadFile()"></input>');
						document.getElementById("headImg").click();

					}

					function uploadFile() {
						document.getElementById("tj").click();
					}

					function deleteWhite() {
						var str = $("#remark").val();
						var objExp = /(^\s*)|(\s*$)/g;
						str = str.replace(objExp, "");
						$("#remark").val(str);
					}

					function check() {
						var uname = $("#username").val();
						var judgeName = $("#judgeName").val();
						var judgeEmail = $("#judgeEmail").val();
						if (uname.length < 6) {
							layer.tips('账号不能小于6位数', '#username', {
								time : 2000,
								tips : 3
							});
							return false;
						}
						if (judgeEmail == "") {
							layer.tips('邮箱已经被使用', '#re_email', {
								time : 2000,
								tips : 3
							});
							return false;
						}
						if (judgeName == "") {
							layer.tips('用户名已经被使用', '#username', {
								time : 2000,
								tips : 3
							});
							return false;
						}
						var page = $("#page").val();
						if (parseInt(page) > parseInt("120")
								|| parseInt(page) < parseInt("0")) {
							layer.tips('年龄必须在0-120', '#page', {
								time : 2000,
								tips : 3
							});
							return false;
						}

					}
				</script>

			</div>
		</div>
	</div>

</body>
</html>