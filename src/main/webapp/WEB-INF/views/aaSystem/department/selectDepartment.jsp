<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div style="padding: 5px">
	<ul id="pick-organization-tree" class="ztree">
		
	</ul>
</div>
<script type="text/javascript">
var dialogIndex = $('#pick-organization-tree').parents(".layui-layer:first").attr("times");
var setting = {
	callback: {
		onClick: clickPickOrganization
	}
};
var json = '${ztreeData}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#pick-organization-tree"), setting, treeMapList);

function clickPickOrganization(event, treeId, node, clickFlag) {
	if ('${callbackMethod}' != '') {
		if (typeof(eval('${callbackMethod}')) == "function") {
			var func = eval('${callbackMethod}');
			func(node.id, node.strSn, node.name);
			layer.close(dialogIndex);
		} else {
			Dialog.warn("提供的回调方法不存在，请修改！");
		}
	} else {
		var deptIdFilter = '${deptIdFilter}';
		var deptNoFilter = '${deptNoFilter}';
		var deptNameFilter = '${deptNameFilter}';
		if (deptIdFilter == '' && deptNoFilter == '' && deptNameFilter == '') {
			Dialog.warn("提供的数据回填的dom元素不存在，请修改！");
		} else {
			if (deptIdFilter != '') {
				if ($('#' + deptIdFilter).is('input')) {
					$('#' + deptIdFilter).val(node.id);
				} else {
					$('#' + deptIdFilter).text(node.id);
				}
			}
			if (deptNoFilter != '') {
				if ($('#' + deptNoFilter).is('input')) {
					$('#' + deptNoFilter).val(node.strSn);
				} else {
					$('#' + deptNoFilter).text(node.strSn);
				}
			}
			if (deptNameFilter != '') {
				if ($('#' + deptNameFilter).is('input')) {
					$('#' + deptNameFilter).val(node.strName);
				} else {
					$('#' + deptNameFilter).text(node.strName);
				}
			}
			layer.close(dialogIndex);
		}
	}
}
</script>