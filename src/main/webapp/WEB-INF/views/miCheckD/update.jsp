<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 超级管理员 admin
	 @date 2019-05-16 10:47:21
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<head>
<script type="text/javascript">
</script>
</head>
<form class="layui-form" method="post" action="${ctx}/miCheckD/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${miCheckD.id}">
		<div class="layui-form-item">
			<label class="layui-form-label">修改人工号:</label>
			<div class="layui-input-block">
				<input type="text" name="updateUserNo" class="layui-input" placeHolder="请输入修改人工号" value="${miCheckD.updateUserNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">公司别:</label>
			<div class="layui-input-block">
				<input type="text" name="companyIdva" class="layui-input" placeHolder="请输入公司别" value="${miCheckD.companyIdva}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">存货编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlNo" class="layui-input" placeHolder="请输入存货编号" value="${miCheckD.strMatrlNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlName" class="layui-input" placeHolder="请输入品名" value="${miCheckD.strMatrlName}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">计量单位(库存单位):</label>
			<div class="layui-input-block">
				<input type="text" name="strUnit" class="layui-input" placeHolder="请输入计量单位(库存单位)" value="${miCheckD.strUnit}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">费用属性:</label>
			<div class="layui-input-block">
				<input type="text" name="strCostAttribute" class="layui-input" placeHolder="请输入费用属性" value="${miCheckD.strCostAttribute}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdStockNum" class="layui-input" placeHolder="请输入库存数量" value="${miCheckD.bdStockNum}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">实盘数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdCheckNum" class="layui-input" placeHolder="请输入实盘数量" value="${miCheckD.bdCheckNum}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">盘盈数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdInventoryLossNum" class="layui-input" placeHolder="请输入盘盈数量" value="${miCheckD.bdInventoryLossNum}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">盘盈余额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdInventoryLossMoney" class="layui-input" placeHolder="请输入盘盈余额" value="${miCheckD.bdInventoryLossMoney}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">strA:</label>
			<div class="layui-input-block">
				<input type="text" name="strA" class="layui-input" placeHolder="请输入strA" value="${miCheckD.strA}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">strB:</label>
			<div class="layui-input-block">
				<input type="text" name="strB" class="layui-input" placeHolder="请输入strB" value="${miCheckD.strB}" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
