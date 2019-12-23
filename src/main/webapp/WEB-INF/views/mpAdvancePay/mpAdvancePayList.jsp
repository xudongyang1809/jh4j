<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 王梦奇 022347
	 @date 2019-05-28 08:49:47
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script>

	laydate.render({
		elem:'#strBillDateAdvance',
		type:'month',
		format:'yyyy-MM',
		showBottom:false,
		ready:function(date){
			$("#layui-laydate3").off('click').on('click','.laydate-month-list li',function(){
				$("#layui-laydate3").remove();
			});
		},
		change:function(value,dates,edate){
			$('#strBillDateAdvance').val(value);
			$(".layui-laydate").hide();
		}
	});





	form.on('checkbox(checkboxMpAdvance)', function(data) {
		if ($(data.elem).hasClass("checkAllMpAdvance")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});



	function deleteMpAdvance() {
		debugger;
		var ids = "";
		$('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function () {
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
			Dialog.warn("未选中一条以上的入口程序");
			return;
		}
		layer.confirm("确定删除吗?", {
					btn: ['确定','取消'] //按钮
				},
				function()
				{
					$.post("${ctx}/mpAdvancePay/delete",{ids:ids}, function(msg) {
						try {
							var result = JSON.parse(msg);
							var messages=result.message;
							Ajax.ajaxDone(result);
							if (result.statusCode == 200) {
								NavTab.reloadWithPagination(result.navTabId);
								Dialog.success(messages);
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

<form id="pagerForm" method="post" action="${ctx}/mpAdvancePay/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strPayNo" value="${mpPayM.strPayNo}" />
	<input type="hidden" name="strBillDate" value="${mpPayM.strBillDate}" />
	<input type="hidden" name="strVendorNo" value="${mpPayM.strVendorNo}" />
	<input type="hidden" name="strPayStus" value="${mpPayM.strPayStus}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/mpAdvancePay/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">报账单号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strPayNo"  class="layui-input" value="${mpPayM.strPayNo}"   autocomplete="off"  placeholder="报账单号" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">报支日期</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strBillDate" id="strBillDateAdvance"   class="layui-input" value="${mpPayM.strBillDate}"  autocomplete="off"  placeholder="报支日期"  />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">供应商编号</label>
				<div class="layui-input-block">
					<input type="hidden"  id="strVendorNoMpPayAdvance" name="strVendorNo"  value="${mpPayM.strVendorNo}" class="layui-input"  />
					<input type="text"  id="strVendorNoNameMpPayAdvance"  name="strVendorName" class="layui-input" value="${strVendorName}"  value=""  autocomplete="off"  placeholder="请挑选供应商" />
					<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
					<a class="layui-btn layui-btn-sm select-btn"
					   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpPayAdvance&strVendorNoName=strVendorNoNameMpPayAdvance"
					   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"
					   rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">报支状态</label>
			  	<div class="layui-input-inline">
					<select name="strPayStus" >
						<option value="" >请选择</option>
						<option value="N" ${mpPayM.strPayStus eq 'N'?'se;ected':''} >新增</option>
						<option value="S" ${mpPayM.strPayStus eq 'S'?'selected':''}>已报账</option>
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
	<shiro:hasPermission name="MpPayM:create">
   		<a class="add" max="true" target="dialog" dialogId="createMpPayMDialog" href="${ctx}/mpAdvancePay/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MpPayM:edit">
   		<a class="edit" max="true" target="dialog" dialogId="upadteMpPayMDialog" href="${ctx}/mpAdvancePay/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MpPayM:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/mpAdvancePay/delete?ids={slt_uid}">删除</a>
		<a class="deleteList" onclick="deleteMpAdvance()">批量删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table" style="width: 150%;">
		<thead>
			<tr>
				<th style="width: 10px;">
					<input type="checkbox" lay-skin="primary" class="checkAllMpAdvance" lay-filter="checkboxMpAdvance" />
				</th>
				<th>序号</th>
				<th>报账单号</th>
				<th>报支单号</th>
				<th>报支日期</th>
				<th>厂商编号</th>
				<th>报支人</th>
				<th>报账申请人</th>
				<th>报支种类</th>
				<th>付款方式</th>
				<th>报支状态</th>
				<th>备注</th>
				<th>收支项目代码</th>
				<th>税前金额合计</th>
				<th>税额合计</th>
				<th>税后总额</th>
				<th>总冲销总额</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mpPayM" varStatus="status">
				<tr target="slt_uid" rel="${mpPayM.id}" id="${mpPayM.id}">
					<td><input type="checkbox" lay-skin="primary" lay-filter="checkboxMpAdvance" /></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPayM.strPayNo}</td>
					<td>${mpPayM.strBillNo}</td>
					<td>${mpPayM.strBillDate}</td>
					<td>${mpPayM.strVendorNo}</td>
					<td>${mpPayM.strBillEmplName}</td>
					<td>${mpPayM.strEmplName}</td>
					<td>
						<c:if test="${mpPayM.strBillType eq 'OA'}">预付款</c:if>
						<c:if test="${mpPayM.strBillType eq 'OB'}">现货现款</c:if>
					</td>
					<td>
						<c:if test="${mpPayM.strPayType eq '01'}">一般电汇</c:if>
						<c:if test="${mpPayM.strPayType eq '02'}">自行领取票据</c:if>
						<c:if test="${mpPayM.strPayType eq '03'}">现金付款</c:if>
						<c:if test="${mpPayM.strPayType eq '04'}">承兑汇票</c:if>
					</td>
					<td>
						<c:if test="${mpPayM.strPayStus eq 'N'}">新增</c:if>
						<c:if test="${mpPayM.strPayStus eq 'S'}">已报账</c:if>
						<c:if test="${mpPayM.strPayStus eq 'D'}">删除</c:if>
					</td>
					<td>${mpPayM.strMemo}</td>
					<td>${mpPayM.strPlanCode}</td>
					<td>${mpPayM.bdTotalAmt}</td>
					<td>${mpPayM.bdTotalTaxAmt}</td>
					<td>${mpPayM.bdTotalAfterAmt}</td>
					<td>${mpPayM.bdTotalWriteOffAmt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
