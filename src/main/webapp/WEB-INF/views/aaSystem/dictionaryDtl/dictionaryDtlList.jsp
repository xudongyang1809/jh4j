<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/dictdtl/list">
	<input type="hidden" name="dictId" value="${dictId}" /> 
	<input type="hidden" name="pageNum" value="${page.pageNum}" /> 
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" /> 
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="strName" value="${strName}" />
</form>
<div class="tab-header">
	<form id="queryForm" method="post" action="${ctx}/dictdtl/list" class="layui-form" onsubmit="return navTabSearch(this, '#dictionary-list-view')">
		<div class="layui-form-item">
			<div  class="layui-inline">
				<label for="strName" class="layui-form-label" >编码/类型:</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strName" id="strName" value="${strName}" placeholder="输入关键字检索">
				</div>
			</div>
			<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
    	</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="Dictionary:create">
		<a class="add" target="dialog" width="550" height="400" dialogId="createProgram" href="${ctx}/dictdtl/preCreate?dictId=${dictId}">添加</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Dictionary:edit">
		<a class="edit" target="dialog" width="550" height="400" dialogId="updateProgram" href="${ctx}/dictdtl/preUpdate/{slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Dictionary:delete">
		<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" refreshContainer="#dictionary-list-view" href="${ctx}/dictdtl/delete/{slt_uid}">删除</a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table" id="usertable">
		<thead>
			<tr>
				<th width="50px">序号</th>
				<th>编码</th>
				<th>词典值</th>
				<th>类型</th>
				<th>描述</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dictdtl" items="${dictdtls}" varStatus="status">
				<tr target="slt_uid" rel="${dictdtl.id}" id="${dictdtl.id}" intIsActive="${dictdtl.intIsActive }">
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${dictdtl.strSn}</td>
					<td>${dictdtl.strValue}</td>
					<td>${dictdtl.dict.strName}</td>
					<td>${dictdtl.strDesc}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp">
	<c:param name="container" value="#dictionary-list-view"/>
</c:import>