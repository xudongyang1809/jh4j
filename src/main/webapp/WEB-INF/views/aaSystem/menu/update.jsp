<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/menu/update" onsubmit="return dialogAjaxDone(this, 'update', '#menu-list-view')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" name="id" value="${menu.id}"/>
		<input type="hidden" name="parent.id" value="${menu.parent.id}"/>
 		<div class="layui-form-item">
	    	<label class="layui-form-label">授权名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strSn" lay-verify="required" value="${menu.strSn}" ${(menu.program ne null or fn:length(rolePermissionList) > 0) ? 'readonly' : ''} placeholder="请输入授权名称" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
 		<div class="layui-form-item">
	    	<label class="layui-form-label">菜单名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" value="${menu.strName}" placeholder="请输入菜单名称" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">排序优先级</label>
		    <div class="layui-input-inline">
	      		<input type="text" name="intPriority" lay-verify="required|number" value="${menu.intPriority}" placeholder="请输入优先级" autocomplete="off" class="layui-input">
	    	</div>
	    	<div class="layui-form-mid layui-word-aux">默认"99"</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">是否显示</label>
		    <div class="layui-input-block">
	      		<input type="checkbox" name="isShow" lay-skin="switch" lay-text="是|否" ${menu.isShow eq 1 ? 'checked' : ''} />
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">程序描述</label>
	    	<div class="layui-input-block">
	      		<textarea name="strDesc" placeholder="请输入程序描述" class="layui-textarea">${menu.strDesc}</textarea>
	    	</div>
	  	</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
