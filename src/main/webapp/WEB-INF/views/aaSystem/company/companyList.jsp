<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/company/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-header">
	<form class="layui-form" action="${ctx}/company/list" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
	  		<div class="layui-inline">
	    		<label class="layui-form-label">模糊查询</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="keywords" value="${keywords}" placeholder="输入编码或名称..." class="layui-input" />
	    		</div>
	    	</div>
	    	<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
	  	</div>
	 </form>
</div>

<div class="tab-bars">
	<shiro:hasPermission name="Company:create">
		<a class="add" target="dialog" width="550" height="400" dialogId="createCompany" href="${ctx}/company/preCreate">新增</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Company:edit">
		<a class="edit" target="dialog" width="550" height="400" dialogId="updateCompany" href="${ctx}/company/preUpdate/{slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Company:delete">
		<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" href="${ctx}/company/delete/{slt_uid}">删除</a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>公司编码</th>
				<th>公司名称</th>
				<th>公司別</th>
				<th>备注</th>
				<th>创建人</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${companies}" var="company">
				<tr target="slt_uid" rel="${company.id}">
					<td>${company.strSn}</td>
					<td>${company.strName}</td>
					<td>${company.strNCSn}</td>
					<td>${company.strDesc}</td>
					<td>${company.createUser.strName}</td>
					<td>${company.createDateTime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>

