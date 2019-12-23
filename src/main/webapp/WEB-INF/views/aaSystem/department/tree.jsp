<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#deptment-tree-container {
	width: 260px;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	border-right: 1px solid #ccc;
	overflow: auto;
}
</style>
</head>
<body>
	<div id="deptment-tree-container">
		<ul id="deptment-tree-tab" class="ztree">
			
		</ul>
	</div>
	<div id="department-list-view" style="position: absolute; top: 0px; left: 261px; bottom: 0px; right: 0px;">
		
	</div>
</body>
<script type="text/javascript">
//树结构的配置信息
var setting = {
	callback: {
		onClick: clickSelectPermissionMenu,
		onExpand: onExpand,
		onCollapse: onCollapse
	}
};
var json = '${treeMapListJson}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#deptment-tree-tab"), setting, treeMapList);
/* var treeObj = $.fn.zTree.getZTreeObj("deptment-tree-tab");
var cookie = $.cookie("deptment-tree" + window.location);
if (cookie) {
    z_tree = JSON.parse(cookie);
    for (var i = 0; i < z_tree.length; i++) {
        var node = treeObj.getNodeByParam('id', z_tree[i])
        treeObj.expandNode(node, true, false)
    }
} */

function clickSelectPermissionMenu(event, treeId, treeNode, clickFlag) {
	Dialog.load();
	$('#department-list-view', NavTab.getCurrentPanel()).html("");
	$('#department-list-view', NavTab.getCurrentPanel()).load("${ctx}/department/list?fatherId=" + treeNode.id, function () {
		$('#department-list-view', NavTab.getCurrentPanel()).attr("url", "${ctx}/department/list?fatherId=" + treeNode.id);
		layer.closeAll("loading");
	});
}

function onExpand(event, treeId, treeNode) {
    var cookie = $.cookie("deptment-tree" + window.location);
    var z_tree = new Array();
    if (cookie) {
        z_tree = JSON.parse(cookie);
    }
    if ($.inArray(treeNode.id, z_tree) < 0) {
        z_tree.push(treeNode.id);
    }
    $.cookie("deptment-tree" + window.location, JSON.stringify(z_tree))
}

function onCollapse(event, treeId, treeNode) {
    var cookie = $.cookie("deptment-tree" + window.location);
    var z_tree = new Array();
    if (cookie) {
        z_tree = JSON.parse(cookie);
    }
    var index = $.inArray(treeNode.id, z_tree);
    z_tree.splice(index, 1);
    for (var i = 0; i < treeNode.children.length; i++) {
        index = $.inArray(treeNode.children[i].id, z_tree);
        if (index > -1) z_tree.splice(index, 1);
    }
    $.cookie("deptment-tree" + window.location, JSON.stringify(z_tree))
}
</script>
</html>