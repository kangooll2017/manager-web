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
		重置密码
	</h1>

	<div class="login" style="margin-top: 50px;">

		<div class="web_qr_login" id="web_qr_login"
			style="display: block; height: 300px;">

			<!--重置密码框-->
			<div class="web_login" id="web_login">
				<div class="login-box">
					<div class="login_form">
						<form action="${ctp }/manager/reset" name="loginform"
							accept-charset="utf-8" id="reset_form" class="loginForm"
							method="post">
							<!-- 带上令牌 -->
							<input type="hidden" name="pswdToken" value="${param.pswdToken }"/>
							<div class="uinArea" id="uinArea">
								<div id="userCue" class="cue">请您设置新密码！</div>
								<label class="input-tips" for="u">密码：</label>
								<div class="inputOuter" id="uArea">
									<input type="password" id="password_input" name="password" class="inputstyle" />
								</div>
							</div>
							<div class="pwdArea" id="pwdArea">
								<label class="input-tips" for="p">重复：</label>
								<div class="inputOuter" id="pArea">
									<input type="password" id="password2_input" name="password2" class="inputstyle" />
								</div>
							</div>
							<br/><br/><br/>
							
							<div style="padding-left: 50px; margin-top: 20px;">
								<input id="submitBtn" type="submit" value="确定" style="width: 150px;"
									class="button_blue" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--重置密码框end-->

		</div>
	</div>
	
	<div class="jianyi">*******吃了没-重置密码找回界面*******</div>

	<script type="text/javascript">
		$(function() {
			//点击确定
			$("#submitBtn").click(function(){
				
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
				
				//没问题，提交表单
				$('#reset_form').submit();
				
			});
		});
	</script>

</body>
</html>