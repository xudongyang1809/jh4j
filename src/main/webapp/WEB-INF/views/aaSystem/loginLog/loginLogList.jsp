<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/loginLog/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/loginLog/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">工号/名称：</label>
				<div class="layui-input-inline">
					<input type="text" name="userNo" class="layui-input" value="${userNo}" placeholder="工号/名称检索" />
				</div>
			</div>
			<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th width="40">序号</th>
				<th width="150">登录名称</th>
				<th width="130">登录IP</th>
				<th width="60">是否成功</th>
				<th width="60">登录类型</th>
				<th width="150">登录时间</th>
				<th width="150">退出时间</th>
				<th>SessionID</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${loginLogs}" varStatus="status">
			<tr target="slt_uid" rel="${item.id}">
				<td>${page.pageBeginCount + status.index + 1}</td>
				<td>${item.user.strAccount}[${item.user.strName}]</td>
				<td>${item.strLoginIP}</td>
				<td>${item.intIsSuccess == 1 ? "成功" : "失败"}</td>
				<td>${item.intType == 1 ? "登录" : "退出"}</td>
				<td>${item.strLoginDateTime}</td>
				<td>${item.strLogoutDateTime}</td>
				<td>${item.strSessionId}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script type="text/javascript">
function deleteData(url, id) {
	layer.confirm("确定删除吗?", {
		  btn: ['确定','取消'] //按钮
		}, function() {
	    	customAjaxTodo(url+id, function(msg) {
				layer.msg(m.message, {icon: 1});
   		 	});
		}, function() {
		 	 layer.close();
		}
	);
}
</script>
