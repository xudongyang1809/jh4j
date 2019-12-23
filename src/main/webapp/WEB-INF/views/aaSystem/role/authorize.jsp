<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style type="text/css">
#roleAuthorize {
	padding: 10px;
}

#roleAuthorizeDialog #menuTree {
	width: 50%;
	height: 100%;
	border-right: 1px solid #ccc;
	overflow: auto;
	box-sizing:border-box;
	-moz-box-sizing:border-box;
	-webkit-box-sizing:border-box;
}

#roleAuthorizeDialog #menuTree span {
    font-size: 15px;
}

#actionList {
	position: absolute;
	top: 0px;
	bottom: 0px;
	left: 50%;
	right: 0px;
	padding-left: 1px;
}

#actionList>div {
	height: 30px;
	border-bottom: 1px solid #ccc;
	line-height: 30px;
	padding-left: 5px;
}

#actionList>div>i {
	cursor: pointer;
	color: #c2c2c2;
}

#actionList>div>i:hover {
	color: #5FB878;
	font-weight: bolder;
}

#actionList>div>i.unselected:before {
	content: "\e626";
}

#actionList>div>i.selected {
	color: #5FB878;
	font-weight: bolder;
}

#actionList>div>i.selected:before {
	content: "\e627";
}
</style>
</head>
<body>
	<blockquote class="layui-elem-quote">角色：${role.strName}</blockquote>
	<div style="position: absolute; top: 70px; bottom: 10px; left: 10px; right: 10px; border: 1px solid #ccc;">
		<ul id="menuTree" class="ztree">
			
		</ul>
		<div id="actionList" class="layui-form">
			<span style="font-weight: bolder; font-size: 20px;">请选择一个功能菜单！</span>
		</div>
	</div>
</body>
<script type="text/javascript">
//树结构的配置信息
var setting = {
	callback: {
		onClick: clickSelectAuthorizeMenu
	}
};
var roleId = '${role.id}';
var json = '${treeMapListJson}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#roleAuthorizeDialog #menuTree"), setting, treeMapList);

function clickSelectAuthorizeMenu(event, treeId, treeNode, clickFlag) {
	Dialog.load();
	$.post("${ctx}/permission/getPermissionByParams", {programId: treeNode.programId, strSn: treeNode.strSn, roleId: roleId}, function(msg) {
		try {
			var json = JSON.parse(msg);
			if (json.statusCode == 200) {
				$('#actionList').html("");
				if (treeNode.programId == null) {
					$('#actionList').append('<div>' + 
							'<input type="hidden" name="strSn" value="' + treeNode.strSn + '" />' +
							'<input type="hidden" name="permissionCode" value="' + json.data.strName + '" />' +
							'<input type="hidden" name="menuId" value="' + treeNode.id + '" />' +
							'<input type="hidden" name="rolePermissionId" value="' + json.data.rolePermissionId + '" />' +
							'<input type="hidden" name="programId" value="' + (json.data.moduleId == null ? "" : json.data.moduleId) + '" />' +
							'<input type="checkbox" lay-filter="cbx-selectPermission" lay-skin="primary" ' + (json.data.isSelected == 1 ? 'checked' : '') + ' title="' + json.data.strName + '[' + json.data.strDesc + ']' + '" /></div>');
				} else {
					for (var i = 0; i < json.data.length; i++) {
						$('#actionList').append('<div>' + 
								'<input type="hidden" name="strSn" value="' + treeNode.strSn + '" />' +
								'<input type="hidden" name="permissionCode" value="' + json.data[i].strName + '" />' +
								'<input type="hidden" name="menuId" value="' + treeNode.id + '" />' +
								'<input type="hidden" name="rolePermissionId" value="' + json.data[i].rolePermissionId + '" />' +
								'<input type="hidden" name="programId" value="' + json.data[i].moduleId + '" />' +
								'<input type="checkbox" lay-filter="cbx-selectPermission" lay-skin="primary" ' + (json.data[i].isSelected == 1 ? 'checked' : '') + ' title="' + json.data[i].strName + '[' + json.data[i].strDesc + ']' + '" /></div>');
					}
				}
			} else {
				$('#actionList').html('<div style="padding: 5px; font-size: 20px; font-weight: bolder; border-bottom: 0;">' + json.message + '</div>');
			}
			form.render();
			layer.closeAll('loading');
		} catch (e) {
			layer.closeAll('loading');
			console.log(msg);
			Dialog.error(e.message);
		}
	});
}

form.on('checkbox(cbx-selectPermission)', function(data) {
	var roleId = '${role.id}';
	var programId = $(data.elem).parent().find('input[name="programId"]').val();
	var menuId = $(data.elem).parent().find('input[name="menuId"]').val();
	var strSn = $(data.elem).parent().find('input[name="strSn"]').val();
	var permissionCode = $(data.elem).parent().find('input[name="permissionCode"]').val();
	var rolePermissionId = $(data.elem).parent().find('input[name="rolePermissionId"]').val();
	var strPermission = strSn + ":" + permissionCode;
	if (data.elem.checked) {
		$.post("${ctx}/role/insertRolePermission", {strSn: strSn, roleId: roleId, strPermission: strPermission}, function(msg) {
			try {
				var json = JSON.parse(msg);
				Ajax.ajaxDone(json);
				console.log({programId: programId, strSn: strSn, roleId: roleId});
				$.post("${ctx}/permission/getPermissionByParams", {programId: programId, strSn: strSn, roleId: roleId}, function(msg) {
					try {
						console.log(msg);
						var json = JSON.parse(msg);
						if (json.statusCode == 200) {
							$('#actionList').html("");
							if (programId == null || programId == "") {
								$('#actionList').append('<div>' + 
										'<input type="hidden" name="strSn" value="' + strSn + '" />' +
										'<input type="hidden" name="permissionCode" value="' + json.data.strName + '" />' +
										'<input type="hidden" name="menuId" value="' + menuId + '" />' +
										'<input type="hidden" name="rolePermissionId" value="' + json.data.rolePermissionId + '" />' +
										'<input type="hidden" name="programId" value="' + json.data.moduleId + '" />' +
										'<input type="checkbox" lay-filter="cbx-selectPermission" lay-skin="primary" ' + (json.data.isSelected == 1 ? 'checked' : '') + ' title="' + json.data.strName + '[' + json.data.strDesc + ']' + '" /></div>');
							} else {
								for (var i = 0; i < json.data.length; i++) {
									$('#actionList').append('<div>' + 
											'<input type="hidden" name="strSn" value="' + json.data[i].programCode + '" />' +
											'<input type="hidden" name="permissionCode" value="' + json.data[i].strName + '" />' +
											'<input type="hidden" name="menuId" value="' + menuId + '" />' +
											'<input type="hidden" name="rolePermissionId" value="' + json.data[i].rolePermissionId + '" />' +
											'<input type="hidden" name="programId" value="' + json.data[i].moduleId + '" />' +
											'<input type="checkbox" lay-filter="cbx-selectPermission" lay-skin="primary" ' + (json.data[i].isSelected == 1 ? 'checked' : '') + ' title="' + json.data[i].strName + '[' + json.data[i].strDesc + ']' + '" /></div>');
								}
							}
						} else {
							$('#actionList').html('<div class="jumbotron">' + json.message + '</div>');
						}
						form.render();
					} catch (e) {
						console.log(msg);
						Dialog.error(e.message);
					}
				});
			} catch (e) {
				console.log(e.message);
				Dialog.error(e.message);
			}
		});
	} else {
		$.post("${ctx}/role/deleteRolePermission", {rolePermissionId: rolePermissionId}, function(msg) {
			try {
				var json = JSON.parse(msg);
				Ajax.ajaxDone(json);
			} catch (e) {
				console.log(e.message);
				Dialog.error(e.message);
			}
		});
	}
});
</script>
</html>