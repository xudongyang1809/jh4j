<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div id="permissionChooseModule">
		
	</div>
</body>
<script type="text/javascript">
try {
	var json = '${treeMapListJson}';
	var moduleNavId = '${moduleListNavId}';
	var treeMapList = JSON.parse(json);
	layui.tree({
		elem: '#permissionChooseModule',
		skin: 'menu',
		nodes: treeMapList,
		click: function(node) {
			var dialogIndex = layer.load(1);
			if (node.programId != null) {
				$('#pagerForm', $('div[tabId="' + moduleNavId + '"]')).find('input[name="moduleId"]').val(node.programId);
				$('#pagerForm', $('div[tabId="' + moduleNavId + '"]')).find('input[name="menuId"]').val(node.id);
				navTabAjaxDone($('#pagerForm', $('div[tabId="' + moduleNavId + '"]')));
				layer.close(dialogIndex);
			} else {
				Dialog.warn("您选择的不是末端程序节点或者该节点指向的程序已被删除！");
				layer.close(dialogIndex);
			}
		}
	});
	$('#permissionChooseModule .layui-tree-branch').html("");
	$('#permissionChooseModule .layui-tree-branch').addClass("fa");
	$('#permissionChooseModule .layui-tree-branch').addClass("fa-folder");
	$('#permissionChooseModule .layui-tree-branch').removeClass("layui-icon");
	$('#permissionChooseModule .layui-tree-branch').removeClass("layui-tree-branch");
	$('#permissionChooseModule').find('a').click(function() {
		$('#permissionChooseModule').find('cite').css("background-color", "white");
		$('#permissionChooseModule').find('cite').css("color", "black");
		$(this).find('cite').css("background-color", "#1E9FFF");
		$(this).find('cite').css("color", "white");
	});
} catch (e) {
	console.log(json);
	Dialog.error(e.message);
}
</script>
</html>