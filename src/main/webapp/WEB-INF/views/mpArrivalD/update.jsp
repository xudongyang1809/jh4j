<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
	@desc 编辑画面
	@author 王梦奇 022347
	@date 2019-05-08 18:55:29
	@Copyright: 江苏金恒信息科技股份有限公司
-->
<head>
<script type="text/javascript">
</script>
</head>
<form class="layui-form" method="post" action="${ctx}/mpArrivalD/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${mpArrivalD.id}">
		<div class="layui-form-item">
			<label class="layui-form-label">主档Id:</label>
			<div class="layui-input-block">
				<input type="text" name="ihId" class="layui-input" placeHolder="请输入主档Id" value="${mpArrivalD.ihId}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购合同号:</label>
			<div class="layui-input-block">
				<input type="text" name="strPoNo" class="layui-input" placeHolder="请输入采购合同号" value="${mpArrivalD.strPoNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">到货项次号:</label>
			<div class="layui-input-block">
				<input type="text" name="strPoItemNo" class="layui-input" placeHolder="请输入到货项次号" value="${mpArrivalD.strPoItemNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">到货时间:</label>
			<div class="layui-input-block">
				<input type="text" name="strApplyDateTime" class="layui-input" placeHolder="请输入到货时间" value="${mpArrivalD.strApplyDateTime}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">存货编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlNo" class="layui-input" placeHolder="请输入存货编号" value="${mpArrivalD.strMatrlNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlName" class="layui-input" placeHolder="请输入品名" value="${mpArrivalD.strMatrlName}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌:</label>
			<div class="layui-input-block">
				<input type="text" name="strBrand" class="layui-input" placeHolder="请输入品牌" value="${mpArrivalD.strBrand}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">规格型号:</label>
			<div class="layui-input-block">
				<input type="text" name="strSpecMark" class="layui-input" placeHolder="请输入规格型号" value="${mpArrivalD.strSpecMark}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购单价:</label>
			<div class="layui-input-block">
				<input type="text" name="bdRealPrice" class="layui-input" placeHolder="请输入采购单价" value="${mpArrivalD.bdRealPrice}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdQty" class="layui-input" placeHolder="请输入采购数量" value="${mpArrivalD.bdQty}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购合同中数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdPoNoQty" class="layui-input" placeHolder="请输入采购合同中数量" value="${mpArrivalD.bdPoNoQty}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">到货数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdAmt" class="layui-input" placeHolder="请输入bdAmt" value="${mpArrivalD.bdAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购承办人:</label>
			<div class="layui-input-block">
				<input type="text" name="strRespEmpNo" class="layui-input" placeHolder="请输入采购承办人" value="${mpArrivalD.strRespEmpNo}" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
