<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 超级管理员 admin
	 @date 2019-04-29 11:10:45
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${ctx}/mfBom/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strProdMatrlNo" value="${mfBom.strProdMatrlNo}" />
	<input type="hidden" name="strMaterialName" value="${mfBom.strMaterialName}" />
	<input type="hidden" name="strMatrlNo" value="${mfBom.strMatrlNo}" />
	<input type="hidden" name="strMatrlName" value="${mfBom.strMatrlName}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/mfBom/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">产品存货编号:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strSn" autocomplete="off" class="layui-input" value="${cmMatrinfoDetail.strSn}" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">产品存货名称:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strName" autocomplete="off" class="layui-input" value="${cmMatrinfoDetail.strName}" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">品牌:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strBrand" autocomplete="off" class="layui-input" value="${cmMatrinfoDetail.strBrand}" />
			  	</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label">品名:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strMatrlName" autocomplete="off" class="layui-input" value="${cmMatrinfoDetail.strMatrlName}" />
			  	</div>
			</div>--%>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<%--<shiro:hasPermission name="MfBom:create">
   		<a class="add" width="900" height="580" target="dialog" dialogId="createMfBomDialog" href="${ctx}/mfBom/preCreate">添加</a>
   	</shiro:hasPermission>--%>
   	<shiro:hasPermission name="MfBom:edit">
   		<a class="edit" width="1200" height="580" target="dialog" max="true" dialogId="upadteMfBomDialog" href="${ctx}/mfBom/preUpdate?id={slt_uid}">编辑</a>
   	</shiro:hasPermission>
   <%--	<shiro:hasPermission name="MfBom:delete">
   		&lt;%&ndash;<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/mfBom/delete/{slt_uid}">删除</a>&ndash;%&gt;
		<a class="deleteList"  onclick="deleteListMfBom()">批量删除</a>
   	</shiro:hasPermission>--%>
</div>
<div class="tab-content layui-form">
	<table class="frog-table" id="cmMatrinfoDetailTable">
		<thead>
		<tr>
			<th><input type="checkbox" lay-skin="primary" class="checkAllMfBom" lay-filter="checkAllMfBom" ></th>
			<th>序号</th>
			<th>存货编码</th>
			<th>存货名称</th>
			<th>品牌</th>
			<th>型号</th>
			<th>计量单位</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="cmMatrinfoDetail" varStatus="status">
			<tr target="slt_uid" rel="${cmMatrinfoDetail.id}" id="${cmMatrinfoDetail.id}" ondblclick="showCmMatrinfoDetail(this)">
				<td><input type="checkbox" data-value="${mfBom.id}" lay-skin="primary"  lay-filter="checkAllMfBom"/></td>
				<td>${page.pageBeginCount+status.index+1}</td>
				<td>${cmMatrinfoDetail.strSn}</td>
				<td>${cmMatrinfoDetail.strName}</td>
				<td>${cmMatrinfoDetail.strBrand}</td>
				<td>${fn:escapeXml(cmMatrinfoDetail.strSpec)}</td>
				<td>${cmMatrinfoDetail.strPrickleZH}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<%--<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th><input type="checkbox" lay-skin="primary" class="checkAllMfBom" lay-filter="checkAllMfBom" ></th>
				<th>序号</th>
				<th>产品存货编号</th>
				<th>产品存货名称</th>
				<th>项次号</th>
				<th>原料</th>
				<th>品名</th>
				<th>品牌</th>
				<th>库存单位</th>
				<th>型号规格</th>
				<th>原料数量</th>
				<th>子项采购单价</th>
				<th>子项采购总价</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mfBom" varStatus="status">
				<tr target="slt_uid" rel="${mfBom.id}" id="${mfBom.id}">
					<td><input type="checkbox" data-value="${mfBom.id}" lay-skin="primary"  lay-filter="checkAllMfBom"/></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mfBom.strProdMatrlNo}</td>
					<td>${mfBom.strMaterialName}</td>
					<td>${mfBom.strItemNo}</td>
					<td>${mfBom.strMatrlNo}</td>
					<td>${mfBom.strMatrlName}</td>
					<td>${mfBom.strBrand}</td>
					<td>${mfBom.strUnit}</td>
					<td>${mfBom.strSpec}</td>
					<td>${mfBom.bdMatrlQty}</td>
					<td>${mfBom.bdItemPurPrice}</td>
					<td>${mfBom.bdItemSumPrice}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>--%>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script>
	/*批量选择*/
form.on('checkbox(checkAllMfBom)', function(data) {
	if ($(data.elem).hasClass("checkAllMfBom")) {
		if (data.elem.checked) {
			$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
		} else {
			$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
		}
		form.render('checkbox');
	}
});
	/*批量删除*/
function deleteListMfBom() {
	var ids = "";
	$('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function() {
		if ($(this).prop("checked")) {
			var id = $(this).parents('tr:first').attr("rel");
			if (ids == "") {
				ids = id;
			} else {
				ids += "," + id;
			}
		}
	});
	if (ids == "") {
		Dialog.warn("未选中一条以上的数据");
		return;
	}
	layer.confirm("确定删除吗?", {
		btn: ['确定','取消'] //按钮
	},function() {
		$.post("${ctx}/mfBom/delete", {ids: ids},
				function(msg) {
					try {
						var result = JSON.parse(msg);
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							NavTab.reloadWithPagination(result.navTabId);
						}
					} catch (e) {
						console.log(msg);
						Dialog.error(e.message);
					}
				});
	}, function()
	{
		layer.close();
	})
}
</script>