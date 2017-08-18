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
	pageContext.setAttribute("url", "complain/complainemail/list");
	pageContext.setAttribute("headShow", "投诉信");
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
					<i class="glyphicon glyphicon-th"></i> 数据列表
				</h3>
			</div>
			
			<!--  -->
			<div class="panel-body">
				<form id="searchForm" action="${ctp }/complain/complainemail/list" method="post" class="form-inline" role="form" style="float: left;">
					<div class="form-group has-feedback">
						<div class="input-group">
							<div class="input-group-addon">查询条件</div>
							<input name="condition" class="form-control has-success" type="text"
								placeholder="被投诉商家/投诉理由">
						</div>
					</div>
					<button id="searchBtn" type="button" class="btn btn-warning">
						<i class="glyphicon glyphicon-search"></i> 查询
					</button>
				</form>
				<button type="button" class="btn btn-danger" onclick="alert('呵呵');"
					style="float: right; margin-left: 10px;">
					<i class=" glyphicon glyphicon-remove"></i> 呵呵
				</button>
				<button type="button" class="btn btn-primary" style="float: right;"
					onclick="alert('哈哈');">
					<i class="glyphicon glyphicon-plus"></i> 哈哈
				</button>
				<br>
				<hr style="clear: both;">
				<div class="table-responsive">
					<table class="table  table-bordered">

						  <thead>
			                <tr >
			                  <th width="30">#</th>
			                  <th>被投诉商家</th>
			                  <th>投诉理由</th>
			                  <th width="100">操作</th>
			                </tr>
			              </thead>
			              <tbody>
				              <c:forEach items="${list }" var="map">
					                <tr>
					                  <td>${map.id }</td>
					                  <td>${map.shopName }</td>
					                  <td>${map.reason }</td>
					                  <td>
					                  	  <button eid=${map.id } status=${map.status } type="button" class='${map.status != 0?"btn btn-danger":"btn btn-info" } btn-xs readBtn'>
					                  	  	<i class='${map.status != 0?"glyphicon glyphicon-cd":"glyphicon glyphicon-eye-open"}'></i>
					                  	  </button>
									      <button eid=${map.id } type="button" class="btn btn-primary btn-xs saveBtn"><i class=" glyphicon glyphicon-floppy-save"></i></button>
										  <button eid=${map.id } type="button" class="btn btn-warning btn-xs deleteBtn"><i class=" glyphicon glyphicon-trash"></i></button>
									  </td>
					                </tr>
				              </c:forEach>
			              </tbody>
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
	<script type="text/javascript">
		$(function(){
			//已阅读/未阅读	切换按钮
			$(".readBtn").click(function(){
				var eid = $(this).attr("eid");
				var status = $(this).attr("status");
				$.ajax({
					url:"${ctp}/complain/complainemail/changeStatus",
					data:{eid:eid,status:status},
					type:"post",
					success:function(data){
						location.href="${ctp}/complain/complainemail/list";
					}
				});
				
			});
			
			//删除按钮
			$(".deleteBtn").click(function(){
				var eid = $(this).attr("eid");
				layer.confirm("确认是否删除？",
					['确认','取消'],
					function(){
						//确认
						$.ajax({
							url:"${ctp}/complain/complainemail/delete",
							data:"eid="+eid,
							type:"post",
							success:function(result){
								alert(result);
								location.href="${ctp}/complain/complainemail/list";
							}
						});
					});
				
			});
			
			//下载按钮
			$(".saveBtn").click(function(){
				var eid = $(this).attr("eid");
				alert("下载按钮");
				window.location.href="${ctp}/complain/complainemail/download?eid="+eid;
			});
			
			//查询按钮
			$("#searchBtn").click(function(){
				$("#searchForm").submit();
			});
		});
	</script>	
	
</body>

</html>