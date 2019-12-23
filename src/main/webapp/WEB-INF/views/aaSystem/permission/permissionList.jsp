<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function chooseModule(btn) {
	Dialog.load();
	$.post("${ctx}/permission/chooseModule", function (msg) {
		layer.open({
			type: 1,
			title: "选择功能模块",
			area: ['400px', '500px'],
			content: msg,
			success: function() {
				layer.closeAll("loading");
			}
		});
	});
}
</script>
</head>
<body>
<div class="tab-header">
	<form class="layui-form" action="${ctx}/permission/list" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
	  		<div class="layui-inline">
	    		<label class="layui-form-label">菜单节点</label>
	    		<div class="layui-input-inline" style="width: 400px;">
	      			<input type="text" name="menuPathName" value="${menuPathName}" placeholder="选择菜单节点..." readonly class="layui-input" />
	    		</div>
	    	</div>
	    	<div class="layui-inline" style="display: none;">
	    		<button class="search">查询</button>
	    	</div>
	  	</div>
	 </form>
</div>
<c:if test="${moduleId != null}">
	<div class="tab-bars">
		<a class="add" target="dialog" width="500" height="350" dialogId="createPermission" href="${ctx}/permission/preCreate?moduleId=${moduleId}">新增</a>
		<a class="edit" target="dialog" width="550" height="350" dialogId="updatePermission" href="${ctx}/permission/preUpdate?permissionid={slt_uid}">编辑</a>
		<a class="delete" target="ajaxTodo" title="确认要删除此动作吗?" href="${ctx}/permission/delete?permissionId={slt_uid}" refreshContainer="#permission-list-view">删除</a>
		<a class="add" target="ajaxTodo" title="确认要一键新增常用的动作(查看，创建，编辑，删除，导入，导出)吗?" refreshContainer="#permission-list-view" href="${ctx}/permission/oneKeyAdd?moduleId=${moduleId}">一键添加动作清单</a>
	</div>
</c:if>
<form id="pagerForm" method="post" action="${ctx}/permission/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
	<input type="hidden" name="moduleId" value="${moduleId}" />
	<input type="hidden" name="menuId" value="${menuId}" />
</form>
<div class="tab-content" style="${moduleId == null ? 'top: 61px;' : ''}">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>动作名称</th>
				<th>动作描述</th>
				<th>创建人</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="permission" varStatus="status">
				<tr target="slt_uid" rel="${permission.id}">
					<td title="序号">${page.pageBeginCount + status.index + 1}</td>
			     	<td title="动作名称">${permission.strName}</td>
			     	<td title="动作描述">${permission.strDesc}</td>
			     	<td title="创建人">${permission.createUser.strName}</td>
			     	<td title="创建时间">${permission.createDateTime}</td>
				 </tr>
			 </c:forEach>
		</tbody>
	</table>
</div>
<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp">
	<c:param name="container" value="#permission-list-view"/>
</c:import>
</body>
</html>
