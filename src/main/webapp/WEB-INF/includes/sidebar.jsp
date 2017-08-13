<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px;" class="list-group" id="treeDemo">
		
			<!-- 展示所有权限，带分级 -->
			<c:forEach items="${permissions }" var="permission">
				<li class="list-group-item tree-closed"><span><i
						class="${permission.icon }"></i> ${permission.name }<span
						class="badge" style="float: right">${ fn:length(permission.childs)  }</span></span>
					<ul style="margin-top: 10px;">
						
						<c:forEach items="${permission.childs }" var="per">
							<li style="height: 30px;">
								<a href="${ctp }/${per.url }"><i class="${per.icon }"></i> ${per.name }</a>
							</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
			
		</ul>
	</div>
</div>