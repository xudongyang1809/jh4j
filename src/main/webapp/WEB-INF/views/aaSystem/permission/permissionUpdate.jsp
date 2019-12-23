<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/permission/update" onsubmit="return dialogAjaxDone(this, 'update', '#permission-list-view')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" name="id" value="${permission.id}" />
		<input type="hidden" name="program.id" value="${permission.program.id}" />
 		<div class="layui-form-item">
	    	<label class="layui-form-label">动作名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" value="${permission.strName}" lay-verify="required" placeholder="请输入动作名称" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">动作描述</label>
	    	<div class="layui-input-block">
	      		<textarea name="strDesc" placeholder="请输入动作描述" class="layui-textarea">${permission.strDesc}</textarea>
	    	</div>
	  	</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
 