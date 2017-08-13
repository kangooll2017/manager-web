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
	pageContext.setAttribute("url", "manager/manager/list");
	pageContext.setAttribute("headShow", "管理维护");
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
			<div class="panel-body">
				<hr style="clear: both;">
				<div class="table-responsive">
					<table class="table  table-bordered">

						<thead>
							<tr>
								<th width="30">id</th>
								<th width="30"><input type="checkbox"></th>
								<th>账号</th>
								<th>邮箱地址</th>
								<th width="100">操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${pageInfo.list }" var="manager">
								<tr>
									<td>${manager.id }</td>
									<td><input type="checkbox"></td>
									<td>${manager.account }</td>
									<td>${manager.email }</td>
									<td>
										<button type="button" class="btn btn-success btn-xs">
											<i class=" glyphicon glyphicon-check"></i>
										</button>
										<button type="button" class="btn btn-primary btn-xs edit_btn">
											<i class=" glyphicon glyphicon-pencil"></i>
										</button>
										<button type="button" class="btn btn-danger btn-xs">
											<i class=" glyphicon glyphicon-remove"></i>
										</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="6" align="center">
									
									<!-- 分页条 -->
									<ul class="pagination">
										<li><a href="${ctp }/main.html?pageNum=1">首页</a></li>
										<li><a href="${ctp }/main.html?pageNum=${pageInfo.prePage}">上一页</a></li>
										<c:forEach items="${pageInfo.navigatepageNums }" var="num">
											<c:if test="${num == pageInfo.pageNum }">
												<li class="active"><a href="#">${num } <span class="sr-only">(current)</span></a></li>
											</c:if>
											<c:if test="${num != pageInfo.pageNum }">
												<li><a href="${ctp }/main.html?pageNum=${num}">${num }</a></li>
											</c:if>
										</c:forEach>
										<li><a href="${ctp }/main.html?pageNum=${pageInfo.nextPage == 0 ? pageInfo.pages : pageInfo.nextPage}">下一页</a></li>
										<li><a href="${ctp }/main.html?pageNum=${pageInfo.pages}">末页</a></li>		
									</ul>
									
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 添加的模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改管理员数据</h4>
	      </div>
	      
	      <!-- 模态框体 -->
	      <div class="modal-body">
	        <form>
			  <div class="form-group">
			    <label for="exampleInputEmail1">账号</label>
			    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Account">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputEmail1">邮箱</label>
			    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">
			  </div>
			</form>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary">添加</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
			
			//初始化模态框
			$('#myModal').modal({keyboard:true,show:false});
			
			//点击添加按钮
			$(".edit_btn").click(function(){
				$('#myModal').modal("show");
			});
			
		});
	</script>
</body>

</html>