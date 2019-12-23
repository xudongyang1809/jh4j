<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function closeCallback() {
	reloadContainer('#menu-list-view');
}
</script>
</head>
<body>
<c:if test="${fatherId eq null}">
	<div class="jumbotron">选中的菜单节点不存在或被删除</div>	
</c:if>
<c:if test="${fatherId ne null}">
	<div>
		<div class="tab-header">
			<form class="layui-form" action="${ctx}/tree/nodeList?id=${fatherId}" onsubmit="return navTabSearch(this, '#menu-list-view')">
				<div class="layui-form-item">
			  		<div class="layui-inline">
			    		<label class="layui-form-label">菜单名称</label>
			    		<div class="layui-input-inline">
			      			<input type="text" name="strName" value="${strName}" placeholder="输入菜单名称..." class="layui-input">
			    		</div>
			    	</div>
			    	<div class="layui-inline">
			    		<button class="search">查询</button>
			    	</div>
			  	</div>
		  	</form>
		</div>
		<div class="tab-bars">
			<shiro:hasPermission name="Module:save">
				<a class="add" target="dialog" width="850" height="550" dialogId="selectProgram" closeCallback="closeCallback" href="${ctx}/menu/preDistributeProgram/${fatherId}">分配程序</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="Module:edit">
				<a class="edit" target="dialog" width="500" height="450" dialogId="updateMenu" href="${ctx}/menu/preUpdate/{slt_uid}">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="Module:delete">
				<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" refreshContainer="#menu-list-view" href="${ctx}/menu/delete/{slt_uid}">删除</a>
			</shiro:hasPermission>
		</div>
		<form id="pagerForm" method="post" action="${ctx}/menu/nodeList?id=${fatherId}">
			<input type="hidden" name="pageNum" value="${page.pageNum}" />
			<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
			<input type="hidden" name="strName" value="${strName}" />
		</form>
		<div class="tab-content">
			<table class="frog-table">
				<thead>
					<tr>
						<th>序号</th>
						<th>菜单名称</th>
						<th>程序名称</th>
						<th>请求路径</th>
						<th>优先级</th>
						<th>描述</th>
						<th>创建人</th>
						<th>创建时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="menu" varStatus="status">
						<tr target="slt_uid" rel="${menu.id}"> 
							<td title="序号">${status.index + 1}</td>
				   			<td title="菜单名称">${menu.strName}</td>
				   			<td title="程序名称">${menu.program.strName}</td>
				   			<td title="请求路径">${menu.program.strUrl}</td>
					     	<td title="优先级">${menu.intPriority}</td>
					     	<td title="程序描述">${menu.strDesc}</td>
					     	<td title="创建人">${menu.createUser.strName}</td>
					     	<td title="创建时间">${menu.createDateTime}</td>
						 </tr>
					 </c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 分页 -->
		<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp">
			<c:param name="container" value="#menu-list-view"/>
		</c:import>
	</div>
</c:if>
</body>
</html>