<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 毛敏 022325
	 @date 2019-05-29 13:54:19
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<head>
<script type="text/javascript">
</script>
</head>
<form class="layui-form" method="post" action="${ctx}/msSettlementD/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${msSettlementD.id}">
		<div class="layui-form-item">
			<label class="layui-form-label">销售结算单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strSettleNumber" class="layui-input" placeHolder="请输入销售结算单号" value="${msSettlementD.strSettleNumber}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售订单编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strOrderNo" class="layui-input" placeHolder="请输入销售订单编号" value="${msSettlementD.strOrderNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售订单项次:</label>
			<div class="layui-input-block">
				<input type="text" name="strOrderItem" class="layui-input" placeHolder="请输入销售订单项次" value="${msSettlementD.strOrderItem}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销账单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strSaleNo" class="layui-input" placeHolder="请输入销账单号" value="${msSettlementD.strSaleNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">需求计划编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strApplyNo" class="layui-input" placeHolder="请输入需求计划编号" value="${msSettlementD.strApplyNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">需求计划项次号:</label>
			<div class="layui-input-block">
				<input type="text" name="strApplyItem" class="layui-input" placeHolder="请输入需求计划项次号" value="${msSettlementD.strApplyItem}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售存货编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlNo" class="layui-input" placeHolder="请输入销售存货编号" value="${msSettlementD.strMatrlNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存单位:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlName" class="layui-input" placeHolder="请输入库存单位" value="${msSettlementD.strMatrlName}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
			<div class="layui-input-block">
				<input type="text" name="strBrand" class="layui-input" placeHolder="请输入品名" value="${msSettlementD.strBrand}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌:</label>
			<div class="layui-input-block">
				<input type="text" name="strUnit" class="layui-input" placeHolder="请输入品牌" value="${msSettlementD.strUnit}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">型号规格:</label>
			<div class="layui-input-block">
				<input type="text" name="strSpec" class="layui-input" placeHolder="请输入型号规格" value="${msSettlementD.strSpec}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购单价:</label>
			<div class="layui-input-block">
				<input type="text" name="bdPurchasePrice" class="layui-input" placeHolder="请输入采购单价" value="${msSettlementD.bdPurchasePrice}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdPurchaseCount" class="layui-input" placeHolder="请输入采购数量" value="${msSettlementD.bdPurchaseCount}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售单价:</label>
			<div class="layui-input-block">
				<input type="text" name="bdSalePrice" class="layui-input" placeHolder="请输入销售单价" value="${msSettlementD.bdSalePrice}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdSaleCount" class="layui-input" placeHolder="请输入销售数量" value="${msSettlementD.bdSaleCount}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">税率:</label>
			<div class="layui-input-block">
				<input type="text" name="bdTaxRate" class="layui-input" placeHolder="请输入税率" value="${msSettlementD.bdTaxRate}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">含税金额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdAmt" class="layui-input" placeHolder="请输入含税金额" value="${msSettlementD.bdAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">含税总金额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdTotaAmt" class="layui-input" placeHolder="请输入含税总金额" value="${msSettlementD.bdTotaAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">不含税金额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdExcludSumAmt" class="layui-input" placeHolder="请输入不含税金额" value="${msSettlementD.bdExcludSumAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">不含税总金额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdExcludAmt" class="layui-input" placeHolder="请输入不含税总金额" value="${msSettlementD.bdExcludAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">税额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdTaxAmt" class="layui-input" placeHolder="请输入税额" value="${msSettlementD.bdTaxAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">strStus:</label>
			<div class="layui-input-block">
				<input type="text" name="strStus" class="layui-input" placeHolder="请输入strStus" value="${msSettlementD.strStus}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-block">
				<input type="text" name="strRemark" class="layui-input" placeHolder="请输入备注" value="${msSettlementD.strRemark}" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
