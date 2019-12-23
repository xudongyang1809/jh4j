<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 毛敏 022325
	 @date 2019-05-29 13:51:08
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script>
	/*批量选择*/
	form.on('checkbox(checkALLMsSettlementM)', function(data) {
		if ($(data.elem).hasClass("checkALLMsSettlementM")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
	/*批量删除*/
	function deleteMsSettlementM() {
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
			$.post("${ctx}/msSettlementM/delete", {ids: ids},
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
	/*编辑销售结算页面*/
	function updateToMsSettlementM(){
		debugger;
		var btbedit = document.getElementsByName("Check_MsSettlementM");
		var trId;
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
			}
		}
		if (trId == undefined || trId == null) {
			Dialog.warn("未选中一条数据");
			return false;
		}
		$.post("${ctx}/msSettlementM/preUpdate?id="+trId,"",function(content){
			top.layer.open({
				type: 1,
				area: ["100%","100%"],
				title: "编辑销售结算",
				shadeClose: true,
				offset: "0px",
				maxmin: true,
				anim: 5,
				content: content
			});
		});
	}
</script>
<div id="msSettlementMListId">
<form id="pagerForm" method="post" action="${ctx}/msSettlementM/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strSettleNumber" value="${msSettlementM.strSettleNumber}" />
	<input type="hidden" name="strOrderNo" value="${msSettlementM.strOrderNo}" />
	<input type="hidden" name="strVendorNo" value="${msSettlementM.strVendorNo}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/msSettlementM/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">销售结算单号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strSettleNumber" class="layui-input" value="${msSettlementM.strSettleNumber}" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">销售订单编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strOrderNo" class="layui-input" value="${msSettlementM.strOrderNo}"   />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">供应商编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strVendorNo" class="layui-input" value="${msSettlementM.strVendorNo}"/>
			  	</div>
			</div>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="MsSettlementM:create">
   		<a class="add" width="1100" height="580" target="dialog" max="true" dialogId="createMsSettlementMDialog" href="${ctx}/msSettlementM/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MsSettlementM:edit">
   		<a class="edit" width="1100" height="580" target="dialog" max="true" dialogId="upadteMsSettlementMDialog" href="${ctx}/msSettlementM/preUpdate?id={slt_uid}">编辑</a>
   		<%--<a class="edit" onclick="updateToMsSettlementM()">编辑</a>--%>
	</shiro:hasPermission>
   	<shiro:hasPermission name="MsSettlementM:delete">
   		<%--<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/msSettlementM/delete/{slt_uid}">批量删除</a>--%>
		<a class="deleteList" onclick="deleteMsSettlementM()">批量删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th><input type="checkbox" lay-skin="primary" class="checkALLMsSettlementM" lay-filter="checkALLMsSettlementM"></th>
				<th>序号</th>
				<th>销售结算单号</th>
				<%--<th>销售订单编号</th>--%>
				<th>供应商</th>
				<th>结算金额</th>
				<th>开票金额</th>
				<th>开票日期</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="msSettlementM" varStatus="status">
				<tr target="slt_uid" rel="${msSettlementM.id}" id="${msSettlementM.id}">
					<td><input type="checkbox" name="Check_MsSettlementM" data-value="${msSettlementM.id}" lay-skin="primary" lay-filter="checkALLMsSettlementM"></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${msSettlementM.strSettleNumber}</td>
					<%--<td>${msSettlementM.strOrderNo}</td>--%>
					<td>${msSettlementM.strVendorName}</td>
					<td>${msSettlementM.bdSettleAmtZH}</td>
					<td>${msSettlementM.bdInvoiceSumAmtZH}</td>
					<td>${msSettlementM.strSettleDate}</td>
					<td>${msSettlementM.strStusZH}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
</div>