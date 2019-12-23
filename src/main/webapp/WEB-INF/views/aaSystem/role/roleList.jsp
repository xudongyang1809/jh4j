<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/role/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="strName" value="${strName}"/>
</form>
<div class="tab-header">
	<form class="layui-form" action="${ctx}role/list" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
	  		<div class="layui-inline">
	    		<label class="layui-form-label">角色名称</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="strName" value="${strName}" placeholder="输入角色名称..." autocomplete="off" class="layui-input">
	    		</div>
	    	</div>
	    	<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
	  	</div>
  	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="Role:create">
		<a class="add" target="dialog" width="400" height="200" dialogId="createRole" href="${ctx}/role/preCreate">新增</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Role:edit">
		<a class="edit" target="dialog" width="400" height="200" dialogId="updateRole" href="${ctx}/role/preUpdate?id={slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Role:delete">
		<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" href="${ctx}/role/delete?id={slt_uid}">删除</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Role:authorize">
		<a class="edit" target="dialog" width="500" height="640" dialogId="roleAuthorizeDialog" href="${ctx}/role/preAuthorize?id={slt_uid}">角色授权</a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>角色名称</th>
				<th style="width: 150px;">角色所含人员数量</th>
				<th>创建时间</th>
				<th>创建人</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="role" varStatus="status">
				<tr target="slt_uid" rel="${role.id}"> 
					<td>${page.pageBeginCount + status.index + 1}</td>
			     	<td title="角色名称">${role.strName}</td>
			     	<td title="角色所含人员数量">
			     		<c:if test="${fn:length(role.userList) > 0}">
			     			<a style="color: #01AAED; text-decoration: underline;" title="角色下的人员信息" target="dialog" width="500" height="500" dialogId="showUserList" href="${ctx}/role/userList?roleId=${role.id}">点击查看角色人数：${fn:length(role.userList)}</a>
			     		</c:if>
			     		<c:if test="${fn:length(role.userList) eq 0}">
			     			无
			     		</c:if>
			     	</td>
			     	<td title="创建及时间">${role.createDateTime}</td>
			     	<td title="创建人">${role.createUser.strName}</td>
				 </tr>
			 </c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>


