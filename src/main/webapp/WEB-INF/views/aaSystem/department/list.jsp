<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
</head>
<body>
<c:if test="${fatherId eq null}">
	<div class="jumbotron">选中的部门节点不存在或被删除</div>
</c:if>
<c:if test="${fatherId ne null}">
	<div>
		<div class="tab-header">
			<form class="layui-form" action="${ctx}/department/list?fatherId=${fatherId}" onsubmit="return navTabSearch(this, '#department-list-view')">
				<div class="layui-form-item">
			  		<div class="layui-inline">
			    		<label class="layui-form-label">组织编码或名称</label>
			    		<div class="layui-input-inline">
			      			<input type="text" name="keywords" value="${keywords}" placeholder="输入组织编码或名称..." class="layui-input">
			    		</div>
			    	</div>
			    	<div class="layui-inline">
			    		<button class="search">查询</button>
			    	</div>
			  	</div>
		  	</form>
		</div>
		<div class="tab-bars">
			<shiro:hasPermission name="Department:save">
				<a class="add" target="dialog" width="500" height="450" dialogId="createMenu" href="${ctx}/department/preCreate?fatherId=${fatherId}">新增</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="Department:edit">
				<a class="edit" target="dialog" width="500" height="450" dialogId="updateMenu" href="${ctx}/department/preUpdate/{slt_uid}">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="Department:delete">
				<a class="delete" target="ajaxTodo" onAfterAjax="refreshDepartmentTree" title="确认要删除此部门以及该部门下所有的子部门吗?" refreshContainer="#department-list-view" href="${ctx}/department/delete/{slt_uid}">删除</a>
			</shiro:hasPermission>
		</div>
		<form id="pagerForm" method="post" action="${ctx}/department/list?fatherId=${fatherId}">
			<input type="hidden" name="pageNum" value="${page.pageNum}" />
			<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
			<input type="hidden" name="strName" value="${strName}" />
		</form>
		<div class="tab-content">
			<table class="frog-table">
				<thead>
					<tr>
						<th>序号</th>
						<th>部门编号</th>
						<th>部门名称</th>
						<th>部门描述</th>
						<th>父部门名称</th>
						<th>创建人</th>
						<th>创建时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="department" varStatus="status">
						<tr target="slt_uid" rel="${department.id}"> 
							<td title="序号">${page.pageBeginCount + status.index + 1}</td>
				   			<td title="部门编号">${department.strSn}</td>
					     	<td title="部门名称">${department.strName}</td>
					     	<td title="部门描述">${department.strDesc}</td>
					     	<td title="父部门名称">${department.parent.strName}</td>
					     	<td title="创建人">${department.createUser.strName}</td>
					     	<td title="创建时间">${department.createDateTime}</td>
						 </tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 分页 -->
		<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp">
			<c:param name="container" value="#department-list-view"/>
		</c:import>
	</div>
</c:if>
</body>
<script>
function refreshDepartmentTree() {
	$.ajax({
		async: false,
		type: "POST",
		url: "${ctx}/department/getDeptTreeJson",
		success: function(msg) {
			try {
				var treeData = JSON.parse(msg);
				var setting = {
					callback: {
						onClick: clickSelectPermissionMenu,
						onExpand: onExpand,
						onCollapse: onCollapse
					}
				};
				$.fn.zTree.init($("#deptment-tree-tab"), setting, treeData);
				var treeObj = $.fn.zTree.getZTreeObj("deptment-tree-tab");
				var cookie = $.cookie("deptment-tree" + window.location);
				if (cookie) {
				    z_tree = JSON.parse(cookie);
				    for (var i = 0; i < z_tree.length; i++) {
				        var node = treeObj.getNodeByParam('id', z_tree[i])
				        treeObj.expandNode(node, true, false)
				    }
				}
			} catch (e) {
				Dialog.error(e.message);
				console.log(msg);
			}
		}
	});
}
</script>
</html>