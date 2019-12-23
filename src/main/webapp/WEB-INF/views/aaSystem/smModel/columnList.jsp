<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div class="tab-bars">
	<shiro:hasPermission name="SmModelManager:save">
		<a class="add" target="dialog" width="700" height="600" dialogId="createColumnDialog" href="${ctx}/smModel/preCreate/${tabId}">添加</a>
		<a class="edit" target="dialog" width="700" height="600" dialogId="updateColumnDialog" href="${ctx}/smModel/preUpdate/{slt_uid}">修改</a>
		<a class="delete" target="dialog" width="500" height="500" href="${ctx}/smModel/delete/{slt_uid}">删除</a>
		<a class="build" target="dialog" max="true" dialogId="buildCodePageDialog" href="${ctx}/smModel/preBuildCodePage/${tabId}">生成模板</a>
	</shiro:hasPermission>
</div>
<form id="pagerForm" method="post" action="${ctx}/smModel/getModelDetailList/${tabId}?tabName=${tabName}">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
</form>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>字段名</th>
				<th>字段显示名</th>
				<th>类型</th>
				<th>长度</th>
				<th>可否空</th>
				<th>显示类型</th>
				<th>默认值</th>
				<th>显示宽度</th>
				<th>校验规则</th>
				<th>作为查询条件</th>
				<th>是否隐藏</th>
				<th>是否只读</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="item" items="${clist}" varStatus="status">
			<tr target="slt_uid" rel="${item.id}">
				<td>${page.pageBeginCount + status.index + 1}</td>
				<td>${item.colName}</td>
				<td>${item.colNameCn}</td>
				<td>${item.colType}</td>
				<td>${item.colSize}</td>
				<td>${item.colNull eq 'NO' ? '否':'是'}</td>
				<td>${item.colDisplayType}</td>
				<td title="${item.defaultValue}"><div style="width: 100px; text-overflow: ellipsis;">${item.defaultValue}</div></td>
				<td>${item.colDisplayWidth}</td>
				<td>${item.colValidation}</td>
				<td>${item.isLookupCondition eq 'Y' ? '是' : '否'}</td>
				<td>${item.colHidden eq 'none' ? '是' : '否'}</td>
				<td>${item.colReadonly eq 'disabled' ? '是' : '否'}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp">
	<c:param name="container" value=".detailFrame"/>
</c:import>