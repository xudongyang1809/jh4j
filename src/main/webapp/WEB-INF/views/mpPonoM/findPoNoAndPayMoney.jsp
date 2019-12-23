<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>

<head>
	<script type="text/javascript">
		form.render();
		function myBringBack1(obj){
			var id= (obj["id"]);
			$("#${strMpPoNo}").val(obj["strPoNo"]);
			$.post("${ctx}/mpPonoM/BringPreMoney",{id:id}, function (msg) {
				try {
					var result = JSON.parse(msg);
					var messages=result.message;
					var  rel = result.rel;
					$("#${bdPayAmt}").val(rel);
					Ajax.ajaxDone(result);
				}catch (e) {
					console.log(msg);
					Dialog.error(e.message);
				}
			})
			$("div").each(function(){
				if($(this).attr("times") == $("#selectmppono").parent().attr("times")){
					$(this).fadeOut(500,function(){$(this).remove();});
				}
			})
		}
	</script>
</head>
<form id="pagerForm" method="post" action="${ctx}/mpPonoM/preFindPoNo">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="mpPono" value="${mpPono}"/>
	<input type="hidden" name="strMpPoNo" value="${strMpPoNo}"/>
	<input type="hidden" name="strMpPoName" value="${strMpPoName}"/>
	<input type="hidden" name="strSaleVendor" value="${strSaleVendor}"/>
	<input type="hidden" name="strSaleVendorName" value="${strSaleVendorName}"/>
</form>

<div class="tab-header">
	<form method="post" action="${ctx}/mpPonoM/preFindPoNo" autocomplete="off"  class="layui-form" onsubmit="return navTabSearch(this,'#selectmppono')">
		<input type="hidden" name="strMpPoNo" value="${strMpPoNo}"/>
		<input type="hidden" name="strMpPoName" value="${strMpPoName}"/>
		<input type="hidden" name="strSaleVendor" value="${strSaleVendor}"/>
		<input type="hidden" name="strSaleVendorName" value="${strSaleVendorName}"/>
		<div class="layui-form-item" >
			<div class="layui-inline">
				<label class="layui-form-label">合同号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text" name="strPoNo" value="${mpPono.strPoNo}"  />
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">供应商编号：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input"  name="strVendorNo" value="${mpPono.strVendorNo}"    />
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">供应商名称</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strVendorName" value="${mpPono.strVendorName}"   />
				</div>
			</div>
			<div class="layui-inline">
				<button class="search">查询</button>
			</div>
		</div>
	</form>
</div>

<div class="tab-content layui-form">
	<table class="frog-table"  >
		<thead>
		<tr>
			<th>序号</th>
			<th>合同号</th>
			<th>合同名称</th>
			<th>供应商编号</th>
			<th>供应商名称</th>
			<%--<th>承办人</th>--%>
			<th>查找带回</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${mplist}" var="mpPo" varStatus="status">
			<tr target="slt_uid" rel="${mpPo.id}" id="${mpPo.id}" >
				<td>${page.pageBeginCount+status.index+1}</td>
				<td>${mpPo.strPoNo}</td>
				<td>${mpPo.strPoName}</td>
				<td>${mpPo.strVendorNo}</td>
				<td>${mpPo.strVendorName}</td>

				<%--<td>${mpPo.strRespEmpNo}</td>--%>
				<td><a class="layui-btn layui-btn-sm" onclick="myBringBack1({id:'${mpPo.id}',strPoNo:'${mpPo.strPoNo}',strPoName:'${mpPo.strPoNo}-${mpPo.strPoName}',strSaleVendor:'${mpPo.strVendorNo}', strSaleVendorName:'${mpPo.strVendorNo}-${mpPo.strVendorName}'})" title="查找带回">选择</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<c:import url="/WEB-INF/views/pager/dialogPagerBar.jsp">
	<c:param name="container" value="#selectmppono"/>
</c:import>

</html>





