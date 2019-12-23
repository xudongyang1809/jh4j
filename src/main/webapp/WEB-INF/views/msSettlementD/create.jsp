<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 毛敏 022325
	 @date 2019-05-29 13:54:19
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<form class="layui-form" method="post" action="${ctx}/msSettlementD/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
			<label class="layui-form-label">销售结算单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strSettleNumber" placeHolder="请输入销售结算单号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售订单编号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strOrderNo" placeHolder="请输入销售订单编号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售订单项次:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strOrderItem" placeHolder="请输入销售订单项次" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销账单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strSaleNo" placeHolder="请输入销账单号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">需求计划编号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strApplyNo" placeHolder="请输入需求计划编号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">需求计划项次号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strApplyItem" placeHolder="请输入需求计划项次号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售存货编号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strMatrlNo" placeHolder="请输入销售存货编号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存单位:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strMatrlName" placeHolder="请输入库存单位" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strBrand" placeHolder="请输入品名" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strUnit" placeHolder="请输入品牌" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">型号规格:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strSpec" placeHolder="请输入型号规格" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购单价:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdPurchasePrice" placeHolder="请输入采购单价" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购数量:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdPurchaseCount" placeHolder="请输入采购数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售单价:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdSalePrice" placeHolder="请输入销售单价" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售数量:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdSaleCount" placeHolder="请输入销售数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">税率:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdTaxRate" placeHolder="请输入税率" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">含税金额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdAmt" placeHolder="请输入含税金额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">含税总金额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdTotaAmt" placeHolder="请输入含税总金额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">不含税金额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdExcludSumAmt" placeHolder="请输入不含税金额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">不含税总金额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdExcludAmt" placeHolder="请输入不含税总金额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">税额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdTaxAmt" placeHolder="请输入税额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">strStus:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strStus" placeHolder="请输入strStus" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strRemark" placeHolder="请输入备注" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
