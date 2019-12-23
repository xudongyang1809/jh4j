<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<script>
function myBringBack(obj){

	$("#${strVendorNo}").val(obj["strVendorNo"]);
	$("#${strVendorNoName}").val(obj["strVendorNo"]+"-"+obj["strVendorName"]);
	$("#${strVendorName}").val(obj["strVendorName"]);
			$("div").each(function(){
		if($(this).attr("times") == $("#selectMerchantDialog").parent().attr("times")){
			$(this).fadeOut(500,function(){$(this).remove();});
		}
	})

}
</script>
<form id="pagerForm" method="post" action="${ctx}/mcInfomationM/listMerchant">
	<input type="hidden" name="pageNum" value="${page.pageNum}" /> 
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" /> 
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}" />
	<input type="hidden" name="strVendorNo" value="${mcInfomationM.strVendorNo}"/>
	<input type="hidden" name="strVendorName" value="${mcInfomationM.strVendorName}"/>
</form>

<div class="tab-header">
	<form method="post" class="layui-form" action="${ctx}/mcInfomationM/listMerchant" onsubmit="return dialogSearch(this ,'#selectMerchantDialog');">
		<input type="hidden" name="strVendorNo1" value="${strVendorNo}" />
		<input type="hidden" name="strVendorNoName" value="${strVendorNoName}" />
		<input type="hidden" name="strVendorName1" value="${strVendorName}" />

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">商户编码</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="strVendorNo" value="${mcInfomationM.strVendorNo}" autocomplete="off" placeholder="请填写商户编码"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label">商户名称</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="strVendorName" value="${mcInfomationM.strVendorName}" autocomplete="off" placeholder="请填写商户名称"/>
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
				<th>商户编码</th>
				<th>商户名称</th>
				<th>商户英文名</th>

				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="cmMerchant" varStatus="status">
				<tr target="slt_uid" rel="${cmMerchant.id}" id="${cmMerchant.id}">
					<td>${page.pageBeginCount+status.index+1}</td>
					<td>${cmMerchant.strVendorNo}</td>
					<td>${cmMerchant.strVendorName}</td>
					<td>${cmMerchant.strEngName}</td>
					<td><a class="layui-btn layui-btn-xs" onclick="myBringBack({strMerId:'${cmMerchant.id}', strVendorNo:'${cmMerchant.strVendorNo}',strVendorName:'${cmMerchant.strVendorName}'})" title="查找带回">选择</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- 分页 -->
 <c:import url="/WEB-INF/views/pager/dialogPagerBar.jsp">
	<c:param name="container" value="#selectMerchantDialog"/>
</c:import>