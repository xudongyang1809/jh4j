<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style type="text/css">
.layui-elem-field {
	border-color: grey;
}
</style>
</head>
<body>
<div style="padding: 10px;">
	<fieldset class="layui-elem-field">
  		<legend>文件上传</legend>
	  	<div class="layui-field-box">
			<a class="code" href="${ctx}/smCodeExample/preTestFormAndFileSubmit" target="dialog" width="500" height="550" dialogId="testFormAndFileSubmitDialog" title="form表单与文件同时上传示例">form表单与文件同时上传示例</a>
			<a class="code" href="${ctx}/smCodeExample/preTestFileUpload" target="dialog" width="600" height="470" dialogId="testFormAndFileSubmitDialog" title="文件上传示例">单个文件上传示例</a>
		</div>
	</fieldset>
	<fieldset class="layui-elem-field">
  		<legend>挑选部门与人员</legend>
	  	<div class="layui-field-box">
			<div class="layui-form">
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选单个部门（“dom选择器”）</label>
				    	<div class="layui-input-inline">
				    		<input type="hidden" id="deptId" name="dept.id" />
				    		<input type="hidden" id="deptNo" />
				    		<input type="text" id="deptName" placeholder="选择部门..." readonly class="layui-input" style="background-position: 107% 0;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDept="deptId,deptNo,deptName">
						  		<i class="layui-icon">&#xe615;</i>
							</button>
				    	</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选单个人员（“dom选择器”）</label>
						<div class="layui-input-inline">
							<input type="hidden" id="userId" />
			    			<input type="hidden" id="userNo" />
			      			<input type="text" id="username" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<a class="layui-btn layui-btn-sm" onPickUser="userId,userNo,username" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			    		</div>
					</div>
			  	</div>
			  	
			  	<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选单个部门（“回调方法”）</label>
				    	<div class="layui-input-inline">
				    		<input type="hidden" id="deptId1" name="dept.id" />
				    		<input type="hidden" id="deptNo1" name="dept.strSn" />
				    		<input type="text" id="deptName1" placeholder="选择部门..." readonly class="layui-input" style="background-position: 107% 0;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDept="selectSingleDepartmentCallback">
						  		<i class="layui-icon">&#xe615;</i>
							</button>
				    	</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选单个人员（“回调方法”）</label>
						<div class="layui-input-inline">
							<input type="hidden" id="userId1" />
			    			<input type="hidden" id="userNo1" />
			      			<input type="text" id="username1" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			    		</div>
					</div>
			  	</div>
			  	
			  	<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选多个部门（“dom选择器”）</label>
				    	<div class="layui-input-inline">
				    		<input type="hidden" id="deptId2" name="dept.id" />
				    		<input type="hidden" id="deptNo2" />
				    		<input type="text" id="deptName2" placeholder="选择部门..." readonly class="layui-input" style="padding-right: 50px;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDepts="deptId2,deptNo2,deptName2">
						  		<i class="layui-icon">&#xe615;</i>
							</button>
				    	</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选多个人员（“dom选择器”）</label>
						<div class="layui-input-inline">
							<input type="hidden" id="userId2" />
			    			<input type="hidden" id="userNo2" />
			      			<input type="text" id="username2" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<a class="layui-btn layui-btn-sm" onPickUsers="userId2,userNo2,username2" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			    		</div>
					</div>
			  	</div>
			  	
			  	<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选多个部门（“回调方法”）</label>
				    	<div class="layui-input-inline">
				    		<input type="hidden" id="deptId3" name="dept.id" />
				    		<input type="hidden" id="deptNo3" />
				    		<input type="text" id="deptName3" placeholder="选择部门..." readonly class="layui-input" style="padding-right: 50px;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDepts="selectMultiDepartmentCallback">
						  		<i class="layui-icon">&#xe615;</i>
							</button>
				    	</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 200px;">挑选多个人员（“回调方法”）</label>
						<div class="layui-input-inline">
			    			<input type="hidden" id="userId3" />
			    			<input type="hidden" id="userNo3" />
			      			<input type="text" id="username3" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
			      			<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
			      			<a class="layui-btn layui-btn-sm" onPickUsers="selectMultiUserCallback" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			    		</div>
					</div>
			  	</div>
			</div>
		</div>
	</fieldset>
</div>
<script>
/*
 * 选择单个部门的回调方法
 */
function selectSingleDepartmentCallback(deptId, deptNo, deptName) {
	$('#deptId1').val(deptId);
	$('#deptNo1').val(deptNo);
	$('#deptName1').val(deptName);
}

/*
 * 选择多个部门的回调方法
 */
function selectMultiDepartmentCallback(deptIds, deptNos, deptNames, deptList) {
	$('#deptId3').val(deptIds);
	$('#deptNo3').val(deptNos);
	$('#deptName3').val(deptNames);
	console.log(deptList);
}

/*
 * 选择单个人员的回调方法
 */
function selectSingleUserCallback(userId, userNo, username) {
	$('#userId1').val(userId);
	$('#userNo1').val(userNo);
	$('#username1').val(username);
}

/*
 * 选择多个人员的回调函数
 */
function selectMultiUserCallback(userIds, userNos, usernames, userList) {
	$('#userId3').val(userIds);
	$('#userNo3').val(userNos);
	$('#username3').val(usernames);
	console.log(userList);
}
</script>
</body>
</html>
