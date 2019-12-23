<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 超级管理员 admin
	 @date 2019-05-27 10:14:46
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<form class="layui-form" method="post" action="${ctx}/miInventoryTrade/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
			<label class="layui-form-label">修改人工号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="updateUserNo" placeHolder="请输入修改人工号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strTradeNo" placeHolder="请输入交易单号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易明细:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strTradeItem" placeHolder="请输入交易明细" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">财务单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strAcctNo" placeHolder="请输入财务单号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">财务交易日期:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strAcctDate" placeHolder="请输入财务交易日期" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">数据类别:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strActionStyle" placeHolder="请输入数据类别" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">批次号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strBatchNo" placeHolder="请输入批次号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易明细单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strIssueItem" placeHolder="请输入交易明细单号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strMemoNo" placeHolder="请输入备注单号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注明细单号:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" name="strMemoItem" placeHolder="请输入备注明细单号" />
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
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
