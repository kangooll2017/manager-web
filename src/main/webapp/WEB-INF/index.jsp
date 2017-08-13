<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>吃了没</title>
<meta name="keywords"
	content="网站模板下载,网站后台登录模板,后台登录模板HTML,后台模板登录,后台登录模板下载" />
<meta name="description" content="JS代码网提供大量的网站后台模板下载以及手机网站模板下载" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- 引入js -->
<%@include file="/WEB-INF/includes/js-file.jsp"%>
<script type="text/javascript" src="${ctp }/script/login.js"></script>

<!-- 引入css -->
<link href="${ctp }/css/login2.css" rel="stylesheet" />

</head>
<body>
	<h1>
		吃了没后台管理员模板<sup>V2017</sup>
	</h1>

	<div class="login" style="margin-top: 50px;">

		<div class="header">
			<div class="switch" id="switch">
				<a class="switch_btn_focus" id="switch_qlogin"
					href="javascript:void(0);" tabindex="7">账户登录</a> <a
					class="switch_btn" id="switch_login" href="javascript:void(0);"
					tabindex="8">注册账户</a>
				<div class="switch_bottom" id="switch_bottom"
					style="position: absolute; width: 64px; left: 0px;"></div>
			</div>
		</div>


		<div class="web_qr_login" id="web_qr_login"
			style="display: block; height: 300px;">

			<!--登录-->
			<div class="web_login" id="web_login">
				<div class="login-box">
					<div class="login_form">
						<form action="${ctp }/manager/login" name="loginform"
							accept-charset="utf-8" id="login_form" class="loginForm"
							method="post">
							<input type="hidden" name="did" value="0" /> <input type="hidden"
								name="to" value="log" />
							<div class="uinArea" id="uinArea">
								<div class="cue">${indexInfo == null?"请您登录":indexInfo }</div>
								<label class="input-tips" for="u">帐号：</label>
								<div class="inputOuter" id="uArea">
									<input type="text" id="u" name="account" class="inputstyle" />
								</div>
							</div>
							<div class="pwdArea" id="pwdArea">
								<label class="input-tips" for="p">密码：</label>
								<div class="inputOuter" id="pArea">
									<input type="password" id="p" name="password" class="inputstyle" />
								</div>
							</div>
							<br/>
							
								<div class="checkbox">
						            &nbsp;&nbsp;&nbsp;
						            <input type="checkbox" value="remember-me">记住我
						          <label>
						           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						           		<a href="#">忘记密码</a>
						          </label>
						        </div>
							
							
							<div style="padding-left: 50px; margin-top: 20px;">
								<input type="submit" value="登 录" style="width: 150px;"
									class="button_blue" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--登录end-->

		</div>

		<!--注册-->
		<div class="qlogin" id="qlogin" style="display: none;">
			<div class="web_login">
				<form name="registForm" id="registForm" accept-charset="utf-8"
					action="${ctp }/manager/regist" method="post">
					<input type="hidden" name="to" value="reg" /> <input type="hidden"
						name="did" value="0" />
					<ul class="reg_form" id="reg-ul">
						<div id="userCue" class="cue">快速注册请注意格式</div>
						<li><label for="user" class="input-tips2">用户名：</label>
							<div class="inputOuter2">
								<input type="text" id="account" name="account" maxlength="16"
									class="inputstyle2" />
							</div></li>
						<li><label for="password" class="input-tips2">密码：</label>
							<div class="inputOuter2">
								<input type="password" id="password" name="password"
									maxlength="16" class="inputstyle2" />
							</div></li>
						<li><label for="password2" class="input-tips2">确认密码：</label>
							<div class="inputOuter2">
								<input type="password" id="password2" name="" maxlength="16"
									class="inputstyle2" />
							</div></li>
						<li><label for="email" class="input-tips2">邮箱：</label>
							<div class="inputOuter2">
								<input type="text" id="email" name="email" maxlength="20"
									class="inputstyle2" />
							</div></li>
						<li>
							<div class="inputArea">
								<input type="button" id="reg"
									style="margin-top: 10px; margin-left: 85px;"
									class="button_blue" value="同意协议并注册" /> <a href="#"
									class="zcxy" target="_blank">注册协议</a>
							</div>
						</li>
						<div class="cl"></div>
					</ul>
				</form>
			</div>
		</div>
		<!--注册end-->
	</div>
	<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>

	<script type="text/javascript">
		$(function() {
			var stop = false;
			//注册时用户名输入失去焦点事件
			$("#account").blur(function(){
				var account = $(this).val();
				//发ajax去验证用户名是否唯一
				$.ajax({
					url:"${ctp}/manager/checkaccount",
					data:{account:account},
					type:"post",
					success:function(result){
						if (result != null && result != "") {
							//账户已经存在
							$('#userCue').html("<font color='red'><b>"+result+"</b></font>");
							stop = true;
						}else{
							$('#userCue').html("");
							stop = false;
						}
					}
				});
			});
			
			//注册时邮箱输入失去焦点事件
			$("#email").blur(function(){
				var email = $(this).val();
				//发ajax去验证邮箱是否唯一
				$.ajax({
					url:"${ctp}/manager/checkemail",
					data:{email:email},
					type:"post",
					success:function(result){
						if (result != null && result != "") {
							//邮箱已经存在
							$('#userCue').html("<font color='red'><b>"+result+"</b></font>");
							stop = true;
						}else{
							$('#userCue').html("");
							stop = false;
						}
					}
				});
			});
			
			
			//点击注册提交表单
			$('#reg').click(function() {
				//账号前端校验
				if ($('#account').val() == "") {
					$('#account').focus().css({
						border : "1px solid red",
						boxShadow : "0 0 2px red"
					});
					$('#userCue').html("<font color='red'><b>账号不能为空</b></font>");
					return false;
				}
				if ($('#account').val().length < 3
						|| $('#account').val().length > 16) {

					$('#account').focus().css({
						border : "1px solid red",
						boxShadow : "0 0 2px red"
					});
					$('#userCue').html("<font color='red'><b>账号名为3-16字符</b></font>");
					return false;
				}
				
				//密码前端校验
				var pwdmin = 5;
				if ($('#password').val().length < pwdmin) {
					$('#password').focus();
					$('#userCue').html("<font color='red'><b>密码不能小于"+ pwdmin + "位</b></font>");
					return false;
				}
				if ($('#password2').val() != $('#password').val()) {
					$('#password2').focus();
					$('#userCue').html("<font color='red'><b>两次密码不一致！</b></font>");
					return false;
				}
				
				//邮箱前端校验
				var semail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
				if (!semail.test($('#email').val())) {
					$('#email').focus().css({
						border : "1px solid red",
						boxShadow : "0 0 2px red"
					});
					$('#userCue').html("<font color='red'><b>邮件格式不正确</b></font>");
					return false;
					return false;
				} else {
					$('#email').css({
						border : "1px solid #D7D7D7",
						boxShadow : "none"
					});
				}
				
				//账户、邮箱是否唯一
				if (stop) {
					return false;
					$('#userCue').html("<font color='red'><b>请修改信息</b></font>");
				}
				
				$('#registForm').submit();
			});
		});
	</script>

</body>
</html>