<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="form" method="post" action="${ctx}/dict/create" class="layui-form" onAfterSubmit="refreshDictionaryTree" onsubmit="return dialogAjaxDone(this, 'create', '#dictionary-list-view')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" name="id" value="${id}"/>
		<div class="layui-form-item">
			<label class="layui-form-label">词典编码:</label>
			<div class="layui-input-block">
				<input type="text" name="strSn" class="layui-input" lay-verify="required"  placeholder="请输入词典编码,如:strKind" maxlength="30"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">词典名称:</label>
			<div class="layui-input-block">
				<input type="text" name="strName" class="layui-input" lay-verify="required" placeholder="请输入词典名称"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">词典描述:</label>
			<div class="layui-input-block">
				<textarea style="height: 100px" name="strDesc" class="layui-textarea" placeholder="请输入词典描述"></textarea>
			</div>
		</div>
	</div>
	<div class="dialogFooter">
		<button type="submit" class="layui-btn">提交</button>
	</div>
</form>