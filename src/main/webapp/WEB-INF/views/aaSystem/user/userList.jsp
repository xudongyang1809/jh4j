<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/user/list" onsubmit="return navTabSearch(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="strNameOrAccount" value="${strNameOrAccount}"/>
</form>

<div class="tab-header">
	<form class="layui-form" action="${ctx}/user/list" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
	  		<div class="layui-inline">
	    		<label class="layui-form-label">模糊查询</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="strNameOrAccount" value="${strNameOrAccount}" placeholder="输入工号或姓名..." autocomplete="off" class="layui-input">
	    		</div>
	    	</div>
	    	<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
	  	</div>
  	</form>
</div>

<div class="tab-bars">
	<shiro:hasPermission name="User:create">
		<a class="add" target="dialog" width="550" height="550" dialogId="createUser" href="${ctx}/user/preCreate">新增</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="User:edit">
		<a class="edit" target="dialog" width="550" height="500" dialogId="updateUser" href="${ctx}/user/preUpdate?id={slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="User:delete">
		<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" href="${ctx}/user/delete/{slt_uid}">删除</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="User:resetPassword">
		<a class="edit" target="ajaxTodo" title="确认要初始化密码为123456吗?" href="${ctx}/user/initializePassword?id={slt_uid}">重置密码</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="User:distributeRole">
		<a class="edit" target="dialog" width="550" height="600" dialogId="roleManage" href="${ctx}/user/preRoleManage?id={slt_uid}">分配角色</a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th orderField="strAccount">工号</th>
				<th>姓名</th>
				<th>邮箱</th>
				<th>手机号码</th>
				<th>所属部门</th>
				<th>登录次数</th>
				<th>固话</th>
				<th>账号状态</th>
				<th>创建时间</th>
				<th>创建人</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${users}" var="user" varStatus="status">
			<tr target="slt_uid" rel="${user.id}"> 
				<td title="序号">${page.pageBeginCount + status.index + 1}</td>
	   			<td title="工号">${user.strAccount}</td>
		     	<td title="姓名">${user.strName}</td>
		     	<td title="邮箱">${user.strEmail}</td>
		     	<td title="手机号码">${user.strPhone}</td>
		     	<td title="所属部门">${user.dept.strName}</td>
		     	<td title="登录次数">${user.intLoginNum}</td>
		     	<td title="固话">${user.strLinePhone}</td>
		     	<td title="账号状态">${user.strStatus == 'enabled' ? '可用' : '不可用'}</td>
		     	<td title="创建及时间">${user.createDateTime}</td>
		     	<td title="创建人">${user.createUser.strName}</td>
			 </tr>
			 </c:forEach>		
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
