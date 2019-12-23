<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 超级管理员 admin
	 @date 2019-05-27 10:13:33
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<form class="layui-form" method="post" action="${ctx}/miInventory/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
			<label class="layui-form-label">修改人工号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="updateUserNo" placeHolder="请输入修改人工号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">批次号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strPoNo" placeHolder="请输入批次号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">储位:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strAreaId" placeHolder="请输入储位" />
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
			<label class="layui-form-label">品牌:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strBrand" placeHolder="请输入品牌" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">采购单价:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdBuyPrice" placeHolder="请输入采购单价" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">数量:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdQty" placeHolder="请输入数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">总金额:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="bdAmt" placeHolder="请输入总金额" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务类型:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="viewtype" placeHolder="请输入业务类型" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务ID:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="viewid" placeHolder="请输入业务ID" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="viewnum" placeHolder="请输入业务单号" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
