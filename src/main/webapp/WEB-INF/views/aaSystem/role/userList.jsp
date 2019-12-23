<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div>	
	<form id="pagerForm" method="post" action="${ctx}/role/userList">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="roleId" value="${roleId}" />
	</form>
	<table class="frog-table">
		<thead>
			<tr>
				<th style="width: 50px;">序号</th>
				<th>工号</th>
				<th>姓名</th>
				<th style="width: 50px;">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userList}" var="user" varStatus="status">
				<tr target="slt_uid" rel="${user.strAccount}"> 
					<td>${page.pageBeginCount + status.index + 1}</td>
			     	<td title="工号">${user.strAccount}</td>
			     	<td title="姓名">${user.strName}</td>
			     	<td><button class="layui-btn layui-btn-xs layui-btn-danger" onclick="removeRoleUser('${user.strAccount}')">移除</button></td>
				</tr>
		 	</c:forEach>
		</tbody>
	</table>
	<%@include file="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp" %>
</div>
<script>
function removeRoleUser(userAccount) {
	Dialog.load();
	var roleId = '${roleId}';
	$.post("${ctx}/userRole/deleteByRoleIdAndUserNo", {roleId: roleId, userNo: userAccount}, function(msg) {
		try {
			var result = $.parseJSON(msg);
			if (result.statusCode == 200) {
				var container = Dialog.getCurrentDialog().find(">.layui-layer-content");
				var url = $(container).find('#pagerForm').attr("action");
				$(container).load(url, $(container).find('#pagerForm').serializeArray(), function() {
					layer.closeAll('loading');
					Dialog.success(result.message);
				});
			} else {
				Dialog.error(result.message);
			}
		} catch (e) {
			console.log(msg);
			Dialog.error(e.message);
		}
	});
}
</script>