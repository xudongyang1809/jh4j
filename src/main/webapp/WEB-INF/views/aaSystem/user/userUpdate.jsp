<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" method="post" action="${ctx}/user/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" name="id" value="${user.id}" />
 		<div class="layui-form-item">
	    	<label class="layui-form-label">登录账号</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strAccount" value="${user.strAccount}" lay-verify="required" placeholder="请输入登录账号(工号)" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">真实名字</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" value="${user.strName}" lay-verify="required" placeholder="请输入真实名字" autocomplete="off" class="layui-input">
		    </div>
		</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">固定电话</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strLinePhone" value="${user.strLinePhone}" placeholder="请输入固定电话..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">手机号码</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strPhone" value="${user.strPhone}" lay-verify="required|phone" placeholder="请输入手机号码..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">用户状态</label>
	    	<div class="layui-input-block">
	      		<select name="city" lay-verify="required">
			        <option value="1" selected>可用</option>
			        <option value="0">不可用</option>
		      	</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">邮箱地址</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="strEmail" value="${user.strEmail}" placeholder="请输入邮箱地址..." autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label">所属部门</label>
	    	<div class="layui-input-block">
	    		<input type="hidden" name="dept.id" value="${user.dept.id}"/>
	    		<input type="text" id="deptName" placeholder="选择部门..." readonly class="layui-input" value="${user.dept.strName}"/>
      			<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickOrganization="pickOrganizationForUserUpdate">
			  		<i class="layui-icon">&#xe615;</i>
				</button>
	    	</div>
	  	</div>
	  	
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
<script>
/* 挑选组织机构 */
function pickOrganizationForUserUpdate(id, strSn, strName) {
	$('input[name="dept.id"]').val(id);
	$('#deptName').val(strName);
}
</script>