<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/company/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
	    	<label class="layui-form-label">公司编码:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strSn" lay-verify="required" placeholder="请输入公司编码" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">公司名称:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" placeholder="请输入公司编码" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">公司別:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strNCSn" lay-verify="required" placeholder="用于项目管理中，如：公司为金恒，公司别为H" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">备注:</label>
		    <div class="layui-input-block">
	      		<textarea name="strDesc" placeholder="请输入备注..." class="layui-textarea"></textarea>
		    </div>
	  	</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>