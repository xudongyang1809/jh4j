<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 超级管理员 admin
	 @date 2019-05-16 10:47:21
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<form class="layui-form" method="post" action="${ctx}/miCheckD/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
			<label class="layui-form-label">修改人工号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="updateUserNo" placeHolder="请输入修改人工号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">公司别:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="companyIdva" placeHolder="请输入公司别" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">存货编号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strMatrlNo" placeHolder="请输入存货编号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strMatrlName" placeHolder="请输入品名" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">计量单位(库存单位):</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strUnit" placeHolder="请输入计量单位(库存单位)" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">费用属性:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strCostAttribute" placeHolder="请输入费用属性" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存数量:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdStockNum" placeHolder="请输入库存数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">实盘数量:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdCheckNum" placeHolder="请输入实盘数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">盘盈数量:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdInventoryLossNum" placeHolder="请输入盘盈数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">盘盈余额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdInventoryLossMoney" placeHolder="请输入盘盈余额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">strA:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strA" placeHolder="请输入strA" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">strB:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strB" placeHolder="请输入strB" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
