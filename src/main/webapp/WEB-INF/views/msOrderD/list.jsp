<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 毛敏 022325
	 @date 2019-04-29 18:27:16
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${ctx}/msOrderD/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-bars">
	<shiro:hasPermission name="MsOrderD:create">
   		<a class="add" width="500" height="500" target="dialog" dialogId="createMsOrderDDialog" href="${ctx}/msOrderD/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MsOrderD:edit">
   		<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMsOrderDDialog" href="${ctx}/msOrderD/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MsOrderD:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/msOrderD/delete/{slt_uid}">删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>销售订单编号</th>
				<th>销售订单项次</th>
				<th>存货编号</th>
				<th>品名</th>
				<th>品牌</th>
				<th>库存单位</th>
				<th>型号规格</th>
				<th>采购单价</th>
				<th>销售单价</th>
				<th>销售数量</th>
				<th>采购数量</th>
				<th>销售单项总金额</th>
				<th>交货期限</th>
				<th>状态</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="msOrderD" varStatus="status">
				<tr target="slt_uid" rel="${msOrderD.id}" id="${msOrderD.id}">
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${msOrderD.strOrderNo}</td>
					<td>${msOrderD.strOrderItem}</td>
					<td>${msOrderD.strMatrlNo}</td>
					<td>${msOrderD.strMatrlName}</td>
					<td>${msOrderD.strBrand}</td>
					<td>${msOrderD.strUnit}</td>
					<td>${msOrderD.strSpec}</td>
					<td>${msOrderD.bdPurchasePrice}</td>
					<td>${msOrderD.bdSalePrice}</td>
					<td>${msOrderD.bdSaleQty}</td>
					<td>${msOrderD.bdPurchaseQty}</td>
					<td>${msOrderD.bdItemAmt}</td>
					<td>${msOrderD.strDate}</td>
					<td>${msOrderD.strStus}</td>
					<td>${msOrderD.strRemark}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
