<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 超级管理员 admin
	 @date 2019-05-27 10:13:33
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<head>
<script type="text/javascript">
</script>
</head>
<form class="layui-form" method="post" action="${ctx}/miInventory/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${miInventory.id}">
		<div class="layui-form-item">
			<label class="layui-form-label">修改人工号:</label>
			<div class="layui-input-block">
				<input type="text" name="updateUserNo" class="layui-input" placeHolder="请输入修改人工号" value="${miInventory.updateUserNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">批次号:</label>
			<div class="layui-input-block">
				<input type="text" name="strPoNo" class="layui-input" placeHolder="请输入批次号" value="${miInventory.strPoNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">储位:</label>
			<div class="layui-input-block">
				<input type="text" name="strAreaId" class="layui-input" placeHolder="请输入储位" value="${miInventory.strAreaId}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">存货编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlNo" class="layui-input" placeHolder="请输入存货编号" value="${miInventory.strMatrlNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlName" class="layui-input" placeHolder="请输入品名" value="${miInventory.strMatrlName}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌:</label>
			<div class="layui-input-block">
				<input type="text" name="strBrand" class="layui-input" placeHolder="请输入品牌" value="${miInventory.strBrand}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购单价:</label>
			<div class="layui-input-block">
				<input type="text" name="bdBuyPrice" class="layui-input" placeHolder="请输入采购单价" value="${miInventory.bdBuyPrice}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdQty" class="layui-input" placeHolder="请输入数量" value="${miInventory.bdQty}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">总金额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdAmt" class="layui-input" placeHolder="请输入总金额" value="${miInventory.bdAmt}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务类型:</label>
			<div class="layui-input-block">
				<input type="text" name="viewtype" class="layui-input" placeHolder="请输入业务类型" value="${miInventory.viewtype}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务ID:</label>
			<div class="layui-input-block">
				<input type="text" name="viewid" class="layui-input" placeHolder="请输入业务ID" value="${miInventory.viewid}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务单号:</label>
			<div class="layui-input-block">
				<input type="text" name="viewnum" class="layui-input" placeHolder="请输入业务单号" value="${miInventory.viewnum}" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
