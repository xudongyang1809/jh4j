<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#menu-permission-tree {
	width: 260px;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	border-right: 1px solid #ccc;
	overflow: auto;
}

#menu-permission-tree span {
	font-size: 15px;
}
</style>
</head>
<body>
	<div id="menu-permission-tree">
		<ul id="menuPermissionTree" class="ztree">
			
		</ul>
	</div>
	<div id="permission-list-view" style="position: absolute; top: 0px; left: 261px; bottom: 0px; right: 0px;">
		
	</div>
</body>
<script type="text/javascript">
//树结构的配置信息
var setting = {
	callback: {
		onClick: clickSelectPermissionMenu
	}
};
var json = '${treeMapListJson}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#menuPermissionTree"), setting, treeMapList);

function clickSelectPermissionMenu(event, treeId, treeNode, clickFlag) {
	Dialog.load();
	if (treeNode.programId != null) {
		$('#permission-list-view', NavTab.getCurrentPanel()).html("");
		var dialogIndex = Dialog.load();
		$('#permission-list-view', NavTab.getCurrentPanel()).load("${ctx}/permission/list?menuId=" + treeNode.id + "&moduleId=" + treeNode.programId, function () {
			$('#permission-list-view', NavTab.getCurrentPanel()).attr("url", "${ctx}/permission/list?menuId=" + treeNode.id + "&moduleId=" + treeNode.programId);
			layer.closeAll('loading');
		});
	} else {
		Dialog.warn("您选择的不是末端程序节点或者该节点指向的程序已被删除！");
		layer.closeAll('loading');
	}
}
</script>
</html>