<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/program/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
 		<div class="layui-form-item">
	    	<label class="layui-form-label">程序编码</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strSn" lay-verify="required|letter" placeholder="请输入程序编码" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">程序名称</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" placeholder="请输入程序名称" autocomplete="off" class="layui-input">
		    </div>
		</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">程序URL</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strUrl" lay-verify="required" placeholder="请输入程序URL" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">打开方式</label>
	    	<div class="layui-input-block">
	      		<select name="viewType" lay-verify="required">
			        <option value="">请选择程序打开方式</option>
			        <option value="navTab">标签页</option>
			        <option value="dialog">窗口</option>
		      	</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label">程序图标:</label>
			<div class="layui-input-block">
				<input type="text" name="strIcon" class="layui-input" />
			</div>
		</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">优先级</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="intPriority" lay-verify="required|number" value="99" placeholder="请输入优先级" autocomplete="off" class="layui-input">
	    	</div>
	    	<div class="layui-form-mid layui-word-aux">默认"99"</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">程序描述</label>
	    	<div class="layui-input-block">
	      		<textarea name="strDesc" placeholder="请输入程序描述" class="layui-textarea"></textarea>
	    	</div>
	  	</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>