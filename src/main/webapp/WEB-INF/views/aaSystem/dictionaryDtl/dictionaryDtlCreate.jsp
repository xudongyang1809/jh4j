<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="form" method="post" action="${ctx}/dictdtl/create" class="layui-form" onsubmit="return dialogAjaxDone(this, 'create', '#dictionary-list-view')">
	<div class="dialogContent" style="padding-right: 20px;">
		<input type="hidden" name="dict.id" value="${dict.id}" />
		<div class="layui-form-item">
			<label class="layui-form-label">词典分类:</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" readonly value="${dict.strName}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">词典编码:</label>
			<div class="layui-input-block">
				<input type="text" name="strSn" class="layui-input" lay-verify="required" placeholder="请输入词典编码"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">词典值:</label>
			<div class="layui-input-block">
				<input type="text" name="strValue" class="layui-input" lay-verify="required" placeholder="请输入词典的值"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">词典描述:</label>
			<div class="layui-input-block">
				<textarea name="strDesc" class="layui-textarea" placeholder="请输入词典描述" style="height: 100px"></textarea>
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>