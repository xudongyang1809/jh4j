<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="form" method="post" action="${ctx}/dictdtl/update" class="layui-form" onsubmit="return dialogAjaxDone(this, 'update', '#dictionary-list-view')">
	<input type="hidden" name="id" value="${dictDtl.id}" /> 
	<div class="dialogContent">
		<div class="layui-form-item">
    		<label class="layui-form-label" style="width: 110px">词典类型:</label>
    		<div class="layui-input-inline" style="width: 300px">
    		   	<input id="dictionaryId" type="hidden" name="dict.id" value="${dictDtl.dict.id}"/>
				<input id="dictionaryName" name="dictionaryName" class="layui-input" type="text" value="${dictDtl.dict.strName}" readonly="readonly" style="padding-right: 50px;" placeHolder="请点选中词典类型..." />
    		</div>
    	</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 110px">词典编码:</label>
			<div class="layui-input-inline" style="width: 300px">
				<input type="text" name="strSn"  class="layui-input" value="${dictDtl.strSn}" lay-verify="required" placeholder="请输入词典编码"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 110px">词典值:</label>
			<div class="layui-input-inline" style="width: 300px">
				<input type="text" name="strValue" class="layui-input" value="${dictDtl.strValue}" lay-verify="required" placeholder="请输入词典的值"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 110px">词典描述:</label>
			<div class="layui-input-inline" style="width: 300px">
				<textarea name="strDesc" class="layui-textarea" lay-verify="required" placeholder="请输入词典描述" style="height: 100px">${dictDtl.strDesc }</textarea>
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
