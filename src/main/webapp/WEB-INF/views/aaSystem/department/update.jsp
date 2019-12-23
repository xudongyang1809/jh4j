<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/department/update" onsubmit="return dialogAjaxDone(this, 'update', '#department-list-view')">
	<input type="hidden" name="id" value="${department.id}" />
	<div class="dialogContent" style="right: 60px;">
 		<div class="layui-form-item">
	    	<label class="layui-form-label">部门编码</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strSn" lay-verify="required" value="${department.strSn}" placeholder="请输入程序编码" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">部门名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" value="${department.strName}" placeholder="请输入程序名称" autocomplete="off" class="layui-input">
		    </div>
		</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">程序描述</label>
	    	<div class="layui-input-block">
	      		<textarea name="strDesc" placeholder="请输入程序描述" class="layui-textarea">${department.strDesc}</textarea>
	    	</div>
	  	</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
