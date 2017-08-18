<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<div>
				<a class="navbar-brand" style="font-size: 25px;" href="#">吃了没-${headShow }</a>
			</div>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li style="padding-top: 8px;">
					<div class="btn-group">
						<button type="button"
							class="btn btn-default btn-success dropdown-toggle"
							data-toggle="dropdown">
							<i class="glyphicon glyphicon-user"></i> ${loginManager.account }<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${ctp }/manager/exit"> 退出系统</a></li>
						</ul>
					</div>
				</li>
				<li style="margin-left: 10px; padding-top: 8px;">
					<button type="button" class="btn btn-default btn-danger" onClick="alert('哈哈');">
						<span class="glyphicon glyphicon-question-sign"></span> 帮助
					</button>
				</li>
			</ul>
		</div>
	</div>
</nav>