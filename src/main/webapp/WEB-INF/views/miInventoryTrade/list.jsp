<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 超级管理员 admin
	 @date 2019-05-27 10:14:46
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${ctx}/miInventoryTrade/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>
<%--<div class="tab-bars">--%>
	<%--<shiro:hasPermission name="MiInventoryTrade:create">--%>
   		<%--<a class="add" width="500" height="500" target="dialog" dialogId="createMiInventoryTradeDialog" href="${ctx}/miInventoryTrade/preCreate">添加</a>--%>
   	<%--</shiro:hasPermission>--%>
   	<%--<shiro:hasPermission name="MiInventoryTrade:edit">--%>
   		<%--<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMiInventoryTradeDialog" href="${ctx}/miInventoryTrade/preUpdate/{slt_uid}">编辑</a>--%>
   	<%--</shiro:hasPermission>--%>
   	<%--<shiro:hasPermission name="MiInventoryTrade:delete">--%>
   		<%--<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miInventoryTrade/delete/{slt_uid}">删除</a>--%>
   	<%--</shiro:hasPermission>--%>
<%--</div>--%>
<div class="tab-header">
	<form method="post" action="${ctx}/miInventoryTrade/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label">交易单号</label>
				<div class="layui-input-inline">
					<input type="text" name="strTradeNo" id="strTradeNo" class="layui-input" value="${miInventoryTrade.strTradeNo}"/>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label">储位</label>
				<div class="layui-input-inline">
					<select name="strAreaId" id="strAreaId" >
						<option value=''>请选择</option>
						<c:forEach items="${dictDtlList}" var="field">
							<option value='${field.id}'>${field.strName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-md3">
				<label class="layui-form-label">存货编号</label>
				<div class="layui-input-inline">
					<input type="text" name="strMatrlNo" id="strMatrlNo" class="layui-input" value="${miInventoryTrade.strMatrlNo}"/>
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
				<th>序号</th>
				<th>业务单号</th>
				<th>项次号</th>
				<th>数据类别</th>
				<th>储位</th>
				<th>存货编号</th>
				<th>数量</th>
				<th>总金额</th>
				<th>业务主档单号</th>
				<th>业务明细单号</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="miInventoryTrade" varStatus="status">
				<tr target="slt_uid" rel="${miInventoryTrade.id}" id="${miInventoryTrade.id}">
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${miInventoryTrade.strTradeNo}</td>
					<td>${miInventoryTrade.strBatchNo}</td>
					<td>${miInventoryTrade.strActionStyle}</td>
					<td>${miInventoryTrade.strAreaId}</td>
					<td>${miInventoryTrade.strMatrlNo}</td>
					<td>${miInventoryTrade.bdQty}</td>
					<td>${miInventoryTrade.bdAmt}</td>
					<td>${miInventoryTrade.strTradeItem}</td>
					<td>${miInventoryTrade.strIssueItem}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
