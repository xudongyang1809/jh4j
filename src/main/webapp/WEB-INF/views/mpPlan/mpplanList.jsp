<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 王梦奇 022347
	 @date 2019-04-28 15:49:50
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script>
	// 人员回调
	function selectSingleUserCallback(userId, userNo, username) {
		$('#userIdstrBuyerId').val(userId);
		$('#usernamestrBuyerName').val(username);
	}

	form.on('checkbox(checkboxMpplan)', function(data) {
		if ($(data.elem).hasClass("checkAllMpplan")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
	function makestrVendorNo() {
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

		var strVendor = $("#strVendorNoMpplan").val();
		var strVendorName = $("#strVendorNameMpplan").val();
		if(strVendor == ""){
			Dialog.warn("选中的未指定供应商！");
			return;
		} else{
			strVendor =$("#strVendorNoMpplan").val();
		}
		layer.confirm("确定指定吗?", {
					btn: ['确定','取消'] //按钮
				},
				function()
				{
					$.post("${ctx}/mpPlan/makeVendorNo",{ids:ids ,strVendorNo:strVendor,strVendorName:strVendorName }, function(msg) {
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

	function effectVendorNo() {
		debugger;
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
			Dialog.warn("未选中一条以上的入口程序");
			return;
		}
		layer.confirm("确定生效?", {
					btn: ['确定','取消'] //按钮
				},
				function()
				{
					$.post("${ctx}/mpPlan/effect?ids="+ids, function(msg) {
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


	//取消生效
	function uneffectVendorNo() {

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
			Dialog.warn("未选中一条以上的入口程序");
			return;
		}
		layer.confirm("确定生效?", function() {
			$.post("${ctx}/mpPlan/uneffect?ids="+ids, function(msg) {
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
		});
	}
</script>


<form id="pagerForm" method="post" action="${ctx}/mpPlan/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strPlanNo" value="${mpPlan.strPlanNo}" />
	<input type="hidden" name="strBuyerId" value="${mpPlan.strBuyerId}" />
	<input type="hidden" name="strApplyNo" value="${mpPlan.strApplyNo}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/mpPlan/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">采购计划单号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strPlanNo" class="layui-input" placeholder="请输入采购计划单号" value="${mpPlan.strPlanNo}"   autocomplete="off"   style="width: 150px;"/>
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">采购员</label>
				<div class="layui-input-inline">
					<input type="hidden" id="userIdstrBuyerId" name="strBuyerId" value="${mpPlan.strBuyerId}" />
					<input type="text"	 id="usernamestrBuyerName" placeholder="点击挑选人员"  readonly class="layui-input" style="padding-right: 50px; width: 150px"   />
					<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
					<a class="layui-btn layui-btn-sm"   onPickUser="selectSingleUserCallback" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">需求计划编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strApplyNo" class="layui-input" value="${mpPlan.strApplyNo}"  autocomplete="off"  placeholder="请输入需求计划编号" style="width: 150px;" />
			  	</div>
			</div>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>


<div class="tab-header">
	<form method="post" action="${ctx}/mpPlan/deliver" onsubmit="return navTabSearch(this)" id="mpPlanDetailAction">
			<div class="layui-col-xs3">
			<label class="layui-form-label">供应商编号:</label>
			<div class="layui-input-block">
				<input type="hidden" lay-verify="required" id="strVendorNoMpplan" name="strVendorNo"  value="${mpArrivalM.strVendorNo}" class="layui-input"  />
				<input type="hidden" lay-verify="required" id="strVendorNameMpplan" value="${mpArrivalM.strVendorName}" class="layui-input"  />
				<input type="text" lay-verify="required" id="strVendorNoNameMpplan"   class="layui-input"  value="${mpArrivalM.strVendorNoName}"  autocomplete="off" placeholder="请挑选供应商" />
				<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
				<a class="layui-btn layui-btn-sm select-btn"
				   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
				   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"
				   rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
			</div>
		</div>
	</form>

</div>


<div class="tab-bars">
   	<shiro:hasPermission name="MpPlan:edit">
   		<a class="edit" width="500" height="500" max="true" target="dialog" dialogId="upadteMpPlanDialog" href="${ctx}/mpPlan/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   		<a class="delivery" onclick="makestrVendorNo()">批量指定供应商</a>
		<a class="confirm" onclick="effectVendorNo()">生效</a>
		<a class="confirm" onclick="uneffectVendorNo()">取消生效</a>
</div>

<div class="tab-content layui-form">
	<table class="frog-table"  style="width: 200%; max-width: 200%"  >
		<thead>
			<tr>
				<td style="width: 10px;">
					<input type="checkbox" lay-skin="primary" class="checkAllMpplan" lay-filter="checkboxMpplan" />
				</td>
				<th>序号</th>
				<th>采购计划单号</th>
				<th>期望交货日期</th>
				<th>采购日期</th>
				<th>采购员</th>
				<th>采购部门</th>
				<th>状态</th>
				<th>供应商编号</th>
				<th>供应商名称</th>
				<th>需求计划编号</th>
				<th>需求计划明细号</th>
				<th>存货编码</th>
				<th>料号名称</th>
				<th>期望交货日期</th>
				<th>需求申报人员</th>
				<th>需求申报人部门</th>
				<th>销售订单编号</th>
				<th>销售订单项次</th>
				<th>建议采购单价</th>
				<th>采购计划量</th>
				<th>剩余采购量</th>
				<th>采购要求</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mpPlan" varStatus="status">
				<tr target="slt_uid" rel="${mpPlan.id}" id="${mpPlan.id}"
					pageCont="${page.pageBeginCount + status.index + 1}" strStatusId ="${mpPlan.strStatusId}" >
					<td><input type="checkbox" lay-skin="primary" lay-filter="checkboxMpplan" /></td>
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPlan.strPlanNo}</td>
					<td>${mpPlan.strPlanUseDate}</td>
					<td>${mpPlan.strPlanDate}</td>
					<td>${mpPlan.strBuyerName}</td>
					<td>${mpPlan.strBuyerDeptId}</td>
					<td>
						<c:if test="${mpPlan.strStatusId eq 'N'}">新增</c:if>
						<c:if test="${mpPlan.strStatusId eq 'S'}">生效</c:if>
						<c:if test="${mpPlan.strStatusId eq 'D'}">删除</c:if>
					</td>
					<td>${mpPlan.strVendorNo}</td>
					<td>${mpPlan.strVendorName}</td>
					<td>${mpPlan.strApplyNo}</td>
					<td>${mpPlan.strApplyItem}</td>
					<td>${mpPlan.strMatrlNo}</td>
					<td>${mpPlan.strMatrlName}</td>
					<td>${mpPlan.strPlanUseDate}</td>
					<td>${mpPlan.strReqEmpName}</td>
					<td>${mpPlan.strReqDept}</td>
					<td>${mpPlan.strOrderNo}</td>
					<td>${mpPlan.strOrderItem}</td>
					<td>${mpPlan.bdPlanPrice}</td>
					<td>${mpPlan.bdQty}</td>
					<td>${mpPlan.bdPurchasesQty}</td>
					<td>${mpPlan.strRemark}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>



