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
								<th width="400px">账号</th>
								<th>邮箱地址</th>
								<th width="100">操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${pageInfo.list }" var="manager">
								<tr>
									<td>${manager.id }</td>
									<td>${manager.account }</td>
									<td>${manager.email }</td>
									<td>
										<button type="button" mid="${manager.id }" class="btn btn-success btn-xs assign_btn">
											<i class=" glyphicon glyphicon-check"></i>
										</button>
										<button type="button" pageNum=${pageInfo.pageNum } mid="${manager.id }" account="${manager.account }" email="${manager.email }" class="btn btn-primary btn-xs edit_btn">
											<i class=" glyphicon glyphicon-pencil"></i>
										</button>
										<button type="button" pageNum=${pageInfo.pageNum } mid="${manager.id }" account="${manager.account }" email="${manager.email }" class="btn btn-danger btn-xs delete_btn">
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
										<li><a href="${ctp }/manager/manager/list?pageNum=1">首页</a></li>
										<li><a href="${ctp }/manager/manager/list?pageNum=${pageInfo.prePage}">上一页</a></li>
										<c:forEach items="${pageInfo.navigatepageNums }" var="num">
											<c:if test="${num == pageInfo.pageNum }">
												<li class="active"><a href="#">${num } <span class="sr-only">(current)</span></a></li>
											</c:if>
											<c:if test="${num != pageInfo.pageNum }">
												<li><a href="${ctp }/manager/manager/list?pageNum=${num}">${num }</a></li>
											</c:if>
										</c:forEach>
										<li><a href="${ctp }/manager/manager/list?pageNum=${pageInfo.nextPage == 0 ? pageInfo.pages : pageInfo.nextPage}">下一页</a></li>
										<li><a href="${ctp }/manager/manager/list?pageNum=${pageInfo.pages}">末页</a></li>		
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
	        <form id="myForm">
			  <div class="form-group">
			    <label for="exampleInputEmail1">账号</label>
			    <input name="account" type="account" class="form-control" id="account_inout" placeholder="Account">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputEmail1">邮箱</label>
			    <input name="email" type="email" class="form-control" id="email_input" placeholder="Email">
			  </div>
			  <input name="id" type="hidden" id="mid_input" />
			</form>
	      </div>
	      
	      <div class="modal-footer">
	        <button pageNum="" id="saveBtn" type="button" class="btn btn-primary">保存</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 给用户分配权限的模态框 -->
	<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="assignModalLable">分配权限</h4>
	      </div>
	      
	      <!-- 模态框体 -->
	      <div class="modal-body">
				<!-- ztree -->			  
                <ul id="treeDemo" class="ztree" style="font-size: 15px;"></ul>
	      </div>
	      
	      <div class="modal-footer">
	        <button id="assignBtn" type="button" class="btn btn-primary">分配</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script type="text/javascript">
	  	//显示图标的方法
	  	function showIcon(treeId,treeNode){
	  		$("#"+treeNode.tId+"_ico").removeClass();
	  		$("#"+treeNode.tId+"_ico").before("<span class='"+treeNode.icon+"'></span>");
	  	};
	  	
	  	//勾选指定指定id的管理员所拥有的权限
	  	function checkPermissionByManageId(mid){
	  		//先查出该管理员所拥有的权限
	  		$.ajax({
				url:"${ctp}/manager/permission/getPermissonByManagerId",
				data:"mid="+mid,
				type:"post",
				success:function(nodes){
					$.each(nodes,function(){
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						var node = treeObj.getNodeByParam("id", this.id, null);
						treeObj.checkNode(node, true, true);
					});
				}
			});
	  	}
	  	
	  	//清空所有勾选
	  	function clearAllCheck(){
	  		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	  		treeObj.checkAllNodes(false);
	  	}
	</script>
	
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
			$('#myModal').modal({keyboard:true,show:false,backdrop:false});
			$("#assignModal").modal({keyboard:true,show:false,backdrop:false});
			
			//点击编辑按钮
			$(".edit_btn").click(function(){
				var account = $(this).attr("account");
				var email = $(this).attr("email");
				var mid = $(this).attr("mid");
				var pageNum= $(this).attr("pageNum");
				$("#account_inout").val(account);
				$("#email_input").val(email);
				$("#mid_input").val(mid);
				$("#saveBtn").attr("pageNum",pageNum);
				$('#myModal').modal("show");
			});
			
			//点击模态框的保存按钮
			$("#saveBtn").click(function(){
				var pageNum = $(this).attr("pageNum");
				var data = $("#myForm").serialize();
				$.ajax({
					url:"${ctp}/manager/edit",
					data:data,
					type:"post",
					success:function(result){
						//修改成功
						alert(result);
						//关闭模态框
						$('#myModal').modal("hide");
						//刷新页面
						window.location.href = "${ctp}/manager/manager/list?pageNum="+pageNum;
					}
				});
			});
			
			//删除按钮
			$(".delete_btn").click(function(){
				var mid = $(this).attr("mid");
				var pageNum = $(this).attr("pageNum");
				if(confirm("确认是否删除？")){
					//确认删除
					$.ajax({
						url:"${ctp}/manager/delete",
						type:"post",
						data:{id:mid},
						success:function(result){
							//删除成功
							alert(result);
							//刷新页面
							window.location.href = "${ctp}/manager/manager/list?pageNum="+pageNum;
						}
					});
				}
			});
			
			//给管理员分配权限按钮
			$(".assign_btn").click(function(){
				var mid = $(this).attr("mid");
				//清空所有勾选
				clearAllCheck();
			  	//勾选指定指定id的管理员所拥有的权限
			  	checkPermissionByManageId(mid);
				//打开分配权限的模态框
				$("#assignModal").modal("show");
				$("#assignBtn").attr("mid",mid);
			});
			
			//点击保存分配
			$("#assignBtn").click(function(){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getCheckedNodes(true);
				var mid = $(this).attr("mid");
				var pids = "";
				
				$.each(nodes,function(){
// 					var halfCheck = this.getCheckStatus();
// 					if (!halfCheck.half) {
// 						//不是半勾选
// 					}
						pids += this.id + ",";
					
				});
				//发ajax去修改该管理员拥有的权限
				$.ajax({
					url:"${ctp}/manager/assignPermission",
					data:{
						mid:mid,
						pids:pids
					},
					type:'post',
					success:function(result){
						//关闭模态框
						$("#assignModal").modal("hide");
						//修改成功
						layer.msg(result);
						
					}
				});
				
			});
			
			//初始化权限树：获取所有权限list
			$.ajax({
				url:"${ctp}/manager/permission/getAllPermissionList",
				type:"post",
				success:function(result){
					//全展开
					$.each(result,function(){
						if (this.pid == 0) {
							this.open = true;
						}
					});
					
					var setting = {
						data: {
							simpleData: {
								enable: true,
								pIdKey: "pid"
							},
							key: {
								url: "xUrl"
							}
						},
						check:{
							enable:true
						},
						view: {
							//方法的引用（不是调用）
							addDiyDom: showIcon
						}
					};
					//初始化ztree
					$.fn.zTree.init($("#treeDemo"), setting, result);
				}
			});
			
		});
	</script>
</body>

</html>