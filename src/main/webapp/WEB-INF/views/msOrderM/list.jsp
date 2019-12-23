<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 超级管理员 admin
	 @date 2019-04-29 17:54:44
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<div id="msOrderMListId">
<form id="pagerForm" method="post" action="${ctx}/msOrderM/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strOrderNo" value="${msOrderM.strOrderNo}" />
	<input type="hidden" name="strOrderStyle" value="${msOrderM.strOrderStyle}" />
	<input type="hidden" name="strOrderName" value="${msOrderM.strOrderName}" />
	<input type="hidden" name="strVendorNo" value="${msOrderM.strVendorNo}" />
	<input type="hidden" name="strStus" value="${msOrderM.strStus}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/msOrderM/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">销售订单编号:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strOrderNo" class="layui-input" autocomplete="off" value="${msOrderM.strOrderNo}" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">销售订单类型:</label>
			  	<div class="layui-input-inline">
					<%--<input type="text" name="strOrderStyle" class="layui-input" />--%>
					<select name="strOrderStyle" class="layui-input">
						<option value="" ${msOrderM.strOrderStyle eq '' ? 'selected' : ''}></option>
						<option value="1" ${msOrderM.strOrderStyle eq '1' ? 'selected' : ''}>生产型原料</option>
						<option value="2" ${msOrderM.strOrderStyle eq '2' ? 'selected' : ''}>贸易型商品</option>
					</select>
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">销售订单名称:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strOrderName" autocomplete="off" class="layui-input" value="${msOrderM.strOrderName}" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">客户编号:</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strVendorNo" autocomplete="off" class="layui-input" value="${msOrderM.strVendorNo}"/>
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="width: 87px">状态:</label>
			  	<div class="layui-input-inline">
					<select name="strStus" class="layui-input">
						<option value="" ${msOrderM.strStus eq '' ? 'selected' : ''}>请选择</option>
						<option value="N" ${msOrderM.strStus eq 'N' ? 'selected' : ''}>新增</option>
						<option value="S" ${msOrderM.strStus eq 'S' ? 'selected' : ''}>生效</option>
					</select>
			  	</div>
			</div>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="MsOrderM:create">
   		<a class="add" width="1100" height="580" target="dialog" max="true" dialogId="createMsOrderMDialog" href="${ctx}/msOrderM/preCreate">添加</a>
   	</shiro:hasPermission>
	<shiro:hasPermission name="MsOrderM:edit">
		<a class="edit" width="1100" height="580" target="dialog" max="true" dialogId="upadteMsOrderMDialog" href="${ctx}/msOrderM/preUpdate?id={slt_uid}">编辑</a>
	</shiro:hasPermission>
   	<shiro:hasPermission name="MsOrderM:delete">
   		<%--<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/msOrderM/delete/{slt_uid}">删除</a>--%>
		<a class="deleteList"  onclick="deleteListMsOrderM()">批量删除</a>
   	</shiro:hasPermission>
	<shiro:hasPermission name="MsOrderM:view">
		<a class="confirm" target="ajaxTodo" href="${ctx}/msOrderM/updateStatue/{slt_uid}?flg=S" >生效</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MsOrderM:view">
		<a class="cancelConfirm" target="ajaxTodo" href="${ctx}/msOrderM/updateStatue/{slt_uid}?flg=N" >取消生效</a>
	</shiro:hasPermission>
	<%--<shiro:hasPermission name="MsOrderM:view">
		<a class="end" target="ajaxTodo" href="${ctx}/msOrderM/updateStatue/{slt_uid}?flg=X" >结案</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MsOrderM:view">
		<a class="approve" target="ajaxTodo" href="${ctx}/msOrderM/updateStatue/{slt_uid}?flg=XL" >取消结案</a>
	</shiro:hasPermission>--%>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th><input type="checkbox" lay-skin="primary" class="checkAllMsOrderM" lay-filter="checkAllMsOrderM" ></th>
				<th>序号</th>
				<th>销售订单编号</th>
				<th>销售订单类型</th>
				<th>销售订单名称</th>
				<th>客户编号</th>
				<th>甲方经办人</th>
				<th>订单开始日期</th>
				<th>订单结束日期</th>
				<th>业务人员</th>
				<th>销售订单金额</th>
				<th>交期</th>
				<%--<th>税率</th>--%>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="msOrderM" varStatus="status">
				<tr target="slt_uid" rel="${msOrderM.id}" id="${msOrderM.id}">
					<td><input type="checkbox" data-value="${msOrderM.id}" lay-skin="primary"  lay-filter="checkAllMsOrderM"/></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${msOrderM.strOrderNo}</td>
					<td>${msOrderM.strOrderStyle1}</td>
					<td>${msOrderM.strOrderName}</td>
					<td>${msOrderM.strVendorNo}</td>
					<td>${msOrderM.strOperator}</td>
					<td>${msOrderM.strDateFrom}</td>
					<td>${msOrderM.strDateTo}</td>
					<td>${msOrderM.strApplyUserIdZH}</td>
					<td>${msOrderM.bdPlanAmt}</td>
					<td>${msOrderM.strDeliveryDate}</td>
					<%--<td>${msOrderM.bdTaxRate}</td>--%>
					<td>${msOrderM.strStatuZH}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script>
	/*批量选择*/
	form.on('checkbox(checkAllMsOrderM)', function(data) {
		if ($(data.elem).hasClass("checkAllMsOrderM")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
	/*批量删除*/
	function deleteListMsOrderM() {
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
			$.post("${ctx}/msOrderM/delete", {ids: ids},
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