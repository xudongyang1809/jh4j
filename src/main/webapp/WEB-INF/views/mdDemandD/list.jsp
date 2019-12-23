<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 超级管理员 admin
	 @date 2019-05-10 11:32:22
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${ctx}/mdDemandD/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-bars">
	<shiro:hasPermission name="MdDemandD:create">
   		<a class="add" width="500" height="500" target="dialog" dialogId="createMdDemandDDialog" href="${ctx}/mdDemandD/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MdDemandD:edit">
   		<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMdDemandDDialog" href="${ctx}/mdDemandD/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MdDemandD:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/mdDemandD/delete/{slt_uid}">删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>需求计划编号</th>
				<th>需求计划项次号</th>
				<th>销售订单编号</th>
				<th>销售订单项次</th>
				<th>销售存货编号</th>
				<th>库存单位</th>
				<th>品名</th>
				<th>品牌</th>
				<th>型号规格</th>
				<th>建议单价</th>
				<th>销售单价</th>
				<th>销售数量</th>
				<th>计划申报数量</th>
				<th>平衡数量</th>
				<th>平衡接收人</th>
				<th>状态</th>
				<th>平衡分配状态</th>
				<th>汇总状态</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mdDemandD" varStatus="status">
				<tr target="slt_uid" rel="${mdDemandD.id}" id="${mdDemandD.id}">
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mdDemandD.strApplyNo}</td>
					<td>${mdDemandD.strApplyItem}</td>
					<td>${mdDemandD.strOrderNo}</td>
					<td>${mdDemandD.strOrderItem}</td>
					<td>${mdDemandD.strMatrlNo}</td>
					<td>${mdDemandD.strMatrlName}</td>
					<td>${mdDemandD.strBrand}</td>
					<td>${mdDemandD.strUnit}</td>
					<td>${mdDemandD.strSpec}</td>
					<td>${mdDemandD.bdPlanPrice}</td>
					<td>${mdDemandD.bdSalePrice}</td>
					<td>${mdDemandD.bdPlanQty}</td>
					<td>${mdDemandD.bdApplyNumber}</td>
					<td>${mdDemandD.bdBalanceQty}</td>
					<td>${mdDemandD.strBalanceUserId}</td>
					<td>${mdDemandD.strStus}</td>
					<td>${mdDemandD.strBalanceStus}</td>
					<td>${mdDemandD.strSumStus}</td>
					<td>${mdDemandD.strRemark}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
