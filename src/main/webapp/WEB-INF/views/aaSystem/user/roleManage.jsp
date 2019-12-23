<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style type="text/css">
#roleManage {
	padding: 10px;
}

#selectedRoleList {
	width: 50%;
	position: absolute;
	top: 0px;
	bottom: 0px;
	left: 0px;
	overflow: auto;
}

#noselectedRoleList {
	border-left: 0px;
	position: absolute;
	top: 0px;
	bottom: 0px;
	left: 50%;
	right: 0px;
	padding-left: 1px;
}
</style>
</head>
<body>
	<blockquote class="layui-elem-quote">人员：${user.strName}[${user.strAccount}]</blockquote>
	<div style="position: absolute; top: 70px; bottom: 10px; left: 10px; right: 10px;">
		<fieldset class="layui-elem-field" id="selectedRoleList">
	  		<legend>已分配角色</legend>
			<div class="layui-field-box" style="padding: 5px;">
				<table id="userRoleList" class="frog-table">
					<thead>
						<tr>
							<th>角色名</th>
							<th style="width: 36px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userRoleList}" var="userRole" varStatus="status">
							<tr rel="${userRole.id}">
								<td>${userRole.role.strName}</td>
								<td><button class="layui-btn layui-btn-danger layui-btn-xs" onclick="deleteRole(this, event)">删除</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</fieldset>
		<fieldset class="layui-elem-field" id="noselectedRoleList">
	  		<legend>未分配角色</legend>
		  	<div class="layui-field-box" style="padding: 5px; position: absolute; top: 26px; bottom: 0px; left: 0px; right: 0px;">
	  			<div>
	  				<input type="text" class="layui-input" placeHolder="请输入角色名称检索" onkeyup="searchRoles(this)" />
	  			</div>
	  			<div style="position: absolute; top: 45px; left: 5px; right: 5px; bottom: 5px; overflow: auto;">
	    			<table id="roleList" class="frog-table">
						<thead>
							<tr>
								<th>角色名</th>
								<th style="width: 36px;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${roleList}" var="role" varStatus="status">
								<tr rel="${role.id}">
									<td>${role.strName}</td>
									<td><button class="layui-btn layui-btn-xs" onclick="distributeRole(this, event)">分配</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
		  	</div>
		</fieldset>
	</div>
</body>
<script type="text/javascript">
/* 检索角色 */
function searchRoles(input) {
	var searchContent = $(input).val();
	var table = $(input).parent().next();
	if ($.trim(searchContent) == "") {
		table.find('tbody').find('tr').css("display", "");
	}
	table.find('tbody').find('tr').each(function() {
		if ($(this).find('td:first-child').text().search(searchContent) != -1) {
			$(this).css("display", "");
		} else {
			$(this).css("display", "none");
		}
	});
}

/* 分配角色 */
function distributeRole(btn, e) {
	e.cancelBubble = true;
	Dialog.load();
	var roleId = $(btn).parents('tr:first').attr("rel");
	var userAccount = '${user.strAccount}';
	$.post("${ctx}/userRole/insert", {"role.id": roleId, "user.strAccount": userAccount}, function(msg) {
		try {
			var json = JSON.parse(msg);
			if (json.statusCode == '200') {
				$(btn).parents('tr:first').remove();
				$.post("${ctx}/userRole/getRolesByUserAccount", {strAccount: userAccount}, function(msg) {
					try {
						var userRoleList = JSON.parse(msg);
						$('#userRoleList').find('tbody').html("");
						for (var i = 0; i < userRoleList.length; i++) {
							$('#userRoleList').find('tbody').append('<tr rel="' + userRoleList[i].id + '"><td>' + userRoleList[i].role.strName + '</td><td><button class="layui-btn layui-btn-danger layui-btn-xs" onclick="deleteRole(this, event)">删除</button></td></tr>');
						}
						layer.closeAll('loading');
						Dialog.success("分配角色成功");
					} catch (e) {
						console.log(msg);
						layer.closeAll('loading');
						Dialog.error(e.message);
					}
				});
			} else {
				Dialog.error("操作失败");
			}
		} catch (e) {
			console.log(msg);
			layer.closeAll('loading');
			Dialog.error(e.message);
		}
	});
}

/* 
 * 删除角色 
 * @author WangWeiWei_020463
 */
function deleteRole(btn, e) {
	e.cancelBubble = true;
	Dialog.load();
	debugger;
	var userRoleId = $(btn).parents('tr:first').attr("rel");
	var userAccount = '${user.strAccount}';
	$.post("${ctx}/userRole/delete", {userRoleId: userRoleId}, function(msg) {
		try {
			debugger;
			var json = JSON.parse(msg);
			Ajax.ajaxDone(json);
			if (json.statusCode == '200') {
				$(btn).parents('tr:first').remove();
				$.post("${ctx}/userRole/getNoSelectedRolesByUserAccount", {strAccount: userAccount}, function(msg) {
					try {
						debugger;
						var roleList = JSON.parse(msg);
						$('#roleList').find('tbody').html("");
						for (var i = 0; i < roleList.length; i++) {
							$('#roleList').find('tbody').append('<tr rel="' + roleList[i].id + '"><td>' + roleList[i].strName + '</td><td><button class="layui-btn layui-btn-xs" onclick="distributeRole(this, event)">分配</button></td></tr>');
						}
						layer.closeAll('loading');
					} catch (e) {
						console.log(msg);
						Dialog.error(e.message);
						layer.closeAll('loading');
					}
				});
			}
		} catch (e) {
			console.log(msg);
			Dialog.error(e.message);
			layer.closeAll('loading');
		}
	});
}
</script>
</html>