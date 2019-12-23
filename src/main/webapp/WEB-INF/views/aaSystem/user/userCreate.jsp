<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="${ctx}/user/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
 		<div class="layui-form-item">
	    	<label class="layui-form-label">登录账号</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strAccount" lay-verify="required" placeholder="请输入登录账号(工号)" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">真实名字</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" placeholder="请输入真实名字" autocomplete="off" class="layui-input">
		    </div>
		</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">登录密码</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="plainPassword" lay-verify="required" value="123456" placeholder="请输入登录密码..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">固定电话</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strLinePhone" placeholder="请输入固定电话..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">手机号码</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strPhone" lay-verify="required|phone" placeholder="请输入手机号码..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">用户状态</label>
	    	<div class="layui-input-block">
	      		<select name="city" lay-verify="required">
			        <option value="enabled" selected>可用</option>
			        <option value="disabled">不可用</option>
		      	</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">邮箱地址</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strEmail" placeholder="请输入邮箱地址..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">所属部门</label>
	    	<div class="layui-input-block">
	    		<input type="hidden" id="deptId" name="dept.id" />
	    		<input type="text" id="deptName" placeholder="选择部门..." readonly class="layui-input" lay-verify="required" style="background-position: 107% 0;" />
      			<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDept="deptId,,deptName">
			  		<i class="layui-icon">&#xe615;</i>
				</button>
	    	</div>
	  	</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>