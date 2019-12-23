<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 超级管理员 admin
	 @date 2019-05-27 10:14:46
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<head>
<script type="text/javascript">
</script>
</head>
<form class="layui-form" method="post" action="${ctx}/miInventoryTrade/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${miInventoryTrade.id}">
		<div class="layui-form-item">
			<label class="layui-form-label">修改人工号:</label>
			<div class="layui-input-block">
				<input type="text" name="updateUserNo" class="layui-input" placeHolder="请输入修改人工号" value="${miInventoryTrade.updateUserNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strTradeNo" class="layui-input" placeHolder="请输入交易单号" value="${miInventoryTrade.strTradeNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易明细:</label>
			<div class="layui-input-block">
				<input type="text" name="strTradeItem" class="layui-input" placeHolder="请输入交易明细" value="${miInventoryTrade.strTradeItem}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">财务单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strAcctNo" class="layui-input" placeHolder="请输入财务单号" value="${miInventoryTrade.strAcctNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">财务交易日期:</label>
			<div class="layui-input-block">
				<input type="text" name="strAcctDate" class="layui-input" placeHolder="请输入财务交易日期" value="${miInventoryTrade.strAcctDate}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">数据类别:</label>
			<div class="layui-input-block">
				<input type="text" name="strActionStyle" class="layui-input" placeHolder="请输入数据类别" value="${miInventoryTrade.strActionStyle}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">批次号:</label>
			<div class="layui-input-block">
				<input type="text" name="strBatchNo" class="layui-input" placeHolder="请输入批次号" value="${miInventoryTrade.strBatchNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易明细单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strIssueItem" class="layui-input" placeHolder="请输入交易明细单号" value="${miInventoryTrade.strIssueItem}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMemoNo" class="layui-input" placeHolder="请输入备注单号" value="${miInventoryTrade.strMemoNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注明细单号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMemoItem" class="layui-input" placeHolder="请输入备注明细单号" value="${miInventoryTrade.strMemoItem}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">储位:</label>
			<div class="layui-input-block">
				<input type="text" name="strAreaId" class="layui-input" placeHolder="请输入储位" value="${miInventoryTrade.strAreaId}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">存货编号:</label>
			<div class="layui-input-block">
				<input type="text" name="strMatrlNo" class="layui-input" placeHolder="请输入存货编号" value="${miInventoryTrade.strMatrlNo}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">数量:</label>
			<div class="layui-input-block">
				<input type="text" name="bdQty" class="layui-input" placeHolder="请输入数量" value="${miInventoryTrade.bdQty}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">总金额:</label>
			<div class="layui-input-block">
				<input type="text" name="bdAmt" class="layui-input" placeHolder="请输入总金额" value="${miInventoryTrade.bdAmt}" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
