<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/dict/list" >
	<input type="hidden" name="pageNum" value="${page.pageNum}" /> 
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" /> 
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}" />
</form>
<div class="tab-header">
	<form class="layui-form" method="post" action="${ctx}/dict/list" onsubmit="return navTabSearch(this, '#dictionary-list-view')">
		<div class="layui-form-item">
			<label for="inputkeywords" class="layui-form-label">模糊查询</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="keywords" id="inputkeywords" value="${keywords}" placeholder="输入关键字检索">
			</div>
			<div class="layui-inline">
				<button class="search">查询</button>
			</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="Dictionary:create">
		<a class="add" target="dialog" width="550" height="350" dialogId="createProgram" href="${ctx}/dict/preCreate">添加</a>
	</shiro:hasPermission> 
	<shiro:hasPermission name="Dictionary:edit">
		<a class="edit" target="dialog" width="550" height="350" dialogId="updateProgram" href="${ctx}/dict/preUpdate/{slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Dictionary:delete">
		<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" onAfterAjax="refreshDictionaryTree" refreshContainer="#dictionary-list-view" href="${ctx}/dict/delete/{slt_uid}">删除</a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th style="width: 40px;">序号</th>
				<th>编码</th>
				<th>名称</th>
				<th>描述</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dict" items="${dicts}" varStatus="status">
				<tr target="slt_uid" rel="${dict.id}">
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${dict.strSn}</td>
					<td>${dict.strName}</td>
					<td>${dict.strDesc}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp">
	<c:param name="container" value="#dictionary-list-view"/>
</c:import>
<script>
function refreshDictionaryTree() {
	$.ajax({
		async: false,
		type: "POST",
		url: "${ctx}/dict/getDictionaryTreeData",
		success: function(msg) {
			try {
				var treeData = JSON.parse(msg);
				var setting = {
					callback: {
						onClick: clickSelectDict
					}
				};
				$.fn.zTree.init($("#dictionary-tree-tab"), setting, treeData);
			} catch (e) {
				Dialog.error(msg);
			}
		}
	});
}
</script>