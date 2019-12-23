<%--
  Created by IntelliJ IDEA.
  User: maomin
  Date: 2019/5/9
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<head>
<script type="text/javascript">
	function selectStrMatrlNoList(obj){
		/*alert(obj["strMatrlNo"]);
		alert(obj["strName"]);
		alert(obj["strPrickleZH"]);
		alert(obj["strSpec"]);*/
		$("#strMatrlNo").val(obj["strMatrlNo"]);
		$("#strMatrlName").val(obj["strName"]);
		$("#strBrand").val(obj["strBrand"]);
		$("#strUnit").val(obj["strPrickleZH"]);
		$("#strSpec").val(obj["strSpec"]);
		$("div").each(function(){
			if($(this).attr("times") == $("#selectStrMatrlNoId001").parent().attr("times")){
				$(this).fadeOut(500,function(){$(this).remove();});
			}
		})
	}
</script>
</head>
<div id="selectStrMatrlNoId001">
<%--	<form id="pagerForm" method="post" action="${ctx}/msOrderD/selectSaleMatrlNo">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="keywords" value="${keywords}" />

	</form>--%>

	<form id="pagerForm" method="post" action="${ctx}/msOrderD/selectSaleMatrlNo">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="keywords" value="${keywords}" />
		<input type="hidden" name="strClass" value="${cmMatrinfoDetail.strClass}" />
		<input type="hidden" name="parentId" value="${cmMatrinfoDetail.parentId}" />
		<input type="hidden" name="strName" value="${strName}" />
		<input type="hidden" name="strSn" value="${strSn}" />
		<input type="hidden" name="strBrand" value="${strBrand}" />
		<input type="hidden" name="strSelfproduce" value="${strSelfproduce}"  />
	</form>
<div class="tab-header">
	<form method="post" action="${ctx}/msOrderD/selectSaleMatrlNo?strOrderStyle=${strOrderStyle}" class="layui-form" onsubmit="return dialogSearch(this,'#selectStrMatrlNoId001');">
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">存货编号</label>
			<div class="layui-input-inline">
				<input type="text" id="selectSaleMatrlNo_strSn" name="strSn" value="${strSn}" autocomplete="off" class="layui-input"/>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">存货名称</label>
			<div class="layui-input-inline">
				<input type="text" id="strName" name="strName" value="${strName}" autocomplete="off" class="layui-input"/>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">存货品牌</label>
			<div class="layui-input-inline">
				<input type="text" id="strBrand" name="strBrand" value="${strBrand}" autocomplete="off" class="layui-input"/>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">是否为生产型存货</label>
			<div class="layui-input-inline">
				<select id="strSelfproduce" name="strSelfproduce" class="layui-input">
                    <option value="" ${strSelfproduce eq '' ? 'selected' : ''}>请选择</option>
                    <option value="1" ${strSelfproduce eq '1' ? 'selected' : ''}>是</option>
                    <option value="2" ${strSelfproduce eq '2' ? 'selected' : ''}>否</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<button class="search btn-big">查询</button>
		</div>
	</div>
	</form>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
			<th>序号</th>
			<th>存货大类</th>
			<th>存货名称</th>
			<th>存货编号</th>
			<th>品名</th>
			<th>品牌</th>
			<th>型号规格</th>
			<th>请选择</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${matrInfoDtl}" var="matrInfoDtl" varStatus="status">
				<tr target="sid_matrInfoDtl" rel="${matrInfoDtl.id}" id="${matrInfoDtl.id}">
					<td>${page.pageBeginCount+status.index+1}</td>
					<td>${matrInfoDtl.strClass}</td>
					<td>${matrInfoDtl.strName}</td>
					<td>${matrInfoDtl.strSn}</td>
					<td>${matrInfoDtl.strName}</td>
					<td>${matrInfoDtl.strBrand}</td>
					<td>${matrInfoDtl.strSpec}</td>
					<td><a class="layui-btn layui-btn-sm" onclick="selectStrMatrlNoList({strMatrlNo:'${matrInfoDtl.strSn}',strName:'${matrInfoDtl.strName}',strBrand:'${matrInfoDtl.strBrand}',strPrickleZH:'${matrInfoDtl.strPrickleZH}',strSpec:'${matrInfoDtl.strSpec}'})" title="查找带回">选择</a></td>
					<%--<td><a class="layui-btn layui-btn-xs" onclick="selectStrOrdNoList({strOrderNo:'${msOrderList.strOrderNo}'})" title="查找带回">选择</a></td>--%>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>
	<c:import url="/WEB-INF/views/pager/dialogPagerBar.jsp">
		<c:param name="container" value="#selectStrMatrlNoId001"> </c:param>
	</c:import>
</div>
<!-- 分页 -->
<%--<%@ include file="../aaSystem/pager/layuiPagerBar.jsp" %>--%>

