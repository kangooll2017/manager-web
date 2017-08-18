<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%
		pageContext.setAttribute("url", "manager/permission/list");
		pageContext.setAttribute("headShow", "权限维护");
	%>
	<!-- 引入css -->
	<%@include file="/WEB-INF/includes/css-file.jsp"%>
	<!-- 引入js -->
	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

   	<!-- 引入导航条 -->
	<%@include file="/WEB-INF/includes/navbar.jsp"%>

    <div class="container-fluid">
      <div class="row">
      
		<!-- 引入侧边栏 -->
		<%@include file="/WEB-INF/includes/sidebar.jsp"%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 </div>
			  <div class="panel-body">
				
				  <!-- ztree -->			  
                  <ul id="treeDemo" class="ztree" style="font-size: 15px;"></ul>

			  </div>
			</div>
        </div>
        
      </div>
    </div>
    
    <!-- 模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加权限</h4>
	      </div>
	      
	      <div class="modal-body">
	      	  <form id="myForm" action="${ctp }/manager/permission/add" method="post">
		          <div class="form-group">
				    <label for="exampleInputEmail1">name：</label>
				    <input name="name" class="form-control" id="name_input" placeholder="name">
				  </div>
				  <div class="form-group">
				    <label for="exampleInputPassword1">icon:</label>
				    <input name="icon" class="form-control" id="icon_input" placeholder="icon">
				  </div>
				  <div class="form-group">
				    <label for="exampleInputEmail1">url:</label>
				    <input name="url" class="form-control" id="url_input" placeholder="url">
				  </div>
				  <input type="hidden" name="pid" id="pid_input"/>
				  <input type="hidden" name="id" id="id_input"/>
		  	  </form>
	      </div>
	      
	      <div class="modal-footer">
	        <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
      	
      	//鼠标移到节点，在后面显示操作按钮的方法
      	function addHoverDom(treeId, treeNode){
      		if ($("#" + treeNode.tId + "_a").find("b").length>0) {
				return;
			}
      		var addBtn = $("<b style='margin-left:10px;padding-top:0px;color:orange;' class='glyphicon glyphicon-plus' id='addBtn_"+treeNode.tId +"'></b>");
      		var editBtn = $("<b style='margin-left:10px;padding-top:0px;color:blue;' class='glyphicon glyphicon-pencil' id='editBtn_"+treeNode.tId +"'></b>");
      		var deleteBtn = $("<b style='margin-left:10px;padding-top:0px;color:red;' class='glyphicon glyphicon-remove' id='deleteBtn_"+treeNode.tId +"'></b>");
      		if (treeNode.pid == null) {
				//父节点
	    		$("#" + treeNode.tId + "_a").append(addBtn);
	      		$("#" + treeNode.tId + "_a").append(editBtn);
			} else {
				//子节点
				$("#" + treeNode.tId + "_a").append(addBtn);
				$("#" + treeNode.tId + "_a").append(editBtn);
				$("#" + treeNode.tId + "_a").append(deleteBtn);
			}
      		
      		//造出按钮直接绑定单击事件
      		//添加按钮
      		addBtn.click(function(){
      			$("#myForm")[0].reset();
      			$("#pid_input").val(treeNode.id);
      			$('#myModal').modal("show");
      		});
      		
      		//编辑按钮
      		editBtn.click(function(){
      			$("#myForm").prop("action","${ctp}/manager/permission/edit");
      			$("#myModalLabel").text("修改权限");
      			$("#name_input").val(treeNode.name);
      			$("#icon_input").val(treeNode.icon);
      			$("#url_input").val(treeNode.url);
      			$("#id_input").val(treeNode.id);
      			$('#myModal').modal("show");
      		});
      		
      		//删除按钮
      		deleteBtn.click(function(){
      			layer.confirm("确认是否删除？","['确定','取消']",function(){
      				//确定删除
      				$.ajax({
      					url:"${ctp}/manager/permission/delete",
      					data:"id="+treeNode.id,
      					type:"post",
      					success:function(result){
      						//删除成功
      						alert(result);
      						//刷新页面
      						location.href = "${ctp}/manager/permission/list";
      					}
      				});
      			},function(){
      				layer.msg("取消");
      			});
      		});
      		
      	};
      	
      	//鼠标移除节点，后面的按钮消失
      	function removeHoverDom(treeId, treeNode) {
      		$("#" + treeNode.tId + "_a").find("b").remove();
      	};
      	
      </script>
      
      <script type="text/javascript">
      	$(function(){
      		//未来元素绑定单击事件
      		$(document).on("click", "选择器", function(){ 
      			
      		}); 
      	});
      </script>
      
      <script type="text/javascript">
         $(function () {
			//默认展开管理模块，默认管理维护高亮
			$("a[href='${ctp}/${url}']").prop("style","color:red;");
			$("a[href='${ctp}/${url}']").parent().parent().parent().children("ul").show();
			$("a[href='${ctp}/${url}']").parent().parent().parent().siblings().children("ul").hide();
		
      	  	//点击切换展开合上
		    $(".list-group-item").click(function(){
			    if ( $(this).find("ul") ) {
					$(this).toggleClass("tree-closed");
					if ( $(this).hasClass("tree-closed") ) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
			
			//获取所有权限list
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
						view: {
							//方法的引用（不是调用）
							addDiyDom: showIcon,
							addHoverDom: addHoverDom,
							removeHoverDom:removeHoverDom
						}
					};
					//初始化ztree
					$.fn.zTree.init($("#treeDemo"), setting, result);
				}
			});
			
			//初始化模态框
			var options = {backdrop:false,keyboard:true,show:false};
			$('#myModal').modal(options);
			
			//模态框的保存按钮
			$("#saveBtn").click(function(){
				//提交表单
				$("#myForm").submit();
			});
         });
      </script>
  </body>
</html>
