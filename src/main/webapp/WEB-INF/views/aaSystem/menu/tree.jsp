<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#menu-tree {
	width: 260px;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	border-right: 1px solid #ccc;
	overflow: auto;
}

#menu-tree span {
	font-size: 15px;
}
</style>
</head>
<body>
	<div id="menu-tree">
		<ul id="menuTree" class="ztree">
			
		</ul>
	</div>
	<div id="menu-list-view" style="position: absolute; top: 0px; left: 261px; bottom: 0px; right: 0px;">
		
	</div>
</body>
<script type="text/javascript">
//树结构的配置信息
var setting = {
	callback: {
		onClick: clickSelectMenu
	}
};
var json = '${treeMapListJson}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#menuTree"), setting, treeMapList);

function clickSelectMenu(event, treeId, treeNode, clickFlag) {
	$('#menu-list-view', NavTab.getCurrentPanel()).html("");
	var dialogIndex = Dialog.load();
	$('#menu-list-view', NavTab.getCurrentPanel()).load("${ctx}/menu/nodeList?id=" + treeNode.id, function () {
		$('#menu-list-view', NavTab.getCurrentPanel()).attr("url", "${ctx}/menu/nodeList?id=" + treeNode.id);
		layer.close(dialogIndex);
	});
}
</script>
</html>