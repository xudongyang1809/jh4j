<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 超级管理员 admin
	 @date 2019-05-16 10:47:21
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${ctx}/miCheckD/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-bars">
	<shiro:hasPermission name="MiCheckD:create">
   		<a class="add" width="500" height="500" target="dialog" dialogId="createMiCheckDDialog" href="${ctx}/miCheckD/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MiCheckD:edit">
   		<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMiCheckDDialog" href="${ctx}/miCheckD/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MiCheckD:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miCheckD/delete/{slt_uid}">删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>修改人工号</th>
				<th>公司别</th>
				<th>存货编号</th>
				<th>品名</th>
				<th>计量单位(库存单位)</th>
				<th>费用属性</th>
				<th>库存数量</th>
				<th>实盘数量</th>
				<th>盘盈数量</th>
				<th>盘盈余额</th>
				<th>strA</th>
				<th>strB</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="miCheckD" varStatus="status">
				<tr target="slt_uid" rel="${miCheckD.id}" id="${miCheckD.id}">
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${miCheckD.updateUserNo}</td>
					<td>${miCheckD.companyIdva}</td>
					<td>${miCheckD.strMatrlNo}</td>
					<td>${miCheckD.strMatrlName}</td>
					<td>${miCheckD.strUnit}</td>
					<td>${miCheckD.strCostAttribute}</td>
					<td>${miCheckD.bdStockNum}</td>
					<td>${miCheckD.bdCheckNum}</td>
					<td>${miCheckD.bdInventoryLossNum}</td>
					<td>${miCheckD.bdInventoryLossMoney}</td>
					<td>${miCheckD.strA}</td>
					<td>${miCheckD.strB}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
