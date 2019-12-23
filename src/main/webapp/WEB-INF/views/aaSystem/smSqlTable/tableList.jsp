<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<head>
</head>
<div class="tab-bars">
	<shiro:hasPermission name="SmModelAbstract:abstract">
		<a class="database" target="ajaxTodo" title="确认要抽取此数据吗?" href="${ctx}/smModel/extract/{slt_uid}">抽取</a>
		<a class="delete" target="ajaxTodo" title="确认删除已抽取的数据吗?" href="${ctx}/smModel/deleteBizObj/{slt_uid}">删除抽取数据</a>
		<a class="lock" href="${ctx}/smModel/lockModel/{slt_uid}" target="ajaxTodo" title="确定锁定吗,锁定之后将无法生成模板?">锁定</a>
		<a class="unlock" href="${ctx}/smModel/unLockModel/{slt_uid}" target="ajaxTodo" title="确定解除锁定吗?">解锁</a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
 				<th>序号</th>
				<th>数据库表</th>
				<th>是否已抽取</th>
				<th>是否锁定</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${tlist}" var="table" varStatus="status">
				<c:if test="${table.id ne null}">
					<tr target="slt_uid" id="${table.id}" rel="${table.id}" >
						<td>${page.pageBeginCount + status.index + 1}</td> 
						<td>${table.tableName}</td>
						<td style="color: blue;">${table.isExtracted eq 1 ? '是' : '否'}</td>
						<td>${table.status eq 'Y' ? '是' : '否'}</td>
					</tr>
				</c:if>
			</c:forEach>
			<c:forEach items="${tlist}" var="table" varStatus="status">
				<c:if test="${table.id eq null}">
					<tr target="slt_uid" id="${table.id eq null ? table.tableName : table.id}" rel="${table.id eq null ? table.tableName : table.id}" >
						<td>${page.pageBeginCount + status.index + 1}</td> 
						<td>${table.tableName}</td>
						<td style="color: red;">${table.isExtracted eq 1 ? '是' : '否'}</td>
						<td>${table.status eq 'Y' ? '是' : '否'}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>
