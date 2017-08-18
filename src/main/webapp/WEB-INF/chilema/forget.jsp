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
		忘记密码
	</h1>

	<div class="login" style="margin-top: 50px;">

		<div class="web_qr_login" id="web_qr_login"
			style="display: block; height: 250px;">

			<!--忘记密码框-->
			<div class="web_login" id="web_login">
				<div class="login-box">
					<div class="login_form">
						<form action="${ctp }/manager/forget" name="loginform"
							accept-charset="utf-8" id="login_form" class="loginForm"
							method="post">
							<input type="hidden" name="did" value="0" /> <input type="hidden"
								name="to" value="log" />
							<div class="uinArea" id="uinArea">
								<div class="cue" style="font-family: '楷体';font-size: 20px;">请输入您的邮箱地址</div>
								<label class="input-tips" for="u">邮箱：</label>
								<div class="inputOuter" id="uArea">
									<input type="text" id="email_input" name="email" class="inputstyle" />
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
			<!--忘记密码框end-->

		</div>
	</div>
	
	<div class="jianyi">*******吃了没-忘记密码找回界面*******</div>

	<script type="text/javascript">
		$(function() {
			//点击确定
			$("#submitBtn").click(function(){
				
				//邮箱前端校验
				var semail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
				if (!semail.test($('#email_input').val())) {
					$('#email_input').focus().css({
						border : "1px solid red",
						boxShadow : "0 0 2px red"
					});
					$('#userCue').html("<font color='red'><b>邮件格式不正确</b></font>");
					return false;
				} else {
					$('#email_input').css({
						border : "1px solid #D7D7D7",
						boxShadow : "none"
					});
				}
				//没问题，提交表单
				$('#registForm').submit();
				
			});
		});
	</script>

</body>
</html>