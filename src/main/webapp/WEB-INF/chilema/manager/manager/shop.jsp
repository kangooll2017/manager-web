<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首页</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%
	pageContext.setAttribute("url", "manager/shop/list");
	pageContext.setAttribute("headShow", "商家维护");
%>
<!-- 引入css -->
<%@include file="/WEB-INF/includes/css-file.jsp"%>
<!-- 引入js -->
<%@include file="/WEB-INF/includes/js-file.jsp"%>
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>
<body>

	<!-- 引入导航条 -->
	<%@include file="/WEB-INF/includes/navbar.jsp"%>
	<!-- 引入侧边栏 -->
	<%@include file="/WEB-INF/includes/sidebar.jsp"%>
	
	<!-- 主体内容 -->
	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th"></i> 正在经营中的商家。。。
				</h3>
			</div>
			<div class="panel-body">
				<h1>临兵斗者皆阵列前行</h1>
				<br>
				<hr style="clear: both;">
				<div class="table-responsive">
					<table class="table  table-bordered">

					<h3>这是商家维护页面，可以进行商家强制下架操作</h3>	
						
					</table>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		$(function() {
			//默认展开管理模块，默认管理维护高亮
			$("a[href='${ctp}/${url}']").prop("style","color:red;");
			$("a[href='${ctp}/${url}']").parent().parent().parent().children("ul").show();
			$("a[href='${ctp}/${url}']").parent().parent().parent().siblings().children("ul").hide();
			
			//点击展开收回的方法
			$(".list-group-item").click(function() {
				if ($(this).find("ul")) {
					$(this).toggleClass("tree-closed");
				}
				if ($(this).hasClass("tree-closed")) {
					$("ul", this).hide("fast");
				} else {
					$("ul", this).show("fast");
				}
			});
			
			
		});
	</script>
</body>

</html>