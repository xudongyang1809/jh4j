<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 超级管理员 admin
	 @date 2019-04-30 13:34:43
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${ctx}/miAcceptanceD/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-bars">
	<shiro:hasPermission name="MiAcceptanceD:create">
   		<a class="add" width="500" height="500" target="dialog" dialogId="createMiAcceptanceDDialog" href="${ctx}/miAcceptanceD/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MiAcceptanceD:edit">
   		<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMiAcceptanceDDialog" href="${ctx}/miAcceptanceD/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MiAcceptanceD:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miAcceptanceD/delete/{slt_uid}">删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>修改人工号</th>
				<th>入库单号</th>
				<th>入库项次号</th>
				<th>采购合同号</th>
				<th>采购合同项次</th>
				<th>销售订单编号</th>
				<th>销售订单项次</th>
				<th>需求计划编号</th>
				<th>需求计划明细号</th>
				<th>到货明细ID</th>
				<th>储位</th>
				<th>存货编号</th>
				<th>品名</th>
				<th>品牌</th>
				<th>型号规格</th>
				<th>入库单价</th>
				<th>入库量=合格量+让步接收量 </th>
				<th>到货数量</th>
				<th>合格量 </th>
				<th>让步接收量</th>
				<th>退货量</th>
				<th>采购总金额</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="miAcceptanceD" varStatus="status">
				<tr target="slt_uid" rel="${miAcceptanceD.id}" id="${miAcceptanceD.id}">
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${miAcceptanceD.updateUserNo}</td>
					<td>${miAcceptanceD.strInspNo}</td>
					<td>${miAcceptanceD.strInspItem}</td>
					<td>${miAcceptanceD.strPoNo}</td>
					<td>${miAcceptanceD.strPoItemNo}</td>
					<td>${miAcceptanceD.strOrderNo}</td>
					<td>${miAcceptanceD.strOrderItem}</td>
					<td>${miAcceptanceD.strReqNo}</td>
					<td>${miAcceptanceD.strReqItem}</td>
					<td>${miAcceptanceD.strArrId}</td>
					<td>${miAcceptanceD.strAreaId}</td>
					<td>${miAcceptanceD.strMatrlNo}</td>
					<td>${miAcceptanceD.strMatrlName}</td>
					<td>${miAcceptanceD.strBrand}</td>
					<td>${miAcceptanceD.strSpec}</td>
					<td>${miAcceptanceD.bdBuyPrice}</td>
					<td>${miAcceptanceD.bdInStoreQty}</td>
					<td>${miAcceptanceD.bdArrQty}</td>
					<td>${miAcceptanceD.bdPassQty}</td>
					<td>${miAcceptanceD.bdConcessionQty}</td>
					<td>${miAcceptanceD.bdReturnQty}</td>
					<td>${miAcceptanceD.bdTotalAmt}</td>
					<td>${miAcceptanceD.strMemo}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
