<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/role/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
 		<div class="layui-form-item">
	    	<label class="layui-form-label">角色名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" placeholder="请输入角色名称" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>