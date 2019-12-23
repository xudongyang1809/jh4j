<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<head>
<script type="text/javascript">
</script>
	<style>
		.layui-form-label{
			width:110px;
			padding: 12px 0px 2px 0px;
			text-align: center
		}
		.layui-input-block{
			margin-right:25px;
			width: 170px;
		}
	</style>


</head>
<form class="layui-form" method="post" action="${ctx}/mpPlan/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${mpPlan.id}">
		<div class="layui-form-item">
			<div class="layui-col-xs3">
				<label class="layui-form-label">采购计划单号:</label>
				<div class="layui-input-block">
					<input type="text" name="strPlanNo" class="layui-input" placeHolder="请输入采购计划单号" readonly="readonly" value="${mpPlan.strPlanNo}" />
				</div>
			</div>

			<div class="layui-col-xs3">
				<label class="layui-form-label">采购员:</label>
				<div class="layui-input-block">
					<input type="hidden" name="strBuyerId" class="layui-input" placeHolder="请输入采购员" readonly="readonly" value="${mpPlan.strBuyerId}" />
					<input type="text"  class="layui-input" placeHolder="请输入采购员" readonly="readonly" value="${mpPlan.strBuyerName}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">采购部门:</label>
				<div class="layui-input-block">
					<input type="text" name="strBuyerDeptId" class="layui-input" placeHolder="请输入采购部门" readonly="readonly" value="${mpPlan.strBuyerDeptId}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">采购计划量:</label>
				<div class="layui-input-block">
					<input type="text" name="bdQty" class="layui-input" placeHolder="请输入采购计划量"   readonly="readonly"  value="${mpPlan.bdQty}" />
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-col-xs3">
				<label class="layui-form-label">销售订单编号:</label>
				<div class="layui-input-block">
					<input type="text" name="strOrderNo" class="layui-input" placeHolder="请输入销售订单编号" readonly="readonly\" value="${mpPlan.strOrderNo}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">销售订单项次:</label>
				<div class="layui-input-block">
					<input type="text" name="strOrderItem" class="layui-input" placeHolder="请输入销售订单项次" readonly="readonly" value="${mpPlan.strOrderItem}" />
				</div>
			</div>

			<div class="layui-col-xs3">
				<label class="layui-form-label">存货编码:</label>
				<div class="layui-input-block">
					<input type="text" name="strMatrlNo" class="layui-input" placeHolder="请输入存货编码" readonly="readonly" value="${mpPlan.strMatrlNo}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">料号名称:</label>
				<div class="layui-input-block">
					<input type="text" name="strMatrlName" class="layui-input" placeHolder="请输入料号名称" readonly="readonly" value="${mpPlan.strMatrlName}" />
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-col-xs3">
				<label class="layui-form-label">需求计划编号:</label>
				<div class="layui-input-block">
					<input type="text" name="strApplyNo" class="layui-input" placeHolder="请输入需求计划编号" readonly="readonly" value="${mpPlan.strApplyNo}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">需求计划明细号:</label>
				<div class="layui-input-block">
					<input type="text" name="strApplyItem" class="layui-input" placeHolder="请输入需求计划明细号" readonly="readonly" value="${mpPlan.strApplyItem}" />
				</div>
			</div>

			<div class="layui-col-xs3">
				<label class="layui-form-label">需求申报人员:</label>
				<div class="layui-input-block">
					<input type="hidden" name="strReqEmpNo" class="layui-input" placeHolder="请输入需求申报人员id" value="${mpPlan.strReqEmpNo}" />
					<input type="text"  class="layui-input"  readonly="readonly" value="${mpPlan.strReqEmpName}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">需求申报人部门:</label>
				<div class="layui-input-block">
					<input type="hidden" name="strReqDept" class="layui-input" placeHolder="请输入需求申报人部门" value="${mpPlan.strReqDept}" />
					<input type="text" class="layui-input" readonly="readonly" placeHolder="请输入需求申报人部门" value="${mpPlan.strReqDept}" />
				</div>
			</div>

		</div>
		<div class="layui-form-item">
			<div class="layui-col-xs3">
				<label class="layui-form-label">供应商编号:</label>
				<div class="layui-input-block">
					<input type="text" lay-verify="required" id="strVendorNoMpPlan" name="strVendorNo"   autocomplete="off" value="${mpPlan.strVendorNo}" class="layui-input"  placeholder="请挑选供应商编号" />
					<a class="layui-btn layui-btn-sm select-btn" href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpPlan&strVendorName1=strVendorMpPlan" lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"    rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">供应商名称:</label>
				<div class="layui-input-block">
					<input type="text" lay-verify="required" name="strVendorName" id="strVendorMpPlan"  class="layui-input"  autocomplete="off" value="${mpPlan.strVendorName}"  />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">期望交货日期:</label>
				<div class="layui-input-block">
					<input type="text" name="strPlanUseDate" class="layui-input"  lay-verify="required" id="strPlanUseDate" placeHolder="请输入期望交货日期" autocomplete="off" value="${mpPlan.strPlanUseDate}" />
				</div>
			</div>
			<div class="layui-col-xs3">
				<label class="layui-form-label">采购日期:</label>
				<div class="layui-input-block">
					<input type="text" name="strPlanDate" class="layui-input" id="strPlanDate" placeHolder="请输入采购日期" autocomplete="off" value="${mpPlan.strPlanDate}" />
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-col-xs3">
				<label class="layui-form-label">状态:</label>
				<input type="hidden" name="strStatusId" class="layui-input" placeHolder="请输入状态" value="${mpPlan.strStatusId}" />
					<div class="layui-input-block">
						<input type="text" name="strStusS"  id="" style="width: 160px" class="layui-input" placeHolder="请输入状态" autocomplete="off"
							   value="${mpPlan.strStatusId eq 'N' ?'新增':(mpPlan.strStatusId eq 'S'  ? '生效' : (mpPlan.strStatusId eq 'D'?'删除' :'' ))}" />
					</div>
				</div>
			<div class="layui-col-xs9">
				<label class="layui-form-label">采购要求:</label>
				<div class="layui-input-block">
					<input type="text" name="strRemark" class="layui-input" placeHolder="请输入采购要求" autocomplete="off" lay-verify="required" value="${mpPlan.strRemark}" />
				</div>
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
<script>


	laydate.render({
		elem:"#strPlanUseDate"
	})

	laydate.render({
		elem:"#strPlanDate"
	})


</script>