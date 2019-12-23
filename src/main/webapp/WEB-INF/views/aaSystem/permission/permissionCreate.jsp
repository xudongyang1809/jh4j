<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div style="padding: 15px;">
	<blockquote class="layui-elem-quote">提示：创建完动作之后，会自动给超级管理员附加权限</blockquote>
	<form class="layui-form" action="${ctx}/permission/create" onsubmit="return dialogAjaxDone(this, 'create', '#permission-list-view')">
		<input type="hidden" name="program.id" value="${moduleId}" />
 		<div class="layui-form-item">
	    	<label class="layui-form-label">动作名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" placeholder="请输入动作名称" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">动作描述</label>
	    	<div class="layui-input-block">
	      		<textarea name="strDesc" placeholder="请输入动作描述" class="layui-textarea"></textarea>
	    	</div>
	  	</div>
	  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
	</form>
</div>